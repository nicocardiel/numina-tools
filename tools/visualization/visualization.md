# Visualization

## sp3d_with_ds9

This script opens a 3D FITS image in the `ds9` image browser and allows
interactive selection of object and sky spaxels. Simultaneously, the
corresponding spectra and their subtraction are displayed. This interaction is
similar to what is done with the program `qfitsview`. The reason for developing
this code has been the more comfortable interaction with the Matplotlib window
displaying the spectra, along with the ability to leverage the full
functionality of the `ds9` program. The `ds9` session is launched automatically
when running this script and must be closed manually upon completion.

```{include} files/help_numina-sp3d_with_ds9.md
```

## ximshow

This is a tool for visualizing 2D FITS images using Matplotlib, which can be convenient when displaying multiple images consecutively and quickly saving the result to a PNG or PDF file.

```{include} files/help_numina-ximshow.md
```

