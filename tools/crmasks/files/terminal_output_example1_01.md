```{code-block} ansi-shell-session
:class: my-special-block no-copybutton

[92m────────────────────────── [0m[1;35m Numina: Cosmic Ray Masks [0m[92m ──────────────────────────[0m
Using numina.array.crmasks.__main__ version [1;36m0.35[0m.[1;36m3.[0mdev175+g2b33e9a03            
found input file: test_1.fits                                                   
found input file: test_2.fits                                                   
found input file: test_3.fits                                                   
[92m───────────────────────── [0m[1;35m Computing cosmic ray masks [0m[92m ─────────────────────────[0m
number of input arrays: [1;36m3[0m                                                       
gain defined as a constant value: [1;36m1.000000[0m                                      
readout noise defined as a constant value: [1;36m3.400000[0m                             
bias defined as a constant value: [1;36m0.000000[0m                                      
subtracting bias from the input arrays                                          
computing crmasks using crmethod: [1;32mmm_lacosmic[0m                                   
use_lamedian: [3;91mFalse[0m                                                             
flux_factor: [1m[[0m[1;36m1[0m. [1;36m1[0m. [1;36m1[0m.[1m][0m                                                         
apply_flux_factor_to: simulated                                                 
individual pixels to be initially flagged as CR: [3;35mNone[0m                           
individual pixels to be initially ignored as CR: [3;35mNone[0m                           
pixels to be replaced by the median value when removing the CRs: [3;35mNone[0m           
dtype for output arrays: [1m<[0m[1;95mclass[0m[39m [0m[32m'numpy.float32'[0m[1m>[0m                                
dilation factor: [1;36m1[0m                                                              
verify cosmic-ray detection: [3;91mFalse[0m                                              
semiwindow size for plotting coincident cosmic-ray pixels: [1;36m15[0m                   
maximum number of coincident cosmic-ray pixels to plot: [1;36m-1[0m                      
color scale for plots: minmax                                                   
...
...
```
