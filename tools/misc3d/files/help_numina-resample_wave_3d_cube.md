```console
(venv_numina) $ numina-resample_wave_3d_cube --help
```

```{code-block} ansi-shell-session
:class: my-special-block no-copybutton

[38;5;208mUsage:[0m [38;5;244mnumina-resample_wave_3d_cube[0m [[36m-h[0m] [[36m--crval3out[0m [38;5;36mCRVAL3OUT[0m]
                                    [[36m--cdelt3out[0m [38;5;36mCDELT3OUT[0m]
                                    [[36m--naxis3out[0m [38;5;36mNAXIS3OUT[0m]
                                    [[36m--extname[0m [38;5;36mEXTNAME[0m] [[36m--verbose[0m] [[36m--echo[0m]
                                    [36minput_file[0m [36moutput_file[0m

[39mResample a 3D cube in the wavelength axis (NAXIS3).[0m

[38;5;208mPositional Arguments:[0m
  [36minput_file[0m            [39mInput FITS file with the 3D cube.[0m
  [36moutput_file[0m           [39mOutput FITS file with the resampled 3D cube.[0m

[38;5;208mOptions:[0m
  [36m-h[0m, [36m--help[0m            [39mshow this help message and exit[0m
  [36m--crval3out[0m [38;5;36mCRVAL3OUT[0m
                        [39mMinimum wavelength for the output image (in meters).[0m
  [36m--cdelt3out[0m [38;5;36mCDELT3OUT[0m
                        [39mWavelength step for the output image (in meters).[0m
  [36m--naxis3out[0m [38;5;36mNAXIS3OUT[0m
                        [39mNumber of slices in the output image.[0m
  [36m--extname[0m [38;5;36mEXTNAME[0m     [39mExtension name of the input HDU (default: 'PRIMARY').[0m
  [36m--verbose[0m             [39mDisplay intermediate information[0m
  [36m--echo[0m                [39mDisplay full command line[0m
```
