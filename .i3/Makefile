all: config status

config: config.d/*
	cat config.d/* > $@

status: status.d/*
	cat status.d/* > $@

clean:
	rm -f config status

.PHONY: clean
