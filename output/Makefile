export TEXINPUTS := .//:../style//:../sections//:${TEXINPUTS}
export BIBINPUTS := .//:../bibs//:${TEXINPUTS}

THESIS = thesis

all:
	pdflatex ${THESIS}
	pdflatex ${THESIS}
	bibtex   ${THESIS}
	pdflatex ${THESIS}
	pdflatex ${THESIS}
	dvipdf   ${THESIS}

simple: 
	bibtex ${THESIS}
	dvipdf ${THESIS}

debug:
	@rm -f ../debug.log
	bibtex ${THESIS} | tee -a ../debug.log
	dvipdf ${THESIS}

