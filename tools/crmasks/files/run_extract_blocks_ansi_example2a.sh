#!/bin/bash

# Note: this script is executed by ../../../Makefile
# (it is not intended to be executed locally)
local_dir="`pwd`/tools/crmasks/files"
fname="${local_dir}/terminal_output_example2a"
input="${fname}.txt"

#------------------------------------------------------------------------------
output="${fname}_00.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 1 9 0 0
#------------------------------------------------------------------------------
output="${fname}_01.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 0 0 219 222
#------------------------------------------------------------------------------
output="${fname}_02.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 254 264
#------------------------------------------------------------------------------
output="${fname}_03.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 265 272
#------------------------------------------------------------------------------
output="${fname}_04.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 273 293 0 0 631 631
#------------------------------------------------------------------------------
