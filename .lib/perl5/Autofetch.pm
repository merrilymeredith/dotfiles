package Autofetch;

use strict;
use warnings;
use File::Spec::Functions qw(catfile rel2abs);

sub fetch {
  my ($path, $module) = @_;
  system 'cpanm', -nq, -l => $path, $module;
}

sub cachepath {
  catfile(glob('~'), '.cache', 'lib', rel2abs($_[0]) =~ y|/ |-_|r);
}

sub modulefy { $_[0] =~ s/\.pm$//r =~ s|/|::|gr }

sub import {
  return if our $INSTALLED++;

  my $path    = cachepath($0);
  my $incpath = catfile($path, 'lib', 'perl5');

  push @INC, $incpath, sub {
    my (undef, $file) = @_;

    fetch($path, modulefy($file));

    return IO::File->new(catfile($incpath, $file));
  };
}

1;