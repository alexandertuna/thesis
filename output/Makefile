export TEXINPUTS := .//:../style//:../sections//:${TEXINPUTS}
export BIBINPUTS := .//:../bibs//:${TEXINPUTS}

feynmf :
	@echo "feynmf thesis" 
	@feynmf thesis >> /dev/null 
	@echo "feynmf thesis" 
	@feynmf thesis >> /dev/null 
	@echo "bibtex thesis" 
	@bibtex thesis >> /dev/null 
	@echo "feynmf thesis" 
	@feynmf thesis >> /dev/null 
	@echo "feynmf thesis" 
	@feynmf thesis >> /dev/null 
	@echo "dvipdf thesis" 
	@dvipdf thesis >> /dev/null 

latex :
	pdflatex thesis
	pdflatex thesis
	bibtex thesis
	pdflatex thesis
	pdflatex thesis
	dvipdf thesis

simple : 
	feynmf thesis
	feynmf thesis
	bibtex thesis
	feynmf thesis
	feynmf thesis
	dvipdf thesis

debug : 
	@rm -f ../debug.log
	feynmf thesis
	feynmf thesis
	bibtex thesis | tee -a ../debug.log
	feynmf thesis
	feynmf thesis | tee -a ../debug.log
	dvipdf thesis
	
