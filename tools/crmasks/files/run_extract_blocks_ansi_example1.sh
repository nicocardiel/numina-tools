#!/bin/bash

# Note: this script is executed by ../../../Makefile
# (it is not intended to be executed locally)
local_dir="`pwd`/tools/crmasks/files"
fname="${local_dir}/terminal_output_example1"
input="${fname}.txt"

# Note: to identify line numbers, it is useful to use:
# $ cat -n filename.txt
# (enlarge the terminal)
#------------------------------------------------------------------------------
output="${fname}_00.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 1 26
#------------------------------------------------------------------------------
output="${fname}_01.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 27 45
#------------------------------------------------------------------------------
output="${fname}_02.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 46 95
#------------------------------------------------------------------------------
output="${fname}_03.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 96 128
#------------------------------------------------------------------------------
output="${fname}_04.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 129 161
#------------------------------------------------------------------------------
output="${fname}_05.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 162 194
#------------------------------------------------------------------------------
output="${fname}_06.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 195 224
#------------------------------------------------------------------------------
output="${fname}_07.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 225 233
#------------------------------------------------------------------------------
output="${fname}_07b.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 234 254
#------------------------------------------------------------------------------
output="${fname}_08.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 255 275
#------------------------------------------------------------------------------
output="${fname}_09.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 276 301
#------------------------------------------------------------------------------
output="${fname}_10.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 302 313
#------------------------------------------------------------------------------
output="${fname}_11.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 314 339
#------------------------------------------------------------------------------
output="${fname}_12.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 340 353
#------------------------------------------------------------------------------
output="${fname}_13.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 354 398
#------------------------------------------------------------------------------
output="${fname}_14.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 399 413
#------------------------------------------------------------------------------
output="${fname}_15.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 414 428
#------------------------------------------------------------------------------
output="${fname}_16.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 429 443
#------------------------------------------------------------------------------
output="${fname}_17.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 444 461
#------------------------------------------------------------------------------
output="${fname}_18.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 462 498
#------------------------------------------------------------------------------
output="${fname}_19.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 499 500
#------------------------------------------------------------------------------
output="${fname}_20.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 501 513
#------------------------------------------------------------------------------
output="${fname}_21.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 514 525
#------------------------------------------------------------------------------
output="${fname}_22.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 526 537
#------------------------------------------------------------------------------
output="${fname}_23.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 538 549
#------------------------------------------------------------------------------
output="${fname}_24.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 550 564
#------------------------------------------------------------------------------
output="${fname}_25.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 565 580
#------------------------------------------------------------------------------
output="${fname}_26.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 581 598
#------------------------------------------------------------------------------
output="${fname}_27.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 599 619
#------------------------------------------------------------------------------
output="${fname}_28.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 620 621
#------------------------------------------------------------------------------
