# The mother of all Makefiles for LaTeX
#     The Makefile that automatically does what you want for (pdf)latex.
# 
# SYNOPSIS
#     make [pdf|ps|dvi|dvipdf|mf]
# 
# DESCRIPTION
#     Builds virtually any LaTeX document with *no* configuration.
#     Supports documents with
#
#     	1. latex and pdflatex markup and figures
#       2. optional index with makeindex
#       3. optional bibtex bibliographies
#       4. optional feynmf figures
#
#     This Makefile will properly build all the above automatically if
#     present in your markup.
# 
# MAIN TARGETS
#     pdf
#         Builds a pdf file of the document using pdflatex.
#         tex -> pdflatex -> pdf
#         
#     ps
#         Builds a ps file of the document using latex.
#         tex -> latex -> dvi -> dvips -> ps
#     
# AUTHOR
#     Ryan Reece  <ryan.reece@cern.ch>
# 
# COPYRIGHT
#     Copyright 2012-2013 Ryan Reece
#     License: GPL <http://www.gnu.org/licenses/gpl.html>
# 
# SEE ALSO
#     Some ideas taken from:
#     <http://www.acoustics.hut.fi/u/mairas/UltimateLatexMakefile>
# 
# 2012-12-02
#
###############################################################################

export TEXINPUTS := .//:./style//:./tex//:${TEXINPUTS}

#------------------------------------------------------------------------------
# variables
#------------------------------------------------------------------------------

## debug
#DEBUG_TOGGLE    = anything
DEBUG_PRINT     = $(if $(DEBUG_TOGGLE), echo '@@> ', :)
PRINT           = echo '@@  '

## dependency getters
PERL_GET_TEX = perl -ne '($$_)=/^[^%]*(?:include|input)\{(.*?)\}/;@_=split /,/;foreach $$t (@_) {print "$$t.tex "}'
PERL_GET_BIB = perl -ne '($$_)=/^[^%]*bibliography\{(.*?)\}/;@_=split /,/;foreach $$b (@_) {print "$$b.bib "}'
PERL_GET_EPS = perl -ne '@foo=/^[^%]*(includegraphics|psfig)(\[.*?\])?\{(.*?)\}/g;if (defined($$foo[2])) { if ($$foo[2] =~ /.eps$$/) { print "$$foo[2] "; } else { print "$$foo[2].eps "; }}'

## the main tex file
SRC	:= $(shell egrep -l '^[^%]*\\begin\{document\}' *.tex)
DVI	:= $(SRC:%.tex=%.dvi)
PSF	:= $(SRC:%.tex=%.ps)
PDF	:= $(SRC:%.tex=%.pdf)
BASENAME := $(SRC:%.tex=%)
MFF := $(SRC:%.tex=%-feyn.mf)
TOC := $(SRC:%.tex=%.toc)
INCLUDED_TEX := $(shell $(PERL_GET_TEX) $(SRC))
#alltex := $(wildcard *.tex tex/*.tex)

## executables
LATEX     = $(if $(filter $(DVI), $@), latex, pdflatex)
BIBTEX    = bibtex
MAKEINDEX = makeindex
XDVI      = xdvi -gamma 4
DVIPS	  = dvips
DVIPDF    = dvipdft
L2H       = latex2html
GH        = gv
MF        = mf '\mode=localfont; input $(MFF)'

## misc commands
DATE = $(shell date +%Y-%m-%d)
COPY_TOC = if test -r $(TOC); then cp $(TOC) $(TOC).bak; fi
RM = rm -f

## error handeling
ALLOW_ERROR = || $(PRINT) "$@: Skipping error. Exit status: $$?, continuing..."
CHECK_ERROR = || ($(PRINT) "$@: Error! Exit status: $$?, halting..." && $(PRINT_WARNINGS) && false)
#CHECK_WARNINGS = egrep -i -B 1 -A 1 '(^!)' latex.log
CHECK_WARNINGS = egrep -i -B 1 -A 1 '(^!)|(Warning|Error)' latex.log
PRINT_WARNINGS = $(PRINT) "warnings/errors   -------------------------------------------------"; \
	$(CHECK_WARNINGS); \
	$(PRINT) "-------------------------------------------------------------------"

## checks to determine what to run
CHECK_MAKEINDEX = egrep -c '^[^%]*\\\\makeindex' $(BASENAME).tex
CHECK_MF        = egrep -c '^[^%]*\\\\begin\{fmffile\}' $(BASENAME).tex
CHECK_BIBTEX    = egrep -c '(No file.*\\.bbl)|(Citation.*undefined)' $(BASENAME).log
CHECK_LATEX     = egrep -c '(There were undefined)|(Rerun to get)' $(BASENAME).log
CHECK_TOC       = if cmp -s $(BASENAME).toc $(BASENAME).toc.bak; then echo 'unchanged'; else echo 'needs re-run'; fi

## command wrappers
RUN_MAKEINDEX   = $(PRINT) "- running makeindex (output in makeindex.log)" ; \
	$(MAKEINDEX) $(<:%.tex=%) &> makeindex.log $(ALLOW_ERROR)
RUN_BIBTEX      = $(PRINT) "- running bibtex (output in bibtex.log)" ; \
	$(BIBTEX) $(<:%.tex=%) &> bibtex.log $(ALLOW_ERROR)
RUN_MF          = $(PRINT) "- running metafont (output in mf.log)" ; \
	$(MF) &> mf.log $(ALLOW_ERROR)
RUN_LATEX_FIRST = $(PRINT) "- running latex (output in latex.log)" ; \
	$(COPY_TOC) ; \
	$(LATEX) -interaction=nonstopmode $< &> latex.log $(ALLOW_ERROR)
RUN_LATEX       = $(PRINT) "- running $(strip $(LATEX)) (output in latex.log)" ; \
	$(COPY_TOC) ; \
	$(LATEX) -interaction=nonstopmode $< &> latex.log $(ALLOW_ERROR)
RUN_LATEX_HALT  = $(PRINT) "- running $(strip $(LATEX)) (output in latex.log)" ; \
	$(COPY_TOC) ; \
	$(LATEX) -halt-on-error $< &> latex.log $(CHECK_ERROR)
RUN_DVIPS       = $(PRINT) "- running dvips (output in dvips.log)" ; \
	$(DVIPS) $< -o $@ &> dvips.log $(CHECK_ERROR)
RUN_DVIPDF      = $(PRINT) "- running dvipdf (output in dvipdf.log)" ; \
	$(DVIPDF) -o $@ $< &> dvipdf.log $(CHECK_ERROR)

## latex build routine
define BUILD
	$(PRINT_WELCOME)
	$(DEBUG_PRINT) "step 1:  CHECK_MF = `$(CHECK_MF)`"
	if (( `$(CHECK_MF)` > 0 )); then make mf; fi
	$(DEBUG_PRINT) "step 2: latex that will halt on error"
	$(RUN_LATEX_HALT)
	$(DEBUG_PRINT) "step 3:  CHECK_MAKEINDEX = `$(CHECK_MAKEINDEX)`"
	if (( `$(CHECK_MAKEINDEX)` > 0 )); then $(RUN_MAKEINDEX); $(RUN_LATEX); fi
	$(DEBUG_PRINT) "step 4:  CHECK_BIBTEX = `$(CHECK_BIBTEX)`"
	if (( `$(CHECK_BIBTEX)` > 0 )); then $(RUN_BIBTEX); $(RUN_LATEX); fi
	$(DEBUG_PRINT) "step 5:  CHECK_LATEX = `$(CHECK_LATEX)`"
	if (( `$(CHECK_LATEX)` > 0 )); then $(RUN_LATEX); fi
	$(DEBUG_PRINT) "step 6:  CHECK_LATEX = `$(CHECK_LATEX)`"
	if (( `$(CHECK_LATEX)` > 0 )); then $(RUN_LATEX); fi
	$(DEBUG_PRINT) "step 7:  CHECK_TOC = `$(CHECK_TOC)`"
	if cmp -s $(BASENAME).toc $(BASENAME).toc.bak; then true ; else $(RUN_LATEX); fi
	$(DEBUG_PRINT) "step 8:  rm"
	$(RM) $(BASENAME).toc.bak ; true
	$(PRINT_WARNINGS)
endef

## welcome message
define PRINT_WELCOME
	$(PRINT) "---------  welcome to the mother of all latex makefiles  ----------" ; \
	$(PRINT) "found the main tex file: $(SRC)" ; \
	$(PRINT) "which includes: $(INCLUDED_TEX)" ; \
	$(PRINT) "-------------------------------------------------------------------" ; \
	$(PRINT) "let's build your document..."
endef


#------------------------------------------------------------------------------
# named targets
#------------------------------------------------------------------------------
default: pdf

pdf: pdf-imp
	@$(PRINT) "pdf done."

ps: $(PSF) 
	@$(PRINT) "ps done."

dvi: $(DVI)
	@$(PRINT) "dvi done."

dvipdf: $(PDF)
	@$(PRINT) "dvipdf done."

mf: $(MFF)
	@$(PRINT) "mf done."

# TODO: This probably needs fixing
html: $(SRC) $(INCLUDED_TEX)
	@$(DEBUG_PRINT) "- building $@" ; \
	$(L2H) $(SRC) ; \
	$(PRINT) "html done."

JUNK = *.aux *.log *.bbl *.blg *.brf *.cb *.ind *.idx *.ilg *.inx *.dvi *.toc *.out *~ ~* spellTmp *.lot *.lof *.ps *.d

clean:
	@$(DEBUG_PRINT) "- clean" ; \
	rm -f $(JUNK) ; \
	if [ -d tex ] ; then cd tex && rm -f $(JUNK) && cd ../ ; fi

mfclean:
	@$(DEBUG_PRINT) "- mfclean" ; \
	rm -f $(BASENAME)-feyn.*

binclean:
	@$(DEBUG_PRINT) "- binclean" ; \
	rm -f $(BASENAME).pdf

distclean: clean

realclean: clean mfclean binclean

over: realclean default
all: over

show: $(DVI)
	@for i in $(DVI) ; do $(XDVI) $$i & done

showps: $(PSF)
	@for i in $(PSF) ; do $(GH) $$i & done

manual: $(SRC) $(INCLUDED_TEX)
	$(RUN_LATEX_FIRST)
	$(RUN_MF)
	$(RUN_LATEX_HALT)
	$(RUN_BIBTEX)
	$(RUN_LATEX)
	$(RUN_LATEX)
	$(RUN_LATEX)
	$(RM) $(BASENAME).toc.bak ; true

test: 
	@$(DEBUG_PRINT) "- building $@" ; \
	echo "inc1 = $(INCLUDED_TEX)" ; \
	echo $@ ; \
	echo $(LATEX)

.PHONY : default all mf ps dvipdf pdf pdf-imp html show showps info test clean depclean mfclean binclean distclean realclean over


#------------------------------------------------------------------------------
# file targets
#------------------------------------------------------------------------------
## This is a rule to generate a file of prerequisites for a given .tex file.
%.d: %.tex
	@$(DEBUG_PRINT) "- building $@" ; \
	deps=`$(PERL_GET_TEX) $<` ; \
	$(DEBUG_PRINT) "tex:" $$deps ; \
	bibs=`$(PERL_GET_BIB) $< $$deps`; \
	$(DEBUG_PRINT) "bib:" $$bibs ; \
	epses=`$(PERL_GET_EPS) $< $$deps` ; \
	$(DEBUG_PRINT) "eps:" $$epses ; \
	echo "$*.dvi $@ : $< $$deps $$bibs $$epses" > $@ 

## These lines include prerequisite Makefile fragments from .d files for each
## .tex file, creating them according to the target above if they don't exist.
-include $(SRC:%.tex=%.d)
-include $(INCLUDED_TEX:%.tex=%.d)

## Not really a file target, but pdf-imp is grouped here with the other
## main targets that build.  The implicit target %.pdf is for dvipdf.
pdf-imp: $(SRC) $(INCLUDED_TEX)
	@$(DEBUG_PRINT) "- building $@" ; \
	$(BUILD)

## builds the dvi with latex
$(DVI): $(SRC) $(INCLUDED_TEX)
	@$(DEBUG_PRINT) "- building $@" ; \
	$(BUILD)

## makes a pdf from dvi with dvipdf
%.pdf: %.dvi
	@$(DEBUG_PRINT) "- building $@" ; \
	$(RUN_DVIPDF)

## makes a ps from dvi with dvips
%.ps: %.dvi
	@$(DEBUG_PRINT) "- building $@" ; \
	$(RUN_DVIPS)

## builds the mf file
##   because one doesn't expect you to change these figures often,
##   MFF isn't set to depend INCLUDED_TEX, and will only be built
##   when it doesn't already exist.  if you need to remake it, run
##   make mfclean first.
$(MFF): $(SRC)
	@$(DEBUG_PRINT) "- building $@" ; \
	$(PRINT) "it looks like you have some metafont figures." ; \
	$(RUN_LATEX_FIRST); \
	$(RUN_MF)

# EOF
