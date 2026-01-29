#!/bin/bash

# Note: this script is executed by ../../../Makefile
# (it is not intended to be executed locally)
local_dir="`pwd`/tools/crmasks/files"
fname="${local_dir}/terminal_output_example4"
input="${fname}.txt"

#------------------------------------------------------------------------------
output="${fname}_01.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 0 0 195 224
#------------------------------------------------------------------------------
output="${fname}_02.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 225 247
#------------------------------------------------------------------------------
