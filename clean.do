find . -name "*.html" -o -name "*.m4-processed" | while read fn
do
	rm $fn
done
