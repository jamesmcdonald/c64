name = $(shell basename $(CURDIR))
targets = $(name).prg $(name).d64 $(name).prg.list
EXE :=
ifneq ($(shell uname -r | grep -i microsoft),)
	EXE := .exe
endif

%.prg: %.dasm
	dasm $< -o$@ -l$@.list

%.d64: %.prg
	c1541$(EXE) -format $(patsubst %.prg,%,$<),jm d64 $@
	c1541$(EXE) $@ -write $< $(patsubst %.prg,%,$<)

$(name).d64: $(name).prg

$(name).prg: $(name).dasm

clean:
	rm -f $(targets)

run: $(name).d64
	x64sc$(EXE) -autostart $(name).d64
