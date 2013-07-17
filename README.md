#GIMP-scripts
###Version 1.20
#####Copyright (c) 2013 Michael Morris<br>This software is released under MIT Open Source License

**************

##Objective

`GIMP-scripts` is a collection of macros or scripts for GIMP.

**************

###Script-Fu / export_iOS_icons_of_image.scm###

This Script-Fu script contains functions that non-destructively convert the active image to various user specified iOS images and app icons.  

The following describes the conversion process. First, the active image is duplicated.  Second, if scaling is required, scaling is applied to the duplicate image.  Next, the duplicate image is exported with a name that follows the iOS naming convention ("@2x.png" for Retina images and ".png" for Non-Retina images, as well as proper iOS app icon names when exporting app icons). Finally after completion of the export, the duplicate image is destroyed.  Each image generated started with a clean duplicate copy of the active image.

This script contains three functions.

* **Function Name:** `export-image-as-app-icons-for-devices`<br>
**Menu:** `File --> iOS Export --> Image as --> App Icons for Device(s) ...`<br>
Exports the required and recommend iOS app icons for the various iOS devices and iOS display types from the active image.<br><br>
<i>The recommended resolution of the active image is 1024 x 1024.</i><br><br>
The following are the possible iOS app icon filenames (and resolutions):<br>
`iTunesArtwork@2x (1024 x 1024)`<br>
`iTunesArtwork (512 x 512)`<br>
`Icon-72@2x.png (144 x 144)`<br>
`Icon@2x.png (114 x 114)`<br>
`Icon-72.png (72 x 72)`<br>
`Icon.png (57 x 57)`<br>
`Icon-Small-50@2x.png (100 x 100)`<br>
`Icon-Small-50.png (50 x 50)`<br>
`Icon-Small@2x.png (58 x 58)`<br>
`Icon-Small.png (29 x 29)`<br>

* **Function Name:** `export-image-as-ios-images`<br>
**Menu:** `File --> iOS Export --> Image as --> Image(s) ...`<br>
Exports an iOS Retina image and/or an iOS Non-Retina image from the active image. The resulting image(s) are scaled per user specifications.<br><br>
Scaling will be either down, up, or none, depending upon the user specified size and the active image's resolution. Scaling is either square or rectangular. Square scaling results in image(s) that have the width and height equal to the size specified. Rectangular scaling results in image(s) that have either the width or height equal to the size specified and the other dimension scaled proportionally.<br><br>
If the user specifies that both Retina and Non-Retina images are to be exported, the resolution of the resulting iOS Retina image will be equivalent to the size specified while the resolution of the resulting iOS Non-Retina image will be half of the size. If the user specifies only a Retina or only a Non-Retina image is to be exported, resulting iOS image will be equivalent to the size specified.<br><br>
<i>The recommended resolution of the active image is equivalent to the resolution of the largest image to be exported.</i>

* **Function Name:** `export-retina-resolution-image-as-ios-images`<br>
**Menu:** `File --> iOS Export --> Retina Resolution Image as --> Image(s) ...`<br>
Exports an iOS Retina image and/or an iOS Non-Retina image from the active image. The active image's resolution is equivalent to that of the resulting iOS Retina image.<br><br>
The resulting iOS Retina image has the same width and height as the active image. The resulting iOS Non-Retina image has half the width and half the height as the active image.<br><br>
<i>The recommended resolution of the active image is equivalent to that of the resulting iOS Retina image.</i><br>


##Installation
1. Copy the scripts from the `GIMP-scripts/Script-Fu` directory to the GIMP scripts directory.
2. Start GIMP
3. In GIMP `Filters --> Script-Fu --> Refresh Script`
##Release Notes
### 1.20 - July 17, 2013
* Refactored the Menu items in GIMP. Everything is under `File --> iOS Export`.
* Added iOS Export Retina Resolution Image as Image(s). `File --> iOS Export --> Retina Resolution Image as --> Image(s) ...`
* Renamed functions with more descriptive names and cleaned up function descriptions.
### 1.10 - April 17, 2013
* Generalized the single icon export.
  * Retina and/or Standard images can be exported in a single step.
  * Square scaling 1 for 1 width and height.
  * Rectangular scaling that preserves the original image's proportions.
  * Cleaner interface.
* Saving png background and gamma attributes. 
* Using `gimp-image-merge-visible-layers` to combine layers instead of `gimp-image-flatten`.
### 1.00 - January 17, 2013
* Initial release
##Contributors
* **Eric Genet** - iOS Image Export (Retina & Standard), png file saving tweaks, `gimp-image-merge-visible-layers`, and rectangular scaling.