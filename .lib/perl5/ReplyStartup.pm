package ReplyStartup;
use warnings;
use strict;
use parent 'Import::Base';

our @IMPORT_MODULES = (
  'strict',
  'warnings',
  'feature' => [':5.14'],
  'experimentals',
  'Path::Tiny',
);

sub import {
  my $caller = caller(0);

  # Run anything in .replyrc.local.pl in the context of main, at compile time.
  eval(<<END_PERL)->();
    package $caller; sub {
      -e \$_ && do(\$_) for glob('~/.replyrc.local.pl');
      die \$@ if \$@;
    }
END_PERL

  our @ISA;
  goto($ISA[0]->can('import'));
}

1;
