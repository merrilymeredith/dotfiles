package ReplyStartup;

sub import {
  my $code = eval(<<END_PERL) or die $@;
    package main;
    sub {
      warnings->import;
      strict->import;
      require feature; feature->import(':5.14');
      require experimentals; experimentals->import;

      use Path::Tiny;

      -e \$_ && do(\$_) for glob('~/.replyrc.local.pl');
      die \$@ if \$@;
    }
END_PERL

  $code->();
}

1;
