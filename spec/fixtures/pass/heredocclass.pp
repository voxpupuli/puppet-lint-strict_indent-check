# Tests for heredocs within class
class 'heredocclass' {
  file { '/heredoc/file/resource/without/comma':
    content => @(HERE)
      This is a here doc
      with two lines
      | HERE
  }

  file { '/heredoc/file/resource/with/comma':
    content => @(HERE),
      This is a here doc
      with two lines
      | HERE
  }

  file { '/heredoc/in/function/in/file/resource':
    content => inlineepp(@(HERE)),
      This is a here doc
      with two lines
      | HERE
  }

  $variable_with_interpolation = @("EOT")
    Another example
    ${variable}
    with
    ${variable}
    with interpolation
    | EOT
}
