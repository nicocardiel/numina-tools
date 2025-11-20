```console
(venv_numina) $ numina-generate_mosaic_of_3d_cubes --help
```

```{code-block} ansi-shell-session
:class: my-special-block no-copybutton

[38;5;208mUsage:[0m [38;5;244mnumina-generate_mosaic_of_3d_cubes[0m [[36m-h[0m] [[36m--crval3out[0m [38;5;36mCRVAL3OUT[0m]
                                          [[36m--cdelt3out[0m [38;5;36mCDELT3OUT[0m]
                                          [[36m--naxis3out[0m [38;5;36mNAXIS3OUT[0m]
                                          [[36m--desired_celestial_2d_wcs[0m [38;5;36mDESIRED_CELESTIAL_2D_WCS[0m]
                                          [[36m--reproject_method[0m [38;5;36m{interp,adaptive,exact}[0m]
                                          [[36m--parallel[0m]
                                          [[36m--extname_image[0m [38;5;36mEXTNAME_IMAGE[0m]
                                          [[36m--output_celestial_2d_wcs[0m [38;5;36mOUTPUT_CELESTIAL_2D_WCS[0m]
                                          [[36m--footprint[0m] [[36m--verbose[0m] [[36m--echo[0m]
                                          [36minput_list[0m [36moutput_filename[0m

[39mGenerate a 3D mosaic from individual 3D cubes[0m

[38;5;208mPositional Arguments:[0m
  [36minput_list[0m            [39mTXT file with list of 3D images to be combined or[0m
                        [39msingle FITS file[0m
  [36moutput_filename[0m       [39mfilename of output FITS image[0m

[38;5;208mOptions:[0m
  [36m-h[0m, [36m--help[0m            [39mshow this help message and exit[0m
  [36m--crval3out[0m [38;5;36mCRVAL3OUT[0m
                        [39mMinimum wavelength (in m) for the output image[0m
  [36m--cdelt3out[0m [38;5;36mCDELT3OUT[0m
                        [39mWavelength step (in m/pixel) for the output image[0m
  [36m--naxis3out[0m [38;5;36mNAXIS3OUT[0m
                        [39mNumber of slices in the output image[0m
  [36m--desired_celestial_2d_wcs[0m [38;5;36mDESIRED_CELESTIAL_2D_WCS[0m
                        [39mDesired 2D celestial WCS projection. Default None[0m
                        [39m(compute for current 3D cube combination)[0m
  [36m--reproject_method[0m [38;5;36m{interp,adaptive,exact}[0m
                        [39mReprojection method (interp, adaptive, exact)[0m
  [36m--parallel[0m            [39mUse parallel processing for reprojection[0m
  [36m--extname_image[0m [38;5;36mEXTNAME_IMAGE[0m
                        [39mExtension name for image in input files. Default[0m
                        [39mvalue: PRIMARY[0m
  [36m--output_celestial_2d_wcs[0m [38;5;36mOUTPUT_CELESTIAL_2D_WCS[0m
                        [39mfilename for output 2D celestial WCS[0m
  [36m--footprint[0m           [39mGenerate a FOOTPRINT extension with the final[0m
                        [39mfootprint[0m
  [36m--verbose[0m             [39mDisplay intermediate information[0m
  [36m--echo[0m                [39mDisplay full command line[0m
```
