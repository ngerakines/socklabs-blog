---
id: 891
layout: post
title: >
    SBC Issues
---

Yesterday I found that the phones had been connected but after talking to Carolyn throughout the day she told me that the internet connection hadn't been flipped on yet. Go figure.

I took the 6:15 train home, which was one of the nice ones btw, and made it around 7:00. We went out for dinner and when we got back I was determined to give it another shot. This is where I ran into the first problem.

The software that SBC issues with its DSL service is broken. There are bugs and  memory leaks (confirmed) throughout the installation process. The first one I ran into was while it tried to activate my network connection via dhcp. After some digging I found that it creates a new 'network location' and actually went so far as to disable the hardware drivers for my wireless card!

The next issue that I found was with its built in web browser for sbc registration. Several of the 'Next' and 'Back' buttons were either missing or didn't do anything. After looking at the source I saw that it is extremely javascript heavy and it has some really weird dhtml mess thrown in for good measure. This is where it stopped for me because of the missing button issue.

Somehow during the process my member name ( yadda@sbcglobal.net ) did kick in and I managed to connect to the dsl modem/router to actually put the username/password that I <em>thought</em> I registered. It got us online at least, although I'm still not sure how.

Once we got online I hopped over to the sbc.yahoo.com login page and tried logging in with the same username/password that I used for my modem/router and it told me the member ID didn't exist! The caveat there was odd; If i logged in with the same username but a different password it told me that the login username didn't match the password.

By now I was started to become very entertained with the broken system that is known as SBC DSL. I went to the help and support area and some how got into a chat session with a support staff member named 'Karl Smith'. While I will say flat out that he didn't help me the least and that he either talked down to me because he thought I was dumb or it was the other way around, he was at least patient and didn't walk off mid-way.

Eventually he had no idea what to do and his only meaningful, and somehow comical, suggestion was to go to a computer running windows and do it later.

Great.

By then it was getting late and there were only a few people on my buddy list that [a] had windows/ie [b] would spend the 5 minutes to help me out. Thankfully <a href="http://harmonee13.livejournal.com/">Emily</a> helped out and after maybe 3 minutes my account was activated and working perfectly.

So, in short we now have an internet connection at home, SBC support isn't really helpful, and companies need better QA for Safari support.
