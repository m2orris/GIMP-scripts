; export_iOS_icons_of_image.scm
; Copyright (c) 2013 Michael Morris
; This software is released under MIT Open Source License
; ==============================================================================

; ------------------------------------------------------------------------------
(define (export-as-ios-image inImage inDrawable inPath inFilename inWidth inHeight)
    (let* (
        (thePathAndFilename (string-append inPath DIR-SEPARATOR inFilename)))
        
        ; Check to make sure thePathAndFilename does not exist
        (if (file-exists? thePathAndFilename)
        
            ; The file exists, then display message and exit
            (gimp-message (string-append "The file:[" thePathAndFilename "] exists, skipping."))
            
            ; The file does not exist, then duplicate, scale, export, and delete duplicate
            (let* (
                (theDuplicateImage (car (gimp-image-duplicate inImage))))
                (gimp-image-scale theDuplicateImage inWidth inHeight)
                (file-png-save
                    RUN-NONINTERACTIVE
                    theDuplicateImage
                    (car (gimp-image-merge-visible-layers theDuplicateImage 1))
                    thePathAndFilename
                    inFilename
                    0               ; Use Adam7 interlacing?
                    9               ; Deflate Compression factor (0--9)
                    1               ; Write bKGD chunk?
                    1               ; Write gAMA chunk?
                    0               ; Write oFFs chunk?
                    0               ; Write pHYs chunk?
                    0)              ; Write tIME chunk?
                (gimp-image-delete theDuplicateImage)))))

; ------------------------------------------------------------------------------
(define (export-as-ios-retina-and-standard-image inImage inDrawable inPath inFilename inImageExportOption inImageScalingOption inSize)
    ; Image export: retina
    (if (or (= 0 inImageExportOption) (= 1 inImageExportOption))
        (let* (
            (filename (string-append inFilename "@2x.png")))
          
            (if (= 0 inImageScalingOption)
                ; Scaling option square: width = size, height = size
                (export-as-ios-image inImage inDrawable inPath filename inSize inSize)

                (if (= 1 inImageScalingOption)
                    ; Scaling option rectangle: width = size, height is proportionate
                    (export-as-ios-image inImage inDrawable inPath filename inSize (round (* (car (gimp-image-height inImage)) (/ inSize (car (gimp-image-width inImage))))))

                    (if (= 2 inImageScalingOption)
                        ; Scaling option rectangle: width is proportionate, height = size
                        (export-as-ios-image inImage inDrawable inPath filename (round (* (car (gimp-image-width inImage)) (/ inSize (car (gimp-image-height inImage))))) inSize))))
            ; Halve the image size for standard image
            (set! inSize (round (/ inSize 2)))))

    ; Image export: standard
    (if (or (= 0 inImageExportOption) (= 2 inImageExportOption))
        (let* (
            (filename (string-append inFilename ".png")))
            
            (if (= 0 inImageScalingOption)
                ; Scaling option square: width = size, height = size
                (export-as-ios-image inImage inDrawable inPath filename inSize inSize)

                (if (= 1 inImageScalingOption)
                    ; Scaling option rectangle: width = size, height is proportionate
                    (export-as-ios-image inImage inDrawable inPath filename inSize (round (* (car (gimp-image-height inImage)) (/ inSize (car (gimp-image-width inImage))))))

                    (if (= 2 inImageScalingOption)
                        ; Scaling option rectangle: width is proportionate, height = size
                        (export-as-ios-image inImage inDrawable inPath filename (round (* (car (gimp-image-width inImage)) (/ inSize (car (gimp-image-height inImage))))) inSize)))))))

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(script-fu-register
    "export-as-ios-retina-and-standard-image"                       ;func name
    "Image(s) ..."                                                  ;menu label
    "Export scaled (selectable) iOS image(s) (retina and/or\
    standard) from the active image.  The scaling is either square\
    or rectangular.\
    \
    Square scaling results in iOS images that have the width and\
    height equal to the size specified.\
    \
    Rectangular scaling results in iOS image(s) that have either\
    the width or height equal to the size specified and the other\
    dimension scaled proportionally."                               ;description
    "Michael Morris"                                                ;author
    "Copyright (c) 2013 Michael Morris\         
    This software is released under MIT Open Source License"        ;copyright notice
    "April 17, 2013"                                                ;date created
    "*"                                                             ;image type that the script works on
    SF-IMAGE     "Image"                                    0
    SF-DRAWABLE  "Drawable"                                 0
    SF-DIRNAME   "Path"                                     "/tmp"
    SF-STRING    "Filename\n  (without @2x.png & .png)"     "Image"
    SF-OPTION    "Image(s) exported" '("Retina and Standard" "Retina only" "Standard only")
    SF-OPTION    "Image scaling" '("Square (width = size, height = size)" "Rectangle (width = size, height is proportionate)" "Rectangle (width is proportionate, height = size)")
    SF-VALUE     "Size of image in Pixels\n  (if both retina and standard\n  images are being exported,\n  the standard image size\n  will be half of the value)"   "114"
)

(script-fu-menu-register "export-as-ios-retina-and-standard-image" "<Image>/File/Export as iOS")

; ------------------------------------------------------------------------------
(define (export-as-ios-icons-for-device inImage inDrawable inPath iniPadIcons iniPhoneIcons)
    
    (if (or (= 1 iniPadIcons) (= 1 iniPhoneIcons))
        (begin
            (export-as-ios-image inImage inDrawable inPath "iTunesArtwork@2x" 1024 1024)
            (export-as-ios-image inImage inDrawable inPath "iTunesArtwork" 512 512)
            (export-as-ios-image inImage inDrawable inPath "Icon-Small@2x.png" 58 58)
            (export-as-ios-image inImage inDrawable inPath "Icon-Small.png" 29 29)))
    (if (= 1 iniPadIcons)
        (begin
            (export-as-ios-image inImage inDrawable inPath "Icon-72@2x.png" 144 144)
            (export-as-ios-image inImage inDrawable inPath "Icon-72.png" 72 72)
            (export-as-ios-image inImage inDrawable inPath "Icon-Small-50@2x.png" 100 100)
            (export-as-ios-image inImage inDrawable inPath "Icon-Small-50.png" 50 50)))
    (if (= 1 iniPhoneIcons)
        (begin
            (export-as-ios-image inImage inDrawable inPath "Icon@2x.png" 114 114)
            (export-as-ios-image inImage inDrawable inPath "Icon.png" 57 57))))

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(script-fu-register
    "export-as-ios-icons-for-device"                                ;func name
    "Icons for Device(s) ..."                                       ;menu label
    "Exports the required and recommend iOS icons for the iOS\
    devices (selectable) and iOS display types from the active\
    image."                                                         ;description
    "Michael Morris"                                                ;author
    "Copyright (c) 2013 Michael Morris\
    This software is released under MIT Open Source License"        ;copyright notice
    "April 17, 2013"                                                ;date created
    "*"                                                             ;image type that the script works on
    SF-IMAGE    "Image"                             0
    SF-DRAWABLE "Drawable"                          0
    SF-DIRNAME  "Path"                              "/tmp"
    SF-TOGGLE   "Create iPad icons"                 1
    SF-TOGGLE   "Create iPhone/iPod touch icons"    1
)

(script-fu-menu-register "export-as-ios-icons-for-device" "<Image>/File/Export as iOS")