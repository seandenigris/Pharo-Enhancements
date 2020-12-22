"
NB We will move this to Magritte-GToolkit once Lepiter is integrated in GToolkit because we don't want to add the Wiki dependency to Magritte.
!Use cases
!!Databases
- Custom memento subclasses can be the glue, per Diego Lont in *this post>http://forum.world.st/Web-stack-practices-Glorp-QCMagritte-tp4969583p4970881.html* which also touches on QCMagritte and performance issues.
- ''""To map to database/Glorp I would just add properties to the description wherever needed, and add a visitor creating the mappings.""'' *per Stephan Eggermont>http://forum.world.st/Web-stack-practices-Glorp-QCMagritte-tp4969583p4969932.html*
!!Matching options to string representations
""""UPDATE:"""" After a thorough exploration and much learned, it seems that Magritte is not designed to convert arbitrary/multiply-formatted strings into option objects. The reason for this may be simple: unlike for other description types (e.g. numbers) where the user may e.g. type a string represenation into a text editor, for existing options (i.e. not user supplied), you probably already have the option object behind a dropdown or list control. 

Let's say, for example while OCRing receipts, we have the following options for payment method: =={ Cash. Credit. Check }==. Since there is a lot of variation in receipt formats, we need to accept multiple string representations for each object. Let's take the simplest case, ==Cash==. At minimum, we want case insensitive matching, so that ==cash==, ==Cash==, and ==CASH== all map to the same option. So how are option strings matched to options? We look to ${class:MAStringReader}$ , the default visitor magritte uses to convert from strings to objects; specifically: ${method:MAStringReader>>#visitSingleOptionDescription:|expanded=true}$
One option would be to create our own description type, ==MAPaymentTypeDescription==. If it was a subclass of single option description, we could write a corresponding ==MAPaymentTypeReader== that overrides ==visitSingleOptionDescription:== to do what we want. It's unclear whether it would be worth the effort vs. say just handling the string to object conversion outside of Magritte.
Alternately, let's see if there's a way to configure the existing Magritte classes to get the same result. Revisiting ==visitSingleOptionDescription:==, we see that its first attempt is to match the string to the labels property. However, this seems to be of limited use, as a query shows that there is only one entry point that sets this property:
[[[language=smalltalk
 #labels gtReferences & #propertyAt:put: gtReferences & 'Magritte-' gtPackageMatches
]]]

Other entry points, like ${method:MAOptionDescription>>#options:}$ and ${method:MAOptionDescription>>#optionsTextual:}$ do not set this property, causing this first matching attempt to always fail.

The next tactic is quite subtle and relies on several aspects of Magritte which may not be obvious. The reader reenters itself, passing the description's ==reference==. References can be tricky to understand, but there is an extensive explanation in the comment of ${class:MAReferenceDescription|show=#gtCoderCommentsFor:}$.

There is a tempation to refactor so that the label comparison is more generally useful, but since we already have this ==reference== hook, let's step around that rabbit hole for the moment and see if there's an acceptable way to set the reference up to do what we want. The default seems to be the same ${method:MADescription class>>#defaultStringReader|expanded=true|label='MAStringReader'}$ class we saw above:
"
Class {
	#name : #PeMagritteWiki,
	#superclass : #Object,
	#traits : 'TAPWiki',
	#classTraits : 'TAPWiki classTrait',
	#category : #PharoWiki
}

{ #category : #wikiPages }
PeMagritteWiki class >> wikiPageFurtherResearch [
	"This method was automatically generated."
	<wikiPage: 'FurtherResearch'>
	^APWikiPage
		wiki: self
		name: 'FurtherResearch'
		text: 
'I''d like to have code which automatically flips description names to new-style. I asked on Discord how to wrap the following in a cool GT GUI:
[[[
descSels := self localSelectors select: [ :e | e matchesRegex: ''description.+'' ].
newSels := descSels collect: [ :e | 
	fieldName := e allButFirst: ''description'' size.
	fieldName uncapitalized, ''Description'' ].
	r := RBRenameMethodRefactoring renameMethod: #descriptionReference in: VsTransaction to: #referenceDescription permutation: #().
r execute
]]]

- Mariano mentioned some extensions he had done but not released* *here>http://forum.world.st/Adding-to-Magritte-tp4728958p4729020.html*
- Field dependency discussion regarding QC and Seaside *here>http://forum.world.st/Adding-to-Magritte-tp4728958p4729953.html*
- Dynamic descriptions - *here>http://forum.world.st/Understanding-dynamic-descriptions-tp4840991p4841017.html* is a question about ==visible== being set at description creation time, but potentially having a different value later on when the model is changed. A few thoughts came to mind: blocks (with the disadvantages that coem with them in Magritte), value holders, or accept aSymbol that is sent to the object in addition to aBoolean. To my surprise 5 years later, I posted a *response>http://forum.world.st/Understanding-dynamic-descriptions-tp4840991p4843449.html*, connecting the problem to mementos being static and added that just passing a block wouldn''t help
- ''''"I really like describing domain objects with Magritte and using chains of visitors to add cross-cutting concerns like translations, styling and access control. The resulting domain code is very clean and DRY. To map to database/Glorp I would just add properties to the description wherever needed, and add a visitor creating the mappings."'''' *per Stephan Eggermont>http://forum.world.st/Web-stack-practices-Glorp-QCMagritte-tp4969583p4969932.html*'
]

{ #category : #wikiPages }
PeMagritteWiki class >> wikiPageGToolkit_Integration [
	"This method was automatically generated."
	<wikiPage: 'GToolkit Integration'>
	^APWikiPage
		wiki: self
		name: 'GToolkit Integration'
		text: 
'!Documenter
Similar to ${class:GtDocumenter}$''s built-in ability to store documents in class comments via ${method:GtDocument class>>#forClass:}$, you can view and edit fields described by ${class:MAStringDescription}$. For example: ==GtDocument maFor: recipe using: self noteDescription.='
]

{ #category : #wikiPages }
PeMagritteWiki class >> wikiPageGUI [
	"This method was automatically generated."
	<wikiPage: 'GUI'>
	^APWikiPage
		wiki: self
		name: 'GUI'
		text: 
'!Hooks from Model
The current entry points from ==Object== are:
- ==asComponent== (Seaside)
- ${method:Object>>#asMagritteMorph}$
- (WIP) ==asMagritteSpec2Presenter== (name will be finalized when Spec2 is)
- (WIP) ==asMagritteBlElement==
!Down the Rabbit Hole
These all delegate to the description with something like ==self magritteDescription asXyzOn: self==. Let''s take Morphic as an example. Looking at ${method:MAContainer>>#asMorphOn:|expanded=true}$
We see that the presenter class receives a ${class:MAMemento}$, which inserts itself as a layer between the UI and the model object, and which knows both the object and its description.
!Presenters~~/Controllers~~
Settle on presenter term based on *this SO answer>https://stackoverflow.com/a/101561*.
!! Instance Variables
Each has access to the following, but are they needed for every element?
- ==description== - Most of the uses seem static i.e. during Morph building. A few that aren''t are: file choosing, new relation creation, and the actual string reading and writing for each (which maybe could be hardcoded at build time?).
- ==memento== 
  - used again for reading and writing
  - for ==commit== and ==validate==, but do these actions have meaning at the element level?
  - for model access, but this seems to only be used by containers, where it clearly makes sense
- ==morph==, which could be generalized to ==view==, and would make sense for each presenter to keep around, but is only used by containers and during building
- ==parent== is only used by ${method:MAMorphicDescription>>#root}$, which is itself unused.
!!Behavior
The UI controller classes all seem to implement certain methods over and over (e.g. ==string==, ==value==, ==isReadOnly==) creating the suspicion that they might be better implemented elsewhere. Here are some requirements:
- subclassing seems not to be a good general option because some libraries have their own subclassing requirements e.g. Seaside''s ==WAComponent==
- slight variations may be needed e.g. for different change notification mechanisms.

Can the visitor pattern rescue us here?! ""TODO: Read up on visitor""
!!Reimagining
The Morphic and Seaside (i.e. Component) objects are in effect slightly divergent and extended versions of each other. Let''s extract out the commonality. The hurdle that still remains though is that there can''t be one common hierarchy because each framework has its own expectations. I don''t see how to do this without traits...

Another issue with the controllers is that, since they hold a reference to the memento for the parent object, it''s not immediately clear how to instantiate something basic for testing and example purposes. Maybe mock a memento? Pass the actual object? I think the two are polymorphic.'
]

{ #category : #wikiPages }
PeMagritteWiki class >> wikiPageQCMagritte [
	"This method was automatically generated."
	<wikiPage: 'QCMagritte'>
	^APWikiPage
		wiki: self
		name: 'QCMagritte'
		text: 
'A library by Diego Lont that is build on top of Magritte... contains a lot of good add ons; a stack based on Seaside, Magritte, and Bootstrap.
- some dynamic stuff (i.e. dynamic columns, groups that can collapse, automatic values)
- Repos - Laurent Laffont announced *a port to GH>https://github.com/Afibre/QCMagritte*, from which there are several other forks with newer commits. Not sure if work also continued on *original SqS repo>http://smalltalkhub.com/#!/~DiegoLont/QCMagritte/*.
- per Diego, maybe should end up in MagritteAddOns, but still WIP; same per Stephan Eggermont
- some tips on using it for ajax are *here>http://forum.world.st/QCMagritte-and-MAJQDateInputComponent-tp4777365p4777407.html*
- ''''"QCQuery is to search in a dataset, arbitrarily how it is organised. It does so by recursively visiting the magritte description of the objects, and has protection against loops."'''' - excerpt from longer post *here>http://forum.world.st/Deep-QCMagritte-tutorial-tp4744612p4744943.html*
- *Getting started slideshow>https://www.slideshare.net/esug/getting-started-with-qcmagritte*
- Tutorial included: ''''"Once you have [the framework] loaded, you can start the webpage to localhost:8080 and there you have your tutorial."''''
- Builders were apparently ported back to Magritte *per diego>http://forum.world.st/Port-of-builders-to-Magritte-Model-tp4945490.html*'
]
