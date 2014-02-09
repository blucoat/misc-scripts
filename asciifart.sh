#!/bin/bash

url="http://www.asciiartfarts.com/index.html" 
filter="/<pre>/,/<\/pre>/ {if (\$0 ~ /<pre>/ || \$0 ~ /<\/pre>/) {} else {print;}}"

while getopts nr opt; do 
  case $opt in 
    n) filter="/<font [^>]*><pre>/,/<\/pre>/ {if (\$0 ~ /<font [^>]*><pre>/ || \$0 ~ /<\/pre>/) {} else {print;}}" ;;
    r) url="http://www.asciiartfarts.com/random.cgi" ;; 
    *) exit ;;
  esac 
done 

wget "$url" -O - -q | awk -- "$filter" | sed "s/\&amp\;/\&/g;s/\&gt\;/>/g;s/\&lt\;/</g"
