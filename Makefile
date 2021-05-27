
DOCS = contents.adoc ch0.adoc ch1.adoc ch2.adoc ch3.adoc ch4.adoc ch5.adoc refs.adoc

book: ${DOCS}
	asciidoctor ${DOCS}
	mv *.html build

clean:
	rm build/*.html

