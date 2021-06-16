
DOCS = contents.adoc ch0.adoc ch1.adoc ch2.adoc ch3.adoc ch4.adoc ch5.adoc ch6.adoc ch7.adoc refs.adoc

all: html pdfbook htmlbook

html: ${DOCS}
	asciidoctor ${DOCS}
	mv *.html build/article

pdfbook: ${DOCS}
	asciidoctor-pdf -d book book.adoc

htmlbook:
	asciidoctor -d book book.adoc

clean:
	rm build/*.html
	rm book.pdf book.html

