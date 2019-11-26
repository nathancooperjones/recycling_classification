(in-package :r-html)

(defun plastic-recycling-facts ()
  `(:ul
    ((:class "plastic-recycling-facts"))
    (:li "Americans throw away 35 billion plastic bottles every year")
    (:li "Only about 25% of the plastic produced in the U.S. is recycled")
    (:li "Plastic takes up to 1,000 years to degrade in a landfill")
    (:li "Enough plastic is thrown away each year to circle the Earth
    four times")
    (:li "Recycling plastic takes 88% less energy than making plastic
    from raw materials")) )

(defun metals-recycling-facts ()
  `(:ul
    ((:class "metals-recycling-facts"))
    (:li "According to the American Iron and Steel Institute (AISI),
    steel is the most recycled material on the planet.")
    (:li "Nearly 40 percent of worldwide steel production is made
    using recycled steel")
    (:li "About 100 million steel and tin cans are used every day in
    the US")
    (:li "400 million tons of metals are recycled worldwide")
    (:li "630 steel cans are recycled every second in the U.S")
    )
  )

(defun paper-recycling-facts ()
  `(:ul
    ((:class "paper-recycling-facts"))
    (:li "If all our newspaper was recycled, we could save about
    250,000,000 trees each year")
    (:li "If every American recycled just one-tenth of their
    newspapers, we would save about 25,000,000 trees a year")
    (:li "Americans use 85,000,000 tons of paper a year; about 680
    pounds per person")
    (:li "Recycling cardboard only takes 75% of the energy need to
    make new cardboard") ) )

(defun glass-recycling-facts ()
  `(:ul
    ((:class "glass-recycling-facts"))
    (:li "Glass can be recycled and re-manufactured an infinite amount
    of times and never wear out")
    (:li "Recycling just one glass jar saves enough electricity to
    light an 11 watt CFL bulb for 20 hours")
    (:li "More than 28 billion glass bottles and jars end up in
    landfills every year- that is equivalent to filling up two Empire
    State Buildings every three weeks")
    (:li "Glass takes 1,000,000 years to fully degrade in a landfill")) )

(defun electronics-recycling-facts ()
  `(:ul
    ((:class "electronics-recycling-facts"))
    (:li "E-waste comprises 70% of our overall toxic waste")
    (:li "80 to 85% of electronic products were discarded in landfills
    or incinerators, which can release certain toxics into the air")
    (:li "20 to 50 million metric tons of e-waste are disposed
    worldwide every year")
    (:li "Only 12.5% of e-waste is currently recycled")
    (:li "The amount of global e-waste is expected to grow by 8% per year")) )


(defun bulbs-recycling-facts ()
  `(:ul
    ((:class "bulbs-recycling-facts"))
    (:li "Mercury in certain bulbs can seep into the soil of landfills")
    (:li "Materials from bulbs can be reused for new products")
    (:li "Some bulb manufacturers and other organizations sell
    pre-labeled recycling kits that allow you to mail used bulbs to
    recycling centers")
    (:li "Some areas may prohibit disposal and/or require recycling")) )

(defun batteries-recycling-facts ()
  `(:ul
    ((:class "batteries-recycling-facts"))
    (:li "Recycling will help conservation of natural resources, such as
    metals and minerals")
    (:li "Recycling Batteries reduce greenhouse gas emissions that
    contribute to global climate change")
    (:li "Batteries can leak heavy harmful metals which contaminate
    our local soils, groundwater, and streams")
    (:li "28% of consumers throw their batteries in the trash")
    (:li "Recycled battery materials can be reused for new products")) )

(defun general-recycling-facts ()
  `(:ul
    ((:class "general-recycling-facts"))
    (:li "Recycling conserves finite natural resources - this is
    critical as ​population continues to grow exponentially")
    (:li "Recycling prevents waste from going into oceans")
    (:li "Recycling protects forests which help to reduce CO2 emissions")
    (:li "The U.S. recycling levels have not improved in 20 years")
    (:li "U.S. generates more waste than any other country in the world")) )

(defun classes-recycling-facts (class probability)
  (cond
    ((< probability 40)
     (general-recycling-facts))
    ((equal class "metals")
     (metals-recycling-facts))
    ((equal class "paper-cardboard")
     (paper-recycling-facts))
    ((equal class "glass")
     (glass-recycling-facts))
    ((equal class "plastics")
     (plastic-recycling-facts))
    ((equal class "bulbs")
     (bulbs-recycling-facts))
    ((equal class "electronics")
     (electronics-recycling-facts))
    ((equal class "batteries")
     (batteries-recycling-facts))
    ('t
     (general-recycling-facts))))
