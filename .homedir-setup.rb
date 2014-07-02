#!/usr/bin/env ruby
# vim: et sts=2 sw=2 fdm=marker
# encoding: UTF-8

# we don't yet have rbenv so keep safe for ruby 1.8

if `which git` == ''
  puts "please install git"
  exit 1 
end


# util {{{
  # just checks and bails after each call
  def do_cmds (*cmds)
    cmds.each do |cmd|
      puts "$ #{cmd}"
      system( cmd ) or exit $?
    end
  end

  #checks for the first line and if it's not there, appends the whole set
  def add_if_missing (fn, lines)
    match = lines.lines.first.chomp
    add   = false

    if File.exists?(fn)
      File.open(fn) do |file|
        if file.each_line.none? { |line| line.chomp == match }
          add = true
        end
      end
    else
      add = true
    end

    if add == true
      File.open(fn, 'a') do |append|
        append << lines
        append << $/
      end

      puts "Added to #{fn}:"
      puts lines + $/
    end

  end

  def replace_line (fn, match, replace)
    buf     = []
    changed = false

    File.open(fn) do |file|
      file.each_line do |line|
        buf << if line.match(match)
                 changed = true
                 replace
               else
                 line
               end
      end
    end

    if changed
      File.open( fn + ".tmp~", 'w' ) do |file|
        buf.each do |line|
          file.puts line
        end
      end
      puts 'changes in #{fn}.tmp~'
    else
      puts 'no change'
    end
  end
# }}}


# oh-my-zsh {{{
  # i have a custom theme and the omz install complains about already
  # having a directory there.  remove, install, then revert my stuff
  # out of hg

  if Dir.exists?('.oh-my-zsh/.git')
    puts "oh-my-zsh already installed"
  else
    puts "Installing oh-my-zsh..."

    do_cmds \
      'rm -r .oh-my-zsh',
      'git clone git://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh',
      'hg stat -dn0 -I .oh-my-zsh/ | xargs -0 hg revert'

  end

# }}}


add_if_missing '.bash_profile', 'export PATH=~/bin:$PATH'

add_if_missing '.zshrc', <<END
typeset -U path
path=(~/bin "$path[@]")
END


# plenv {{{

  if Dir.exists?('.plenv')
    puts "plenv already installed"
  else
    puts "Installing plenv..."

    do_cmds \
      'git clone git://github.com/tokuhirom/plenv.git .plenv',
      'git clone git://github.com/tokuhirom/Perl-Build.git .plenv/plugins/perl-build/'
    

    add_if_missing '.bash_profile', <<END
export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"
END

    add_if_missing '.zshrc', <<END
path=(~/.plenv "$path[@]")
eval "$(plenv init - zsh)"
END

  end

# }}}


# rbenv {{{

# git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
# git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
# echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
# echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
  if Dir.exists?('.rbenv')
    puts "rbenv already installed"
  else
    puts "Installing rbenv..."

    do_cmds \
      'git clone https://github.com/sstephenson/rbenv.git .rbenv',
      'git clone https://github.com/sstephenson/ruby-build.git .rbenv/plugins/ruby-build/'
    

    add_if_missing '.bash_profile', <<END
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
END

    add_if_missing '.zshrc', <<END
path=(~/.rbenv "$path[@]")
eval "$(rbenv init - zsh)"
END

  end

# }}}




# vundle {{{

# }}}



