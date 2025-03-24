package Autofetch;

use strict;
use warnings;

use Config ();
use Digest::MD5 qw(md5_base64);
use File::Spec::Functions qw(catfile rel2abs);

sub import {
  my ($class, @deps) = @_;

  return if our $INSTALLED++;

  my $path    = cachepath($0);
  my $incpath = catfile($path, 'lib', 'perl5');

  my ($version, $arch) = @Config::Config{'version', 'archname'};

  push @INC,
    $incpath,
    catfile($incpath, $version, $arch),
    catfile($incpath, $version),
    catfile($incpath, $arch);

  clear_cache($path) if -d $path && -M _ > 90;

  push @INC, sub {
    my (undef, $file) = @_;

    fetch($path, modulefy($file), @deps);

    return IO::File->new(catfile($incpath, $file));
  };
}

sub fetch {
  my ($path, @module) = @_;

  system('cpm', 'install', '-L', $path, @module) == 0
    or die "cpm: $!";
}

sub clear_cache {
  my ($path) = @_;
  require File::Find;

  File::Find::finddepth(sub { -d $_ ? rmdir : unlink }, $path);
  rmdir $path;
}

sub modulefy { $_[0] =~ s/\.pm$//r =~ s|/|::|gr }

sub cachepath {
  catfile(glob('~'), '.cache', 'perl-autofetch', md5_base64(rel2abs($_[0])));
}

1;
