#!/bin/bash

# Note: this script is executed by ../../../Makefile
# (it is not intended to be executed locally)
local_dir="`pwd`/tools/crmasks/files"
fname="${local_dir}/terminal_output_example2a"
input="${fname}.txt"

# Note: to identify line numbers, it is useful to use:
# $ cat -n filename.txt
# (enlarge the terminal)
#------------------------------------------------------------------------------
output="${fname}_00.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 1 9 0 0
#------------------------------------------------------------------------------
output="${fname}_01.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 0 0 221 224
#------------------------------------------------------------------------------
output="${fname}_01b.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 225 230
#------------------------------------------------------------------------------
output="${fname}_01c.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 231 271
#------------------------------------------------------------------------------
output="${fname}_02.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 272 282
#------------------------------------------------------------------------------
output="${fname}_03.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 283 291
#------------------------------------------------------------------------------
output="${fname}_04.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 292 312 0 0 650 650
#------------------------------------------------------------------------------
