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
Real Estate is location location location, Real Computing is design design design!'
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
- Are exemplifier and explainer actual tools or concepts.
- Why doesn''t Pharo adopt GToolit; maybe refocus core effort on minimal tools?
!!Tasks
- GT Launcher
  - gt-extras etc go with images, not VM - otherwise doc links broken
- Classes should show custom views in Coder e.g. Wiki pages
  '
]
