---
title: Locus Plus
date: "2021-05-10T22:12:03.284Z"
description: Open Location standards
---

# Locus PLus

There is a prominent proprietary location finding app that seems to be getting much criticism in tech circles at the moment. I'm not going to rehash these, some of the concerns are articulated by much smarter people than me: 

 * [Why What3Words is not suitable for safety critical applications](https://cybergibbons.com/security-2/why-what3words-is-not-suitable-for-safety-critical-applications/)

 * [Why bother with What Three Words?](https://shkspr.mobi/blog/2019/03/why-bother-with-what-three-words/)

 * [Do not add what3words identifiers into OpenStreetMap](https://wiki.openstreetmap.org/wiki/What3words)

In the UK emergency services call centres are using this application, seemingly without any critical analysis in situations where lives can be lost if the wrong information is passed. My belief is that public services can and should do better than this when adopting safety critical standards, and a necessary condition is that standards should be transparent and open so that they can be analysed and constructively criticised, preferably with multiple competing implementations for validation and commercial independence.

May Day public holiday has just been and gone in the UK, the weather was bad, and it seemed like a great (and well named) excuse to set myself a challenge of learning about location APIs and encodings and generally spending the holiday trying to figure out if it is possible to build a comparable system using open standards just for fun. I had a budget of 1-2 person days (mine), whereas the development budget for the proprietary system has been many tens of millions of pounds so far. This isn't as polished, and I'm certainly not saying it is a suitable alternative in it's current form that anyone should be using. It is however a completely transparent and open system that can be inspected, criticised, copied and improved.

# The Problem

The problem that the proprietary app is apparently trying to solve is the ability to pass location coordinates concisely and accurately in an audio conversation.

 A much better solution exists to do this automatically on emergency services calls where the caller is using a smartphone which supports [Advanced Mobile Location](https://eena.org/our-work/eena-special-focus/advanced-mobile-location) information sent to the call centre using SMS. In the UK, this is 75% of calls from mobiles to the emergency services. In the majority of cases where AML is available _and it is possible to transmit this information through to the handling call centre_, it is of course preferable as there is no potential for errors to be introduced pronouncing or transcribing the location. 

 This still leaves a gap for the 25% of calls where AML isn't provided or for rescuse services that can' receive the information it provides. This is the problem space that voice based location applications operate in.

 The key ability is to be able to provide concise, easily pronounced location phrases that eliminate as far as possible the potential for error. These need to be made available in an emergency situation even when the phone has no data connectivity.


# Open standards
There are a few different major standards for representing location coordinates:
 * [Decimal Lat/Lon](https://en.wikipedia.org/wiki/Decimal_degrees): __51.52586764360864__, __-0.08370310190511986__
 * [OS Grid Reference](https://en.wikipedia.org/wiki/Ordnance_Survey_National_Grid): __TQ33038249__ (UK only)
 * [Open Location (Plus) Codes](https://en.wikipedia.org/wiki/Open_Location_Code): __9C3XGWG8+7GV__

 None of these are very optimal for spoken transmission, they are all long strings of letters and digits which have significant probability of a single letter or digit error corrupting the conversation. This can be fixed or improved using the phonetic alphabet and judicious use of readback, but few non-geeky users will be familiar enough with a common phonetic alphabet to use it reliably in a high stress environment.

 ## Abreviating Plus Codes

 One of the fun attributes of Plus Codes is that the main Open Source library, provided by Google, and their implementation in Google Maps support the concept of a relative codes where the alphanumeric part is coupled with a placename which is used in place of the most significant digits, so that:

 __9C3XGWG8+7G__, becomes the much more mangeable __GWG8+7G, London, England__. In fact the number of digits stripped is variable and depends how close the location being exressed is to the reference point, so the above can be further shortened to: __G8+7G, Hoxton, England__. This is now starting to look fairly concise  .

 ## Spelling them out phonetically

 Of course a web page or application that is aware of the users location can give that to a user spelt out phonetically and ready to be read to the operator: __Golf Eight Plus Seven Golf Victor, Hoxton, England__.

 In many ways, it is a feature that a local placename is part of the text read out as it should alert both the user and the operator situationally, and give an opportunity to query any gross location discrepencies. It could however be problematic where the user has no good idea where they are and has issues pronouncing this placename. An option to change the placename reference to a different one needs to be part of the application. A user can toggle through alternative ways to express their location until they find one that is easy to express:
 `Hotel Juliet Plus Four Five Mike, Nunthorpe, England`
 `Golf Romeo Hotel Juliet Plus Four Five Mike, Ormesby, England`
 `Golf Romeo Hotel Juliet Plus Four Five Mike, Middlesbrough, England`
 All correspond to the same place.

 ## Readback

 The final component is readback _using a different coordinate system_. Sending the coordinate as a phonetically spelled out Plus Code, and then confirming the corresponding OS Grid Reference back as part of the conversation is a powerful way of detecting errors.
 
# Implementation

The full implementation of all of the above is available in a [Github Repo](https://github.com/rjp44/locus-plus) and runs on a public URL at  https://locus.plus.

This serves up a React app which installs on a mobile device as a PWA for offline use:
![mobile screenshot](https://github.com/rjp44/locus-plus/raw/main/images/locus-plus.png)

And also has an embedded operator console, more suited to desktop environments, accessed from the menu:
![Console](https://github.com/rjp44/locus-plus/raw/main/images/maps-detail.png)

# Futures
Locus Plus was a personal project done over a couple of days for education and fun. I felt it was more positive to demonstrate how easy it is to do the right, open, thing (even if only to myself) rather than criticising other applications. The domain name cost a few pounds and all of the work is done client side so the hosting will probably always be free-tier.

I will keep the hosted version alive until the domain name expires in just under 12-months time, maybe renew it for one more year after that. If anyone is interested in it as a project or derivative, then please do get in contact. The code is released under a BSD Licence. Enjoy.



...
