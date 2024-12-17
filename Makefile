

.PHONY: compile
compile:
	@rebar3 compile

.PHONY: clean
clean:
	@rebar3 clean

.PHONY: dialyze
dialyze:
	@rebar3 dialyzer

.PHONY: xref
xref:
	@rebar3 xref
