"
Welcome to the Pharo wiki!
"
Class {
	#name : #PharoWiki,
	#superclass : #Object,
	#traits : 'TAPWiki',
	#classTraits : 'TAPWiki classTrait',
	#category : #PharoWiki
}

{ #category : #wikiPages }
PharoWiki class >> wikiPageDeprecating [
	"This method was automatically generated."
	<wikiPage: #Deprecating>
	^APWikiPage
		wiki: self
		name: #Deprecating
		text: 
'!Deprecating
When writing non-backward-compatible code, allow your users to upgrade seamlessly with just a bit of extra care. Leave deprecated methods around for a release, annotated with one of these auto-transforming deprecation message variants:
- ${method:Object>>#deprecated:on:in:transformWith:}$
- ${method:Object>>#deprecated:on:in:transformWith:when:}$
- ${method:Object>>#deprecated:transformWith:}$
- ${method:Object>>#deprecated:transformWith:when:}$

The first time your deprecated method is run, it will be automatically rewritten in your new API. The transformation is specified with ${wikiPage:#RewriteRules}$. For relevant examples, browse the senders of the above messages.'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageDesignPatternsSmalltalkCompanion [
	"This method was automatically generated."
	<wikiPage: #DesignPatternsSmalltalkCompanion>
	^APWikiPage
		wiki: self
		name: #DesignPatternsSmalltalkCompanion
		text: 
'!DesignPatternsSmalltalkCompanion'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageDynabook [
	"This method was automatically generated."
	<wikiPage: #Dynabook>
	^APWikiPage
		wiki: self
		name: #Dynabook
		text: 
'!Dynabook
Although I have to admit that at heart I am not a programmer, but a Dynabook fanatic and it''s been emotionally difficult to see neverending hacking that never seems to lead to a system that touches the dream. Zen and the Art of Motorcycle Maintenance talks about an ideal where static (conservative, traditional, keep things as they are) and dynamic (progress, experimentation, evolution) form a feedback loop where the good parts of the last tevolution become fixed as a static foundation for the next dynamic leap. Unfortunately, in practice we seem to only have the extremes available: the static last century ideas behind Windows and Mac and a steady stream of papers, theories and experiments from the real visionaries (cough, not Steve Jobs, the real ones). I realize that the model of the latter is cathedral building and shortening the hundreds of years from printing press to saddle-sized books, but I can''t help but think that leaving a trail of usable artifacts would bring so many more people on board, playing and creating with something real. When I discovered Squeak, I got right to work with my new Dynabook, but the Morphic clean up that never happened quickly crushed my dreams of any Blue Plane ideas and I went back to hibernation waiting for a cleanup, and then Morphic 3 which was never integrated and then Frankenstein which was never publicly available for use and now Bloc which seems frought with political controversy... - 4/24/2020 on ${wikiPage:SqueakReunion}$.'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageExternalProcesses [
	"This method was automatically generated."
	<wikiPage: #ExternalProcesses>
	^APWikiPage
		wiki: self
		name: #ExternalProcesses
		text: 
'!External Processes
Pharo has ${class:LibC|label=basic capabilities}$ to run unixy commands from within the image. There are also several libraries for this:
- ${wikiPage:OSSubprocess}$
- ${wikiPage:OSProcess}$
- ${wikiPage:PharoShell}$
'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageFullBlockClosure [
	"This method was automatically generated."
	<wikiPage: #FullBlockClosure>
	^APWikiPage
		wiki: self
		name: #FullBlockClosure
		text: 
'!FullBlockClosure
- extensive conversation re outerContext (*on VM ML>http://forum.world.st/Materializing-BlockClosure-s-outerContext-tt5092610.html#a5092654*)
'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageGT_OO_IDE [
	"This method was automatically generated."
	<wikiPage: #GT_OO_IDE>
	^APWikiPage
		wiki: self
		name: #GT_OO_IDE
		text: 
'!Gtoolkit: Restoring Dignity to Our Poor Objects
- Alan Kay real OOP "encapsulated modules all the way down with pure messaging"
- "The thing that attracted me about whole computers was that they can do whatever a computer can do.
Making the interior of a computer to be virtual computers preserves this. “The parts have the same powers as the wholes”. In the most recent children’s system we did over the last decade we made one kind of “universal object” which could be used to make everything else. (This is an interesting design exercise!) And it is interesting to compare the “large comprehensive” object idea with having class object be tiny and trying to build up a universe through zillions of subclasses. The large comprehensive object idea is a little more biological (where every cell in our body contains the entire DNA and the several hundred cell specializations are done entirely by a kind of parameterization)."

Taken together, they are a big clue to the problem GT solves. Take Pharo''s poor Class object... As central and powerful as it is, if you serialized it and sent it to someone, they would not need to master an array of tools to do basic things - like explore its methods (with a class browser), read rich documentation about it (until recently they would have needed to refer to outside sources like eBooks and websites), and find references to it in their image (with a query browser). But Alan is imploring us: "each computational unit should retain all the power of the unit that contains it!" Class should know how to browse its methods, show its documentation, and find its references. Let''s ignore the ''''implementation'''' for a moment, which would surely lead to debate about impossible to understand "monolithic" classes. Instead, let''s focus on the ''''presentation'''' to the user. Even if we still have helper objects that browse and show documentation, from the user perspective these should be integral to the  object. Whenever you see Class, you should have ''''immediate'''' access to these. By immediate, I mean at-hand, which should aim to be as universal and with at little context switching as possible. In essence, our IDE should be shaken to its foundations by the same revolution that created our objects.'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageGT_VM [
	"This method was automatically generated."
	<wikiPage: #GT_VM>
	^APWikiPage
		wiki: self
		name: #GT_VM
		text: 
'!GT VM
Initially forked as a way to immediately achieve certain short-term goals which were needed to move forward^^1^^

!1. *http://forum.world.st/why-GT-forked-the-VM-and-how-to-kill-our-fork-tt5115627.html*
Currently, at feenk we have feenkcom/opensmalltalk-vm: 
https://github.com/feenkcom/opensmalltalk-vm

This is a small fork of the headless branch from pharo-project/opensmalltalk-vm that appeared out of practical necessities, but that we would like to avoid having. This post briefly describes the changes in the feenkcom/opensmalltalk-vm repo and the functionality those changes provide for Glamorous Toolkit. 

For Glamorous Toolkit we aimed for the following functionality: 
        • Open the GUI natively and have native display quality (GUI opened through FFI calls) 
        • Have a Glamorous Toolkit app for Mac OS that works as any other apps for Mac OS 
        • Create end-user applications that are fully customisable (executable name, menus, etc) 
        • Use Github actions for doing all compilations of external libraries and the vm instead of Travis CI. 
        • Have Iceberg running in native windows (which requires nested FFI callbacks) 

There has been work on these issues in both OpenSmalltalk/opensmalltalk-vm and pharo-project/opensmalltalk-vm but they were not entirely addressed. We needed to have something reliable a few months ago, and forking and doing some quick changes made that possible. 

Ideally we want to be able to run Glamorous Toolkit on both OpenSmalltalk/opensmalltalk-vm and pharo-project/opensmalltalk-vm. 

To have native GUIs we relied on Ronie Salgado’s work on the headless vm and started with pharo-project/opensmalltalk-vm - headless branch: 
https://github.com/pharo-project/opensmalltalk-vm/tree/headless
That provided a solution for opening the GUI from the image through FFI calls. Currently we use Glutin (a library for OpenGL context creation, written in pure Rust) and this made it possible to run the entire Glamorous Toolkit inside a callback. 

On macOS when running an app, even a notarized one, the OS warns the user that the app is downloaded from the internet, and the user needs to confirm that they agree. Once the user agrees the app should automatically start. This is not currently possible with Pharo apps (for example PharoLaunched.app) and users have to again run the app manually after giving permission. Also Gatekeeper in macOS runs applications downloaded from zips in a randomized read-only DMG. We do not want this behaviour as users not copying Glamorous Toolkit to the Applications folder on macOS would then experience incorrect application behaviour. 

To create end-user applications we also need to fully customize the executable name (what the user sees in the Task Runner/Activity monitor), icons, native menus. Part of this work is already integrated in the pharo-project/opensmalltalk-vm - headless branch (Customizing the OS X icons, Brand the VM executable and package). 

Since last year Github offers Github Actions similar to Travis. We found it much easier to use than Travis for external libraries and the vm. Also we get to manage the code and the builds in the same place. This work is already integrated in the pharo-project/opensmalltalk-vm - headless branch (Build the VM under GitHub actions: https://github.com/pharo-project/opensmalltalk-vm/pull/56). 

The issues related to running Iceberg is a bit more technical. By moving to the headless vm we are running the entire image computation inside a callback from Glutin (https://github.com/rust-windowing/glutin/). When using Iceberg we get nested callbacks which we could not get to work using Alien. Instead we are using the ThreadedFFI Plugin and running all callback from Iceberg and Glutin using the Threaded FFI plugin (https://github.com/pharo-project/threadedFFI-Plugin). Currently we have a small fork of this plugin (feenkcom/threadedFFI-Plugin) and we also ship a custom plugin with the VM to fix a race condition due to having two copies of the callback stack (a pull request is here: https://github.com/pharo-project/threadedFFI-Plugin/pull/17). 

While not specific to our environment, openssl1.0 is no longer supported, and we are seeing users who are unable to run Pharo due to version conflicts, as reported in https://github.com/pharo-project/opensmalltalk-vm/issues/62. 


To sum up, a fork was the easiest way to get all this running. Now some changes are already in the pharo-project/opensmalltalk-vm - headless branch. What we are still missing are the changes that get the VM to work nicely with Mac OS and a bug fix in ThreadedFFI. 

We would also love it to have all these changes integrated in OpenSmalltalk/opensmalltalk-vm in the headless vm. This requires additional coordination as the required changes are somewhat deeper. 


Please let us know you would prefer to coordinate. 


Cheers, 
Tudor, on behalf of the feenk team '
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageMemoryHogs [
	"This method was automatically generated."
	<wikiPage: #MemoryHogs>
	^APWikiPage
		wiki: self
		name: #MemoryHogs
		text: 
'!Memory Hogs
!!Reclaiming Memory
Once you eliminate common possible causes (see "Common Causes" below), try:
[[[language=smalltalk
10 timesRepeat: [ Smalltalk garbageCollect ].
]]]
And [World menu]>System>[Do image clean up]
!!Common Causes
!!!Your code
Do any of your (class/pool variable) singleton instances store data? Add a #clearAll or #reset (mySingletonVar := nil) to the class side -- or whatever fits your app -- and do that before that #garbageCollect block. [In fact, put that in some XXXAdmin class]
!!!Windows in Morphic
Close all windows
!!!Monticello
Try to open monticello and select any repo, right click and clear the package cache.
!!!Tiling Window Manager
It is a great tool, but yes it gobbles memory. Every once in a while, disable it, GC [as described above](#Reclaiming-memory), and re-enable.
!!!Miscellaneous
NB: These may take some time to run, especially in a larger image
!!!!Built-in Report
For a fairly long report on the image and memory hogs, evaluate `SmalltalkImage current reportCPUandRAM`. It writes files in the image folder containing all the information. Takes a while to run.
!!!!Roll your own
    ((Object allSubclasses collect: [ :aClass |
        aClass -> aClass allInstances size])
        sort: [ :a :b | a value > b value ]) inspect'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageOOP [
	"This method was automatically generated."
	<wikiPage: #OOP>
	^APWikiPage
		wiki: self
		name: #OOP
		text: 
'!Object-Oriented Programming
- "encapsulated modules all the way down with pure messaging" ${footnote:note=Blog comment by Alan Kay 2010-09-15 at 10:12am}$
!References
!!*Blog comment>https://computinged.wordpress.com/2010/09/11/moti-asks-objects-never-well-hardly-ever/* by Alan Kay 2010-09-15 at 10:12am:
I think this article raises important issues.
A good example of a large system I consider “object-oriented” is the Internet. It has billions of completely encapsulated objects (the computers themselves) and uses a pure messaging system of “requests not commands”, etc.
By contrast, I have never considered that most systems which call themselves “object-oriented” are even close to my meaning when I originally coined the term.
So part of the problem here is a kind of “colonization” of an idea — which got popular because it worked so well in the ARPA/PARC community — by many people who didn’t take the trouble to understand why it worked so well.
And, in a design-oriented field such as ours, fads are all to easy to hatch. It takes considerable will to resist fads and stay focused on the real issues.
Combine this with the desire to also include old forms (like data structures, types, and procedural programming) and you’ve got an enormous confusing mess of conflicting design paradigms.
And, the 70s ideas that worked so well are not strong enough to deal with many of the problems of today. However, the core of what I now have to call “real oop” — namely encapsulated modules all the way down with pure messaging — still hangs in there strongly because it is nothing more than an abstract view of complex systems.
The key to safety lies in the encapsulation. The key to scalability lies in how messaging is actually done (e.g. maybe it is better to only receive messages via “postings of needs”). The key to abstraction and compactness lies in a felicitous combination of design and mathematics.
The key to resolving many of these issues lies in carrying out education in computing in a vastly different way than is done today.
——————————————————————-
A few more comments here.
If you are “setting” values from the outside of an object, you are doing “simulated data structure programming” rather than object oriented programming. One of my original motivations for trying to invent OOP was to eliminate imperative assignment (at least as a global unprotected action). “Real OOP” is much more about “requests”, and the more the requests invoke goals the object knows how to accomplish, the better. “Abstract Data Types” is not OOP!
A larger problem here is that though the invention of OOP and the coining of the term were influenced by several prior systems (including Sketchpad and Simula, and others which can be found in the history I wrote for the ACM — a nice irony it turns out!), it is quite clear that the idea of OOP did not include most of its precursors.
We didn’t even do all of the idea at PARC. Many of Carl Hewitt’s Actors ideas which got sparked by the original Smalltalk were more in the spirit of OOP than the subsequent Smalltalks. Significant parts of Erlang are more like a real OOP language the the current Smalltalk, and certainly the C based languages that have been painted with “OOP paint”.
The largest problem here is that a misapplication of a paradigm is being blamed for what is really bad language and systems designs and implementations. And I agree completely with the author that most of the features cited are really bad. But they have nothing to do with OOP.
For example, Smalltalk initially did not have inheritance because I thought the way it was used in Simula was all to easily the foundation of nightmares (too many different semantics from one mechanism). Instead the original Smalltalk used many LISP ideas to allow dynamic experiments with many kinds of generalizations.
I think the remedy is to consign the current wide-spread meanings of “object-oriented” to the rubbish heap of still taught bad ideas, and to make up a new term for what I and my colleagues did.
A smaller consideration is to notice that what is good about the original idea is still quite good, but it does require more thinking (and different thinking) and design to accomplish (but with great benefits in expressiveness, scalability and safety).
Blaming a good idea for being difficult is like blaming the Golden Rule for not being easily able to be learned by most humans. I think the main points of both lie elsewhere.
!!*Blog comment>https://computinged.wordpress.com/2010/09/11/moti-asks-objects-never-well-hardly-ever/* by Alan Kay 2010-09-15 at 11:38am:
I’ll try to write something more extensive after all the other writing I have to do between now and the end of October.
But one of my favorite aphorisms at PARC was “Simple things should be simple and complex things should be possible”.
If simple things aren’t simple, then bad design has been done by some tool maker.
If complex things aren’t possible, then the bad tool makers have not allowed you to learn and scale.
One question we need to ask is “How can we do something with about the mental effort it deserves and somehow then gracefully scale it and share it and protect it and maintain it?”
And we can ask “How can we find out what something means and also create something that has meaning” in a straightforward way without impoverishing the result for someone else’s use?”
45 years ago I used to ask: “If you send computer stuff 1000 miles, what do you have to send with it to make it useful?” A manual? A programmer? Some form of code? What does it “mean to mean”?
The thing that attracted me about whole computers was that they can do whatever a computer can do.
Making the interior of a computer to be virtual computers preserves this. “The parts have the same powers as the wholes”. Whereas data structures have lost this and their manifest pragmatics get in the way of many needed things.
So the design problem to be considered (or the way I looked at it back then) was a “have the cake and eat it too” one. For example, we wanted the number 3 to be no larger than the data version on a PDP-11 (in fact we made it smaller), but also to somehow carry its most important meanings (for both internal and external use) around with it.
In the most recent children’s system we did over the last decade we made one kind of “universal object” which could be used to make everything else. (This is an interesting design exercise!) And it is interesting to compare the “large comprehensive” object idea with having class object be tiny and trying to build up a universe through zillions of subclasses. The large comprehensive object idea is a little more biological (where every cell in our body contains the entire DNA and the several hundred cell specializations are done entirely by a kind of parameterization).
Again, a little more design has to be applied to make this work, but then it works for you over and over.
I’m very fond of “simulation style” programming that uses ideas of McCarthy, Strachey and the later Lucid language to have transitions to future states of objects be done as functional relations, but to “model time explicitly” (rather than allowing the CPU to do it) so that (as in John’s “situation calculus”) there are no race conditions, yet actions can happen and time can progress.
The original Smalltalk was extensible in all areas, including syntactic (because you could make up an input grammar to receive messages), and this allowed programmers to both use and to invent styles that are suitable to the problems.
As an old mathematician (where this is done all the time), I’m very much in favor of this design tool as an inherent part of a programming language. Again, you have to learn how to design a bit more, but I believe that many of the biggest problems with computing today come from bad designs by non-expert designers.
Language extensibility is quite compatible with strong association of meanings.
Real Estate is location location location, Real Computing is design design design!
!!*Blog comment>https://computinged.wordpress.com/2010/09/11/moti-asks-objects-never-well-hardly-ever/* by Alan Kay 2010-09-16 at 12:25 pm:

Before the term “OO” got “colonized” it meant “something in the future pointed at by Smalltalk”. After it got vastly changed when claimed by C++, etc., and redefined by Peter Wegner (a nice guy, but not really in a place to do a good job of this), I started referring to the original branch of OO as “dynamic OO”, and later as “real OO”.
But I think there’s too much water over the dam, and it’s time for a completely different term. And since I think we can do a much better job of this 45 years later, the next term should be given to a qualitative improvement along these lines.
“Dynamic” tried to call attention to several important properties, including “late-binding” and “liveness” (an example of the latter is the Internet, which has never been taken down for maintenance). Instead, like a biological system it changes, grows, repairs, etc., as a living organism and the design accommodates this.
(A glaring dumb exception is that you occasionally see an email from one’s organization saying such and such server “will be down for maintenance”, even though there is no need. Servers are cheap and they are just IDs, which means their content can be moved to other HW, renamed etc. and used while the old HW is being fixed and replaced. SysAdmins who don’t do this do not understand the Internet or “dynamic systems”.)
If a programming language and its DE is worth anything (meaning “powerful”) then it would be ridiculous not to have this power used for all aspects of programming including how to fix and improve itself. No change should take more than a fraction of a second to safely take effect. There is no need for text based source code, separate compliations and loading, reinitializing, etc. A decent dynamic language should be able to easily do all these things.
Both Interlisp and especially Smalltalk showed how this could be done to great benefit to the programming and the designs of the software systems that were being attempted.
The analogies to how the much more complex living systems actually scale would be very clear if computer people were willing to actually learn about complexity and scaling.
The way to get safety is not to make the system static, etc., but to implement “fences” which safely confine, but which can be hopped when a designer needs the next level of “meta” to make new underpinnings.
Nowadays when I get asked by large organizations about all this I try to get them to actually understand why the Internet works, and to see how a soft virtual version of the Internet would make a more ideal programming tool and environment.
As to your last sentence, I’ve been pointing out that “OOP” in many languages is an empty term ….
!!*Blog comment>https://computinged.wordpress.com/2010/09/11/moti-asks-objects-never-well-hardly-ever/* by Alan Kay 2011-03-06 at 1:52 pm:
By my original definition of “Object oriented” neither Java nor C++ is OO.
So why not either change your term or work within the actual definition?
“Good OO style” in Java or C++ is an oxymoron
And the “accepted wisdom” is neither wise nor correct.
BTW, there are many under 100 line programs in Scratch and especially Etoys, that would not be as clear, easy or short without objects.
!!*Blog comment>https://computinged.wordpress.com/2010/09/11/moti-asks-objects-never-well-hardly-ever/* by Alan Kay 2011-03-06 at 1:52 pm:
I don’t think I “misunderstand” what “maintenance” means.
However, since anything can be changed in Smalltalk while it is running — and this has been true since 1976 — we have a case example that it can be done, and how to do it. (And today it can be and is done better and more comprehensively than 35 years ago.)
To be able to do this is one of the meanings (or connotations) of “dynamic” and “late-binding”.
(And, by the way, for early-bound systems, the ploy of renaming servers is a way to keep service continuous for software which doesn’t know how to reconfigure.)
!!*Dr. Alan Kay on the Meaning of “Object-Oriented Programming”>http://www.purl.org/stefan_ram/pub/doc_kay_oop_en*:
E-Mail of 2003-07-23
Dr. Alan Kay was so kind as to answer my questions about the term “object-oriented programming”.
Clarification of "object-oriented" [E-Mail]

Date: Wed, 23 Jul 2003 09:33:31 -0800
To: Stefan Ram [removed for privacy]
From: Alan Kay [removed for privacy]
Subject: Re: Clarification of "object-oriented"
[some header lines removed for privacy]
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Content-Length: 4965
Lines: 117

Hi Stefan \--

Sorry for the delay but I was on vacation.

At 6:27 PM +0200 7/17/03, Stefan Ram wrote:
>   Dear Dr. Kay,
>
>   I would like to have some authoritative word on the term
>   "object-oriented programming" for my tutorial page on the
>   subject. The only two sources I consider to be "authoritative"
>   are the International Standards Organization, which defines
>   "object-oriented" in "ISO/IEC 2382-15", and you, because,
>   as they say, you have coined that term.

I''m pretty sure I did.

>
>   Unfortunately, it is difficult to find a web page or source
>   with your definition or description of that term. There are
>   several reports about what you might have said in this regard
>   (like "inheritance, polymorphism and encapsulation"), but
>   these are not first-hand sources. I am also aware that later
>   you put more emphasis on "messaging" - but I still would like
>   to know about "object oriented".
>
>   For the records, my tutorial page, and further distribution
>   and publication could you please explain:
>
>     When and where was the term "object-oriented" used first?

At Utah sometime after Nov 66 when, influenced by Sketchpad, Simula, 
the design for the ARPAnet, the Burroughs B5000, and my background in 
Biology and Mathematics, I thought of an architecture for 
programming. It was probably in 1967 when someone asked me what I was 
doing, and I said: "It''s object-oriented programming".

The original conception of it had the following parts.

  - I thought of objects being like biological cells and/or individual 
computers on a network, only able to communicate with messages (so 
messaging came at the very beginning \-- it took a while to see how to 
do messaging in a programming language efficiently enough to be 
useful).

  - I wanted to get rid of data. The B5000 almost did this via its 
almost unbelievable HW architecture. I realized that the 
cell/whole-computer metaphor would get rid of data, and that "<-" 
would be just another message token (it took me quite a while to 
think this out because I really thought of all these symbols as names 
for functions and procedures.

  - My math background made me realize that each object could have 
several algebras associated with it, and there could be families of 
these, and that these would be very very useful. The term 
"polymorphism" was imposed much later (I think by Peter Wegner) and 
it isn''t quite valid, since it really comes from the nomenclature of 
functions, and I wanted quite a bit more than functions. I made up a 
term "genericity" for dealing with generic behaviors in a 
quasi-algebraic form.

  - I didn''t like the way Simula I or Simula 67 did inheritance 
(though I thought Nygaard and Dahl were just tremendous thinkers and 
designers). So I decided to leave out inheritance as a built-in 
feature until I understood it better.

My original experiments with this architecture were done using a 
model I adapted from van Wijngaarten''s and Wirth''s "Generalization of 
Algol" and Wirth''s Euler. Both of these were rather LISP-like but 
with a more conventional readable syntax. I didn''t understand the 
monster LISP idea of tangible metalanguage then, but got kind of 
close with ideas about extensible languages draw from various 
sources, including Irons'' IMP.

The second phase of this was to finally understand LISP and then 
using this understanding to make much nicer and smaller and more 
powerful and more late bound understructures. Dave Fisher''s thesis 
was done in "McCarthy" style and his ideas about extensible control 
structures were very helpful. Another big influence at this time was 
Carl Hewitt''s PLANNER (which has never gotten the recognition it 
deserves, given how well and how earlier it was able to anticipate 
Prolog).

The original Smalltalk at Xerox PARC came out of the above. The 
subsequent Smalltalk''s are complained about in the end of the History 
chapter: they backslid towards Simula and did not replace the 
extension mechanisms with safer ones that were anywhere near as 
useful.

>
>     What does "object-oriented [programming]" mean to you?
>     (No tutorial-like introduction is needed, just a short
>     explanation [like "programming with inheritance,
>     polymorphism and encapsulation"] in terms of other concepts
>     for a reader familiar with them, if possible. Also, it is
>     not neccessary to explain "object", because I already have
>     sources with your explanation of "object" from
>     "Early History of Smalltalk".)

(I''m not against types, but I don''t know of any type systems that 
aren''t a complete pain, so I still like dynamic typing.)

OOP to me means only messaging, local retention and protection and 
hiding of state-process, and extreme late-binding of all things. It 
can be done in Smalltalk and in LISP. There are possibly other 
systems in which this is possible, but I''m not aware of them.

Cheers,
Alan

E-Mail of 2003-07-26
Clarification of "object-oriented", 1 [E-Mail]

Date: Sat, 26 Jul 2003 13:47:59 -0800

To: Stefan Ram [removed for privacy]
From: Alan Kay [removed for privacy]
Subject: Re: Clarification of "object-oriented"
[some header lines removed for privacy]
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Content-Length: 3145
Lines: 68

One of the things I should have mentioned is that there were two main 
paths that were catalysed by Simula. The early one (just by accident) 
was the bio/net non-data-procedure route that I took. The other one, 
which came a little later as an object of study was abstract data 
types, and this got much more play.

If we look at the whole history, we see that the proto-OOP stuff 
started with ADT, had a little fork towards what I called "objects" 
\-- that led to Smalltalk, etc.,\-- but after the little fork, the CS 
establishment pretty much did ADT and wanted to stick with the 
data-procedure paradigm. Historically, it''s worth looking at the USAF 
Burroughs 220 file system (that I described in the Smalltalk 
history), the early work of Doug Ross at MIT (AED and earlier) in 
which he advocated embedding procedure pointers in data structures, 
Sketchpad (which had full polymorphism \-- where e.g. the same offset 
in its data structure meant "display" and there would be a pointer to 
the appropriate routine for the type of object that structure 
represented, etc., and the Burroughs B5000, whose program reference 
tables were true "big objects" and contained pointers to both "data" 
and "procedures" but could often do the right thing if it was trying 
to go after data and found a procedure pointer. And the very first 
problems I solved with my early Utah stuff was the "disappearing of 
data" using only methods and objects. At the end of the 60s (I think) 
Bob Balzer wrote a pretty nifty paper called "Dataless Programming", 
and shortly thereafter John Reynolds wrote an equally nifty paper 
"Gedanken" (in 1970 I think) in which he showed that using the lamda 
expressions the right way would allow data to be abstracted by 
procedures.

The people who liked objects as non-data were smaller in number, and 
included myself, Carl Hewitt, Dave Reed and a few others -- pretty 
much all of this group were from the ARPA community and were involved 
in one way or another with the design of ARPAnet->Internet in which 
the basic unit of computation was a whole computer. But just to show 
how stubbornly an idea can hang on, all through the seventies and 
eighties, there were many people who tried to get by with "Remote 
Procedure Call" instead of thinking about objects and messages. Sic 
transit gloria mundi.'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageOSSubprocess [
	"This method was automatically generated."
	<wikiPage: #OSSubprocess>
	^APWikiPage
		wiki: self
		name: #OSSubprocess
		text: 
'!OSSubprocess
There is extremely thorough *documentation>https://github.com/pharo-contributions/OSSubprocess#shell-commands* online.'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageParsing [
	"This method was automatically generated."
	<wikiPage: #Parsing>
	^APWikiPage
		wiki: self
		name: #Parsing
		text: 
'!Parsing
- PetitParser
- PetitParser2
- Xtreams
- SmaCC'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageRewriteRules [
	"This method was automatically generated."
	<wikiPage: #RewriteRules>
	^APWikiPage
		wiki: self
		name: #RewriteRules
		text: 
'!Rewrite Rules
!!Documentation 
To get the basics down, *http://www.refactory.com/tools/refactoring-browser/rewrite-tool* is quite helpful.

Here are a few mailing list discussions which stand out:
- *http://forum.world.st/Adding-a-statement-when-rewriting-td4668879.html*
- *http://forum.world.st/RB-API-td3781019.html*
- *http://forum.world.st/Classes-referenced-in-code-string-td4244214.html*
- *http://forum.world.st/Adding-a-statement-programmatically-tp4454447p4459879.html*'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageSound [
	"This method was automatically generated."
	<wikiPage: #Sound>
	^APWikiPage
		wiki: self
		name: #Sound
		text: 
'!Sound
!!Setup
Load PharoSound from the Pharo Project Catalog
!! Beep
!!!The Pharo Way
[[[language=smalltalk
SoundSystem soundEnabled: true.
SoundSystem current beep
]]]
!!!Another Way (Mac-only)
[[[language=smalltalk
LibC system: ''osascript -e "beep"''.
]]]
!!!Ways not to produce a Beep (work in the Shell, but not in Pharo)
[[[language=smalltalk
LibC system: ''/usr/bin/tput bel''.
]]]
[[[language=smalltalk
LibC system: ''printf "\a"''.
]]]'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageStrategyPattern [
	"This method was automatically generated."
	<wikiPage: #StrategyPattern>
	^APWikiPage
		wiki: self
		name: #StrategyPattern
		text: 
'!StrategyPattern
${wikiPage:DesignPatternsSmalltalkCompanion}$ (p. 339) proposed the following "Smalltalk way" as an alternative to the common class-per-strategy implementation:
[[[language=smalltalk
Composition>>repair
	"Without the strategy pattern, but using perform:."
	| selector |
	"Construct the name of the method to invoke:"
	selector := (''formatWith'', formattingStrategy, ''Algorithm'') asSymbol.
	self perform: selector
]]]

It then dismissed the approach as "''''clever but difficult from a program understanding perspective. Even static analysis tools such as code browsers'' "senders" and "messages" fail on this code.''''"

It struck me as perhaps a bit extreme (i.e. too clever indeed) to construct the algorithm selector via string concatenation. Maybe "senders" search capabilities have gotten more sophhisticated since publication, but Pharo seems to support symbol arguments, even for e.g. message renames. Why not the following:
[[[language=smalltalk
Composition>>repair
	"Without the strategy pattern, but using perform:."
	self perform: self formattingStrategy
]]]
Then client code like ==aComposition formattingStrategy: #formatWithSimpleAlgorithm== would show up in senders, message renames, etc.'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageTodo [
	"This method was automatically generated."
	<wikiPage: #Todo>
	^APWikiPage
		wiki: self
		name: #Todo
		text: 
'!TODO
!!Communications
- Something rotten with Pharo''s including outside projects in core image; why not GH fork? Isn''t best of both worlds
- Why doesn''t Pharo adopt GToolit; maybe refocus core effort on minimal tools?
- Famix for Smalltalk? Not needed?
- Publishing. How Feenk blog created? The GT and Pharo post seems to have diverged from what''s in latest GT image
- How would one integrate Examples into CI pipeline?
!!Tasks
- GT Launcher
  - gt-extras etc go with images, not VM - otherwise doc links broken
- Classes should show custom views in Coder e.g. Wiki pages
- Investigate SmaCC
!!Complete
- Exemplifier and explainer are engines'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageVM [
	"This method was automatically generated."
	<wikiPage: #VM>
	^APWikiPage
		wiki: self
		name: #VM
		text: 
'!VM
- *2014 - Busy people from all dialects trying to work together>http://forum.world.st/Re-Pharo-dev-Simulator-in-Pharo-3-tt4743189.html#a4743209*
- *2019-01-07 - Polito and Eliot exchange re Pharo plugin building>http://forum.world.st/Would-anyone-object-if-I-added-optional-building-of-the-processor-plugins-to-the-Pharo-builds-tt5092829.html*
- *2019-02-17 - Spat between Steph and Eliot (incl. ESL issue)>http://forum.world.st/Re-squeak-dev-Pharo-dev-Squeak-and-Tonel-tt5095437.html*
- *2019-02-18 - Tonel - Esteban and Eliot>http://forum.world.st/Re-squeak-dev-Squeak-and-Tonel-tt5095630.html*
  - Eliot suggests there is a bug in Pharo''s timestamp handling
  - Eliot thinks Esteban is refusing the optional timestamp in Tonel (ESL issue?)
  - Steph said students would have to move to Python
  - Eliot couldn''t load Clement''s Scortch Tonel code
- 2019-02-18 - *Tudor tries to get VMMaker running in Pharo >http://forum.world.st/VMMaker-in-Pharo-Was-Squeak-and-Tonel-tt5095462.html#a5096351*
- 2019-05-07 - *Polito tries Slang/VMMaker on Pharo>http://forum.world.st/Some-more-effort-to-make-Slang-and-VMMaker-work-on-Pharo-for-review-tt5098976.html#a5099070*

- 2020-01-24 - *Polito contributes back; timestamps stripped>http://forum.world.st/Fix-for-label-duplications-in-Slang-s-case-expansion-tp5110597.html*
  - Eliot complains about timestamps
  - Polito apologizes, explains process trying to keep them
  - Reschke notices Pharo has dropped timestamps; Eliot confirms
- *2020 - Pharo builds disrupting OSVM CI>http://forum.world.st/Errored-OpenSmalltalk-opensmalltalk-vm-2103-Cog-b09b99f-tt5119367.html#a5119380*
  - Eliot says to nuke bc Pharo "can build its own vo (insists in forking in fact)"
  - Cellier "I asked for pharo community support for this... Just like shouting in the desert... since the ML seems private, who knows..."
  - ""WF"" emailed Cellier 2020-09-02
  - Stes also says Pharo doesn''t respond, has '
]
