THESIS = thesis
OUTDIR = output
TEXDIR = tex

all: 
	cp ${TEXDIR}/*.tex ${OUTDIR}/
	make -C ${OUTDIR}
	cp ${OUTDIR}/${THESIS}.pdf ./
	ls -hl ${THESIS}.pdf

