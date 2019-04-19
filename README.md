# angular_plotter

This is an Igor Script used to plot the data collected with the angular resolved setup. It is currently not very well written and could use some work to make it more general. Right now, if you try to use it on data saved in a different way than the way I do it, it will most likely not work. I don't think it would be very difficult to make this script better, but don't have the time to dedicate to it right now, so I have left a list of suggested future changes at the bottom.
 
### Data formatting for script to work:
-Only txt files in the folder are collected spectra and possibly a README.txt

-The filenames of the collected spectra start with a letter of lower ascii value than "d" (so that dark is the last file loaded and README is not loaded at all)

-There is a spectrum from 0 to 70 degrees in 2.5 degree intervals

### How this script could be improved:
-Extract wave names from file names to improve generalizability

-Choose columns of dataMatrix based on wave names to improve generalizability
