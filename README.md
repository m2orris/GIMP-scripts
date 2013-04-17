#GIMP-scripts
###Version 1.10
#####Copyright (c) 2013 Michael Morris<br>This software is released under MIT Open Source License

**************

##Objective

`GIMP-scripts` is a collection of macros or scripts for GIMP.

**************

###Script-Fu / export_iOS_icons_of_image.scm###

This Script-Fu script automatically generates all the required and recommend app icons with the proper names and resolutions for the various iOS devices from a single source image.

For each app icon: the source image* is duplicated, then the duplicated image is scaled, then the scaled duplicate image is exported to a .png file, and finally the scaled duplicate image is deleted. The resulting .png files have the proper names and resolutions for iOS app icons for iPad and iPhone/iPod touch for both normal and retina displays.

\**The recommended resolution of the source image is 1024 x 1024*

This script contains two functions.

* **Function Name:** `export-as-ios-icons-for-device`<br>
**Menu:** `File --> Export as iOS --> Icons for Device(s) ...`<br>
Exports multiple iOS app icons to a user specified directory for a user specified iOS device. The following are the possible iOS app icon filenames (and resolutions):<br>
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

* **Function Name:** `export-as-ios-retina-and-standard-image`<br>
**Menu:** `File --> Export as iOS --> Image(s) ...`<br>
Export scaled (selectable) iOS image(s) (retina and/or standard) from the active image.  The scaling is either square or rectangular. Square scaling results in iOS images that have the width and height equal to the size specified. Rectangular scaling results in iOS image(s) that have either the width or height equal to the size specified and the other dimension scaled proportionally.
##Installation
1. Copy the scripts from the `GIMP-scripts/Script-Fu` directory to the GIMP scripts directory.
2. Start GIMP
3. In GIMP `Filters --> Script-Fu --> Refresh Script`
##Release Notes
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