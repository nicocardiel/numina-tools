#!/bin/bash

for fdum in \
  numina-extract_2d_slice_from_3d_cube \
  numina-generate_mosaic_of_2d_images \
  numina-generate_mosaic_of_3d_cubes
do
  ../../extract_ansi_help.sh ${fdum}
done
