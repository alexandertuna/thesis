\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pennThesis}[11/04/\the\year2011 UPenn HEP Thesis Class] 

% the 'oneside' option is needed for single-sided documents
\LoadClass[10pt,letterpaper,openany,oneside]{memoir}

%% -----------------------------------------------------------------------------
%% Begin some switches for different versions
\RequirePackage{ifthen}

\newboolean{boolVersionForPenn}
\setboolean{boolVersionForPenn}{false}

%% -----------------------------------------------------------------------------

% Some standard stuff
\RequirePackage{graphicx}
\RequirePackage{verbatim}
\RequirePackage{color}

% Symbols and such
\RequirePackage{amsmath,amssymb,bm}
\RequirePackage{atlasphysics}
\RequirePackage{calc}

% Note: not subfigure
% \RequirePackage{subfig}

% some tikz stuff
% \RequirePackage{tikz}
% \usetikzlibrary{arrows,backgrounds,decorations.shapes,decorations.text,decorations.markings,decorations.pathmorphing,fit,shapes,snakes,patterns} 

% caption settings with ccaption
% \captionnamefont{\bfseries}
\hangcaption{}

% Line numbering for drafts
\RequirePackage{lineno}

\ifthenelse{\boolean{boolVersionForPenn}}{
  % For what goes to ProQuest and for what I print out, who knows what they 
  % want.  So just include URL, which is pretty harmless.
  \RequirePackage{url}
}{
  % This is the format I use for an electronic document, e.g. what's submitted to CDS
  \RequirePackage[colorlinks=true,breaklinks=true,linktocpage=true,backref,citecolor=red,filecolor=black,linkcolor=red,urlcolor=blue]{hyperref}
}

% Handling single/double spacing properly
\RequirePackage{setspace}

% For rotated tables, long tables, etc.
\RequirePackage{rotating}
\RequirePackage{lscape}
\RequirePackage{longtable}

% Prevent footnotes from being reset after chapter breaks
\RequirePackage{dcounter}
\countstyle[footnote]{}

%% Load this last...  it's picky (but still useful).
\RequirePackage[capitalize]{cleveref}

% Be careful with this.  LaTeX will look through the TEXINPUTS environment variable first, 
% *then* through this graphicspath.  It's probably better to just add whatever path would 
% be here to the beginning of TEXINPUTS.
% \graphicspath{{figs/}}

% This is actually somewhat annoying.  Keep in mind that {\bf my bold text} won't work anymore...
% you'll need to do \bf{my bold text} instead, the same way you'd do \textbf{my bold text}.
\renewcommand{\bf}{\textbf}
\renewcommand{\it}{\textit}
\renewcommand{\tt}{\texttt}
\renewcommand{\rm}{\textrm}

% Make the chapter headings a little nicer
% Based on the 'bianchi' chapter style, but with
% serif text, and small-caps for the word ``Chapter''.
\makechapterstyle{pennChapters}{%
  \renewcommand*{\chapnamefont}{\normalfont\huge}
  \renewcommand*{\chapnumfont}{\normalfont\huge}
  \renewcommand*{\printchaptername}{%
    \chapnamefont\centering\textsc{\@chapapp}}
  \renewcommand*{\printchapternum}{\chapnumfont \thechapter}
  \renewcommand*{\chaptitlefont}{\normalfont\Huge\sffamily}
  \renewcommand*{\printchaptertitle}[1]{%
    \hrule\vskip\onelineskip \centering \chaptitlefont\textbf{##1}\par}
  \renewcommand*{\afterchaptertitle}{\vskip\onelineskip \hrule\vskip
    \afterchapskip}
  \renewcommand*{\printchapternonum}{%
    \vphantom{\chapnumfont \textit{9}}\afterchapternum}}
\chapterstyle{pennChapters}

% Prevent chapter headings from being double-spaced
\renewcommand*{\chaptitlefont}{\normalfont\Huge\begin{Spacing}{1}}
\renewcommand*{\afterchaptertitle}{\vskip\onelineskip \hrule\vskip \afterchapskip\end{Spacing} \vskip\onelineskip}


% Page headings, slightly different from the default.
\makepagestyle{pennHeadings}
\makepsmarks{pennHeadings}{%
  \let\@mkboth\markboth
  \def\chaptermark##1{%
    \markright{\textsc{%
        \ifnum \c@secnumdepth >\m@ne
        \if@mainmatter
        \thechapter. \ %
        \fi
        \fi
        ##1}}}%
  \def\tocmark{\markright{\textsc{\contentsname}}}%
  \def\lofmark{\markright{\textsc{\listfigurename}}}%
  \def\lotmark{\markright{\textsc{\listtablename}}}%
  \def\bibmark{\markright{\textsc{\bibname}}}%
  \def\indexmark{\markright{\textsc{\indexname}}}%
}


% We're making a document with single-sided pages, so only need to define 
% the headings for odd page numbers
\makeoddhead{pennHeadings}{\rightmark}{}{\thepage}


% Add a line below the page headings.
\makeheadrule{pennHeadings}{\textwidth}{0.3pt}
\pagestyle{pennHeadings}


%% Here's a better layout for a final draft
\setstocksize{11in}{8.5in}
\settrimmedsize{11in}{8.5in}{*}
\settrims{0in}{0in}
\ifthenelse{\boolean{boolVersionForPenn}}{
  \settypeblocksize{8in}{5.625in}{*}
  \setlrmargins{1.625in}{*}{*}
  \setulmargins{1.5in}{*}{*}
}{
  \settypeblocksize{8.2in}{6.1in}{*}
  \setlrmargins{1.2in}{*}{*}
  \setulmargins{1.4in}{*}{*}
}
\setheadfoot{13pt}{26pt}
\setheaderspaces{*}{13pt}{*}
\checkandfixthelayout

%% Line spacing should be 2 for Penn document.  I've made it 1.5 for ``my'' version.
\ifthenelse{\boolean{boolVersionForPenn}}{
  \newcommand{\mylinespacing}{2}
}{
  \newcommand{\mylinespacing}{1.5}
}

%% Yeah, I should make this a little more general, with macros and such,
%% rather than the actual title/names/etc.
%% Maybe for the next dissertation.
\newcommand{\maketitlepage}{
  \thispagestyle{empty}
  
  \begin{center}
    \begin{Spacing}{\mylinespacing}
      {\huge\textsc{\@title}}
    \end{Spacing}

  \vspace*{.5cm}

  {\Large \@author }

  \vspace*{.5cm}

  {\Large {\textsc{a dissertation}}}
  
  \vspace*{.2cm}

  {\Large in}

  \vspace*{.2cm}

  {\Large Physics and Astronomy}

  \vspace*{.5cm}

  {\Large Presented to the Faculties of \myinstitution}
  
  \vspace*{.2cm}

  {\Large in~Partial~Fulfillment~of~the~Requirements~for~the~Degree~of~Doctor~of~Philosophy}
  
  \vspace*{.2cm}

  {\Large \the\year}
  \end{center}

  \vspace*{1.75cm}

  \begin{center}
    {\underline{
        \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 
        \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ }}

    \vspace*{.2cm}

    {\Large \adviser}
    
    \vspace*{.2cm}

    {\Large Supervisor of Dissertation}

    \vspace*{1.75cm}

    {\underline{
        \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 
        \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ }}

    \vspace*{.2cm}

    {\Large \chairperson}

    \vspace*{.2cm}

    {\Large Graduate Group Chairperson}

    \vspace*{1.5cm}

    {\Large \underline{Dissertation Committee}}

    \vspace*{.2cm}

    {\Large \committeeOne}

    \vspace*{.2cm}

    {\Large \committeeTwo}

    \vspace*{.2cm}

    {\Large \committeeThree}

    \vspace*{.2cm}

    {\Large \committeeFour}

    \vspace*{.2cm}

    {\Large \adviser}
  \end{center}

  \newpage
}


%% More stuff I should probably make less specific.
\newcommand{\makeabstractpage}{
  \thispagestyle{plain}
  
  \begin{Spacing}{\mylinespacing}
  \begin{center}

    \ifthenelse{\boolean{boolVersionForPenn}}{}{\vspace*{2cm}}

    {\Huge \textsc{abstract}}

    \vspace*{1cm}

    {\Large \textsc{\@title}}

    \vspace*{1cm}

    {\Large \@author}

    \vspace*{.8cm}

    {\Large \advisershort}
    
    \vspace*{1cm}

  \end{center}

  \input{abstract}
  \end{Spacing}
  \addcontentsline{toc}{chapter}{Abstract}
  \newpage
}

% Make this look like a real chapter, but don't number it as such.
\newcommand{\makeacknowledgementspage}{
  \thispagestyle{plain}

  \begin{Spacing}{\mylinespacing}
    \chapter*{Acknowledgements}
    \addcontentsline{toc}{chapter}{Acknowledgements}
    \input{acknowledgements}
  \end{Spacing}
  \newpage
}


% Copyright page.
\newcommand{\makeCCcopyrightpage}{
  \thispagestyle{plain}

  \vspace*{5cm}

  \begin{center}
    {\Large \textsc{\@title}}

    \vspace*{2cm}

    {\Large \textsc{copyright}}
    
    {\Large \the\year}

    {\Large \@author}

    \vspace*{2cm}
    
    \begin{minipage}{.8\columnwidth}
      \centering
      {\large

        \includegraphics{creative_commons_copyright}

        This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. 

        \vspace*{.3cm}

        To view a copy of this license, visit \url{http://creativecommons.org/licenses/by-nc-sa/3.0}

        \vspace*{.3cm}

        or send a letter to:

        \vspace*{.3cm}

        Creative Commons\\
        444 Castro Street, Suite 900\\
        Mountain View, CA 94140\\
        USA\\}
    \end{minipage}
  \end{center}
}


% Copyright page.
\newcommand{\makecopyrightpage}{
  \thispagestyle{plain}

  \vspace*{5cm}

  \begin{center}
    {\Large \textsc{\@title}}

    \vspace*{2cm}

    {\Large \textsc{copyright}}
    
    {\Large \the\year}

    {\Large \@author}

    \vspace*{2cm}
    
    All rights reserved.
  \end{center}
}


% Make all of the front matter, up to the table of contents.
\renewcommand{\maketitle}{
  \begin{titlingpage}
    \maketitlepage
    \makecopyrightpage
  \end{titlingpage}
  \setcounter{page}{3} % The title page should be page 'i'.
  \makeacknowledgementspage
  \makeabstractpage
}


% Draft version
\def\@draftversion{}
\newcommand{\draftversion}[1]%
{
  \def\@draftversion{#1}
}


% Draft heading code
% \newcommand{\draftheading}%
% {
%   %   
%   % compute the time in hours and minutes
%   % make new variables \timehh and \timemm
%   %   
%   \newcount\timehh\newcount\timemm
%   \timehh=\time 
%   \divide\timehh by 60 \timemm=\time
%   \count255=\timehh\multiply\count255 by -60 \advance\timemm by \count255
%   % put in header
%   \markboth%
%   % --- Left mark
%   {\hspace*{\fill}{\protect\small\bf \fbox{DRAFT}}
%     \hspace*{\fill}
%     \protect\makebox[0pt][r]{\protect\small\today\ --  
%       \ifnum\timehh<10 0\fi\number\timehh\,:\,\ifnum\timemm<10 0\fi\number\timemm}
%   }%--- right mark
%   {\protect\makebox[0pt][l]{\protect\small\today\ --  
%       \ifnum\timehh<10 0\fi\number\timehh\,:\,\ifnum\timemm<10 0\fi\number\timemm}
%     \hspace*{\fill}
%     {\protect\small\bf \fbox{DRAFT}}
%     \hspace*{\fill}}
%   %
%   \pagestyle{myheadings}
% }


% If this is a draft, then add the line numbers to the document.
\AtBeginDocument{
  \ifx\@draftversion\@empty%
  \else \linenumbers % \draftheading
  \fi
}


% Control the depth of the table of contents, and how deep you can number sub-sub-sub sections.
\setcounter{tocdepth}{3}
\setcounter{secnumdepth}{4}
\setcounter{maxsecnumdepth}{4}


% So that transparent images in tikz don't screw with the output in Acrobat.
\pdfpageattr{/Group <</S /Transparency /I true /CS /DeviceRGB>>} 
