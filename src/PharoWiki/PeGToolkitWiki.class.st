"
@TODO collect tweets re GT into a summary paragraph
!Configuration
!!Saved Playground Scripts
You can specify where to save playgound snippets and other artifacts for both new and old GT. This can be useful for personal projects where images are frequently recreated, so you don't accidentally lose all your snippets in the image folder of a deleted image. A convenient place to do this would be in a Metacello baseline postload. Here's an example:
==BaselineOfXyz>>#postLoad==
[[[language=smalltalk
	| rootFolder |
	rootFolder := FileLocator dynabookData / 'Virtual Stash'.
	GTPlayBook 
		cacheDirectory: rootFolder / 'play-cache';
		stashDirectory: rootFolder / 'play-stash'.
	Smalltalk globals
		at: #XdPlaygroundSettings
		ifPresent: [ :cls | cls directory: rootFolder / 'xdocs' ]
]]]
which would be triggered in the baseline like this:
==baseline: spec==
...
[[[language=smalltalk
	spec for: #'common' do: [
		spec postLoadDoIt: #'postLoad'. ]
]]]
!Discoverability
- Slideshows: I am enjoying a slideshow and want to see how it works. I bring up halos and navigate through parents until I find GtSlideElement. Via the inspector, I go to the slide and then slideshow, but there's no way to get back to GtPharo101 unless it is explicitly mentioned in the slideshow (which it is in this case, but may not be generally) (from GT Discord feedback channel 9/9/2020)
- Views: let's say I've never implemented a view. Sure, I can: 1) ""Alt-click"" on a view tab (which already requires esoteric knowledge of that secret incantation or 2) search for existing views via pragma filtering, but that's kind of like groping around blindfolded because I already know exactly what I want to show, and I'd have to hunt around for a view that does that. I could browse senders of a view message (which I only know to do after over a decade of Smalltalk experience), but some of those messages seem pretty generic (e.g. list). How do I as a user most efficiently get from ""I want to implement a view"" or maybe more specifically ""I'm looking at an existing view (or the source for it)"" to ""this is how you implement your view""? And how do I know how to get there? (from GT Discord how-to channel 9/8/2020)
!Features
Core components - what you need to know.
!!Notifications
The following example displays text in the notification center. Asked for an explanation of why this works on Discord help channel on 2/24/21.
[[[language=smalltalk
BlBlocUIManagerNotification
	requestOrNil: #inform:
	with: { 'Example information' }
]]]
!!Search
There is a live session on this and you can see examples in image via ==<gtSearch>==
!!${wikiPage:Views}$
!Huh!
I'm struggling to understand GT's Pillar annotations. What are the ""[with|without] markup"" strategies about? Then there is this mind-bending code:
GtClassAnnotation>>#styleTextWithoutMarkup: aBlRope
    self styleTextWithMarkup: aBlRope.
    super styleTextWithoutMarkup: aBlRope.
Layman's translation: ""Style without markup... I mean with markup... I mean without markup... ugh, whatever"" :stuck_out_tongue_winking_eye:
 
tudor girba09/10/2020
If you press on the pencil button, you will see the markup all the time
!Installation
On Mac, you may run into problems with GToolkit being quarantined. A quick google search will reveal how to unquarantine GT. If you'd like to do this in Smalltalk, check out the *ComputerWorld>https://github.com/seandenigris/Computer-World* project (search for the ==unquarantine== message).
!Magic
Things that are difficult to find out for yourself by exploring the live system.
- Alt-click on view tab to go to code
!Further Research
- baseline-aware syntax highlighter that makes inline nested dependencies available in Coder? tudor girba08/31/2020
It’s an extension in MethodCoder
 
Konrad Hinsen09/11/2020
- @SeanDeNigris The rendering of annotations baffled me as well initially. What happens is that all markup is rendered first, and then the markup is hidden in the ""clean"" display mode. So maybe styleTextWithoutMarkup should better be called styleTextWithMarkupThenHideMarkup.
- ==gt-extra== - to copy after template instantiation. See ${method:GtImageSetup class>>#copyDataAndDocsFolders}$
!Other GT Pages
- ${wikiPage:#GT_OO_IDE}$
- ${wikiPage:#GT_VM}$
"
Class {
	#name : #PeGToolkitWiki,
	#superclass : #Object,
	#traits : 'TAPWiki',
	#classTraits : 'TAPWiki classTrait',
	#category : #PharoWiki
}

{ #category : #wikiPages }
PeGToolkitWiki class >> wikiPageBloc [
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
PeGToolkitWiki class >> wikiPageExamples [
	"This method was automatically generated."
	<wikiPage: 'Examples'>
	^APWikiPage
		wiki: self
		name: 'Examples'
		text: 
'!Structure and Navigation
Feenk uses three ways to navigate (per Tudor on GT Discord live-sessions channel on 10/24/2020):
- capturing examples in ""documents"". The narrative is both the challenging and the interesting bit. To make it less challenging, we actually guide the whole design through storytelling. We often imagine how the demo would look like. It''''s something we call demo-driven (http://demodriven.com/).
- using the ""map"" and inspecting objects from left to right. This provides a quick way to navigate and find the level of abstraction/granularity you are interested in.
- using ""queries"". When you know that you are looking for how to work with a domain class, you can search it in examples.'
]

{ #category : #wikiPages }
PeGToolkitWiki class >> wikiPageGT_VM [
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
PeGToolkitWiki class >> wikiPageOO_IDE [
	"This method was automatically generated."
	<wikiPage: #OO_IDE>
	^APWikiPage
		wiki: self
		name: #OO_IDE
		text: 
'!Gtoolkit: Restoring Dignity to Our Poor Objects
- Alan Kay real OOP "encapsulated modules all the way down with pure messaging"
- "The thing that attracted me about whole computers was that they can do whatever a computer can do.
Making the interior of a computer to be virtual computers preserves this. “The parts have the same powers as the wholes”. In the most recent children’s system we did over the last decade we made one kind of “universal object” which could be used to make everything else. (This is an interesting design exercise!) And it is interesting to compare the “large comprehensive” object idea with having class object be tiny and trying to build up a universe through zillions of subclasses. The large comprehensive object idea is a little more biological (where every cell in our body contains the entire DNA and the several hundred cell specializations are done entirely by a kind of parameterization)."

Taken together, they are a big clue to the problem GT solves. Take Pharo''s poor Class object... As central and powerful as it is, if you serialized it and sent it to someone, they would not need to master an array of tools to do basic things - like explore its methods (with a class browser), read rich documentation about it (until recently they would have needed to refer to outside sources like eBooks and websites), and find references to it in their image (with a query browser). But Alan is imploring us: "each computational unit should retain all the power of the unit that contains it!" Class should know how to browse its methods, show its documentation, and find its references. Let''s ignore the ''''implementation'''' for a moment, which would surely lead to debate about impossible to understand "monolithic" classes. Instead, let''s focus on the ''''presentation'''' to the user. Even if we still have helper objects that browse and show documentation, from the user perspective these should be integral to the  object. Whenever you see Class, you should have ''''immediate'''' access to these. By immediate, I mean at-hand, which should aim to be as universal and with at little context switching as possible. In essence, our IDE should be shaken to its foundations by the same revolution that created our objects.'
]

{ #category : #wikiPages }
PeGToolkitWiki class >> wikiPageSmaCC [
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
PeGToolkitWiki class >> wikiPageTODO [
	"This method was automatically generated."
	<wikiPage: 'TODO'>
	^APWikiPage
		wiki: self
		name: 'TODO'
		text: 
'!Phlow Columns
- GtPhlowColumnedListView provides 14 methods to configure a column. These seem to simply forward requests to the underlying GtPhlowColumn (which is itself a proxy for BrColumn) using the same API. Why not just have #column:do:, which is the most powerful and allows access to the underlying column? It will greatly reduce the amount of code and users will only have to understand and work with the column API...
- BrColumn class comment refers to classes that don''t exists; unclear whether example produces a meaningful result - how do we view it?
- Can one prototype a view in a playground?

Via column:do: and stencil:, you could put any Bloc element:
column: ''Input'' do: [ :clm | 
	clm stencil: [ :e | 
		BlElement new
				background: Color blue;
				yourself ] ];
Including an editor:
column: ''Input'' do: [ :clm | 
			clm stencil: [ :e | 
			"Halt once."
			"BlTextElement new
		text: e counterparty asRopedText;
		yourself.
			BrEditor new
		look: BrGlamorousEditorLook;
		text: e counterparty;
		matchParent;
		yourself.
		"BlElement new
				background: Color blue;
				yourself ] ];'
]

{ #category : #wikiPages }
PeGToolkitWiki class >> wikiPageViews [
	"This method was automatically generated."
	<wikiPage: 'Views'>
	^APWikiPage
		wiki: self
		name: 'Views'
		text: 
'!Prototyping
All you need is an empty view to start. For example:
[[[
GtPhlowEmptyView new 
    list 
        title: ''List'';
        items: [{1 . 2 . 3}]
]]]
!Picture in Picture
Imagine this - you have a ==Tempfile== class. While a ==Tempfile== logically is a special type of  ${class:AbstractFileReference}$, for technical reasons it is not implemented as a subclass. Wouldn''t it be nice to still have all the built-in views for files?! Another use case, an ==EPUB== class. This one is a little different, because while it is a ''''file'''' from one perspective, this is not the ''''primary'''' perspective. It would be nice to have file views available, but only as one alternative. Although discouraged as a general design principle, this is a case where sub-tabs seem appropriate. Here is an example:
[[[
MyEPUB>>#gtFileFor: aView inContext: aContext
	<gtView>
	^ aView composite
		title: ''File'';
		views: (self file gtViewsInContext: aContext)
]]]'
]
