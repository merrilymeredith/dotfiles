use warnings;
use strict;
use feature ':all';
use experimentals;

use lib glob('~/.lib/perl5');

use Data::Printer {
  filters => {-external => ['JSON', 'URI']},
  class   => {show_methods => 'public', inherited => 'public'},
};

use Path::Tiny;

-e $_ && require($_) for glob('~/.replyrc.local.pl');

1;
