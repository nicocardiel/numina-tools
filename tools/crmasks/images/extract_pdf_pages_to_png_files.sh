#!/bin/bash

# Note: PDF pages are zero-indexed in ImageMagick, so [1] means page 2

input="mediancr_identified_example1.pdf"

for page in 3 4 12; do
  npage=$((page + 1))
  fpage=$(printf "%02d" "$npage")
  output="cr${fpage}_example1.png"
  magick -density 300 "${input}[${page}]" -quality 100 "$output"
  echo "${output} generated"
done
