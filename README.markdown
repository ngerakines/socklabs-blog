
# About

This is the Jekyll repository for [my blog](http://blog.socklabs.com/).

# HAHAHA

ls -1 *.txt | awk '{ newFile = $0; split(substr(newFile, 0, 11), d, "-"); printf( "echo \"date: %s/%s/%s\" | cat - %s > %s.new && mv %s.new %s\n", d[1], d[2], d[3], newFile, newFile, newFile, newFile); }'

ls -1 *.txt | awk '{ oldFile = $0; newFile = substr(oldFile, 10, length(oldFile)-13); printf( "echo \"slug: %s\" | cat - %s > %s.new && mv %s.new %s\n", newFile, oldFile, oldFile, oldFile, oldFile, oldFile); }'
