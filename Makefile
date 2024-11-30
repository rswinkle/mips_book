
DOCS = contents.adoc info.adoc ch0.adoc ch1.adoc ch2.adoc ch3.adoc ch4.adoc ch5.adoc ch6.adoc ch7.adoc refs.adoc

all: pdfbook htmlbook epubbook

html: ${DOCS}
	asciidoctor ${DOCS}
	mv *.html build/

pdfbook: ${DOCS}
	asciidoctor-pdf -a is_pdf book.adoc -o mips_book.pdf

htmlbook:
	asciidoctor book.adoc -o mips_book.html

epubbook:
	asciidoctor-epub3 -a ebook-validate book.adoc -o mips_book.epub

clean:
	rm mips_book.pdf
	rm mips_book.epub
	rm mips_book.html
	rm build/*.html
	rm build/*.pdf

