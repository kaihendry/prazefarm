redo-ifchange *.inc $2.html.in
m4 -PEIinc < $2.html.in | toc
