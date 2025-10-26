# NUMINA tools

This webpage describes how to execute specific scripts provided by the Python
package [numina](https://numina.readthedocs.io/en/stable/index.html). Among
other features, this package offers the interface for executing data reduction
pipelines for various instruments of the Gran Telescopio Canarias (GTC), in
particular [EMIR](https://www.gtc.iac.es/instruments/emir/emir.php), [MEGARA](https://www.gtc.iac.es/instruments/megara/megara.php) and [FRIDA](https://www.gtc.iac.es/instruments/frida/frida.php).
Additionally, **numina** includes code for performing common operations
involved in astronomical image reduction workflows, allowing such functionality
to be reused across pipelines for different instruments.

This webpage *does not describe how to use the data reduction pipelines* for
the various GTC instruments. That information is provided in dedicated
documentation pages for each instrument: [pyemir](https://pyemir.readthedocs.io/en/stable/), [megaradrp](https://guaix-ucm.github.io/megaradrp-cookbook/), and [fridadrp](https://guaix-ucm.github.io/fridadrp-tutorials/) (still under developement).
The utilities described here correspond only to particular manipulations of
astronomical images which, once implemented as part of a data reduction
pipeline for a particular instrument, have proven useful for processing images
obtained with other instruments. In this sense, they are limited in scope, and
it is not the aim of **numina** to provide a general-purpose astronomical image
reduction package.

```{toctree}
:maxdepth: 1

installation/installation
crmasks/crmasks
```

```{warning}
This webpage contains a preliminary draft of the documentation for the
aforementioned scripts. As such, some details may vary slightly depending on
the version of numina being used.
```
