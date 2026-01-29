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
  "$input" "${output}" 225 232
#------------------------------------------------------------------------------
output="${fname}_08.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 233 252
#------------------------------------------------------------------------------
output="${fname}_09.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 253 279
#------------------------------------------------------------------------------
output="${fname}_10.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 280 291
#------------------------------------------------------------------------------
output="${fname}_11.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 292 317
#------------------------------------------------------------------------------
output="${fname}_12.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 318 331
#------------------------------------------------------------------------------
output="${fname}_13.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 332 376
#------------------------------------------------------------------------------
output="${fname}_14.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 377 391
#------------------------------------------------------------------------------
output="${fname}_15.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 392 406
#------------------------------------------------------------------------------
output="${fname}_16.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 407 421
#------------------------------------------------------------------------------
output="${fname}_17.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 422 439
#------------------------------------------------------------------------------
output="${fname}_18.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 440 476
#------------------------------------------------------------------------------
output="${fname}_19.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 477 478
#------------------------------------------------------------------------------
output="${fname}_20.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 479 491
#------------------------------------------------------------------------------
output="${fname}_21.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 492 503
#------------------------------------------------------------------------------
output="${fname}_22.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 504 515
#------------------------------------------------------------------------------
output="${fname}_23.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 516 527
#------------------------------------------------------------------------------
output="${fname}_24.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 528 542
#------------------------------------------------------------------------------
output="${fname}_25.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 543 558
#------------------------------------------------------------------------------
output="${fname}_26.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 559 576
#------------------------------------------------------------------------------
output="${fname}_27.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 577 597
#------------------------------------------------------------------------------
output="${fname}_28.md"
tools/extract_blocks_ansi.sh \
  "$input" "${output}" 598 599
#------------------------------------------------------------------------------
