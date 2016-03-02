
TARGET=main.tex

DOT=$(wildcard figs/*.dot)
SVG=$(wildcard figs/*.svg)
SVG+=$(wildcard plots/*.svg)

all: paper

%.pdf: %.svg
	inkscape --export-pdf $(@) $(<)

%.eps: %.svg
	inkscape --export-eps $(@) $(<)

%.aux: paper

%.svg: %.dot

	twopi -Tsvg -o$(@) $(<)

bib: $(TARGET:.tex=.aux)

	BSTINPUTS=:./sty bibtex $(TARGET:.tex=.aux)

paper: $(TARGET) $(SVG:.svg=.eps) $(DOT:.dot=.eps)

	TEXINPUTS=:./sty pdflatex $(TARGET)

clean:
	rm -f *.spl *.idx *.aux *.log *.snm *.out *.toc *.nav *intermediate *~ *.glo *.ist *.bbl *.blg $(SVG:.svg=.eps) $(DOT:.dot=.svg) $(DOT:.dot=.pdf)

distclean: clean
	rm -f $(TARGET:.tex=.pdf)
