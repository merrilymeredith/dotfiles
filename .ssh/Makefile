# Do away with this setup once openssh >=7.3 is readily available just move
# config.d/10-base to config and add an Include config.d/*

config: config.d/*
	cat config.d/* > $@

clean:
	rm -f config

.PHONY: clean
