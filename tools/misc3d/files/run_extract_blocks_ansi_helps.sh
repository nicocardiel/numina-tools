#!/bin/bash

for fdum in \
  numina-measure_slice_xy_offsets_in_3d_cube \
  numina-resample_wave_3d_cube
do
  ../../extract_ansi_help.sh ${fdum}
done
