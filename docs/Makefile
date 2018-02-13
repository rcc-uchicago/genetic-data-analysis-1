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
all: slides_test.pdf slides.pdf

# Generate the slides while also testing the R code.
slides_test.pdf : ../code/slides.Rmd
	Rscript -e 'knitr::opts_chunk$$set(eval = TRUE); rmarkdown::render("../code/slides.Rmd",output_file = "../docs/slides_test.pdf")'

# Create the slides.
slides.pdf : ../code/slides.Rmd
	Rscript -e 'knitr::opts_chunk$$set(eval = FALSE); rmarkdown::render("../code/slides.Rmd",output_file = "../docs/slides.pdf")'

clean:
	rm -f slides.tex slides.pdf slides_test.pdf


