#!/usr/bin/env ruby
# vim: et sts=2 sw=2 fdm=marker

# we don't yet have rbenv so keep safe for ruby 1.8

if `which git` == ''
  puts "please install git"
  exit 1 
end


# just checks and bails after each call
def do_cmds (*cmds)
  cmds.each do |cmd|
    puts "$ #{cmd}"
    system( cmd ) or exit $?
  end
end



# oh-my-zsh {{{
  # i have a custom theme and the omz install complains about already
  # having a directory there.  remove, install, then revert my stuff
  # out of hg

  if Dir.exists?('.oh-my-zsh/.git')
    puts "oh-my-zsh already installed"
  else
    puts "Installing oh-my-zsh..."

    do_cmds \
      'git clone git://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh',
      'hg stat -dn0 -I .oh-my-zsh/ | xargs -0 hg revert'

  end

# }}}


# plenv {{{

  if Dir.exists?('.plenv')
    puts "plenv already installed"
  else
    puts "Installing plenv..."

    do_cmds \
      'git clone git://github.com/tokuhirom/plenv.git .plenv',
      'git clone git://github.com/tokuhirom/Perl-Build.git .plenv/plugins/perl-build/'

  end

# }}}


# rbenv {{{
  if Dir.exists?('.rbenv')
    puts "rbenv already installed"
  else
    puts "Installing rbenv..."

    do_cmds \
      'git clone https://github.com/sstephenson/rbenv.git .rbenv',
      'git clone https://github.com/sstephenson/ruby-build.git .rbenv/plugins/ruby-build/'
    
  end
# }}}



