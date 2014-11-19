export TEXINPUTS := .//:./style//:sections//:${TEXINPUTS}
export BIBINPUTS := .//:./bibs//:${TEXINPUTS}

THESIS = thesis

all:
	pdflatex ${THESIS}
	pdflatex ${THESIS}
	bibtex   ${THESIS}
	pdflatex ${THESIS}
	pdflatex ${THESIS}
	clear
	ls -ltrh

