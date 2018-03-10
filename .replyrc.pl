use lib glob('~/.lib/perl5');

use Data::Printer {
  filters => {-external => ['JSON', 'URI']},
  class   => {show_methods => 'public', inherited => 'public'},
};

use Path::Tiny;

1;
