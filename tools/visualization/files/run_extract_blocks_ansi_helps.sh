#!/bin/bash

for fdum in \
  numina-ximshow \
  numina-sp3d_with_ds9
do
  ../../extract_ansi_help.sh ${fdum}
done
