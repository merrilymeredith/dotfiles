package Autofetch;

use strict;
use warnings;

sub fetch {
  my ($path, $module) = @_;
  system 'cpanm', -nq, -l => $path, $module;
}

sub cachepath { "$ENV{HOME}/.cache/lib/" . ($_[0] =~ y|/ |-_|r) }

sub modulefy { $_[0] =~ s/\.pm$//r =~ s|/|::|gr }

my $path = cachepath($0);

push @INC, "$path/lib/perl5", sub {
  my (undef, $file) = @_;

  fetch($path, modulefy($file));

  return IO::File->new($path . '/lib/perl5/' . $file);
};

1;
