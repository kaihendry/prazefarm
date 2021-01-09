find -name "*.html.in" | while read src
do
	echo ${src%.*}
done | xargs redo-ifchange
