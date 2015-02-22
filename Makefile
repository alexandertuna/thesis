export TEXINPUTS := .//:./style//:sections//:${TEXINPUTS}
export BIBINPUTS := .//:./bibs//:${TEXINPUTS}

THESIS = thesis

all:
	pdflatex ${THESIS}
	bibtex   ${THESIS}
	pdflatex ${THESIS}
	pdflatex ${THESIS}
	clear
	du -hs
	ls -ltrh
	open -a preview ${THESIS}.pdf
	sh scripts/pages.sh
	git status

