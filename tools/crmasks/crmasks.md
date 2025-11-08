# Removing CR in multiple exposures

A common task in astronomical image reduction is the removal of cosmic rays. To
facilitate this process, it is customary (when possible) to acquire three or
more equivalent exposures, allowing a median combination to effectively
eliminate the cosmic rays. However, this approach does not perform optimally
when exposure times are long and the number of cosmic rays is high, as the same
pixel may be affected by a cosmic ray in more than one exposure. Under such
circumstances, the median combination removes most cosmic rays from the final
image, but residual pixels may remain that have not been properly corrected.

We have encountered this issue while reducing observing blocks performed with
the instrument MEGARA at the GTC. Each of these observing blocks consists of
three identical science exposures, taken with the same exposure time and
maintaining telescope pointing through an autoguiding system.

## Overall description

```{note}
Since the issue of astronomical images being heavily affected by cosmic rays
is typically restricted to long-exposure observations, it is uncommon to
have significantly more than three equivalent exposures available. If four
exposures are obtained, a median combination still fails to correct cases
where a pixel is affected by cosmic rays in two of the exposures. In such
scenarios, increasing the number of exposures from three to five becomes
necessary. However, having five or more truly equivalent exposures is not
trivial, as long integration times may lead to variations in the signal
(e.g., changes in airmass and/or atmospheric transmission, sky line
intensity, pointing variations, or instrument flexures, among other possible
issues), making it unreasonable to assume that the images are reasonably
equivalent. On the other hand, if a particular observing program does allow
for a larger number of exposures (five or more), then a median combination
may yield satisfactory results, and the method described below may not be
required. For all these reasons, the following description assumes that the
number of available exposures is three.
```

The method described here should be applied when three (or more) equivalent
exposures are available. It works by identifying pixels where the signal has
been affected by cosmic rays in more than half of the available exposures, such
that the median combination still retains an erroneous signal. These pixels
are identified in the median-combined image using two distinct procedures,
which can also be combined to enhance the effectiveness of the detection
process:

1. The L.A. Cosmic technique [(van Dokkum 2001)](https://iopscience.iop.org/article/10.1086/323894), a robust algorithm
   for cosmic-ray detection, based on a variation of Laplacian edge detection.
   Here we are using the implementation of this algorithm provided by the
   Python package
   [ccdproc](https://ccdproc.readthedocs.io/en/latest/index.html) through the
   [$\color{gray}\texttt{cosmicray_lacosmic()}$
   function](https://ccdproc.readthedocs.io/en/latest/api/ccdproc.cosmicray_lacosmic.html),
   which in turn is based on the implementation provided by the
   [Astro-SCRAPPY](https://github.com/astropy/astroscrappy) package (McCully
   2014). This algorithm is widely used for detecting cosmic rays in individual
   exposures. In our case, it serves to identify residual cosmic-ray pixels in
   the median combination, which likely correspond to pixels suspected of
   having been hit by a cosmic ray in two out of the three available exposures.
   In this document, we will refer to this method in abbreviated form as
   $\color{red}\textbf{LAcosmic}$.

2. The Median-Minimum (MM) diagnostic diagram technique (Cardiel et al. 2025,
   in preparation), an alternative method that works by identifying pixels that
   deviate unexpectedly in a diagnostic diagram constructed using the median
   and minimum signal values of each pixel across the different exposures. This
   algorithm is based on the assumption that the gain and readout noise of the
   detector are known with reasonable accuracy. This allows for the prediction
   of the typical difference between the median and the minimum signal values
   recorded in the same pixel across the three different exposures, as a
   function of the minimum signal (once the bias level has been subtracted).
   With the aid of numerical simulations, a *detection boundary* is predicted
   in the MM diagnostic diagram, such that pixels falling above this boundary
   ave a high probability of having been affected by cosmic rays in two out of
   the three available exposures. In this document, we will refer to this
   method in abbreviated form as $\color{blue}\textbf{MMcosmic}$.

## Script usage

```{warning}
This functionality is still in the development phase and is not yet fully
consolidated. Some future modifications may be introduced as more testing
is conducted with new images.
```

The **numina** script responsible for detecting and correcting residual cosmic
rays using the methods
$\color{red}\textbf{LAcosmic}$ and or
$\color{blue}\textbf{MMcosmic}$
is called
**numina-crmasks**. Its execution is straightforward:

```console
(venv_numina) $ numina-crmasks params_example1.yaml
```

The script **numina-crmasks** takes a single initial argument: the name of a
YAML-formatted file. This file facilitates providing default values for
multiple parameters, allowing the user to focus only on modifying a subset of
them to experiment with how changes affect the results.

Note: YAML is a human-readable data serialization language (for details, see
[YAML syntax description](https://docs.ansible.com/ansible/latest/reference_appendices/YAMLSyntax.html).

An example of a `params_example1.yaml` file is shown below and available
{download}`here <files/params_example1.yaml>`:

```{literalinclude} files/params_example1.yaml
:emphasize-lines: 5, 9, 12-14, 17
:language: yaml
:lineno-start: 1
:linenos: true
```

Indentation in a YAML file **is extremely important** (it's one of the core
parts of how YAML defines structure). YAML uses spaces (not tabs) to represent
nesting or parent-child relationships between data elements. It is possible to
insert comments using the `#` (hash) symbol, so that everything on the same
line after `#` is ignored by the YAML parser.

In our case, at the top level there are six parameters (highlighted with a
yellow background in the example above):

- `images`: List of input FITS images to be processed. Each single image
  is provided below this keyword, in an indented line, starting with a dash
  followed by a space and the name of the corresponding FITS file.

- `extnum`: Extension number of the FITS file to be read (e.g., `0` for
  the primary extension).

- `gain`, `rnoise` and `bias`: General image parameters such as detector
  gain (electron/ADU), readout noise (ADU), and bias level (ADU). In this file
  we are using the parameters corresponding to some preprocessed MEGARA
  exposures, where the bias level has already been subtracted, and the signal
  has been converted to electrons (for this reason we are using `bias=0` and
  `gain=1.0`).

- `requirements`: under this section, there are *three parameter blocks*:

  1\. General execution parameters: They control the overall behavior of
  **numina-crmasks**.

  2\. Parameters for the
  $\color{red}\textbf{LAcosmic}$
  technique: Identified by the `la_`
  prefix, these parameters configure the *Laplacian Cosmic Ray Detection
  Algorithm* (van Dokkum 2001). Some default values are provided. These
  parameters, without the `la_` prefix, are transferred to the
  [$\color{gray}\texttt{cosmicray_lacosmic()}$
  function](https://ccdproc.readthedocs.io/en/latest/api/ccdproc.cosmicray_lacosmic.html).

  3\. Parameters for the $\color{blue}\textbf{MMcosmic}$ method:
  Identified by the `mm_` prefix, these control the computation of the
  detection boundary in the MM diagnostic diagram.

A more detailed description of all the parameters included in the
`requirements` section is provided in the [description of parameters in
requirements](description-of-parameters-in-requirements) section below.

```{note}
Users of the MEGARA data reduction pipeline will recognize the above
`requirements` section as the same one found in the observation result
YAML file used by the reduction recipe **MegaraCrDetection**. This means
that the entire section of the `params.yaml` file starting from line 17
onward, can be inserted into the observation result file of the
corresponding recipe. For further details, see [CR not removed by median
stacking](https://guaix-ucm.github.io/megaradrp-cookbook/crmasks.html) in
the MEGARA cookbook.
```

## Script output

After executing the code (several examples are shown below), the
**numina-crmasks** script generates several FITS files:

- `combined_mediancr.fits`: Median combination of the three available
  exposures, replacing pixels suspected of being affected by cosmic rays in two
  of the three exposures by the minimum value at each pixel across the three
  available exposures. When the replaced pixels truly correspond to cases where
  the same pixel has been affected by a cosmic ray in two out of the three
  available exposures, using the minimum value is effectively equivalent to
  relying on a single exposure. In such cases, there is no reason to assume
  that this value is biased toward lower-than-expected levels, since only a
  single measurement is available.

  Instead of using the minimum value at each pixel, it is also possible to
  replace the flagged pixels using the value computed by the
  $\color{gray}\texttt{cosmicray_lacosmic()}$ function.
  To do so, you must set the parameter ``use_lamedian=True`` (which is not the
  default) and pay attention to the parameter ``la_cleantype``.

- `combined_meancrt.fits`: First attempt to perform a mean (not median!)
  combination of the three available individual exposures. First, a direct mean
  combination of the original exposures is computed, resulting in an image that
  contains all cosmic rays present in the individual frames. A mask of pixels
  affected by cosmic rays is then generated from this image, and the pixels
  within this mask are replaced with their corresponding values from the
  `combined_mediancr.fits` image.

- `combined_meancr.fits`: Second attempt to obtain a mean combination of the
  three available exposures. In this case the combination is obtained by
  generating an individual cosmic ray mask for each of the three initial
  exposures. A mean combination is then performed using each image along with
  its corresponding mask. Finally, the masked pixels in the three exposures are
  replaced by the minimum value.

Each of these FITS contains the combined image in the primary extension, along
with two additional extensions: one storing the variance (extension VARIANCE),
and another containing the pixel map (number of single exposures employed to
compute the combined result for each pixel).

```console
(venv_numina) $ fitsinfo combined_me*fits
```

```{code-block} console
:class: my-special-block no-copybutton

Filename: combined_meancr.fits
No.    Name      Ver    Type      Cards   Dimensions   Format
  0  PRIMARY       1 PrimaryHDU      21   (2016, 1596)   float32
  1  VARIANCE      1 ImageHDU         8   (2016, 1596)   float32
  2  MAP           1 ImageHDU         8   (2016, 1596)   int16

Filename: combined_meancrt.fits
No.    Name      Ver    Type      Cards   Dimensions   Format
  0  PRIMARY       1 PrimaryHDU      21   (2016, 1596)   float32
  1  VARIANCE      1 ImageHDU         8   (2016, 1596)   float32
  2  MAP           1 ImageHDU         8   (2016, 1596)   int16

Filename: combined_mediancr.fits
No.    Name      Ver    Type      Cards   Dimensions   Format
  0  PRIMARY       1 PrimaryHDU      21   (2016, 1596)   float32
  1  VARIANCE      1 ImageHDU         8   (2016, 1596)   float32
  2  MAP           1 ImageHDU         8   (2016, 1596)   int16
```

Since the mean has a lower standard deviation than the median, the
`combined_meancrt.fits` and `combined_meancr.fits` images are initially
preferable. Among these two, tests suggest that `combined_meancr.fits` tends
to yield better results. However, it is recommended to try all three methods
and compare the outputs to determine which works best for your specific
dataset.

In addition to the three images described above, the **numina-crmasks** script
also generates an additional FITS file that compiles the masks and auxiliary
data used to produce the various image combinations previously discussed.

- `crmasks.fits`: FITS file containing 5 cosmic ray masks, each one stored in
  a different extension.

```console
(venv_numina) $ fitsinfo crmasks.fits
```

```{code-block} console
:class: my-special-block no-copybutton

Filename: crmasks.fits
No.    Name      Ver    Type      Cards   Dimensions   Format
  0  PRIMARY       1 PrimaryHDU      43   ()
  1  MEDIANCR      1 ImageHDU         8   (2016, 1596)   uint8
  2  MEANCRT       1 ImageHDU         8   (2016, 1596)   uint8
  3  CRMASK1       1 ImageHDU         8   (2016, 1596)   uint8
  4  CRMASK2       1 ImageHDU         8   (2016, 1596)   uint8
  5  CRMASK3       1 ImageHDU         8   (2016, 1596)   uint8
  6  LAMEDIAN      1 ImageHDU         8   (2016, 1596)   float32
```

In this case, the primary extension does not contain an image, but rather a
small set of parameters stored as FITS keywords, along with the parameters used
during the execution of the **numina-crmasks** script (which are recorded in
the HISTORY section of this primary header). Extensions 1 through 5 contain five
masks:

- $\color{magenta}\texttt{MEDIANCR}$: mask employed to generate the
  `combined_mediancr.fits` result.

- $\color{magenta}\texttt{MEANCRT}$: mask employed to generate the
  `combined_meancrt.fits` result.  In this case, pixels already flagged in
  $\color{magenta}\texttt{MEDIANCR}$ are also flagged in this second mask.

- $\color{magenta}\texttt{CRMASK1}$, $\color{magenta}\texttt{CRMASK2}$ and
  $\color{magenta}\texttt{CRMASK3}$: individuals masks associated to each of
  the three individual exposures, which are employed to generate the
  `combined_meancr.fits` result. In this case, pixels are only flagged when
  they were so in the $\color{magenta}\texttt{MEANCRT}$ mask (the mean
  combination should be less noisy than the individual exposures, so by
  imposing this restriction we help reducing the number of false positives).

In all cases, these masks store values of 0 and 1, corresponding respectively
to pixels unaffected and affected by cosmic rays.

- $\color{magenta}\texttt{LAMEDIAN}$: this extension does not actually contain
  a mask but rather the value of the cosmic-ray-cleaned image obtained using
  $\color{red}\texttt{LAcosmic}$.

## Examples

The images used in the following examples correspond to a cropped region from
frames obtained with the MEGARA instrument, a fiber fed Integral Field Unit
installed at the Gran Telescopio Canarias. 

The exposures used in each example actually correspond to simulated images
generated from a reference image (the median of three 1200-sec exposures, all
of them contain a high number of cosmic rays), to which the individual cosmic
rays detected in the single exposures have been added. This allows for sets of
three exposures in which several scenarios have been examined:

- **Example 1:** three equivalent exposures are used (the expected signal in
  each individual exposure is the same), and the detection boundary in the
  diagnostic diagram is determined automatically.

- **Example 2:** three equivalent exposures are used, with a manual adjustment
  of the detection boundary.

- **Example 3:** the three exposures are not equivalent, with a multiplicative
  factor between the signal measured in the different individual exposures.

- **Example 4:** three equivalent exposures are used, but there is an (X, Y)
  offset between the individual images.

The initial images have been preprocessed (bias subtracted and gain scale
corrected). 

A simple median combination of the three images initially performs well, but as
we will see below, it leaves several dozen pixels uncorrected due to cosmic ray
hits occurring in the same pixel in two out of the three available exposures.

In these MEGARA images, the spectral direction lies along the horizontal axis,
and the spectra from the different fibers are distributed along the vertical
axis.

```{note}
Although the examples shown below demonstrate a highly interactive execution
of the **numina-crmasks** script, the intended design allows the program to
be run in a largely automated manner when needed. This may be the case in
observational projects where the detector parameters (gain, readout noise)
remain constant, and where, after interactively determining optimal
parameters for residual cosmic ray removal on a subset of images, the same
configuration can be applied to a larger set of similarly acquired frames
using the same instrumental configuration.
```

### Example 1: simple execution

In this example, we will use `crmethod: mm_lacosmic`,
which means that cosmic-ray pixels will be detected using both the
$\color{red}\textbf{LAcosmic}$ and the $\color{blue}\textbf{MMcosmic}$
methods. We will consider a pixel to contain spurious signal due to a cosmic
ray hit when it is detected by either of the two methods, and not necessarily
by both simultaneously.

```console
(venv_numina) $ cd example1
(venv_numina) $ numina-crmasks params_example1.yaml
```

```{include} files/terminal_output_example1_01.md
```

After a short processing time, **numina-crmasks** starts applying the
$\color{red}\textbf{LAcosmic}$ technique to detect residual cosmic rays in the
median combination.

```{include} files/terminal_output_example1_02.md
```

In this example 98 pixels are flagged as suspicious of being affected by cosmic
rays.

Next, the program begins applying the $\color{blue}\textbf{MMcosmic}$
method in the median combination. 

```{include} files/terminal_output_example1_03.md
```

In this process a 3D stack is built from the available individual exposures.
The minimum, maximum, and median values of each pixel across the three
available exposures are computed, resulting in three 2D images referred to as
`min2d`, `max2d`, and `median2d`, respectively. Naturally, these images have
the same dimensions as the original exposures being combined.

Using the information stored in the `median2d` and `min2d` images, the
program constructs a diagram that plots the difference between `median2d` and
`min2d` against the value of `min2d` (after subtracting the bias signal).  We
will refer to this graphical representation as the Median-Minimum (**MM** for
short) diagnostic diagram.

Since we are using `interactive=True`, the corresponding MM diagnostic diagram 
is displayed interactively, allowing the user to examine it in real time (this
figure is also saved as `diagnostic_histogram2d.png`).

```{figure} images/diagnostic_histogram2d_example1.png
:alt: MM diagnostic diagram for the median combination
:name: fig-diagnostic_histogram2d_example1
:width: 100%

Simulated (left) and real (right) Minimum-Median diagnostic diagram.
```

The MM diagnostic diagram displayed above is actually a 2D histogram, and it is
shown in two panels:

- *Left Panel:* This shows the result of a predefined number of simulations
  (`mm_nsimulations: 10` in this example). En each simulation, the program
  employs the original `median2d` image to generate 3 synthetic exposures,
  based on the provided values for gain, readout noise, and bias.
- *Right Panel:* This shows the same diagnostic diagram, but using the actual
  data from the individual exposures.

Returning to the left panel, for each bin along the horizontal axis, the
corresponding 1D histogram in the vertical direction is converted into a
cumulative distribution function (CDF). The red crosses mark the values of
`median2d - min2d` where the probability of finding a pixel above that value
is low enough that only one such pixel is expected. An initial spline (blue
curve) is fitted through these red crosses.

To define a more conservative detection boundary, the blue curve is extended
upward (orange, green, and red curves) by repeating the fit for a few
iterations, applying an increasing weights to the points located above the
original fit. The final curve serves as an upper boundary to the expected
location of pixel values in this MM diagnostic diagram.

This detection boundary is also plotted in the right panel, where the displayed
2D histogram corresponds to the `min2d - bias` and `median2d - min2d`
values exihibited by the real data. In principle, if the three individual
exposures used are truly equivalent, the MM diagnostic diagram on the right
should closely resemble the diagram shown on the left. Pixels that appear above
the calculated boundary in the right-hand figure exhibit very large values of
`median2d - min2d`, exceeding what would be expected based on the image noise,
and are considered as cosmic-ray pixels by this $\color{blue}\textbf{MMcosmic}$
method.

```{include} files/terminal_output_example1_04.md
```

In this example, there are 72 pixels flagged above the detection boundary.

After pressing the `q` key, the program resumes execution (you can press the
`x` key to halt the program execution at this point in case it is necessary to
modify any of the input parameters).

Since we are using ``crmethod: mm_lacosmic``, the program proceeds to combine
the detections made by both the $\color{red}\textbf{LAcosmic}$ and
$\color{blue}\textbf{MMcosmic}$ methods. This allows
for a detailed analysis of how many pixels were flagged as suspicious by one
method but not the other, and how many were identified by both.

```{include} files/terminal_output_example1_05.md
```

```{figure} images/diagnostic_mediancr_example1.png
:name: fig-diagnostic_mediancr_example1
:width: 100%

**Panel (a)**: MM diagnostic diagram showing the pixels detected only using the
$\color{red}\textbf{LAcosmic}$ algorithm (red x's), those detected only using
the $\color{blue}\textbf{MMcosmic}$ method in the MM diagnostic diagram (blue
+'s), and those detected by both methods (open magenta circles). **Panel (b)**:
the same diagram is shown, but instead of symbols, a sequential number is
assigned to each suspected pixel.  The displayed numbers follow the same color
coding used for symbols in Panel (a). **Panel (c)**: representation of the
`median2d` image, with the locations of suspected pixels overlaid. The same
symbols and colors used in Panel (a) are applied here. **Panel (d)**:
representation of the `mean2d` image. Pressing keys `1`, `2`, and `3` cycles
through the individual exposures in this panel. Pressing `0` displays again the
`mean2d` image. Any zoom applied in Panel (a) is propagated to Panel (b), while
Panel (c) displays only the suspected pixels selected within the zoomed region
of Panel (a). Panels (c) and (d) update simultaneously when the zoom is
modified in either of them. This interactive figure allows the user to closely
examine which pixels are suspected of having been affected by cosmic rays in
two out of the three available exposures. It also helps to understand how the
two detection methods ($\color{red}\textbf{LAcosmic}$ and
$\color{blue}\textbf{MMcosmic}$) have performed in identifying suspected
pixels.
```

Pressing the `?` key displays a help message in the terminal, indicating the
available actions that can be performed.

```{code-block} ansi-shell-session
:class: my-special-block no-copybutton

-------------------------------------------------------------------------------
Keyboard shortcuts:
'h' or 'r': reset zoom to initial limits
'p': pan mode
'o': zoom to rectangle
'f': toggle full screen mode
's': save the figure to a PNG file
...............................................................................
'?': show this help message
'i': print pixel info at mouse position (ax3 only)
'&': print CR pixels within the zoomed region (ax3 only)
'n': toggle display of number of cosmic rays (ax3 only)
'a': toggle imshow aspect='equal' / aspect='auto' (ax3 and ax4 only)
't': toggle mean2d -> individual exposures in ax4
'0': switch to mean2d in ax4
'1', '2', ...: switch to individual exposure #1, #2, ... in ax4
',': set vmin and vmax to min and max of the zoomed region (ax3 and ax4 only)
'/': set vmin and vmax using zscale of the zoomed region (ax3 and ax4 only)
'q': close the plot and continue the program execution
'x': halt the program execution
-------------------------------------------------------------------------------
```

```{figure} images/diagnostic_mediancr_zoom_example1.png
:name: fig-diagnostic_mediancr_zoom_example1
:width: 100%

By zooming into Panel (a) of
{numref}`fig-diagnostic_mediancr_example1`, the user can better visualize what
is happening near the detection boundary in the MM diagnostic diagram. Upon
performing this action, Panel (c) displays only the suspected pixels selected
within the zoomed region of Panel (a). As can be observed, many of the pixels
detected above the detection boundary appear along sky lines, suggesting that
they are likely false positives. Note that Panel (c) now displays the suspected
pixels using the same numbering as in Panel (b).
```

Even though we are aware that the detection boundary used is slightly
underestimated, we proceed with the execution of **numina-crmasks** by pressing
the `q` key again. From this point onward, the program continues without any
further interruptions.

The previous step allowed us to detect 154 suspected pixels that require
correction. To avoid leaving neighboring pixels uncorrected (those in contact
with pixels identified as cosmic rays but not flagged themselves due to having
relatively low signal) the program surrounds each detected pixel with a
one-pixel-wide border. This process is known as **dilation**, and the extent of
dilation can be controlled using the `dilation` requirement in the YAML file
(set to 1 pixel in this example).

```{include} files/terminal_output_example1_06.md
```

With a dilation factor of 1, the initial 154 pixels expand to 967 pixels.
After dilation, the program groups connected pixels into clusters, each
representing an individual cosmic ray hit affecting contiguous pixels. In this
example, the 967 pixels are grouped into 79 cosmic rays. A table identifiying
the flagged pixels is saved in the file `mediancr_identified.csv`.

For each identified case, the program generates an independent page in the
output file `mediancr_identified_cr.pdf`. Initially the corresponding plots are
not displayed interactively (unless the `verify_cr` is set to `True` in the
input YAML file), so users should open this file manually after the program
finishes execution. Each page of this file displays one of the identified
cosmic rays. Below are three examples: CR#7 is a slightly hot pixel on the
detector; CR#17 is a false positive (a relatively bright sky line); and CR#23
is genuine case of cosmic rays hitting the same pixels in two exposures.

```{figure} images/cr07_example1.png
:name: fig-cr07_example1
:width: 100%

Example of relatively hot pixel that exhibits the similar signal in the
three exposures.
```

```{figure} images/cr17_example1.png
:name: fig-cr17_example1
:width: 100%

Example of false positive, corresponding to a sky emission line.
```

```{figure} images/cr23_example1.png
:name: fig-cr23_example1
:width: 100%

Example of correct detection of two cosmic rays affecting the same pixels in
two out of the three available exposures.
```

In each of the above figures, the plots for each residual cosmic ray are
organized into two rows. The *top row* displays the 3 individual exposures. The
left panel of the *bottom row* shows the initial `median2d` combination of the
3 exposures. The central panel of the *bottom row* displays the detection
information, where each detected pixel is coloured according to the detection
method: red when detected only by $\color{red}\textbf{LAcosmic}$; blue when
detected only by $\color{blue}\textbf{MMcosmic}$; yellow when detected by
both $\color{red}\textbf{LAcosmic}$ and $\color{blue}\textbf{MMcosmic}$;
gray for pixels included after the dilation process. The right panel of the
*bottom row* shows the result of replacing the masked pixels in `median2d` by
their value in `min2d`.

All pixels suspected of being affected by cosmic rays in the median image are
stored in the $\color{magenta}\texttt{MEDIANCR}$ extension of the
`crmasks.fits` file with a value of 1.

Next, the program generates the `mean2d` image, which contains the average of
all individual exposures, and attempts to identify cosmic rays in this image.
Note that in this case, the number of cosmic rays will be very large, as it
will include all cosmic rays from all individual exposures.  This procedure
begins with the $\color{red}\textbf{LAcosmic}$ method, using the same
parameters for the $\color{gray}\texttt{cosmicray_lacosmic()}$ function as
defined above, and continues with the $\color{blue}\textbf{MMcosmic}$
method. In this second case, it is worth noting that an MM diagnostic diagram
is constructed using $\texttt{mean2d} − \texttt{min2d}$ on the vertical axis
instead of $\texttt{median2d} − \texttt{min2d}$. **The same previously derived
detection boundary is used**, and pixels whose values exceed the prediction of
this boundary are flagged as cosmic rays. In this instance, the figure showing
the location of suspected pixels is not displayed interactively, although it is
saved as a PNG file under the name `diagnostic_meancr.png`.

```{include} files/terminal_output_example1_07.md
```

All pixels suspected of being affected by cosmic rays in the mean image are
stored in the $\color{magenta}\texttt{MEANCRT}$ extension of the
`crmasks.fits` file with a value of 1.

The same process is then repeated again, but this time using the individual
exposures. In these cases, the diagnostic diagram of the
$\color{blue}\texttt{MMCosmic}$ method is constructed using the value
$\texttt{image#}i − \texttt{min2d}$ on the vertical axis, where $i$ is the
image number (1, 2, 3, etc.). **The same detection boundary calculated at the
beginning is reused**, and the figures showing the pixels detected as affected
by cosmic rays are also not displayed interactively; instead, they are saved as
PNG files under the name `diagnostic_crmaski.png`, where `i` is the image
number.

```{include} files/terminal_output_example1_08.md
```

```{include} files/terminal_output_example1_09.md
```

```{include} files/terminal_output_example1_10.md
```

All pixels suspected of being affected by cosmic rays in the each individual
image are stored with a value of 1 in the $\color{magenta}\texttt{CRMASK}i$
extension of the `crmasks.fits` file, being $i$ the image number.

Since at this point a specific cosmic-ray pixel mask has been obtained for each
individual image, it is possible to investigate whether there are pixels that
are masked in all exposures. These are *problematic pixels* that require
special treatment. The program detects them, indicates how many there are, and
generates both a graphical representation of each case (file
`problematic_pixels.pdf`) and a CSV table (file `problematic_pixels.csv`)
indicating a cosmic ray index, the coordinates (following the FITS convention)
of the affected pixels within each cosmic ray case, and a mask value.

```{include} files/terminal_output_example1_11.md
```

At this point, the program can now generate the `crmasks.fits` file, in which
the different computed masks will be stored.

```{include} files/terminal_output_example1_12.md
```

Note that in this file, the masks are stored in different extensions. Since we
have also used the LACosmic method, the cosmic-ray-cleaned image returned by
the $\color{gray}\texttt{cosmicray_lacosmic()}$ function is additionally saved
in an extension named $\color{magenta}\texttt{LAMEDIAN}$.

Finally, the program proceeds to compute the combined images. First, it uses
the $\color{magenta}\texttt{MEDIANCR}$ mask to obtain the corrected median
combination, replacing masked pixels with the minimum value (or with the value
stored in the $\color{magenta}\texttt{LAMEDIAN}$ extension if the parameter
`use_lamedian: True` is set). The corrected image is then saved in the file
`combined_mediancr.fits`.

```{include} files/terminal_output_example1_13.md
```

The first attempt to compute a corrected mean combination is performed on the
initial mean-combined image, where the values indicated by the
$\color{magenta}\texttt{MEANCRT}$ mask
**are replaced with those from the corrected median image**. This last point is
very important. The result is saved in the file `combined_meancrt.fits`.

```{include} files/terminal_output_example1_14.md
```

The program also generates a second version of a combined image using the mean
value at each pixel, this time making use of the individual masks obtained for
each individual exposure $\color{magenta}\texttt{CRMASK}i$. The resulting image
is saved in the file combined_meancr.fits.

```{include} files/terminal_output_example1_15.md
```

If the program completes successfully, the following farewell message is
displayed:

```{include} files/terminal_output_example1_16.md
```

### Example 2: adjusting the detection boundary


With the goal of obtaining a detection boundary that reaches higher values in
the MM diagnostic diagram and therefore reduces the number of false detections,
we can use a manual piecewise adjustment, which can be defined by specifying
fixed points that the fit must pass through.

For that purpose, we are going to set
the input parameter `mm_boundary_fit` to `piecewise`:

```{literalinclude} files/params_example2.yaml
:language: yaml
:lines: 63
:lineno-start: 63
:linenos: true
```

In addition, we are arbitrarily including 3 fixed points, that are inserted
under the `mm_fixed_points_in_boundary` parameter:

```{literalinclude} files/params_example2.yaml
:language: yaml
:lines: 65-69
:lineno-start: 65
:linenos: true
```

We can run the program again using this new version of the input parameter
file.

```console
(venv_numina) $ cd example2
(venv_numina) $ numina-crmasks params_example2.yaml
```

In this case, the generated diagnostic diagram is as follows:

```{figure} images/diagnostic_histogram2d_example2.png
:alt: MM diagnostic diagram for the median combination
:name: fig-diagnostic_histogram2d_example2
:width: 100%

Simulated (left) and real (right) Minimum-Median diagnostic diagram. In
this case the detection boundary has been determined using a piecewise fit to
three fixed points.  This figure should be compared with
{numref}`fig-diagnostic_histogram2d_example1`.
```

By shifting the detection boundary upward, the false detection rate decreases.
In particular, the number of false detections on the sky lines decreases
drastically, as can be seen in panel (c) of the following figure:


```{figure} images/diagnostic_mediancr_example2.png
:name: fig-diagnostic_mediancr_example2
:width: 100%

MM diagnostic diagram and location of the detected cosmic-ray pixels. To be
compared with {numref}`fig-diagnostic_mediancr_example1`.
```

From this point onward, the program can be used in the same way as in Example
1.


### Example 3: adjusting the flux level

In some circumstances, small variations in the detected flux among different
exposures may occur. This causes a straightforward execution of
**numina-crmasks** to produce a simulated diagnostic diagram that does not
match the one obtained when using the individual exposures. To illustrate this
issue, in this example we use the same three individual exposures as in the
previous two examples, but in this case the signal of the first image has been
artificially decreased by 20%, while that of the third exposure has been
increased by 20%.

```console
(venv_numina) $ cd example3
(venv_numina) $ numina-crmasks params_example3_initial.yaml
```

```{figure} images/diagnostic_histogram2d_example3_initial.png
:alt: MM diagnostic diagram for the median combination
:name: fig-diagnostic_histogram2d_example3_initial
:width: 100%

Simulated (left) and real (right) Minimum-Median diagnostic diagram. In
this case, there is a clear difference between  the simulated and the real
data.
```

Since the detection boundary is underestimated, the number of false positives
on the sky lines increases dramatically, as shown in panel(c) of the following
figure:

```{figure} images/diagnostic_mediancr_example3_initial.png
:name: fig-diagnostic_mediancr_example3_initial
:width: 100%

MM diagnostic diagram and location of the detected cosmic-ray pixels. Note the
large number of false detections on the sky lines.
```

The **numina-crmasks** program includes the option to attempt to determine
multiplicative factors that allow rescaling the individual exposures to
minimize this problem. The procedure does not guarantee optimal results, but it
can help reveal the presence of this issue. The user may also explicitly
provide the multiplicative factors, having calculated them beforehand.

In the following steps, we will attempt to automatically estimate these factors by specifying the following information in the parameter file:

```{literalinclude} files/params_example3.yaml
:language: yaml
:lines: 21-25
:lineno-start: 21
:linenos: true
```

Note that we have modified the value of the `flux_factor` parameter,
changing it from `none` to `auto`. This instructs **numina-crmasks** to check
for the presence of a multiplicative factor between the individual exposures
and the median image before generating the diagnostic diagram.

If nothing else is changed in the parameter file, the code uses information
from the entire image. However, in this example there are large regions of the
detector with very little signal, so it is advisable to select rectangular
regions that contain pixels with significant signal. In this case, a single
region is selected that includes the sky emission lines. The coordinates of
this rectangle are specified under the parameter `flux_factor_regions`.

The additional parameter `apply_flux_factor_to` allows choosing whether the
calculated multiplicative factors should be applied to the simulated images
(thus generating individual exposures that preserve the signal differences
between them) or to the original images (rescaling them so that the exposures
should then have similar signal levels). In this example, we choose the first
option.

```console
(venv_numina) $ numina-crmasks params_example3_initial.yaml
```

Before generating the diagnostic diagram, **numina-crmasks** first displays a
figure showing the median combination (left panel) and the image number used to
compute the median at each pixel (right panel).

```{figure} images/image_number_at_median_position_example3.png
:name: fig-image_number_at_median_position_example3
:width: 100%

Left panel: median combination. Right panel: imagen number employed to computed
the median at each pixel.  Since in this example we have decreased and
increased the signal of the first and third exposures, respectively, the pixels
of the image with the strongest signal (sky lines) are mostly seen in the right
panel with the color corresponding to the second individual image. The user can
interactively zoom in on either of the two panels, and the same zoom level is
automatically applied to the adjacent panel.
```

Examining the previous figure clearly reveals the presence of a signal
discrepancy among the individual exposures.

Next, **numina-crmasks** attempts to determine a multiplicative flux factor
between each individual exposure and the median image.

```{figure} images/flux_factor1_example3.png
:name: fig-flux_factor1_example3
:width: 100%
```

```{figure} images/flux_factor2_example3.png
:name: fig-flux_factor2_example3
:width: 100%
```

```{figure} images/flux_factor3_example3.png
:name: fig-flux_factor3_example3
:width: 100%
```

In the figures shown above, the ratio between the signal in each individual
image and the median image is compared as a function of the signal in the
image. These figures are 2D histograms, and after removing some isolated bins
(left panels), a fit is performed to determine a multiplicative factor for each
individual exposure (right panels).

The user can choose to proceed from this point using these automatically
determined factors or rerun the program by explicitly setting the desired
factors in the `flux_factor` parameter. In the latter case, the factors are
provided as a list, for example: `flux_factor: [0.75, 1.01, 1.16]`.

In this example, the factors automatically calculated by **numina-crmasks** do
not match exactly the factors used to generate the input images (those factors
were `0.80`, `1.00` and `1.20`). In this case, where we are using
`apply_flux_factor_to: simulated` as an input parameter, the discrepancy is
not very problematic because the goal is to obtain an appropriate detection
boundary, and the multiplicative factors are being used only for that task. If
instead one wanted to use `apply_flux_factor_to: original`, a more accurate
determination of those multiplicative factors would be advisable.

Continuing the program execution after the automatic estimation of the
multiplicative factors, the code displays the resulting diagnostic diagram and
the estimated detection boundary.

```{figure} images/diagnostic_histogram2d_example3.png
:alt: MM diagnostic diagram for the median combination
:name: fig-diagnostic_histogram2d_example3
:width: 100%

Simulated (left) and real (right) Minimum-Median diagnostic diagram. This
diagram has been generated making use of the multiplicative factors computed by
**numina-crmasks**. This time, the simulated data show a distribution much
more similar to that of the original data, and the calculated detection
boundary is better defined. Compare this figure with 
{numref}`fig-diagnostic_histogram2d_example3_initial`.
```

From this point onward, the program can be used in the same way as in Example
1.


### Example 4: taking care of small image offsets

Another situation that may also occur is that the individual exposures show
small shifts between them, on the order of a fraction of a pixel in X or Y.
Note that, in principle, offsets larger than 1 pixel can always be reduced to
values smaller than one pixel by applying an integer translation of the offset
and leaving the fractional part as a residual.

In this new example, we will use as input a set of individual images that are
slightly shifted. In particular, we keep the second image fixed and shift the
first image by $(-0.5, +0.5)$ pixels in $(X, Y)$, while the offsets applied to
the third exposure are $(+0.5, -0.25)$ pixels.

As in Example 3, we will start running **numina-crmasks** while ignoring the
possibility that offsets may exist among the three individual exposures.

```console
(venv_numina) $ cd example4
(venv_numina) $ numina-crmasks params_example4_initial.yaml
```

In this case, we again encounter simulated diagnostic diagrams that fail to
reproduce what is observed in the individual exposures.

```{figure} images/diagnostic_histogram2d_example4_initial.png
:alt: MM diagnostic diagram for the median combination
:name: fig-diagnostic_histogram2d_example4_initial
:width: 100%

Simulated (left) and real (right) Minimum-Median diagnostic diagram. In
this case, there is a clear difference between the simulated and the real
data.
```

Since the detection boundary is underestimated, the number of false positives
on the sky lines increases dramatically, as shown in panel(c) of the following
figure:

```{figure} images/diagnostic_mediancr_example4_initial.png
:name: fig-diagnostic_mediancr_example4_initial
:width: 100%

MM diagnostic diagram and location of the detected cosmic-ray pixels. Note the
large number of false detections on the sky lines.
```

In this situacion, the **numina-crmasks** program includes the option to
attempt to determine the offsets between individual exposures making use of 2D
crosscorrelation.  The procedure does not guarantee optimal results, but it can
help reveal the presence of this issue. The user may also explicitly provide
the desired offsets, having calculated them beforehand.

In the following steps, we will attempt to automatically determine these
offsets by specifying the following information in the parameter file:

```{literalinclude} files/params_example4.yaml
:language: yaml
:lines: 60-62
:lineno-start: 60
:linenos: true
```

Note that we have modified the value of the `mm_crosscorr_region` parameter,
changing it from `null` to a rectangular region to be employed in the
crosscorrelation procedure. This instructs **numina-crmasks** to check
for the presence offsets between each individual exposure and the median
combination before generating the diagnostic diagram.

```console
(venv_numina) $ numina-crmasks params_example4.yaml
```

```{include} files/terminal_output_example4_01.md
```

In this example, we are using a rectangular region of the image that contains
bright sky lines. The offsets found for the three exposures — $(0.41, -0.46)$,
$(0.01, 0.00)$, and $(-0.29, 0.49)$ — agree very well with the offsets
introduced when simulating the individual exposures  — $(0.50, -0.50)$, $(0.00,
0.00)$, and $(-0.25, 0.50)$.

```{figure} images/xyoffset_crosscorr_1_example4.png
:name: fig-xyoffset_crosscorr_1_example4
:width: 100%

For each individual exposure, the program displays a figure with four panels.
In the top row, we have the median combination (left panel) and the
corresponding individual image (right panel). In the bottom row, we see the
difference between both images (left panel) and the same result after the
individual image has been shifted by applying the (X, Y) offsets calculated
using the 2D cross-correlation method (right panel).  In this case, the
situation for the first individual exposure is shown. The offset between the
median and that exposure is clearly visible (bottom-left panel), and after
applying the calculated offset, the difference between the median and the
shifted individual image becomes much more consistent with the exposures being
properly aligned.  
```

```{figure} images/xyoffset_crosscorr_2_example4.png
:name: fig-xyoffset_crosscorr_2_example4
:width: 100%

Figure similar to {numref}`fig-xyoffset_crosscorr_1_example4`, for the case of
the second individual exposure.
```

```{figure} images/xyoffset_crosscorr_3_example4.png
:name: fig-xyoffset_crosscorr_3_example4
:width: 100%

Figure similar to {numref}`fig-xyoffset_crosscorr_1_example4`, for the case of
the third individual exposure.
```

When generating the diagnostic diagram, **"numina-crmasks"** applies the
calculated offsets to the median image in order to simulate three exposures
that have the same relative displacements as the original three exposures.

```{figure} images/diagnostic_histogram2d_example4.png
:alt: MM diagnostic diagram for the median combination
:name: fig-diagnostic_histogram2d_example4
:width: 100%

Simulated (left) and real (right) Minimum-Median diagnostic diagram. This
diagram has been generated making use of the (X,Y) offsets between exposures
computed by **numina-crmasks**. This time, the simulated data show a distribution much more similar to that of the original data, and the calculated detection boundary is better defined. Compare this figure with
{numref}`fig-diagnostic_histogram2d_example4_initial`.
```

The newly calculated detection boundary performs much better, removing the
large number of false detections that occur when the presence of offsets
between exposures is not taken into account.

```{figure} images/diagnostic_mediancr_example4.png
:name: fig-diagnostic_mediancr_example4
:width: 100%

MM diagnostic diagram and location of the detected cosmic-ray pixels.
Compare this figure with
{numref}`fig-diagnostic_mediancr_example4_initial`.
```

From this point onward, the program can be used in the same way as in Example 1.

(description-of-parameters-in-requirements)=
## Parameters in the requirements section

This section describes the parameters found in the requirements section of the
YAML file used to run **numina-crmasks**.

### General parameters

These parameters determine the overall execution of **numina-crmasks**:

- `crmethod` (string): this parameter must take one of the following values:

  - $\color{green}\texttt{lacosmic}$: The L.A. Cosmic technique (van Dokkum 2001).

  - $\color{green}\texttt{mmcosmic}$: The Median-Minimum diagnostic diagram
    technique (Cardiel et al. 2025, in preparation).

  - $\color{green}\texttt{mm_lacosmic}$: Combination of
    $\color{green}\texttt{lacomisc}$ and $\color{green}\texttt{mmcosmic}$. In
    this case, pixels are flagged as suspicious if they are detected by either
    of the two previous algorithms.

- `use_lamedian` (boolean): If True, the cosmic-ray corrected array
  returned by the $\color{gray}\texttt{cosmicray_lacosmic()}$ function when
  cleaning the median array is used instead of the minimum value at each pixel.
  This affects differently depending on the combination method:

  - $\color{green}\texttt{mediancr}$: all the masked pixels in the mask
    $\color{magenta}\texttt{MEDIANCR}$ are replaced.

  - $\color{green}\texttt{meancrt}$: only the pixels coincident in masks
    $\color{magenta}\texttt{MEANCRT}$ and $\color{magenta}\texttt{MEDIANCR}$;
    the rest of the pixels flagged in the mask
    $\color{magenta}\texttt{MEANCRT}$ are replaced by the value obtained when
    the combination method is `mediancr`.

  - $\color{green}\texttt{meancr}$: only the pixels flagged in all the
    individual exposures (i.e., those flagged simultaneously in all the masks
    $\color{magenta}\texttt{CRMASK1}$, $\color{magenta}\texttt{CRMASK2}$,
    etc.); the rest of the pixels flagged in any of the
    $\color{magenta}\texttt{CRMASK1}$, $\color{magenta}\texttt{CRMASK2}$, etc.
    masks are replaced by the corresponding masked mean.

- `interactive`: Controls whether the program generates
  interactive plots using Matplotlib. If True, the plots are displayed with
  zoom and pan functionality. If False, the program runs in non-interactive
  mode. In any case, all the plots are also saved as PNG or PDF files.

- `flux_factor` (string, single float, list of floats, or None): this parameter
  controls how the relative flux levels of individual exposures are handled.
  This paramewter can be set in several ways:

  - $\color{green}\texttt{none}$: Assumes all exposures are equivalent;
    internally, a flux factor of 1.0 is applied to each.

  - $\color{green}\texttt{auto}$: The program automatically estimates the flux
    factor for each exposure by comparing it to the median of all exposures.

  - List of values: You can manually specify a list of flux factors (e.g.,
    `[0.78, 1.01, 1.11]`), with one value per exposure.

  - Single float: A single value (e.g., 1.0) applies the same flux factor to
    all exposures.

- `flux_factor_region` 
  (string $\color{green}\texttt{"[xmin:xmax, ymin:ymax]"}$): rectangular region
  to determine the relative flux levels of the individual exposures in
  comparison to the median combination, where the limits are defined in pixels
  following the FITS convention (the first pixel in each direction is numbered
  as 1). If this parameter is set to null in the YAML file (intepreted as None
  when read by Python), it is assumed that the full image area is employed.

- `apply_flux_factor_to` (string): specifies to which images the flux factors
  should be applied. Valid options are:

  - $\color{green}\texttt{original}$: apply the flux factors to the original
    images.

  - $\color{green}\texttt{simulated}$: apply the flux factors to the simulated
    data.

- `dilation` (integer): Specifies the dilation factor used to expand the
  mask around detected cosmic ray pixels. A value of 0 disables dilation. A
  value of 1 is typically recommended, as it helps include the tails of cosmic
  rays, which may have lower signal levels but are still affected.

- `regions_to_be_skipped` (list of $\color{green}\texttt{[xmin, xmax, ymin,
  ymax]}$ regions). The format of each region must be a list of 4 integers,
  following the FITS convention

- `pixels_to_be-flagged_as_cr` (list of $\color{green}\texttt{[X,Y]}$ pixel
  coordinates; FITS criterium).

- `pixels_to_be_ignored_as_cr` (list of $\color{green}\texttt{[X,Y]}$ pixel
  coordinates; FITS criterium).

- `pixels_to_be_replaced_by_local_median` (list of 
  $\color{green}\texttt{[X, Y, X_width, Y_width]}$ values): $\color{green}\texttt{X, Y}$ pixel coordinates
  (FITS criterium), and median window size $\color{green}\texttt{X_width,
  Y_width}$ to compute the local median (these two numbers must be odd).

- `verify_cr` (boolean): If set to True, the code displays a graphical
  representation of the pixels detected as cosmic rays during the computation
  of the $\color{magenta}\texttt{MEDIANCR}$ mask, allowing the user to decide
  whether or not to include those pixels in the final mask.

- `semiwindow` (integer): Defines the semiwindow size (in pixels) used
  when plotting the double cosmic ray hits. This parameter is only used if
  `plots` is set to True.

- `color_scale` (string): Specifies the color scale used in the
  images displayed in the `mediancr_identified_cr.pdf` file. This option is
  only relevant if `plots` is set to True. Valid values are
  $\color{green}\texttt{minmax}$ and $\color{green}\texttt{zscale}$.

- `maxplots` (integer): Sets the maximum number of suspicious double
  cosmic rays to display. Limiting the number of plots is useful when
  experimenting with program parameters, as it helps avoid generating an
  excessive number of plots due to false positives. A negative value means all
  suspected double CRs will be displayed (note that this may significantly
  increase execution time). This option is only used if `plots` is True.

### Parameters for the L.A. Cosmic algorithm

All parameters in this section correspond to parameters of the
[$\color{gray}\texttt{cosmicray_lacosmic()}$
function](https://ccdproc.readthedocs.io/en/latest/api/ccdproc.cosmicray_lacosmic.html),
which is used to apply the $\color{red}\texttt{LAcosmic}$ technique. Not all
parameters from that function are used (only a subset is being employed). Note
that the parameter names here match those in the
$\color{gray}\texttt{cosmicray_lacosmic()}$ but with a `la_` prefix, which
helps distinguish them from the parameters used in the
$\color{blue}\texttt{MMcosmic}$ algorithm.

We recommend that users consult the documentation for these parameters in the
official documentation of the [$\color{gray}\texttt{cosmicray_lacosmic()}$
function](https://ccdproc.readthedocs.io/en/latest/api/ccdproc.cosmicray_lacosmic.html).

- `la_gain_apply` (bool): If True, apply the gain when computing the corrected
  image.

- `la_sigclip` (float): Laplacian-to-noise limit for cosmic ray detection.

- `la_sigfrac` (float): Fractional detection limit for neighboring pixels.

- `la_objlim` (float): Minimum contrast between Laplacian image and the fine
  structure image.

- `la_satlevel` (float): Saturation level of the image (in ADU). **Important**:
  this parameter is employed in electrons by the
  $\color{gray}\texttt{cosmicray_lacosmic()}$ function.  Here we define this
  parameter in ADU and it is properly transformed into electron afterwards.

- `ls_niter` (integer): Number of iterations of the L.A. Cosmic algorithm to
  perform.

- `la_sepmed` (boolean): Use the separable median filter instead of the full
  median filter.

- `la_cleantype` (string): Clean algorithm to be used:

  - $\color{green}\texttt{median}$: An unmasked 5x5 median filter.

  - $\color{green}\texttt{medmask}$: A masked 5x5 median filter.

  - $\color{green}\texttt{meanmask}$ A masked 5x5 mean filter.

  - $\color{green}\texttt{idw}$: A masked 5x5 inverse distance weighted
    interpolation.

- `la_fsmode` (string): Method to build the fine structure image. Possible
  values are:

  - $\color{green}\texttt{median}$: Use the median filter in the standard LA
    Cosmic algorithm.

  - $\color{green}\texttt{convolve}$: Convolve the image with the psf kernel to
    calculate the fine structure image.

- `la_psfmodel` (string): Model to use to generate the psf kernel if `fsmode ==
  'convolve'` and `psfk` is None (the latter is always the case when using
  **numina-crmasks**). Possible choices:

  - $\color{green}\texttt{gauss}$ and $\color{green}\texttt{moffat}$: produce
    circular PSF kernels.

  - $\color{green}\texttt{gaussx}$: Gaussian kernel in the X direction.

  - $\color{green}\texttt{gaussy}$: Gaussian kernel in the Y direction.

  - $\color{green}\texttt{gaussxy}$: Elliptical Gaussian.

- `la_psffwhm_x` (integer): Full Width Half Maximum of the PSF to use to
  generate the kernel along the X axis (pixels).

- `la_psffwhm_y` (integer): Full Width Half Maximum of the PSF to use to
  generate the kernel along the Y axis (pixels).

- `la_psfsize` (integer): Size of the kernel to calculate (pixels).

- `la_psfbeta` (float): Moffat beta parameter. Only used if 
  `la_fsmode`=$\color{green}\texttt{convolve}$
  and `la_psfmodel`=$\color{green}\texttt{moffat}$.

- `la_verbose` (boolean): Print to the screen or not. This parameter is
  automatically set to False if the program is executed with `--log-level` set
  to `WARNING` or higher.

In addition to these parameters, **numina-crmasks** also uses the values of
`gain` and `rnoise` (defined at the top level of its configuration YAML file)
as inputs to the $\color{gray}\texttt{cosmicray_lacosmic()}$ function.
Therefore, there is no need to define `la_gain` or `la_readnoise`.

Note that although the $\color{gray}\texttt{cosmicray_lacosmic()}$ function
initially only makes use of a single parameter `psffwhm` to generate kernels,
we have included the option to use different FWHM values along each axis. This
is enabled by setting the desired values for `la_psffwhm_x` and `la_psffwhm_y`,
and choosing `la_psfmodel=gaussxy`, whose kernel is defined within the
**numina-crmasks** code. When `la_psfmodel` is set to `gauss` or `moffat`, a
single `psffwhm` value computed as the arithmetic mean of `la_psffwhm_x` and
`la_psffwhm_y` is employed. When `la_psfmodel` is set to `gaussx` or `gaussy`,
the `psffwhm` parameter is set to `la_psffwhm_x` or `la_psffwhm_y`,
respectively.

### Parameters for the detection boundary in the MM diagnostic diagram

These are the parameters that define how to compute the detection boundary in
the MM diagnostic diagram. Their name make use of the prefix `mm_` to clearly
distinguish them from those associated with the L.A. Cosmic method.

- `mm_xy_offsets` (list of $\color{green}\texttt{[xoffset, yoffset]}$ values).
  Offsets (pixels) to apply to each simulated individual exposure when
  computing the diagnostic diagram for the mmcosmic method. This option is not
  compatible with `mm_crosscorr_region`.

- `mm_crosscorr_region` (string $\color{green}\texttt{"[xmin:xmax,
  ymin:ymax]"}$): Rectangular region used to determine X and Y offsets between
  the individual exposures. The region must be specified in the format
  $\color{green}\texttt{[xmin:xmax, ymin:ymax]}$, where the limits are defined
  in pixels following the FITS convention (the first pixel in each direction is
  numbered as 1).  This means that $1 \leq \texttt{xmin} < \texttt{xmax} \leq
  \texttt{NAXIS1}$ and $1 \leq \texttt{ymin} < \texttt{ymax} \leq
  \texttt{NAXIS2}$. If this parameter is set to null in the YAML file
  (interpreted as None when read by Python), it is assumed that the individual
  exposures are perfectly aligned.

- `mm_boundary_fit` (string): Type of mathematical function used to determine
  the boundary separating the expected signal in the MM diagnostic diagram
  between pixels affected and unaffected by cosmic rays. The two available
  options are:

  - $\color{green}\texttt{piecewise}$: piecewise linear function passing through
    a set of fixed points defined in `mm_fixed_points_in_boundary`).

  - $\color{green}\texttt{spline}$: iterative fit using splines with a
    predefined number of knots specified by `mm_knots_split`.

- `mm_knots_splfit` (integer): Total number of knots employed in the spline fit
  that define the detection boundary in the diagnostic diagram.

- `mm_fixed_points_in_boundary` (list of 
  $\color{green}\texttt{[X, Y, weight]}$): Points used to fit the detection
  boundary in the MM diagnostic diagram. In the case of a `piecewise` fit, the
  boundary is constructed using straight lines connecting the specified points.
  If a $\texttt{spline}$ fit is used, the manually provided points are combined
  with simulated ones. In the first case, each point is specified on a separate
  line in the YAML file using the format $\color{green}\texttt{[X, Y]}$. In the
  second case, the format is $\color{green}\texttt{[X, Y, weight]}$, where the
  weight is optional and should be a large number (default 1000 when not
  provided) to ensure that the numerical fit closely follows the manually
  specified points.

- `mm_nsimulations` (integer): Number of simulations to perform for each
  collection of exposures when generating the simulated diagnostic diagram.

- `mm_niter_boundary_extension` (integer): Number of iterations
  used to extend the detection boundary above the red crosses in the simulated
  diagnostic diagram, improving the robustness of cosmic ray detection by
  reducing the number of false positives. This option is only employed when
  `mm_boundary_fit`=$\color{green}\texttt{spline}$.

- `mm_weight_boundary_extension` (float): Weight applied to
  the vertical distance between fitted points in the diagnostic diagram when
  extending the detection boundary above the red crosses. During each
  iteration, points above the previous fit are multiplied by this weight raised
  to the power of the iteration number. This forces the fit to better align
  with the upper boundary defined by the red crosses in the simulated
  diagnostic diagram, improving the accuracy of cosmic ray detection.

- `mm_threshold` (float): Minimum threshold for the `median2d -
  min2d` value in the diagnostic diagram. This acts as an additional
  constraint beyond the detection boundary (pixels with values below this
  threshold are not considered as suspected cosmic ray hits).

- `mm_minimum_max2d_rnoise` (float): Minimum value of
  `max2d`, expressed in readout noise units, required to consider a pixel as
  a double cosmic ray. This helps avoid false positives caused by large
  negative values in one of the individual exposures.

- `mm_seed` (integer or None): Sets the random seed used when generating the
  simulated diagnostic diagram. If set to None, the seed is randomly
  generated, resulting in slightly different simulations each time.
