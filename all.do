fd *.html.in | while read src
do
	echo public/${src%.*}
done | xargs redo-ifchange
