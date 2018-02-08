# A Makefile for generating the PDFs from the R Markdown files.
#
# Type "make" in this directory to generate the PDFs from the R
# Markdown files.
#
# Type "make clean" to discard the generated PDFs, and all accompanying
# output.
#

# RULES
# -----
all: slides.pdf

# Create the PDF file.
slides.pdf : slides.Rmd
	Rscript -e 'rmarkdown::render("slides.Rmd")'

clean:
	rm -f slides.tex slides.pdf
	rm -Rf slides_files

