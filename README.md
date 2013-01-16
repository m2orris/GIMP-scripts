#GIMP-scripts
###Version 1.0
#####Copyright (c) 2013 Michael Morris<br>This software is released under MIT Open Source License

**************

##Objective

`GIMP-scripts` is a collection of macros or scripts for GIMP.

**************

###Script-Fu / export_iOS_icons_of_image.scm###

This Script-Fu script automatically generates all the required app icons with the proper names and resolutions for the various iOS devices from a single source image.

For each app icon: the source image* is duplicated, then the duplicated image is scaled, then the scaled duplicate image is exported to a .png file, and finally the scaled duplicate image is deleted. The resulting .png files have the proper names and resolutions for iOS app icons for iPad and iPhone/iPod touch for both normal and retina displays.

**The recommended resolution of the source image is 1024 x 1024*

This script contains two functions.

* **Function Name:** `export-ios-icons-of-image-for-device`<br>
**Menu:** `File --> Export iOS Icon of Image --> Icons for Device(s) ...`<br>
Exports multiple iOS app icons to a user specified directory for a user specified iOS device. The following are the possible iOS app icon filenames (and resolutions):<br>

    iTunesArtwork@2x (1024 x 1024)
    iTunesArtwork (512 x 512)
    Icon-72@2x.png (144 x 144)
    Icon@2x.png (114 x 114)
    Icon-72.png (72 x 72)
    Icon.png (57 x 57)
    Icon-Small-50@2x.png (100 x 100)
    Icon-Small-50.png (50 x 50)
    Icon-Small@2x.png (58 x 58)
    Icon-Small.png (29 x 29)

* **Function Name:** `export-ios-icon-of-image`<br>
**Menu:** `File --> Export iOS Icon of Image --> Single Icon ...`<br>
Exports a single iOS app icon to a user specified directory with a user specified filename and a user specified width in pixels.

##Installation
1. Copy the scripts from the `GIMP-scripts/Script-Fu` directory to the GIMP scripts directory.
2. Start GIMP
3. In GIMP `Filters --> Script-Fu --> Refresh Script`