OUTDIR = Workarea

all : clean feynmf

debug : clean debugint

feynmf :
	cp thesis.tex ${OUTDIR}
	make -C ${OUTDIR} feynmf
	cp ${OUTDIR}/thesis.pdf .
	ls -hl thesis.pdf

debugint :
	cp thesis.tex ${OUTDIR}
	make -C ${OUTDIR} debug
	cp ${OUTDIR}/thesis.pdf .
	ls -hl thesis.pdf

simple : 
	cp thesis.tex ${OUTDIR}
	make -C ${OUTDIR} simple
	cp ${OUTDIR}/thesis.pdf .
	ls -hl thesis.pdf



clean :
	rm -f ${OUTDIR}/*.*
	

