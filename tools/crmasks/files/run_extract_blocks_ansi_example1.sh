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
  "$input" "${output}" 27 43
#------------------------------------------------------------------------------
output="${fname}_02.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 44 93
#------------------------------------------------------------------------------
output="${fname}_03.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 94 126
#------------------------------------------------------------------------------
output="${fname}_04.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 127 159
#------------------------------------------------------------------------------
output="${fname}_05.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 160 192
#------------------------------------------------------------------------------
output="${fname}_06.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 193 222
#------------------------------------------------------------------------------
output="${fname}_07.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 223 230
#------------------------------------------------------------------------------
output="${fname}_08.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 231 250
#------------------------------------------------------------------------------
output="${fname}_09.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 251 277
#------------------------------------------------------------------------------
output="${fname}_10.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 278 289
#------------------------------------------------------------------------------
output="${fname}_11.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 290 315
#------------------------------------------------------------------------------
output="${fname}_12.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 316 329
#------------------------------------------------------------------------------
output="${fname}_13.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 330 374
#------------------------------------------------------------------------------
output="${fname}_14.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 375 389
#------------------------------------------------------------------------------
output="${fname}_15.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 390 404
#------------------------------------------------------------------------------
output="${fname}_16.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 405 419
#------------------------------------------------------------------------------
output="${fname}_17.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 420 437
#------------------------------------------------------------------------------
output="${fname}_18.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 438 474
#------------------------------------------------------------------------------
output="${fname}_19.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 475 476
#------------------------------------------------------------------------------
output="${fname}_20.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 477 489
#------------------------------------------------------------------------------
output="${fname}_21.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 490 501
#------------------------------------------------------------------------------
output="${fname}_22.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 502 513
#------------------------------------------------------------------------------
output="${fname}_23.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 514 525
#------------------------------------------------------------------------------
output="${fname}_24.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 526 540
#------------------------------------------------------------------------------
output="${fname}_25.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 541 556
#------------------------------------------------------------------------------
output="${fname}_26.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 557 574
#------------------------------------------------------------------------------
output="${fname}_27.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 575 595
#------------------------------------------------------------------------------
output="${fname}_28.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 596 597
#------------------------------------------------------------------------------
