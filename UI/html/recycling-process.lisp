(in-package :r-html)

(defun plastic-recycling-process ()
  `(:ul
    ((:class "plastic-recycling-process"))
    (:li "Remove lids from bottles before recycling (check)")
    (:li "Rinse out bottles with water before recycling")
    (:li "Take your plastics to a recycling center if pickup is unavailable")
    )
  )

(defun metals-recycling-process ()
  `(:ul
    ((:class "metals-recycling-process"))
    (:li "If an Aluminum Can or Foil, remove excess moisture and waste")
    (:li "Seperate the metal from other materials")
    (:li "Bottle Caps can be recycled if they are metal")
    (:li "Check Earth911's recycling directory to find a scrap metal
    recycler in your area")
    )
  )

(defun paper-recycling-process ()
  `(:ul
    ((:class "paper-recycling-process"))
    (:li "Remove excess tape from paper and cardboard")
    (:li "Remove staplers from paper")
    (:li "Place paper in a recycling container without any contaminants")
    (:li "You may choose to also shred your paper")
    )
  )

(defun glass-recycling-process ()
  `(:ul
    ((:class "glass-recycling-process"))
    (:li "Remove plastic and metal lids and place them in a separate recycling bin.")
    (:li "Rinse out glasses with water")
    (:li "Place glasses into a recycling container dedicated for glass")
    )
  )

(defun electronics-recycling-process ()
  `(:ul
    ((:class "electronics-recycling-process"))
    (:li "e-waste is recyclable at retailors such as best buy")
    (:li "Search your state for e-waste recyclers")
    (:li "Can always donate unwanted electronics")
    )
  )

(defun bulbs-recycling-process ()
  `(:ul
    ((:class "bulbs-recycling-process"))
    (:li "Incandescent and halogen light bulbs can be thrown in the trash")
    (:li "store flourescent lights in a cardboard box and transport
    them to a Home Depot or Ikea to be properly recycled")
    )
  )

(defun batteries-recycling-process ()
  `(:ul
    ((:class "batteries-recycling-process"))
    (:li "Recycled at local electronics retailer, recycling center, or
    community center")
    (:li "Check Earth911 to find drop-off locations in your area")
    )
  )

(defun classes-recycling-process (class)
  (cond
    ((equal class "metals")
     (metals-recycling-process))
    ((equal class "paper_cardboard")
     (paper-recycling-process))
    ((equal class "glass")
     (glass-recycling-process))
    ((equal class "plastics")
     (plastic-recycling-process))
    ((equal class "bulbs")
     (bulbs-recycling-process))
    ((equal class "electronics")
     (electronics-recycling-process))
    ((equal class "batteries")
     (batteries-recycling-process))
    ('t
     nil)
    )
  )
