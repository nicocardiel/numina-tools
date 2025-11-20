# Mosaicking

## extract_2d_slice_from_3d_cube

This script extracts a 2D section from a 3D FITS image. It allows specifying
the axis to collapse and the interval (pixel range) along that axis.

```{include} files/help_numina-extract_2d_slice_from_3d_cube.md
```

## generate_mosaic_of_2d_images

This script generates a mosaic of 2D images from a list of 2D FITS files.

```{include} files/help_numina-generate_mosaic_of_2d_images.md
```

## generate_mosaic_of_3d_cubes

This script generates a mosaic of 3D data cubes from a list of 3D FITS files.

- It is possible to use arguments to fix the desired outupt celestial 2D WCS,
  as well as the output `CRVAL3` and `CDELT3` parameters that define the output
  linear wavelength sampling.

- If the input is a single 3D FITS cube, the code can be used to resample the
  initial cube with different values of `CRVAL3` and `CDELT3`. In that case, it
  is recommended to use interp as the reprojection method to avoid the default
  Gaussian kernel used when the reprojection method is `adaptive`). 

```{include} files/help_numina-generate_mosaic_of_3d_cubes.md
```

