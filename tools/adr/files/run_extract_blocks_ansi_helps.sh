#!/bin/bash

for fdum in \
  numina-compare_adr_extensions_in_3d_cube \
  numina-compute_adr_wavelength
do
  ../../extract_ansi_help.sh ${fdum}
done
