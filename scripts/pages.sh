echo [$(date +%Y-%m-%d-%Hh%Mm%Ss)] $(pdfinfo thesis.pdf | grep Pages | tr -d "Pages: ") >> pages.md

