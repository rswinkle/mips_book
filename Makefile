
DOCS = contents.adoc ch0.adoc ch1.adoc ch2.adoc ch3.adoc ch4.adoc ch5.adoc ch6.adoc ch7.adoc refs.adoc

all: html book docbook

html: ${DOCS}
	asciidoctor ${DOCS}
	mv *.html build/article

pdf: ${DOCS}
	asciidoctor-pdf -d book book.adoc

book:
	asciidoctor -d book ${DOCS}
	mv *.html build/book

docbook:
	asciidoctor -d book ${DOCS}
	mv *.html build/docbook

clean:
	rm build/*.html

