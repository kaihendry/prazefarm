src="${2#public/}"
redo-ifchange *.inc $src.html.in
m4 -PEIinc < $src.html.in | toc
