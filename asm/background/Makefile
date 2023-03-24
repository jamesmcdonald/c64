name = $(shell basename $(CURDIR))
targets = $(name).prg $(name).d64 $(name).prg.list

%.prg: %.dasm
	dasm $< -o$@ -l$@.list

%.d64: %.prg
	c1541 -format $<,jm d64 $@
	c1541 $@ -write $< $(patsubst %.prg,%,$<)

$(name).d64: $(name).prg

$(name).prg: $(name).dasm

clean:
	rm -f $(targets)


run: $(name).d64
	x64sc -autostart $(name).d64
