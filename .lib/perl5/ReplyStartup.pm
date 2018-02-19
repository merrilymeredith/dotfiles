package ReplyStartup;
use warnings;
use strict;

use Import::Into;

sub import {
  my $caller = caller(0);

  import::into($_ => $caller) for qw(
    strict
    warnings
    experimentals
    Path::Tiny
  );
  import::into(feature => $caller, ':5.14');
  import::into('Data::Printer' => $caller, {
      filters => {-external => ['JSON', 'URI']},
      class   => {show_methods => 'public', inherited => 'public'},
  });

  # Run anything in .replyrc.local.pl in the context of
  # main, at compile time.
  eval(<<END_PERL)->();
    package $caller; sub {
      -e \$_ && do(\$_) for glob('~/.replyrc.local.pl');
      die \$@ if \$@;
    }
END_PERL
}

1;
