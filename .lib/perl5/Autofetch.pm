package Autofetch;

use strict;
use warnings;
use 5.010;

sub fetch {
  my ($path, $module) = @_;
  system 'cpanm', -nq, -l => $path, $module;
}

sub cachepath {
  $ENV{HOME} . '/.cache/lib/' . ($_[0] =~ y|/ |-_|r);
}

sub modulefy {
  $_[0] =~ s/\.pm$//r =~ s|/|::|gr;
}

push @INC, sub {
  my (undef, $file) = @_;
  state $path = cachepath($0);

  fetch($path, modulefy($file));

  return IO::File->new($path . '/lib/perl5/' . $file);
};
  
1;
