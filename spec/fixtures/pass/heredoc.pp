$variable = @(EOT)
  This is a multiline
  heredoc string
  | EOT

$variable_with_interpolation = @("EOT")
  Another example
  ${variable}
  with
  ${variable}
  with interpolation
  | EOT

case fact('os.family') {
  'debian': {
    $greeting = @(EOT)
      Hello
      World
      | EOT
  }
}

file { 'file':
  content => @(FILE),
    $signed_header_fields{'received'} = 0;
    $enable_dkim_verification = 1;
    $enable_dkim_signing = 1;
    @client_ipaddr_policy = (
        \@mynetworks => 'MYNETS',
    );
    $policy_bank{'MYNETS'} = {
        originating => 1,
        final_virus_destiny => D_REJECT,
        final_spam_destiny => D_REJECT,
        final_bad_header_destiny => D_PASS,
        terminate_dsn_on_notify_success => 0,
        warnbadhsender => 1,
    };
    | FILE
  ;
}
