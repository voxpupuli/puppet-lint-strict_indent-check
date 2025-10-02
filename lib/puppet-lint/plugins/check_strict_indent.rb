# frozen_string_literal: true

# Public: Check the manifest tokens for correct indent levels and
# record a warning for each instance found.

PuppetLint.new_check(:strict_indent) do
  def match(tokens)
    opening_token = {
      RBRACE: :LBRACE,
      RBRACK: :LBRACK,
      RPAREN: :LPAREN,
    }
    open = {
      LBRACE: [],
      LBRACK: [],
      LPAREN: [],
    }

    matches = {}

    tokens.each do |token|
      if %i[LBRACE LBRACK LPAREN].include?(token.type)
        open[token.type] << token
      elsif %i[RBRACE RBRACK RPAREN].include?(token.type)
        match = open[opening_token[token.type]].pop
        unless match.nil?
          matches[token] = match
          matches[match] = token
        end
      end
    end

    matches
  end

  def check
    chars_per_indent = PuppetLint.configuration.chars_per_indent || 2
    indent = 0
    colon_indent = nil

    matches = match(tokens)

    tokens.select do |token|
      token.type == :NEWLINE
    end.reject do |token|
      # ignore newline at end of code
      token.next_token.nil?
    end.each do |token|
      temp_indent = 0

      matched_open_lines = []
      # indent for open groups in the previous line
      open_groups = 0
      prev_token = token.prev_token
      while !prev_token.nil? and prev_token.type != :NEWLINE
        temp_indent += 1 if prev_token.type == :HEREDOC_OPEN
        if %i[LBRACE LBRACK LPAREN].include?(prev_token.type)
          if matches[prev_token].nil?
            open_groups += 1
          elsif matches[prev_token].line > prev_token.line and !matched_open_lines.include?(matches[prev_token].line)
            # increase indent for left braces not matched in the same line or in a line we have already matched a brace to
            open_groups += 1
            matched_open_lines << matches[prev_token].line
          end
        end
        prev_token = prev_token.prev_token
      end
      indent += open_groups

      # reset prev_token to last non-whitespace token on previous line
      prev_token = token.prev_token
      while !prev_token.nil? and (prev_token.type == :WHITESPACE or prev_token.type == :COMMENT)
        prev_token = prev_token.prev_token
      end

      # get type if available
      prev_type = prev_token.nil? ? nil : prev_token.type

      # handle change in indent based on last token
      case prev_type
      when :COLON
        if open_groups == 0
          if colon_indent.nil?
            # only indent for a colon when you haven't indented yet
            colon_indent = prev_token.line
            indent += 1
          else
            # you probably missed a semicolon two lines ago
          end
        end
      when :SEMIC
        unless colon_indent.nil?
          # only unindent for a semicolon when we've indented for a colon
          colon_indent = nil
          indent -= 1
        end
      when :EQUALS, :FARROW
        temp_indent += 1
      end

      # unindent for closing brackets in the current line
      next_token = token.next_token
      matched_close_lines = []
      while !next_token.nil? and next_token.type != :NEWLINE
        if %i[RBRACE RBRACK RPAREN].include?(next_token.type)
          if !matches[next_token].nil? and
             matches[next_token].line < next_token.line and
             !matched_close_lines.include?(matches[next_token].line)
            # right braces matched in a previous line decrease indent unless we already matched a brace in the same line
            indent -= 1
            matched_close_lines << matches[next_token].line
          end
          if next_token.type == :RBRACE and !colon_indent.nil? && (!matches[next_token].nil? and matches[next_token].line < colon_indent)
            # unindent at the end of resources if needed
            indent -= 1
            colon_indent = nil
          end
        elsif next_token.type == :SEMIC and !colon_indent.nil? and
              %i[INDENT NEWLINE].include?(next_token.prev_token.type) and
              (next_token.next_token.nil? or next_token.next_token.type == :NEWLINE)
          # For a lone semicolon within a block decrement immediately. Use temp_indent because
          # indent will be decremented in the next line by the prev_token logic above.
          temp_indent -= 1
        end
        next_token = next_token.next_token
      end

      # obviously we have a problem
      if indent < 0
        notify :error, {
          message: 'Error calculating indent. Please file an issue at https://github.com/relud/puppet-lint-indent-check/issues',
          line: token.next_token.line,
          column: token.next_token.column,
        }
        # stop parsing indent
        break
      end

      # get actual indent
      actual = case token.next_token.type
               when :INDENT
                 token.next_token.value.length
               when :HEREDOC
                 # Lines containing heredocs have no indent token as the indent is consumed by the heredoc token.
                 # However the last line of the token value is the whitespace before the pipe in the termination line.
                 # We use the length of this to get the indent.
                 if token.next_token.value.end_with?("\n")
                   0
                 else
                   token.next_token.value.split("\n").last.length
                 end
               when :HEREDOC_PRE
                 # For interpolated heredocs the pipe whitespace is in the HEREDOC_POST token so we need scan forward
                 # to this and get its length.
                 next_token = token.next_token
                 while !next_token.nil? and next_token.type != :NEWLINE and next_token.type != :HEREDOC_POST
                   next_token = next_token.next_token
                 end
                 if next_token.type == :HEREDOC_POST
                   next_token.value.split("\n").last.length
                 else
                   # Should never get here return zero if we do
                   0
                 end
               else
                 0
               end

      # expected indent
      expected = (indent + temp_indent) * chars_per_indent

      # oh no! incorrect indent!
      next unless actual != expected

      # no one cares if blank lines and comments are indented correctly
      next if %i[COMMENT NEWLINE].include?(token.next_token.type)

      notify :warning, {
        message: "indent should be #{expected} chars and is #{actual}",
        line: token.next_token.line,
        column: token.next_token.column,
        token: token.next_token,
        indent: expected,
        actual: actual,
      }
    end
  end

  def fix(problem)
    char_for_indent = ' '
    if %i[INDENT WHITESPACE].include?(problem[:token].type)
      problem[:token].value = char_for_indent * problem[:indent]
    elsif problem[:token].type == :HEREDOC
      change = problem[:indent] - problem[:actual]
      indent_heredoc(problem[:token], change)
    elsif problem[:token].type == :HEREDOC_PRE
      change = problem[:indent] - problem[:actual]
      indent_heredoc(problem[:token], change)
      next_token = problem[:token].next_token
      while !next_token.nil? and next_token.type != :HEREDOC_POST
        indent_heredoc(next_token, change) if next_token.type == :HEREDOC_MID
        next_token = next_token.next_token
      end
      indent_heredoc(next_token, change) if next_token.type == :HEREDOC_POST
    else
      tokens.insert(
        tokens.find_index(problem[:token]),
        PuppetLint::Lexer::Token.new(:INDENT, char_for_indent * problem[:indent], problem[:line], problem[:column]),
      )
    end
  end

  def map_heredoc_lines(value, change, skip)
    char_for_indent = ' '
    value.split("\n").map! do |line|
      if skip or line.empty?
        skip = false
        line
      elsif change < 0
        line[-change..]
      else
        (char_for_indent * change) + line
      end
    end.join("\n")
  end

  def indent_heredoc(token, change)
    case token.type
    when :HEREDOC
      token.raw = map_heredoc_lines(token.raw, change, false)
    when :HEREDOC_PRE
      token.value = map_heredoc_lines(token.value, change, false)
    when :HEREDOC_MID
      token.value = map_heredoc_lines(token.value, change, true)
    when :HEREDOC_POST
      token.raw = map_heredoc_lines(token.raw, change, true)
    end
  end
end
