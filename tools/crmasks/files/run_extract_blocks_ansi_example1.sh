#!/bin/bash

# Note: this script is executed by ../../../Makefile
# (it is not intended to be executed locally)
local_dir="`pwd`/tools/crmasks/files"
fname="${local_dir}/terminal_output_example1"
input="${fname}.txt"

#------------------------------------------------------------------------------
output="${fname}_00.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 1 26
#------------------------------------------------------------------------------
output="${fname}_01.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 27 41
#------------------------------------------------------------------------------
output="${fname}_02.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 42 91
#------------------------------------------------------------------------------
output="${fname}_03.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 92 124
#------------------------------------------------------------------------------
output="${fname}_04.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 125 157
#------------------------------------------------------------------------------
output="${fname}_05.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 158 190
#------------------------------------------------------------------------------
output="${fname}_06.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 191 220
#------------------------------------------------------------------------------
output="${fname}_07.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 221 228
#------------------------------------------------------------------------------
output="${fname}_08.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 229 249
#------------------------------------------------------------------------------
output="${fname}_09.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 250 275
#------------------------------------------------------------------------------
output="${fname}_10.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 276 287
#------------------------------------------------------------------------------
output="${fname}_11.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 288 313
#------------------------------------------------------------------------------
output="${fname}_12.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 314 327
#------------------------------------------------------------------------------
output="${fname}_13.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 328 372
#------------------------------------------------------------------------------
output="${fname}_14.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 373 387
#------------------------------------------------------------------------------
output="${fname}_15.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 388 402
#------------------------------------------------------------------------------
output="${fname}_16.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 403 417
#------------------------------------------------------------------------------
output="${fname}_17.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 418 435
#------------------------------------------------------------------------------
output="${fname}_18.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 436 472
#------------------------------------------------------------------------------
output="${fname}_19.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 473 474
#------------------------------------------------------------------------------
output="${fname}_20.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 475 487
#------------------------------------------------------------------------------
output="${fname}_21.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 488 499
#------------------------------------------------------------------------------
output="${fname}_22.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 500 511
#------------------------------------------------------------------------------
output="${fname}_23.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 512 523
#------------------------------------------------------------------------------
output="${fname}_24.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 524 538
#------------------------------------------------------------------------------
output="${fname}_25.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 539 554
#------------------------------------------------------------------------------
output="${fname}_26.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 555 572
#------------------------------------------------------------------------------
output="${fname}_27.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 573 593
#------------------------------------------------------------------------------
output="${fname}_28.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 594 595
#------------------------------------------------------------------------------
