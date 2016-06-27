# Public: Check the manifest tokens for correct indent levels and
# record a warning for each instance found.

PuppetLint.new_check(:'strict_indent') do
  def match(tokens)
    open = {
      :LBRACE => [],
      :LBRACK => [],
      :LPAREN => [],
    }

    matches = {}

    tokens.each do |token|
      if [:LBRACE, :LBRACK, :LPAREN].include?(token.type)
        open[token.type] << token
      elsif [:RBRACE, :RBRACK, :RPAREN].include?(token.type)
        match = open[("L" + token.type.to_s[1..-1]).to_sym].pop
        if not match.nil?
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

    tokens.select { |token|
      token.type == :NEWLINE
    }.reject { |token|
      # ignore newline at end of code
      token.next_token.nil?
    }.each do |token|
      temp_indent = 0

      # indent for open groups in the previous line
      open_groups = 0
      prev_token = token.prev_token
      while not prev_token.nil? and prev_token.type != :NEWLINE
        if [:LBRACE, :LBRACK, :LPAREN].include?(prev_token.type)
          if matches[prev_token].nil? or matches[prev_token].line > prev_token.line
            # left braces not matched in the same line increase indent
            open_groups += 1
          end
        end
        prev_token = prev_token.prev_token
      end
      indent += open_groups

      # reset prev_token to last non-whitespace token on previous line
      prev_token = token.prev_token
      while not prev_token.nil? and prev_token.type == :WHITESPACE
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
        if not colon_indent.nil?
          # only unindent for a semicolon when we've indented for a colon
          colon_indent = nil
          indent -= 1
        end
      when :EQUALS, :FARROW
        temp_indent += 1
      end

      # unindent for closing brackets in the current line
      next_token = token.next_token
      while not next_token.nil? and next_token.type != :NEWLINE
        if [:RBRACE, :RBRACK, :RPAREN].include?(next_token.type)
          if not matches[next_token].nil? and matches[next_token].line < next_token.line
            # right braces matched in a previous line decrease indent
            indent -= 1
          end
          if next_token.type == :RBRACE and not colon_indent.nil?
            if not matches[next_token].nil? and matches[next_token].line < colon_indent
              # unindent at the end of resources if needed
              indent -= 1
              colon_indent = nil
            end
          end
        end
        next_token = next_token.next_token
      end

      # obviously we have a problem
      if indent < 0
        notify :error, {
          :message => 'Error calculating indent. Please file an issue at https://github.com/relud/puppet-lint-indent-check/issues',
          :line    => token.next_token.line,
          :column  => token.next_token.column,
        }
        # stop parsing indent
        break
      end

      # get actual indent
      actual = 0
      if token.next_token.type == :INDENT
        actual = token.next_token.value.length
      else
        actual = 0
      end

      # expected indent
      expected = (indent + temp_indent) * chars_per_indent

      # oh no! incorrect indent!
      if actual != expected
        # no one cares if blank lines and comments are indented correctly
        if not [:COMMENT, :NEWLINE].include?(token.next_token.type)
          notify :warning, {
            :message => "indent should be #{expected} chars and is #{actual}",
            :line    => token.line,
            :column  => token.column,
            :token   => token,
            :indent  => expected,
          }
        end
      end
    end
  end

  def fix(problem)
    char_for_indent = ' '
    if [:INDENT,:WHITESPACE].include?(problem[:token].next_token.type)
      problem[:token].next_token.value = char_for_indent * problem[:indent]
    else
      tokens.insert(
        tokens.find_index(problem[:token]) + 1,
        PuppetLint::Lexer::Token.new(:INDENT, char_for_indent * problem[:indent], problem[:line], problem[:column]),
      )
    end
  end
end
