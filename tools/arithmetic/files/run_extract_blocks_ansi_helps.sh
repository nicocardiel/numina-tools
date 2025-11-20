#!/bin/bash

for fdum in \
  numina-imath \
  numina-imath3d
do
  ../../extract_ansi_help.sh ${fdum}
done
