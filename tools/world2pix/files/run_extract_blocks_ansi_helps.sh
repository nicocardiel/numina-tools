#!/bin/bash

for fdum in \
  numina-pixel_solid_angle_arcsec2 \
  numina-pixel_to_world \
  numina-world_to_pixel
do
  ../../extract_ansi_help.sh ${fdum}
done
