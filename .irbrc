# aliases only effective after v1.4.3
IRB.conf[:COMMAND_ALIASES] ||= {}
IRB.conf[:COMMAND_ALIASES][:ri] = :help
