# Miscellaneous 3D data scripts

## measure_slice_xy_offsets_in_3d_cube

This script calculates the spatial offset in the sky plane between a particular
spatial slice and all the spatial slices of a given 3D cube. It does so using a
cross-correlation method.

```{include} files/help_numina-measure_slice_xy_offsets_in_3d_cube.md
```

## resample_wave_3d_cube

This script resamples a 3D data cube by specifying the output values for
`CRVAL3`, `CDELT3` and `NAXIS3`. The celestial WCS is preserved, and the
spectral WCS is modified in order to make use of the new wavelength sampling.
This code does not use the functionality of the reproject package and instead
performs a simple linear redistribution of the signal in the newly sampled
wavelength grid. In this sense, it produces the same result as the
`numina-generate_mosaic_of_3d_images` script when employed with a single input
3D FITS file and the reprojection method is `interp`.

```{include} files/help_numina-resample_wave_3d_cube.md
```

