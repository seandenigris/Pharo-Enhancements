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
PharoWiki class >> wikiPageAST [
	"This method was automatically generated."
	<wikiPage: 'AST'>
	^APWikiPage
		wiki: self
		name: 'AST'
		text: 
'!Usage Examples
- Format source - ==(RBParser parseMethod: source) formattedCode==
- Generate source relying on ==storeOn:== -  ${method:MAElementDescription>>#addTo:as:}$ in Magritte-Developer
- Modify AST
  - ${class:PeAST_Transformer}$ offers some higher-level support
  - ${method:ConfigurationOf class>>#createBaselineFrom:}$ in DeNigrisPreferences
'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageBindings_to_Other_Languages [
	"This method was automatically generated."
	<wikiPage: #Bindings_to_Other_Languages>
	^APWikiPage
		wiki: self
		name: #Bindings_to_Other_Languages
		text: 
'!New page'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageBloc [
	"This method was automatically generated."
	<wikiPage: 'Bloc'>
	^APWikiPage
		wiki: self
		name: 'Bloc'
		text: 
'!Documentation
- High level overview: ${class:GtWhatMakesBlocSpecialExplanation|show=gtCoderCommentsFor:|label=What Makes Bloc Special}$
- Main entry point: ${class:BaselineOfBloc|show=gtCoderCommentsFor:}$
- Another good entry point: ${class:ManifestBloc|show=gtCoderCommentsFor:}$
- There is the Bloc-Examples package, but packages are currently awkward to browse
!!Aspects
- Event Handling
	- ${class:BlMouseOverOutAndEnterLeaveEventExplanation|show=gtCoderCommentsFor:}$
- Graphs
	- ${class:GtMondrianVsBlocExplanation|label=''Mondrian graph builder''|show=gtCoderCommentsFor:}$ - graph builder on top of Bloc
- Layouts
	- ${class:BlGridLayoutUsageExplanation|show=gtCoderCommentsFor:}$ - a grid example
- Shapes
	- ${class:BlRectangleShapeWithArrowExplanation|show=gtCoderCommentsFor:|label=Rectangle Shape With Arrow}$ - example of complex shape (i.e. popup-like rectangle with arrow)
!Cookbook
- Draggable element: ==aBlElement addEventHandler: BlPullHandler new==. Here''s an example ${example:BrAnchoredExamples>>#tooltip|previewExpanded=false}$:
!Higher Levels Built on Bloc Foundation
- Browser engine - ${class:BaselineOfBrick|show=gtCoderCommentsFor:|label=Brick}$
- Widgets - ${class:BaselineOfGToolkitPhlow|show=gtCoderCommentsFor:|label=Phlow}$'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageCode_Changes [
	"This method was automatically generated."
	<wikiPage: 'Code Changes'>
	^APWikiPage
		wiki: self
		name: 'Code Changes'
		text: 
'!Epicea
This is Pharo''s code change tracking system. There are two common use cases for which ==PharoEnhancements== adds extensions:
- ${method:EpCodeChange class>>#allSourceCodeMatching:|label=Source code substring matching}$
- ${method:EpCodeChange class>>#allAffectingPackagesNamed:|label=Package(s) matching}$'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageContinuous_Integration [
	"This method was automatically generated."
	<wikiPage: 'Continuous Integration'>
	^APWikiPage
		wiki: self
		name: 'Continuous Integration'
		text: 
'- Speeding things up: *git partial checkout>https://medium.com/pinterest-engineering/how-a-one-line-change-decreased-our-build-times-by-99-b98453265370*'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageCookbook_2 [
	"This method was automatically generated."
	<wikiPage: 'Cookbook 2'>
	^APWikiPage
		wiki: self
		name: 'Cookbook 2'
		text: 
'!Changing an Object''s Class
There is ${method:Behavior>>#adoptInstance:}$, but following through the class comments, one doesn''t get a warm and fuzzy feeling, as it is apparently "''''not for casual use''''".
A specific case is when you have an object, but you want an instance of a subclass. In this case, you can use ${method:Object class>>#newFrom:}$ and/or ${method:Object>>#copySameFrom:}$. For example:
[[[
	PDFFileReference newFrom: ''/path/to/file.pdf'' asFileReference
]]]'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageDecimal_Numbers [
	"This method was automatically generated."
	<wikiPage: #Decimal_Numbers>
	^APWikiPage
		wiki: self
		name: #Decimal_Numbers
		text: 
'!Decimal Numbers
This is one of those convroversial topics inspiring endless conversation^^1^^. In summary, Floats are what computers expect, but not what naive (i.e. relying on life and primary school experience) humans expect.
!!Floats
Floats are a computing artifact that are not like the everyday decimals we are used to. They seem more appropriate in computer graphics applications than one for recipes. One important feature is: ''''forget about exact comparison''''^^1^^.
!!Scaled Decimals
${class:ScaledDecimal}$ is a little more (and less) complicated. 

It keeps full precision, unlike a Float, but rounds its ''''display'''' to the precision specified by its ==scale==, as seen in this example *proposed by Chris Cunningham>http://forum.world.st/SIXX-problem-for-ScaledDecimal-tp3535135p3537088.html*:
[[[language=smalltalk
sd1 := (1/3) asScaledDecimal: 2.
sd2 := (33/100) asScaledDecimal: 2.
self assert: sd2 printString equals: ''0.33s2''.
self assert: sd2 printString equals: sd2 printString.
self assert: sd1 ~= sd2. "Possibly surprising"
self assert: (sd1 + sd1) printString equals: ''0.67s2'' "Possibly surprising" 
]]]
He goes on to say: "''''From my perspecive, ScaledDecimal is great when you want to keep as much precision as possible, but need to SHOW less precision.  It reminds me of science, where you have this measurement that is way more precise than you can really measure, so you ''scale'' it back to a precision that is reliable.''''"

This thread from 2001^^2^^ has the familiar gnashing of teeth over this class, with an argument made that it shouldn''t keep more precision than its scale.
!!Fixed Decimal
From *the project description>http://www.squeaksource.com/FixedDecimal.html*: 
A FixedDecimal is similar to a ScaledDecimal, but different in certain select ways. It''s primary purpose was to be able to represent precise decimals for such things as representing money - where ScaledDecimals leave something to be desired. For instance, with ScaledDecimals, you get: (33.333s withScale:2) \+ (33.333s withScale:2) print it yields 66.67s but with FixedDecimals, you would get: (33.333 asFixedDecimal: 2) + (33.333 asFixedDecimal: 2) print it yields 66.66. So, FixedDecimals round the numbers to the exact scale you specify - converting a float (or fraction) to a FixedDecimal and back will not necessarily return the starting number, unlike ScaledDecimals.

In the announcement thread, *Nicolas Cellier pointed out some problems>http://forum.world.st/ANN-FixedDecimals-tp66327p66328.html*, which may have been fixed by now.
!!Binary Coded Decimal
This thread from 2001^^2^^ suggests that a BCD is really what you want for money, and it what ScaledDecimal should be.
!!References
# *http://forum.world.st/Issue-940-13-10-1-3-returns-false-tt1305147.html*
# *http://forum.world.st/ScaledDecimal-conversion-and-equality-question-tt3359724.html*'
]

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
PharoWiki class >> wikiPageDocumentation [
	"This method was automatically generated."
	<wikiPage: 'Documentation'>
	^APWikiPage
		wiki: self
		name: 'Documentation'
		text: 
'!Theory
*Here>https://documentation.divio.com* is a really interesting system to split up documentation based on the target audience and their current objective.'
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
PharoWiki class >> wikiPageExamples [
	"This method was automatically generated."
	<wikiPage: #Examples>
	^APWikiPage
		wiki: self
		name: 'Examples (GT)'
		text: 
'!Finding what you need
Feenk uses three way to navigate (per Tudor on GT Discord live-sessions channel on 10/24/2020):
- capturing examples in ""documents"". The narrative is both the challenging and the interesting bit. To make it less challenging, we actually guide the whole design through storytelling. We often imagine how the demo would look like. It''s something we call demo-driven (http://demodriven.com/).
- using the ""map"" and inspecting objects from left to right. This provides a quick way to navigate and find the level of abstraction/granularity you are interested in.
- using ""queries"". When you know that you are looking for how to work with a domain class, you can search it in examples.'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageExternalProcesses [
	"This method was automatically generated."
	<wikiPage: #ExternalProcesses>
	^APWikiPage
		wiki: self
		name: #ExternalProcesses
		text: 
'Pharo has basic capabilities with ${class:LibC}$ to run unixy commands from within the image. There are also several libraries for this:
- ${wikiPage:OSSubprocess}$
- ${wikiPage:OSProcess}$
- ${wikiPage:PharoShell}$
!Waiting for a command to complete
!!LibC
${example:LibC class>>#exampleRunAndWait}$
!!OSSubprocess
${example:OSSUnixSubprocess class>>#exampleRunAndWait}$
!!OSProcess
[[[
p := PipeableOSProcess waitForCommand: ''sleep 2''.
self assert: p succeeded
]]]'
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
PharoWiki class >> wikiPageGit [
	"This method was automatically generated."
	<wikiPage: 'Git'>
	^APWikiPage
		wiki: self
		name: 'Git'
		text: 
'!Cookbook
""Difference between two commits"" (e.g. for last commit): This is built into the Iceberg UI, but on the command line you can do: ==git diff HEAD~ HEAD== or ==git show== (*via SO>https://stackoverflow.com/a/17563740*)

""Non-Smalltalk files"": If you stage (e.g. via ==git add -A==), they will be included in your next Iceberg commit. Or you can commit outside the image and then adopt it in Iceberg.
""Load Packages without a Baseline"": ==((IceRepositoryCreator new url: ''git@bitbu…’; createRepository) packageNamed: #PackageName) load== (via Julián Grigera on Pharo Discord Iceberg channel on 10/24/2020)
!!Fix desynchronized repos (WIP)
You make a commit to a branch that exists on the remote, but when you try to push it, you realize there were commits on the remote that you hadn''t pulled and now your branch has diverged. What to do? It depends...
!!!No Conflicts
This would mean none of the same classes modified for Tonel, or none of the same methods modified for FileTree. This CLI script seems to be the simplest fix (replace ==master== with the branch in question):
```language=shell
git fetch origin master
git rebase origin/master
git push origin master
```
But, if you''re more comfortable in Iceberg, you can [TODO: INSERT SOLUTION FROM GH WIKI]
!!!Conflicts
Here you''ll follow the Iceberg instructions for "No Conflicts", but with the following modifications:
# Choose, "Checkout packages already loaded"
# At the end, go into Epicea and revert the in image code changes that wipes out your changes

Alternatively, you could follow the git script above and then manually resolve the conflict on the command line.'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageGtoolkit [
	"This method was automatically generated."
	<wikiPage: #Gtoolkit>
	^APWikiPage
		wiki: self
		name: #Gtoolkit
		text: 
'!Magic
Things that are difficult to find out for yourself by exploring the live system.
- Alt-click on view tab to go to code
!Discoverability
- Slideshows: I am enjoying a slideshow and want to see how it works. I bring up halos and navigate through parents until I find GtSlideElement. Via the inspector, I go to the slide and then slideshow, but there''s no way to get back to GtPharo101 unless it is explicitly mentioned in the slideshow (which it is in this case, but may not be generally) (from GT Discord feedback channel 9/9/2020)
- Views: let''s say I''ve never implemented a view. Sure, I can: 1) "Alt-click" on a view tab (which already requires esoteric knowledge of that secret incantation or 2) search for existing views via pragma filtering, but that''s kind of like groping around blindfolded because I already know exactly what I want to show, and I''d have to hunt around for a view that does that. I could browse senders of a view message (which I only know to do after over a decade of Smalltalk experience), but some of those messages seem pretty generic (e.g. list). How do I as a user most efficiently get from "I want to implement a view" or maybe more specifically "I''m looking at an existing view (or the source for it)" to "this is how you implement your view"? And how do I know how to get there? (from GT Discord how-to channel 9/8/2020)
!Views
!!Picture in Picture
Imagine this - you have a ==Tempfile== class. While a ==Tempfile== logically is a special type of  ${class:AbstractFileReference}$, for technical reasons it is not implemented as a subclass. Wouldn''t it be nice to still have all the built-in views for files?! Another use case, an ==EPUB== class. This one is a little different, because while it is a ''''file'''' from one perspective, this is not the ''''primary'''' perspective. It would be nice to have file views available, but only as one alternative. Although discouraged as a general design principle, this is a case where sub-tabs seem appropriate. Here is an example:
[[[
MyEPUB>>#gtFileFor: aView inContext: aContext
	<gtView>
	^ aView composite
		title: ''File'';
		views: (self file gtViewsInContext: aContext)
]]]
!Installation
On Mac, you may run into problems with GToolkit being quarantined. A quick google search will reveal how to unquarantine GT. If you''d like to do this in Smalltalk, check out the *ComputerWorld>https://github.com/seandenigris/Computer-World* project (search for the ==unquarantine== message).
!Customization
!!Saved Playground Scripts
You can specify where to save playgound snippets and other artifacts for both new and old GT. This can be useful for personal projects where images are frequently recreated, so you don''t accidentally lose all your snippets in the image folder of a deleted image. A convenient place to do this would be in a Metacello baseline postload. Here''s an example:
==BaselineOfXyz>>#postLoad==
[[[language=smalltalk
	| rootFolder |
	rootFolder := FileLocator dynabookData / ''Virtual Stash''.
	GTPlayBook 
		cacheDirectory: rootFolder / ''play-cache'';
		stashDirectory: rootFolder / ''play-stash''.
	Smalltalk globals
		at: #XdPlaygroundSettings
		ifPresent: [ :cls | cls directory: rootFolder / ''xdocs'' ]
]]]
which would be triggered in the baseline like this:
==baseline: spec==
...
[[[language=smalltalk
	spec for: #''common'' do: [
		spec postLoadDoIt: #''postLoad''. ]
]]]
!Huh!
I''m struggling to understand GT''s Pillar annotations. What are the "[with|without] markup" strategies about? Then there is this mind-bending code:
GtClassAnnotation>>#styleTextWithoutMarkup: aBlRope
    self styleTextWithMarkup: aBlRope.
    super styleTextWithoutMarkup: aBlRope.
Layman''s translation: "Style without markup... I mean with markup... I mean without markup... ugh, whatever" :stuck_out_tongue_winking_eye:
 
tudor girba09/10/2020
If you press on the pencil button, you will see the markup all the time
!Further Research
- baseline-aware syntax highlighter that makes inline nested dependencies available in Coder? tudor girba08/31/2020
It’s an extension in MethodCoder
 
Konrad Hinsen09/11/2020
- @SeanDeNigris The rendering of annotations baffled me as well initially. What happens is that all markup is rendered first, and then the markup is hidden in the "clean" display mode. So maybe styleTextWithoutMarkup should better be called styleTextWithMarkupThenHideMarkup.
- ==gt-extra== - to copy after template instantiation. See ${method:GtImageSetup class>>#copyDataAndDocsFolders}$
!Relevant pages
- ${wikiPage:#GT_OO_IDE}$
- ${wikiPage:#GT_VM}$'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageLauncher [
	"This method was automatically generated."
	<wikiPage: 'Launcher'>
	^APWikiPage
		wiki: self
		name: 'Launcher'
		text: 
'!Bug: Unzipping recent GToolkit ==gt-extra== folders
I''m just holding on to this one because it is a minor annoyance that only applies to custom code. I''m just leaving this record of my research in case we want to follow up later. I created a template from the following (https://www.dropbox.com/s/tzy73oi3sh32x2y/GT%200.8.225.zip?dl=0, zipped for sharing, unzip to reproduce). When I tried to create an image from the template, I got an error during unzipping (something about Hoffman tables). I don''t think it''s a Launcher error, because Launcher just uses
[[[
| sourceFolder archive anImage aString |
sourceFolder := FileLocator home / ''Downloads'' / ''GT 0.8.225''.
archive := ZipArchive new.
	archive
		addFile: anImage imageFile as: aString , ''.image'';
		addFile: anImage changesFile as: aString , ''.changes''.
	[ archive addFile: anImage sourcesFile as: anImage sourcesFile basename ]
		on: NotFound 
		do: [ :e | "ignore the file" ].
	anImage versionFile exists
		ifTrue: [ archive addFile: anImage versionFile as: anImage versionFile basename ].
	anImage addSupportFilesToTemplateArchive: archive.
	archive writeToFile: (self localTemplatesDirectory / aString , ''zip''). 
]]]'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageMagritte [
	"This method was automatically generated."
	<wikiPage: #Magritte>
	^APWikiPage
		wiki: self
		name: #Magritte
		text: 
'NB We will move this to Magritte-GToolkit once Lepiter is integrated in GToolkit because we don''t want to add the Wiki dependency to Magritte.
!Use cases
!!Matching options to string representations
""UPDATE:"" After a thorough exploration and much learned, it seems that Magritte is not designed to convert arbitrary/multiply-formatted strings into option objects. The reason for this may be simple: unlike for other description types (e.g. numbers) where the user may e.g. type a string represenation into a text editor, for existing options (i.e. not user supplied), you probably already have the option object behind a dropdown or list control. 

Let''s say, for example while OCRing receipts, we have the following options for payment method: =={ Cash. Credit. Check }==. Since there is a lot of variation in receipt formats, we need to accept multiple string representations for each object. Let''s take the simplest case, ==Cash==. At minimum, we want case insensitive matching, so that ==cash==, ==Cash==, and ==CASH== all map to the same option. So how are option strings matched to options? We look to ${class:MAStringReader}$ , the default visitor magritte uses to convert from strings to objects; specifically: ${method:MAStringReader>>#visitSingleOptionDescription:|expanded=true}$
One option would be to create our own description type, ==MAPaymentTypeDescription==. If it was a subclass of single option description, we could write a corresponding ==MAPaymentTypeReader== that overrides ==visitSingleOptionDescription:== to do what we want. It''s unclear whether it would be worth the effort vs. say just handling the string to object conversion outside of Magritte.
Alternately, let''s see if there''s a way to configure the existing Magritte classes to get the same result. Revisiting ==visitSingleOptionDescription:==, we see that its first attempt is to match the string to the labels property. However, this seems to be of limited use, as a query shows that there is only one entry point that sets this property:
[[[language=smalltalk
 #labels gtReferences & #propertyAt:put: gtReferences & ''Magritte-'' gtPackageMatches
]]]

Other entry points, like ${method:MAOptionDescription>>#options:}$ and ${method:MAOptionDescription>>#optionsTextual:}$ do not set this property, causing this first matching attempt to always fail.

The next tactic is quite subtle and relies on several aspects of Magritte which may not be obvious. The reader reenters itself, passing the description''s ==reference==. References can be tricky to understand, but there is an extensive explanation in the comment of ${class:MAReferenceDescription}$.

There is a tempation to refactor so that the label comparison is more generally useful, but since we already have this ==reference== hook, let''s step around that rabbit hole for the moment and see if there''s an acceptable way to set the reference up to do what we want. The default seems to be the same ${method:MADescription class>>#defaultStringReader|expanded=true|label=''MAStringReader''}$ class we saw above:
!Hooks from Model to UI
The current entry points from ==Object== are:
- ==asComponent== (Seaside)
- ==asMagritteMorph==
- (WIP) ==asMagritteSpec2Presenter== (name will be finalized when Spec2 is)
- (WIP) ==asMagritteBlElement==

These all delegate to the description with something like ==self magritteDescription asXyzOn: self==, which in turn passes a ${class:MAMemento}$, which inserts itself as a layer between the UI and the model object, and which knows both the object and its description.

The UI controller classes all seem to implement certain methods over and over (e.g. ==string==, ==value==, ==isReadOnly==) creating the suspicion that they might be better implemented elsewhere. Here are some requirements:
- subclassing seems not to be a good general optioni because some libraries have their own subclassing requirements e.g. Seaside''''s ==WAComponent==
- slight variations may be needed e.g. for different change notification mechanisms.

Can the visitor pattern rescue us here?! ""TODO: Read up on visitor""

Another issue with the controllers is that, since they hold a reference to the memento for the parent object, it''s not immediately clear how to instantiate something basic for testing and example purposes. Maybe mock a memento? Pass the actual object? I think the two are polymorphic.
! Further Research
I''d like to have code which automatically flips description names to new-style. I asked on Discord how to wrap the following in a cool GT GUI:
[[[
descSels := self localSelectors select: [ :e | e matchesRegex: ''description.+'' ].
newSels := descSels collect: [ :e | 
	fieldName := e allButFirst: ''description'' size.
	fieldName uncapitalized, ''Description'' ].
	r := RBRenameMethodRefactoring renameMethod: #descriptionReference in: VsTransaction to: #referenceDescription permutation: #().
r execute
]]]
'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageMemoryHogs [
	"This method was automatically generated."
	<wikiPage: #MemoryHogs>
	^APWikiPage
		wiki: self
		name: #MemoryHogs
		text: 
'!Reclaiming Memory
Once you eliminate common possible causes (see "Common Causes" below), try:
[[[language=smalltalk
10 timesRepeat: [ Smalltalk garbageCollect ].
]]]
And [World menu]>System>[Do image clean up]
!Common Causes
!!Your code
Do any of your (class/pool variable) singleton instances store data? Add a #clearAll or #reset (mySingletonVar := nil) to the class side -- or whatever fits your app -- and do that before that #garbageCollect block. [In fact, put that in some XXXAdmin class]
!!Windows in Morphic
Close all windows
!!Monticello
Try to open monticello and select any repo, right click and clear the package cache.
!!Tiling Window Manager
It is a great tool, but yes it gobbles memory. Every once in a while, disable it, GC [as described above](#Reclaiming-memory), and re-enable.
!Diagnosis
NB: These may take some time to run, especially in a larger image
!!Built-in Report
For a fairly long report on the image and memory hogs, evaluate `SmalltalkImage current reportCPUandRAM`. It writes files in the image folder containing all the information. Takes a while to run.
!!Call Graph Analysis
There is Spy (not sure of current repo location) which offers Roassal visualization.
!!Roll your own
    ((Object allSubclasses collect: [ :aClass |
        aClass -> aClass allInstances size])
        sort: [ :a :b | a value > b value ]) inspect'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageMetacello [
	"This method was automatically generated."
	<wikiPage: 'Metacello'>
	^APWikiPage
		wiki: self
		name: 'Metacello'
		text: 
'!Custom Platform Attributes
Here''s an example of special handling for GToolit images. The only method that needs to be implemented is ==customAttributes==, but we delegate the testing to ==isGTImage== so that, if changes to GT necessitate a different test, and there are a ton of these floating around in different baselines, it will be easy to find and refactor them.
${method:BaselineOfPharoEnhancements>>#customProjectAttributes|expanded=true}$
${method:BaselineOfPharoEnhancements>>#isGTImage|expanded=true}$
Now you can use ==#Gtoolkit== in your baseline, just like e.g. ==pharo.8.x==:
${method:BaselineOfPharoEnhancements>>#baseline:|expanded=true}$
!Recording i.e. "What Would Metacello Do?"
The basic script is fairly simple - just change your load script from ==load== to ==record==. For example:
[[[
Metacello new
	"ignoreImage;" "uncomment to have Metacello pretend it''s a fresh image"
	baseline: ''PharoEnhancements'';
	repository: ''github://seandenigris/Pharo-Enhancements'';
	record.
]]]
Two items to note:
# If you already have some of the packages loaded, uncommenting the line above will tell you what would be loaded if none of them were.
# If you "Print It" the above script you will get a string describing the load, but if you want to navigate the actual ==loadDirective== object, you have to send ==roots first== to the returned object, as clarified *on the Metacello ML>https://groups.google.com/g/metacello/c/FyiB0sVb7j8/m/SNXR8yTsAwAJ*.
'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPageMoney [
	"This method was automatically generated."
	<wikiPage: #Money>
	^APWikiPage
		wiki: self
		name: #Money
		text: 
'!Money
!!Projects
- *Avi''s Money project from Dabble>http://smalltalkhub.com/#!/~pdebruic/Money*. *Per Paul Debrucker>http://forum.world.st/Pharo-dev-Monetary-package-tp4692670p4693053.html*: "originally comes from last chapter of Smalltalk Best Practices Patterns by Kent Beck and was uploaded by Avi Bryant." and he worked on thereafter. Originally hosted *on SqS>http://www.squeaksource.com/Money.html*.
- Units package can be used to model money, *according to Denis Kudriashov>http://forum.world.st/Pharo-dev-Monetary-package-tp4692670p4692706.html*
!!Discussion
- *Thread>http://forum.world.st/Smalltalk-float-to-currency-how-to-tt86320.html* with a consensus to use ${wikiPage:Decimal_Numbers|label=}$ which may have (had) a bug *described by Vanessa (then Bert)>http://forum.world.st/Smalltalk-float-to-currency-how-to-tp86320p86339.html* where it was not properly rounded causing comparison issues
- Advice to use FixedDecimal
- *Thread that''s all over the place>http://forum.world.st/SIXX-problem-for-ScaledDecimal-tt3535135.html*
!!Decimal Representation
The only thing everyone seems to agree on is ''''not'''' to use Floats. Many advocate ${class:ScaledDecimal}$, but Chris Cunningham points out in several places that the scale is only for display, and precision beyond that scale is kept and used, resulting in potentially surprising results which are inappropriate for money. *He explains>http://forum.world.st/Pharo-dev-Monetary-package-tp4692670p4692890.html*: "''''In general, [this is] NOT what you want when dealing with Money - if you have an amount, it is a definite amount, and not an approximate amount.  (With the possible exceptions of interim results - but for those, you probably need strict control over exactly how precise the interim results are - which isn''t readily available in ScaleDecimal).  This is the main reason I built the FixedDecimal package on SqueakSource.''''" There is also advice to use a "Binary Coded Decimal" for money. See ${wikiPage:Decimal_Numbers}$ for (much) more (gory) detail.'
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
!!Problem with Class-Based Code
Trygve Reenskaug *on Squeak-Dev>http://forum.world.st/SmaCC-First-steps-tp4802170p4805293.html*:
The problem with reading class oriented code (C++, Java, C#, Ruby, ..., Smalltalk) is that the code does not reveal how the system will work at runtime (polymorphism). The essence of object orientation is that objects collaborate to achieve a goal.  The DCI programming paradigm adds code for how the system works at runtime:
A class says everything about the inner construction of an object
but nothing about how it is used in its interaction with other objects.
The new DCI context says everything about how objects are used when interacting with other objects
but nothing about their insides.
Class and context separates the code into two materially independent concerns: What the system IS (classes) and what the system DOES (Contexts). BabyIDE is a programming environment that supports the DCI paradigm.  It is available in Squeak 4.5 and may be available in Pharo later.
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
'What interests me is how to handle parsing in a generic way. How can we handle format input/output in a way that minimizes duplication and maximizes compatibility between libraries. If I define RTF grammar once, I don''t want to do it three more times to try out the four major parsing libraries. If I define the parsing in one direction, how much of that can be reused to reverse?
!Available Options
- PetitParser
- PetitParser2
- Xtreams
  - PEGActor example available *per Chris Cunningham>http://forum.world.st/Xtreams-PEGParser-now-has-a-working-PEGActor-subclass-td4925586.html*
!!SmaCC
!!!Docs
  - *Website>http://www.refactoryworkers.com/SmaCC/ASTs.html*
  - *Swiki entry>http://wiki.squeak.org/squeak/3117*
  - *Antlr C\++ grammar>https://github.com/antlr/grammars-v4/blob/master/cpp/CPP14Lexer.g4* - how was this converted to SmaCC?
 !!!Repos
  - *Pharo port>https://github.com/SmaCCRefactoring/SmaCC*
  
  
!!Translating Smalltalk Code
See *here>http://readthesourceluke.blogspot.com/2014/09/block-translators-parsing-magic.html* for a technique that avoids using a parser at all. For example, if you have a select block that deals with your domain objects, you can implement a SQL equivalent.
!Background/Theory
- ==terminal== - a thing that finally apperars verbatim e.g. in ==x = 0==, the terminals are ==x==, ==\===, and ==0==, vs. non-terminal parser artifacts like ==id==, ==operator==, and ==number==^^1^^
- Context-free - the non-terminal on the left side of all rules can always be replaced with the right side, regardless of surrounding tokens.^^1^^
- ==LR parser== (Left-to-right, Rightmost derivation in reverse) are "widely used for the processing of computer languages" (*per Wikipedia>https://en.wikipedia.org/wiki/LR_parse*)
- ==GLR Parser== - (GLR standing for "Generalized LR", where L stands for "left-to-right" and R stands for "rightmost (derivation)") is an extension of an LR parser algorithm to handle ""non-deterministic and ambiguous grammars"". (*Wikipedia>https://en.wikipedia.org/wiki/GLR_parser*)
!!Material Conditional
Per Udo Schneider on *this Pharo-Users thread>http://forum.world.st/BLOG-Block-Translators-parsing-magic-tp4779569p4779629.html*:
I''d say that''s an implementation of the "Material implication"[1] 
operator from Propositional calculus. 

You can write it as 

P -> Q 

and read it as "P implies Q" or (not 100% correct) "if P (is true) then 
Q (is true)". 

Let''s take a look at the truth table: 

  P | Q | P -> Q 
---+---+------- 
  t | t | t 
---+---+------- 

inserting it into the statement above yields: 

"if true then true" which is true indeed. 

The funny thing starts when we look at the case(s), where P is false. 
The general (verbal) rule says that if the premise (P) is false the 
truth value of the conclusion doesn''t matter. Hence the complete term is 
true: 

  P | Q | P -> Q 
---+---+------- 
  f | t | t 
---+---+------- 
  f | f | t 
---+---+------- 

There is one case left: What happens if the premise is true but the 
conclusion is false? That''s in direct violation of the defintion which 
states that "if P (is true) then Q (is true)". As P is true and Q is 
false the truth value of the complete term is false! 

  P | Q | P -> Q 
---+---+------- 
  t | f | f 
---+---+------- 

Or to put it in different words: An implication can only be false if the 
premise is true but the conclusion is false. 

So we end up with this truth table: 

  P | Q | P -> Q 
---+---+------- 
  t | t | t 
---+---+------- 
  f | t | t 
---+---+------- 
  f | f | t 
---+---+------- 
  t | f | f 
---+---+------- 

We did not take a look yet, at how to implement this with basic boolean 
operators. So we need to take a look at the table and find the 
expression: Let''s start with the exception (fourth case). We can express 
this as: 

!(P & !Q) -> "The term is false if P is true and Q is false" 

I added the inner term "P & !Q" to the table to make it easier to follow: 


  P | Q | P -> Q | P & !Q | !(P & !Q) 
---+---+--------+--------+----------- 
  t | t | t      | f      | t 
---+---+--------+--------+----------- 
  f | t | t      | t      | f 
---+---+--------+--------+----------- 
  f | f | t      | f      | t 
---+---+--------+--------+----------- 
  t | f | f      | f      | t 
---+---+--------+--------+----------- 

The "last" step is to simplify the term "!(P & !Q)" using one of de 
Morgan''s laws: 
\!(A & B) == !A | !B 

Using this for our term gives 

!(P & !Q) == !P | !!Q == !P | Q 

  P | Q | P -> Q | P & !Q | !(P & !Q) | !P | Q 
---+---+--------+--------+-----------+-------- 
  t | t | t      | f      | t         | t 
---+---+--------+--------+-----------+-------- 
  f | t | t      | t      | f         | f 
---+---+--------+--------+-----------+-------- 
  f | f | t      | f      | t         | t 
---+---+--------+--------+-----------+-------- 
  t | f | f      | f      | t         | t 
---+---+--------+--------+-----------+-------- 

So our final term is "correct" (proof in the truth table) and is 
equivalent to the smalltalk term: 

\!P | Q  := self not or: [aBlock value] 


I have to admit though that implications in Propositional calculus 
really gave me a headache. You might simply want to accept that they are 
defined this way. And maybe it doesn''t help ... but there are even more 
strange things lurking around the corner [4] :-) 

Although not immidiatly obvious all the terms in Propositional calculus 
do not neccessarly have a semantic meaning in context to each other. 
They are totaly independent. The only thing that counts is the truth 
value of its terms. E.g. something like this is 
mathematically/syntacically valid but doesn''t make any sense from a 
semantic point of view: 

P := I am 12y old 
Q := It rains 

The term "P -> Q" is perfectly fine mathematically/syntacically but 
doesn''t mean anything in terms of semantics. 


Hope this helps. 

CU, 

Udo 

[1] http://en.wikipedia.org/wiki/Material_implication_(rule_of_inference) 
[2] http://en.wikipedia.org/wiki/Propositional_calculus
[3] http://en.wikipedia.org/wiki/De_Morgan''s_laws
[4] http://en.wikipedia.org/wiki/Paradoxes_of_material_implication
!!Miscellaneous
- *Fascinating thread>http://forum.world.st/SmaCC-First-steps-td4802170.html* as Kilon begins his journey parsing Python
!Reference
#*https://en.wikipedia.org/wiki/Context-free_grammar*
'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPagePersistence [
	"This method was automatically generated."
	<wikiPage: 'Persistence'>
	^APWikiPage
		wiki: self
		name: 'Persistence'
		text: 
'Per Pierce Ng, in *this enlightening thread>http://forum.world.st/Easiest-light-weight-cloud-web-persistence-for-Pharo-td5123027.html*:
If you are familiar with Docker then starting a database server is easy 
that way. Assuming you pick a ''boring'' product then what matters for 
your app is the quality of the database interface code on Pharo for that 
product. For PostgreSQL and MySQL no problem. I''ve not used Mongo itself 
nor Voyage so no comment. 

If you neither want to run a separate database server nor roll your own 
writing out to Fuel etc, then you''re looking at ''embedded'' databases. 
For pure Smalltalk, Omnibase or SimplePersistence. If you are ok with 
something that uses FFI, then SQLite, Unqlite and probably others. 

Personally I''d choose SQLite because it is boring - ubiquitous, high 
quality, and importantly unlike the pure Smalltalk and many embedded 
key-value databases there is a plethora of external tools that operate 
on SQLite databases which will help your debugging. 

For SQL databases you can also use an ORM like Glorp or ReStore. 

Finally there are also NoSQL-as-a-service like Google Firebase. 

Many options. Great time sinks. :-) Have fun. 

- *PostgreSQL>https://github.com/svenvc/p3*
- *MySQL>https://github.com/pharo-rdbms/Pharo-MySQL*
- *Omnibase>https://github.com/sebastianconcept/OmniBase*  
- *SimplePersistence>https://github.com/seandenigris/Simple-Persistence*
- *SQLite>https://github.com/pharo-rdbms/Pharo-SQLite3*
- *Unqlite>https://github.com/mumez/PunQLite*
- *Glorp>https://github.com/pharo-rdbms/glorp*
- *ReStore>https://github.com/rko281/ReStoreForPharo*
- *Firebase>https://github.com/psvensson/firebase-st*
- *Choose Boring Technology>http://boringtechnology.club/*'
]

{ #category : #wikiPages }
PharoWiki class >> wikiPagePillar [
	"This method was automatically generated."
	<wikiPage: #Pillar>
	^APWikiPage
		wiki: self
		name: #Pillar
		text: 
'!Pillar
!!Annotations
- Parameters - available defined in class-side ==possibleParameters== (e.g. ${method:PRCitationAnnotation class>>#possibleParameters}$
${example:GtCoderExamples>>#scripter|label=''hi there''}$'
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
PharoWiki class >> wikiPageSmaCC [
	"This method was automatically generated."
	<wikiPage: 'SmaCC'>
	^APWikiPage
		wiki: self
		name: 'SmaCC'
		text: 
'!Getting Started
SmaCC seems designed to be managed ''''only'''' with the SmaCC GUI tools. These have been ported to Morphic, but are still WIP in Gtoolkit. The needed boilerplate to get started is: 1) a scanner class and 2) a parser class that returns the scanner class from class-side ==scannerClass==. The PharoEnhancements provides a message for this:
${example:SmaCCParser class>>#exampleNewEmptyParser}$
!Documentation
The most comprehensive documentation is ${class:SmaCCDefinitionParser}$ itself. With the SmaCC GUI tools, or GToolkit views, you can easily browse and test the productions. You will find lots of interesting little details that may be too arcane for most written docs. For example, did you know that productions can use either ==:== or the more standard ==::===? How do we know, we checked out the ==<production>== rule and in GToolkit even live-tested ==::=== as a sanity check to make sure it matched.
!Converstion from Antlr
Here''s an example from John Brant via Discord GT general channel 9/22:
[[[
| antlrAST rwRule rewriter |
antlrAST := Antlr4Parser parse: (ZnEasy get: ''https://raw.githubusercontent.com/antlr/grammars-v4/master/arithmetic/arithmetic.g4'') contents.
rwRule := (ZnEasy get: ''https://raw.githubusercontent.com/j-brant/SmaCC/master/rewrites/antlr/antlr.rw'') contents.
rewriter := SmaCCRewriteEngine new.
rewriter rewriteRule: (SmaCCRewriteRuleFileParser parse: rwRule).
rewriter rewriteTree: antlrAST
]]]
!Competion in GT
Per John Brant in Discord GT -> how-to:
To build completion with a SmaCC AST, you need to create a new subclass of GtCompletionStrategy (e.g., GtPharoCompletionStrategy) and override the completionActionsFor:at:max:requested: method. That method will need to parse the text using the parseWithErrors:{startingAt:} method. This method will return an AST and where there are parse errors it will insert SmaCCErrorNodes. Now, you''ll either want to create a custom visitor for  completion or you can add extension methods to your AST nodes. The GtPharoCompletionStrategy uses extension methods where several nodes defined a completionActionsFor: method. For example, the GtPharoVariableNode>>completionActionsFor: method checks that the cursor position is at the end of the variable name, and then gets a list of completions that start with the variable from both the local variables defined in the AST and externally defined variables like instance and global variables. The method then returns a collection of GtCompletionActions that are shown in the drop down. For completion, probably the most important completion action is the GtInsertTextCompletionAction, but there are actions like deleting text and composites.
!Questions
- Why create a rule with just one token e.g. ==Number : <number> {{Number}} ;==
- When would you not want to ==%annotate_tokens;==?'
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
PharoWiki class >> wikiPageTime_Control [
	"This method was automatically generated."

	<wikiPage: #Time_Control>
	^ APWikiPage
		wiki: self
		name: #Time_Control
		text:
			'!Time Control
- *http://www.manfred-lange.com/publications/TimeTravel.pdf*. There are *apparently>http://forum.world.st/Smalltalk-float-to-currency-how-to-tp86320p86334.html* other versions available.'
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
- Parameterized examples - ==dependsOn:== are arguments? Will they be runnable from e.g. Coder?
- How to change main window title?
!!Tasks
- GT Launcher
  - gt-extras etc go with images, not VM - otherwise doc links broken
- Classes should show custom views in Coder e.g. Wiki pages
- Investigate SmaCC
- Debugger: add do, dive, debug buttons
- Coder show superclass(es) methods is filter WIP per Tudor
- Git Tool - browse change
[[[
BrGlamorousWithContextMenuLook
						content: [ BrGlamorousSimpleContextMenuContent new
								items:
									{(''Revert changes''
										->
											[ :e | self workingCopy diffToReferenceCommit revertChanges: anIceNode ]).
									(''Browse''
										->
											[ :e | anIceNode value definition browse ])};
								yourself ])
]]]
!Dreams
- Since views are explicitly annotated, could there be documentation connected specifically with <gtView> so that it shows (or shows that it is available) whenever such a method is being worked on? E.g. the slideshow
- Link to headings inside documenter doc, like GH does with HTML anchors. I know Pillar already has section tags but never used them...
- Universal undo
- Documentation organization e.g. tags, hierarchy
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

{ #category : #wikiPages }
PharoWiki class >> wikiPageXML [
	"This method was automatically generated."
	<wikiPage: 'XML'>
	^APWikiPage
		wiki: self
		name: 'XML'
		text: 
'One initial decision you have to make is how much to rely on XML. It may be convenient to keep XML objects hanging around indefinitely inside wrapper classes. At the other extreme, you might do the minimum processing necessary to create domain objects and then throw away the XML.
!!Custom Node Classes
- pass ${class:XMLPluggableElementFactory}$ to ${method:XMLDOMParser>>#nodeFactory:}$. 
- For SAX, the work was apparently lost^^1^^, but the ==OPAX== project which may be a starting point^^1^^
!!Selective (Island) Parsing
!!!Built-In
Hernan suggested using SAX like so:^^1^^
[[[
| parser doc |
parser := XMLPullParser parse: doc.
[ parser isEndDocument ] whileFalse: [
    parser 
        if: ''FILM'' 
        peek: [ : found | 
            Transcript show: found name , '' -> '' , found attributes asString; cr.
            parser next.
            Transcript show: parser tagName ].
    parser next ]
]]]

See #test01ParsingNodes and BioSmalltalk''s BioNCBIBlastSAXParser for more examples. Steph mentioned a "PullParser chapter"^^1^^
!!Sorting Nodes
The consensus seems to be that the cleanest approach is to sort the nodes after they are parsed. However, I just couldn''t shake the itch to make it part of the model, or at least seemless. This hack seemed like the STTCPW to compromise:
[[[
	XMLCustomElement>>handleEndTag 
        ^ self nodes sort: [ :a :b | a < b ]. 
]]]
An experiment to allow swapping out ==XMLOrderedList== with an ==XMLSortedList== "causes the image to hang and CPU to sweat".^^2^^
!!Validation
This awsome feature can sometimes cause trouble, especially if you don''t need it. For example, the system may seem to hang while it churns, downloading DTDs that it''s never going to use. Luckily it seems like it is no longer enabled by default. Toggle by sending ${method:SAXHandler>>#resolvesExternalEntities:}$. There also seemed to be a potential problem where #entityURIFromRelative:andBase: interprets relative URLs like ''xhtml-lat1.ent'' as file paths, leading to results like "XMLFileIOException: File @ ~/Squeak/http:/www.w3.org/TR/xhtml1/DTD/xhtml-lat1.ent (line 28) (line 3)".^^3^^
!!Visitor Experiment
Steph Ducasse did an experiment registering for specific tags e.g. ==MyFilmVisitor new visitTags: #(FILM ROLE)==. It was pointed out by Vincent Blondeau that, with his approach, he would have to specify all nested tags, so ==film== doesn''t get you ==title== - you have to visit that separately. A point of confusion seemed to by ==characters:== ("What a bad name!"), which you use "to get the content on the tag"; Brice Govin added that "information inside a marker is consider as an XMLString that is created after a call to XMLDOMParser>>characters:". Alex Bergel warned that " a visitor is not the ideal solution to query XML tree. It works well in some case, and it is disastrous in some other", recommending XPath instead. ==Pastell== was mentioned, which Tudor Girba said was superceded by ==XPath==^^1^^
!!Whitespace, Ignoring Extraneous (i.e. empty nodes)
XMLParser: Send ${method:XMLNodeWithElements>>#removeAllFormattingNodes}$. See *this ML thread>http://forum.world.st/How-to-get-rid-of-empty-XML-nodes-tt5059684.html* for rationale on why these nodes exist in the first place.
!References
# *http://forum.world.st/How-to-access-XML-tag-name-tt4884065.html*
# http://forum.world.st/Parsing-XML-into-sorted-elements-tt3615867.html
# http://forum.world.st/XMLDomParser-Changes-in-Pharo-3-0-tt4778401.html#a4778522'
]
