#!/bin/bash

# Note: this script is executed by ../../../Makefile
# (it is not intended to be executed locally)
local_dir="`pwd`/tools/crmasks/files"
fname="${local_dir}/terminal_output_example4"
input="${fname}.txt"

# Note: to identify line numbers, it is useful to use:
# $ cat -n filename.txt
# (enlarge the terminal)
#------------------------------------------------------------------------------
output="${fname}_01.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 0 0 195 224
#------------------------------------------------------------------------------
output="${fname}_02.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 225 233
#------------------------------------------------------------------------------
output="${fname}_03.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 234 255
#------------------------------------------------------------------------------
