; export_iOS_icons_of_image.scm
; Copyright (c) 2013 Michael Morris
; This software is released under MIT Open Source License
; ==============================================================================

(define (export-ios-icon-of-image inImage inDrawable inPath inFilename inDimension)
    (let* (
        (thePathAndFilename (string-append inPath DIR-SEPARATOR inFilename)))
        
        ; Check to make sure thePathAndFilename does not exist
        (if (file-exists? thePathAndFilename)
        
            ; The file exists, display message and exit
            (gimp-message (string-append "The file:[" thePathAndFilename "] exists, skipping."))
            
            ; The file does not exist, duplicate, scale, export, and delete duplicate
            (let (
                (theDuplicateImage (car (gimp-image-duplicate inImage))))
                
                (gimp-image-scale theDuplicateImage inDimension inDimension)
                (file-png-save
                    RUN-NONINTERACTIVE
                    theDuplicateImage
                    (car (gimp-image-flatten theDuplicateImage))
                    thePathAndFilename
                    inFilename
                    0               ; Use Adam7 interlacing?
                    9               ; Deflate Compression factor (0--9)
                    0               ; Write bKGD chunk?
                    0               ; Write gAMA chunk?
                    0               ; Write oFFs chunk?
                    0               ; Write pHYs chunk?
                    0)              ; Write tIME chunk?
                (gimp-image-delete theDuplicateImage)
            )
        )
    )
)

(script-fu-register
    "export-ios-icon-of-image"                  ;func name
    "Single Icon ..."                           ;menu label
    "Exports an iOS icon of the image around the user's choice of:\
      path, filename, and width in pixels."     ;description           
    "Michael Morris"                            ;author
    "Copyright (c) 2013 Michael Morris\         
      This software is released under MIT Open Source License" ;copyright notice
    "January 10, 2013"                          ;date created
    "*"                                         ;image type that the script works on
    SF-IMAGE     "Image"            0
    SF-DRAWABLE  "Drawable"         0
    SF-DIRNAME   "Path"             "/tmp"
    SF-STRING    "Filename"         "Icon.png"
    SF-VALUE     "Width in Pixels"  "57"
)

(script-fu-menu-register "export-ios-icon-of-image" "<Image>/File/Export iOS Icon of Image")

; ==============================================================================

(define (export-ios-icons-of-image-for-device inImage inDrawable inPath iniPadIcons iniPhoneIcons)
    
    (if (or (= 1 iniPadIcons) (= 1 iniPhoneIcons))
        (begin
            (export-ios-icon-of-image inImage inDrawable inPath "iTunesArtwork@2x" 1024)
            (export-ios-icon-of-image inImage inDrawable inPath "iTunesArtwork" 512)
            (export-ios-icon-of-image inImage inDrawable inPath "Icon-Small@2x.png" 58)
            (export-ios-icon-of-image inImage inDrawable inPath "Icon-Small.png" 29)))
    (if (= 1 iniPadIcons)
        (begin
            (export-ios-icon-of-image inImage inDrawable inPath "Icon-72@2x.png" 144)
            (export-ios-icon-of-image inImage inDrawable inPath "Icon-72.png" 72)
            (export-ios-icon-of-image inImage inDrawable inPath "Icon-Small-50@2x.png" 100)
            (export-ios-icon-of-image inImage inDrawable inPath "Icon-Small-50.png" 50)))
    (if (= 1 iniPhoneIcons)
        (begin
            (export-ios-icon-of-image inImage inDrawable inPath "Icon@2x.png" 114)
            (export-ios-icon-of-image inImage inDrawable inPath "Icon.png" 57)))
)

(script-fu-register
    "export-ios-icons-of-image-for-device"      ;func name
    "Icons for Device(s) ..."                   ;menu label
    "Exports iOS icons of the image around the user's choice of:\
      path and device(s): iPad and/or iPhone/iPod touch";description        
    "Michael Morris"                            ;author
    "Copyright (c) 2013 Michael Morris\
      This software is released under MIT Open Source License" ;copyright notice
    "January 10, 2013"                          ;date created
    "*"                                         ;image type that the script works on
    SF-IMAGE     "Image"                           0
    SF-DRAWABLE  "Drawable"                        0
    SF-DIRNAME   "Path"                            "/tmp"
    SF-TOGGLE    "Create iPad icons"               1
    SF-TOGGLE    "Create iPhone/iPod touch icons"  1
)

(script-fu-menu-register "export-ios-icons-of-image-for-device" "<Image>/File/Export iOS Icon of Image")
