#!/bin/bash

# Note: this script is executed by ../../../Makefile
# (it is not intended to be executed locally)
local_dir="`pwd`/tools/crmasks/files"
fname="${local_dir}/terminal_output_example7b"
input="${fname}.txt"

#------------------------------------------------------------------------------
output="${fname}_01.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 0 0 195 207 0 0
#------------------------------------------------------------------------------
