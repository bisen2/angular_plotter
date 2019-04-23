# angular_plotter

This is an Igor Script used to plot the data collected with the angular resolved setup. It is currently not very well written and could use some work to make it more general. Right now, if you try to use it on data saved in a different way than the way I do it, it will most likely not work. I don't think it would be very difficult to make this script better, but don't have the time to dedicate to it right now, so I have left a list of suggested future changes at the bottom.

### Usage:
When the procedure file is compiled, a new menu item labeled "Spectrometer" should appear. This gives the options to:

-Load Files (Ctrl 1): Gives dialog to choose a folder of data files to load

-Make DataMatrix (Ctrl 2): Preps data loaded from previous command for use in future commands. In particular, it creates a matrix of all of the spectrometer data

-Make Heatmap (Ctrl 3): Plots and formats image of the data matrix made in the previous command. Also pops up a dialog to select a location to save the image as a PNG

-Plot Forward Emission (Ctrl 4): Plots the forward emission spectrum of the loaded data and formats the graph. Also pops up a dialog to select a location to save the image as a PNG

-Do Everything (Ctrl 5): Runs all of the previous commands sequentially. This is good for doing everything quickly, but is less robust than running each command individually.

### Note:
As of now, all PNGs are saved with a 1024 dpi resolution to make very high quality graphs. If you want to conserve disk space, a lower resolution could be set in the script.
 
### Data formatting for script to work:
-Only txt files in the folder are collected spectra and possibly a README.txt

-The filenames of the collected spectra start with a letter of lower ascii value than "d" (so that dark is the last file loaded and README is not loaded at all)

-There is a spectrum from 0 to 70 degrees in 2.5 degree intervals

### How this script could be improved:
-Extract wave names from file names to improve generalizability

-Choose columns of dataMatrix based on wave names to improve generalizability
