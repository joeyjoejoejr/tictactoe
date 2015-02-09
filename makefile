PLAYFIELD_BMPS = $(wildcard playfields/*.bmp)
INCLUDES  = includes/vcs.h includes/macro.h
DASM = dasm
STELLA = /Applications/Stella.app/Contents/MacOS/Stella
DASMFLAGS = -f3 -ldist/tictactoe.txt -odist/tictactoe.bin -sdist/tictactoe.sym -Idist
BINFILE = tictactoe.bin

all: $(BINFILE)

$(BINFILE): $(INCLUDES) $(PLAYFIELD_BMPS) src distdir
	$(DASM) dist/$(basename $(@F)).dasm $(DASMFLAGS)

$(INCLUDES): distdir
	cp $@ dist/

$(PLAYFIELD_BMPS): distdir
	bin/bmp2pf $@ > dist/$(@F)

src: distdir
	cp src/*.dasm dist/

distdir:
	mkdir -p dist

clean:
	rm -rf dist

run: all
	$(STELLA) dist/$(BINFILE)

