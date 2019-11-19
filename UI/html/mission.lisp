(in-package :r-html)

(defun mission-statement-html ()
  (my-html
   `(:div
     ((:class "mission-page-contents"))
     (:h1 "Mission Statement")
     (:div
      ((:class "Goal"))
      (:h2 "How it came to be")
      (:p "Unlike the other groups in IPRO, our group was formed
      essentially during the first class of the semester as most of us
      worked together last spring in IPRO and we knew we wanted to
      work together again. Even though we quickly had our team in
      place, we still didn't know what we were going to do. In one of
      the first classes for IPRO, we were tasked with coming up with
      innovation that will help with public safety. Most of the ideas
      we can up with for this didn't have strong support or interest
      from everyone in our group. That is except for about the
      recycling situation in Chicago to which we all had mutually
      strong interests in wanting to work on the recycling problem.")
     (:p "With our area of interest set to recycling, it was time to
     create something that could actually make a positive impact on
     recycling. To do so we needed research to get a better
     understanding about why there is a problem with recycling and so
     we could try to make a solution that may not solve the main
     problem itself, but be able to make a small impact, as something
     is better than nothing. Eventually a breakthrough came from
     Nathan in which he talked about a tool that would take an input
     of a picture of an item and then output whether or not that item
     in the picture is recyclable. It was clear to us that this tool
     would help with recycling, it was just up to us to make it
     happen.") )
     (:div
      ((:class "Method"))
      (:h2 "Process of creating our Tool")
      (:p "We know we wanted our tool to take a picture and tell us if
      the item in the picture is recyclable or not. We broke this down
      process down to three essential parts: first being able to take
      an input photo and send it over a server, second is analyzing
      the photo and determining if it is reyclable or not, and
      grabbing the results from the server and displaying it.")
      (:p "The first and third part come from the same area, the
      UI. Ultimately we would like for our tool to be on phones as it
      would be the most practical way of using it in real life as
      simply take a photo and run the tool on it. But for right now we
      are putting the tool on a website because we want to get the
      program down and functioning as intended before thinking about
      scaling the tool. The UI has three pages: upload photo,
      recycling information, and mission statement. The upload photo
      page is where our program comes to play in which it takes an
      input of a photo, analyzes it using AI, and showing the results
      of whether or not the item is recyclable or not. As of right now
      the upload photo page is still a work in progress in connecting
      the photo uploaded to the AI software, but it will soon be
      working! The recycling information contains important
      information and research about recycling and recycling in
      chicago that we gathered. Lastly is this page, the mission
      statement where we describe our process in creating this tool
      and our goal for it.")
      (:div
       ((:class "UI-pages"))
       (:figure
        (:img ((:src "resources/pages/mission/recycling-info.png")))
        (:figcaption "Recycling information page"))
       (:figure
        (:img ((:src "resources/pages/mission/upload-photo.png")))
        (:figcaption "Upload photo page")
        ))
      (:p "The second part, also the most important part of the three,
      is going to need to be able to analyze the photo. This means
      that we needed to train AI to be able to determine if an item is
      recyclable or not. To do this we first needed to collect photos
      to train the AI and we did by collecting hundreds of photos in
      each of the following six categories: metals, paper and
      cardboard, glass, plastics, batteries, bulbs, and
      electronics. Once the photos were assembled.")
      (:p "With our photos assembled, now it is time to train our AI
      which is being led by Nathan. The AI works through layers in
      which the first and last year are fixed to input and output
      respectivelly. In between the two consists of hidden layers
      which does the analyzing.")
      (:div
       ((:class "AI-photos-works"))
       (:figure
        (:img ((:src "resources/pages/mission/AI2.png")))
        (:figcaption "Model of how AI analyzes input."))
       (:figure
        (:img ((:src "resources/pages/mission/AI1.png")))
        (:figcaption "Example of how AI analyzes an input.")
        )
       )
      (:p "In order for AI to analyze a photo, we first have to train
      it so it can recognize what is in the image. Using the photos we
      have gathered, we feed the AI the images and what reyclable item
      category is in the image. Through each photo, the AI learns a
      little bit about the shape and characteristics of the reyclable
      item category and after learning from several hundred photos of
      each category, the AI develops a good understanding on how to
      tell if a given item belongs to one of the recycable categories
      and if it does, will return the recycling category of the item.")
      (:div
       ((:class "AI-analyzing"))
       (:figure
        (:img ((:src "resources/pages/mission/AITraining.png")))
        (:figcaption "Model of how AI is trained from pictures."))
       (:figure
        (:img ((:src "resources/pages/mission/AIAnalyzing.png")))
        (:figcaption "Example of how AI analyzes a photo of a battery.")
        )
       )
      )
     (:div
      ((:class "Helpful"))
      (:h2 "How our tool will help Recycling")
      (:p "We understand that not everyone is going to use our tool,
      or even make an effort to recycle, and we aren't going to be
      able to change everybodies mind and effort in recycling. That's
      okay because we believe that even in its simplest form, this
      site, that it will help influence some people to make a more
      active effort to recycle. That is in its most basic form, once
      scaled to run on phones and other devices, it has a chance to
      make a noticeable impact on recycling. For instance it can be
      used at recycling companies such as Lakeshore's recycling
      company to sort the recycling which is currently done by
      hand. Even more potent is having on phones were people simply
      take a photo and get told if it is reyclable or not making it an
      accessibly and simple to use tool that individuals that show
      minimal interest in recycling may use.") ) )) )
