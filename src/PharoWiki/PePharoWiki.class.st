"
Welcome to the Pharo wiki!
"
Class {
	#name : #PePharoWiki,
	#superclass : #Object,
	#traits : 'TAPWiki',
	#classTraits : 'TAPWiki classTrait',
	#category : #PharoWiki
}

{ #category : #wikiPages }
PePharoWiki class >> wikiPageAST [
	"This method was automatically generated."
	<wikiPage: 'AST'>
	^APWikiPage
		wiki: self
		name: 'AST'
		text: 
'!Terminology - AST vs. "Parse Tree"
==parseTree== returns a generated tree suitable for modification, while ==ast== returns a cached tree. For lots and lots more details, see *http://forum.world.st/ast-vs-parseTree-td4893074i40.html*
!Usage Examples
- ""Format source"": ==(RBParser parseMethod: source) formattedCode==
!Code Generation
!!DIY Approaches
!!!String Manipulation
This has the lowest barrier to entry,  because you are writing Smalltalk code, just inside a string. The approach is *okay* for simple cases, but can get unwieldy, and doesn''t benefit from e.g. (early) compiler warnings. It is also lacking when one wants to offer the behavior as a method and also as a script with no dependencies (maybe for CI).

You can create and fill a template, like this:
[[[
| template |
template := ''answerToEverything

^ {returnValue}''.

template format: { #returnValue -> 42 } asDictionary
]]]

You can also build the source with a stream. See  ${method:MAElementDescription>>#addTo:as:}$ in Magritte-Developer, which also uses the noteworthy technique of  relying on ==store:== to regenerate an object instance.

This approach really seems to shine for code that is really data, like a literal array, which is much easier to work with live than to deal with as source code/AST. 

Here''s an example. Say you have a method that returns a literal array to be consumed as pairs, like this:
${method:PePharoWiki>>#exampleReturningLiteralArray|expanded=true}$
Notice the formating:
# alphabetical items
# two items per line

Other techniques like AST manipulation would be awkward. Inserting nodes per #1 would not be straightforward and auto-formatting would prevent #2.

With strings, however, we have total flexibility in how the source code will look. In this case, this is worth the complication of this low-level approach:
[[[language=smalltalk
| aCollection |
"Given an updated collection"
aCollection := #(''Adam'' (''Bubba'' ''Tiny'') ''Zed'' nil).

"A new method can easily be generated"
String streamContents: [ :str |
	str nextPutAll: ''exampleReturningLiteralArray
	^ #(
		"Name" "Aliases"''.
	aCollection pairsDo: [ :name :aliases | 
		| aliasesToStore |
		str cr; tab; tab; print: name; space.
		aliasesToStore := aliases ifEmpty: [ nil ].
		aliasesToStore storeOn: str ].
	str cr; tab; nextPutAll: '').'' ].
]]]
!!!AST Manipulation
If you start with an existing method and modify its AST, you have the advantage of working with real objects in the domain of source code, which is less error-prone than dumb strings. However, the API does not seem to be optimized for this scenario and there is a bit of a learning curve. Here is an excerpt of a script porting a Metacello baseline method from a ConfigurationOf to a BaselineOf.
[[[
| methodTree |
methodTree := (BaselineOfMyProject>>#baseline301:) parseTree.
methodTree selector: #baseline:.
methodTree pragmas at: 1 put: (RBPragmaNode selector: #baseline arguments: #()).
BaselineOfMyProject compile: methodTree newSource classified: ''baseline''
]]]
The full script can be viiewed in ${method:ConfigurationOf class>>#createBaselineFrom:}$ in the *DeNigrisPreferences project>https://github.com/seandenigris/Pharo-Preferences*

One use case that is difficult to handle with the approaches above is when one wants to offer the same behavior both as a message to an object and as a script with no dependencies  (e.g. self sends), maybe for CI. Two libraries offer better support for this: ==PharoCodeGenerator== and ==PharoEnhancements== ${class:PeAST_Transformer}$ class (see below).
!!Libraries
- *PharoCodeGenerator>https://github.com/juliendelplanque/PharoCodeGenerator* - DSL to create methods from stratch, templates, or existing methods
- *PlainPharoCode>https://github.com/hogoww/PlainPharoCode* - Use blocks to define the method body
- ${class:PeAST_Transformer}$ offers some higher-level support for transforming the AST of an existing method'
]

{ #category : #wikiPages }
PePharoWiki class >> wikiPageBindings_to_Other_Languages [
	"This method was automatically generated."
	<wikiPage: #Bindings_to_Other_Languages>
	^APWikiPage
		wiki: self
		name: #Bindings_to_Other_Languages
		text: 
'!New page'
]

{ #category : #wikiPages }
PePharoWiki class >> wikiPageCSV [
	"This method was automatically generated."
	<wikiPage: 'CSV'>
	^APWikiPage
		wiki: self
		name: 'CSV'
		text: 
'!Cookbook
NB. The following all use NeoCSV unless otherwise indicated.

Let''s use GnuCash CSV transaction export files as an example to illustrate two scenarios reequiring a little creativity...
!!Rows Depending on Other Rows
Each transaction is represented by a transaction row is followed by one or more "split" rows, which are actually part of the initial transaction. This makes ==#upToEnd== and even ==#collect:== insufficient. ==#inject:into:== can help here.
!!Rows Representing Multiple Objects
The situation is even slightly more complicated, because each row starts with columns representing the overall transaction, and ends with rows representing a relevant split. Thus the first row is actually a transaction ''''and'''' its first split.

The following script shows an example handling both of these issues:

[[[
	^ rows
		inject: OrderedCollection new
		into: [ :col :rowDict | 
			| newTransaction split recordedTransaction |
			newTransaction := VsTransaction fromGnuCashCSV: rowDict.
			split := VsSplit fromGnuCashCSV: rowDict.
			recordedTransaction := newTransaction isValid
				ifTrue: [ col add: newTransaction ]
				ifFalse: [ col last ].
			recordedTransaction splits add: split.
			col ]
]]]
!NeoCSV
For the basics, start with the *paper>https://github.com/svenvc/docs/blob/master/neo/neo-csv-paper.md*.

Over the course of much practical use, a few common situations have arisen...
!!Intermediary Objects - More expressive than arrays, and cheaper than creating a class
Ideally, you parse directly to domain objects, but there are situations when this will not work. For example, when a record represents multiple objects, or certain columns (e.g. ''''account name'''' and ''''account ID'''') must be combined into one object field (e.g. ''''account''''). In cases like these, when you don''t want to bother creating a class ''just'' to represent a record, you can send ${method:NeoCSVReader>>#namedColumnsConfiguration}$ to your reader. Instead of plain arrays, this will return dictionary records where each value is keyed by the column header.'
]

{ #category : #wikiPages }
PePharoWiki class >> wikiPageCode_Changes [
	"This method was automatically generated."
	<wikiPage: 'Code Changes'>
	^APWikiPage
		wiki: self
		name: 'Code Changes'
		text: 
'!Epicea
This is Pharo''s code change tracking system. There are two common use cases for which *PharoEnhancements>https://github.com/seandenigris/Pharo-Enhancements* adds extensions:
- ${method:EpCodeChange class>>#allSourceCodeMatching:|label=Source code substring matching}$
- ${method:EpCodeChange class>>#allAffectingPackagesNamed:|label=Package(s) matching}$'
]

{ #category : #wikiPages }
PePharoWiki class >> wikiPageContinuous_Integration [
	"This method was automatically generated."
	<wikiPage: 'Continuous Integration'>
	^APWikiPage
		wiki: self
		name: 'Continuous Integration'
		text: 
'- Speeding things up: *git partial checkout>https://medium.com/pinterest-engineering/how-a-one-line-change-decreased-our-build-times-by-99-b98453265370*'
]

{ #category : #wikiPages }
PePharoWiki class >> wikiPageCookbook_2 [
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
]]]
!Replacing Strings with Real Objects
A good way to start may be to search for implementors of the accessor. In this example, we search for implementors of ==macAddress==. For each relevant method:
[[[
objs := self methodClass allSubInstances select: [ :e | e macAddress isNotNil ].
objs collect: [ :e | 
	| newMac |
	newMac := CwMAC_Address fromString: e macAddress.
	{ e macAddress. newMac } ]. "Compare current values with replacements"
objs do: [ :e | 
	| newMac |
	newMac := CwMAC_Address fromString: e macAddress.
	e macAddress: newMac ]
]]]
Notice
!SortFunctions
This is a cool addition to Pharo, but more than allowing terse, elegant code, it has an important benefit over block-based sorting: clean serialization. Serialization libraries like Fuel and STON are generally brittle when serializing blocks, and, according to STON creator Sven, block serialization is impossible to handle generally. For examples, see ${class:SortFunctionTest}$'
]

{ #category : #wikiPages }
PePharoWiki class >> wikiPageData_Import_and_Export [
	"This method was automatically generated."
	<wikiPage: 'Data Import and Export'>
	^APWikiPage
		wiki: self
		name: 'Data Import and Export'
		text: 
'! Sanitizing Input
When importing a large amount of data, inconsistencies (e.g. due to manual error) are common. For instance, "all" names are stored as "last name, first name" except that some omit the comma, some are "first name last name", etc. Rather than trying to extend parsers and other input processing machinery to handle every case, it may be easier to map and fix the anomalies first. For example:
[[[language=smalltalk
cleanNameInput: aString
	| map |
	map := { 
		''Smiiiiith, John'' -> ''Smith, John''. "Last name misspelled"
		''Doe Jr., Jane'' -> ''Doe, Jane Jr.''. "generational in a weird place"
	} asDictionary.
	^ map at: aString ifPresent: [ :v | v ] ifAbsent: [ aString ]
]]]

For PetitParser, ==#parse:withContext:== seems to be a good sanitation hook:
[[[language=plain
MyParser >> #parse: aString withContext: context
	| cleanInput |
	cleanInput := self cleanInput: aString.
	^ super parse: cleanInput withContext: context.
]]]
!SortedCollection Workaround
Block issues can manifest when materializing ==SortedCollection==s with sort blocks, as *reported on the dev list>http://forum.world.st/STON-SortedCollection-Bug-tt4967138.html*. 

To avoid this completely without modifying domain objects, you can usually use a ${class:SortFunction}$. 

Another option is to put camparison behavior to the collection''s elements:
1. Use the default sorting behavior (i.e. `#<=`), which means `#sortBlock` will be nil.
2. Implement `#<=` on the domain object elements.
!STON
IMHO the main difference with Fuel is that you trade efficiency (plain text vs. binary) for flexibility (portable to Amber, human-readable). 
[[[language=smalltalk
"Serialize"
FileLocator home / ''my_file.ston'' writeStreamDo: [ :s | STON put: myData onStream: s ].
"Re-materialize"
FileLocator home / ''my_file.ston'' readStreamDo: [ :s | STON fromStream: s ].
]]]
!!Blocks
Sven offered this on Discord on 12/01/2020...
This is a recurring question. BlockClosures are way too general and powerful to be serialised. That is why serialising BlockClosures is not supported in STON. The code inside a block can refer to and even affect state outside the block. Furthermore the return operator is quite special as it returns from some outer context. A subset of BlockClosures are those that are clean. These do not close over other variables, nor do they contain a return. By using their source code representation, it is possible to serialise/materialise them. You can try this by adding the following methods: 
BlockClosure>>#stonOn: stonWriter
 self isClean
   ifTrue: [ stonWriter writeObject: self listSingleton: self printString ]
   ifFalse: [ stonWriter error: ''Only clean blocks can be serialized'' ]

BlockClosure>>#stonContainSubObjects
 ^ false

BlockClosure class>>#fromSton: stonReader
 ^ self compilerClass new 
     source: stonReader parseListSingleton; 
     evaluate
     
With these additions you can do the following: 
[[[
 STON fromString: (STON toString: [ :x :y | x + y ]).
]]]
Note that the actual class name depends on the Pharo version (BlockClosure in Pharo 7, FullBlockClosure in Pharo 9 and maybe soon CleanBlockClosure - Marcus is working on that last one and that would be very cool because it would say exactly what it it). I am still not 100% convinced to add this as a standard feature to STON. Using source code fully exposes the implementation, while using the compiler can be dangerous. It also adds a dependency on source code and the compiler. But it would be good if people can experiment with this feature.'
]

{ #category : #wikiPages }
PePharoWiki class >> wikiPageDatabases [
	"This method was automatically generated."
	<wikiPage: 'Databases'>
	^APWikiPage
		wiki: self
		name: 'Databases'
		text: 
'!!File-Base
- SQLite
	- [The SQLite3 API is very well documented, and the UDBC-SQLite3 project (https://github.com/astares/Pharo-UDBC) is a nice and clean binding to it.](http://forum.world.st/Re-Pharo-users-Digest-Vol-77-Issue-67-tp5104319.html)
  
	- https://github.com/juliendelplanque/SQLite3. Here''s a usage example [gist](https://gist.github.com/seandenigris/c5b2d2b025b255be1c70a2ace42e19ed).

- Unqlite via punqlite
- PostgreSQL - sven wrote a PostgreSQL wire protocol implementation called P3
- Any SQL DB via UDBC/Garage (e.g. the above, MySQL)



> Let''s not forget Gemstone, which is commercial, but free for some limited use. It has all advantages of OOP and Smalltalk, no ORM problems. You can write prepared queries in Smalltalk on Gemstone DB side, which can be optimized (to avoid large memory consumption on client side in Pharo). There is a tool GTConnector? for Pharo which looked nice in presentation. We used Gemstone in my previous job and it was most stable component of entire stack I believe. - David Bajger via Discord #learning-help 10/8/2017



> For traditional multi-user ORM + SQL database I''d look at P3 from Sven for Postgres with GLORP… And I would probably generate GLORP descriptors from Magritte by default - Stephan Eggermont via Discord #learning-help 10/8/2017
!!Glorp
> Glorp which is an ORM works over some of these. Voyage is an OO persistence API whose main backend is mongodb, although i think there is at least one other. - Pierce Ng via Discord #learning-help 10/8/2017
- Schema migration - *per Esteban Marg>http://forum.world.st/Deep-QCMagritte-tutorial-tp4744612p4744943.html*, there is support in VW that could potentially be ported to Pharo'
]

{ #category : #wikiPages }
PePharoWiki class >> wikiPageDebugging [
	"This method was automatically generated."
	<wikiPage: 'Debugging'>
	^APWikiPage
		wiki: self
		name: 'Debugging'
		text: 
'!Infinite Recursion
If your image locks up do to an endless loop, you have two options:
- you can go get a cup of coffee while waiting for the image to run out of memory and crash, or
- you can send ==SIGUSR1== to the VM process as recommended by Guillermo Polito *on the dev ML>http://forum.world.st/breaking-infinite-loop-from-saved-image-tp4832548p4832584.html*. For example, in Mac Terminal, you could do: ==kill -USR1 $pid==
!Memory Hogging
If the VM was compiled with -g you can run the VM under valgrind with callgrind_annotate to get a tree of instructions spent by vm functions (per Hernand via Pharo Discord #vm channel on 5/12/2021):

[[[language=shell
valgrind --tool=callgrind ./pharo Pharo.image
callgrind_annotate callgrind.out.PID --inclusive=yes --tree=both
]]]'
]

{ #category : #wikiPages }
PePharoWiki class >> wikiPageDecimal_Numbers [
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
PePharoWiki class >> wikiPageDeprecating [
	"This method was automatically generated."
	<wikiPage: #Deprecating>
	^APWikiPage
		wiki: self
		name: #Deprecating
		text: 
'!Deprecating
When writing non-backward-compatible code, allow your users to upgrade seamlessly with just a bit of extra care. Leave deprecated methods around for a release, annotated with one of these auto-transforming deprecation message variants:
- The simplest is ${method:Object>>#deprecated:transformWith:}$
- If you want to add metainfo like timestamp and project version, there is ${method:Object>>#deprecated:on:in:transformWith:}$
-The next two are variants of the first two that let you specify a matching condition to avoid false positives:
    - ${method:Object>>#deprecated:on:in:transformWith:when:}$
    - ${method:Object>>#deprecated:transformWith:when:}$
Browsing senders usually provides easily adaptable examples of the somewhat-obscure rewriting syntax, which are fairly uniform for this use case.

The first time your deprecated method is run, it will be automatically rewritten in your new API. The transformation is specified with ${wikiPage:#RewriteRules}$. For relevant examples, browse the senders of the above messages.'
]

{ #category : #wikiPages }
PePharoWiki class >> wikiPageDesignPatternsSmalltalkCompanion [
	"This method was automatically generated."
	<wikiPage: #DesignPatternsSmalltalkCompanion>
	^APWikiPage
		wiki: self
		name: #DesignPatternsSmalltalkCompanion
		text: 
'!DesignPatternsSmalltalkCompanion'
]

{ #category : #wikiPages }
PePharoWiki class >> wikiPageDocumentation [
	"This method was automatically generated."
	<wikiPage: 'Documentation'>
	^APWikiPage
		wiki: self
		name: 'Documentation'
		text: 
'!Theory
*Here>https://documentation.divio.com* is a really interesting system to split up documentation based on the target audience and their current objective.
!Protocol
!!In Image
We''d like to have information flow down from one common starting point. 

GT uses the BaselineOf comment for this. The problem is that a single comment is a bit limiting. TAPWiki is more flexible because one can have unlimited pages. Maybe a convention could be to add a wiki tab to the baseline, packaged with the model not to add dependencies to the baseline.

Package comments can be helpful, but seem like an optional level e.g. does a test package really need a comment?

Class comments are the next level.

Method comment are tricky. Now that there are rich, multimedia comments at every other level, methods seem like the least alluring place to add comments.
!!External
Ideally, everything in this category would be exported from something live in image, with a disclaimer as to what''s being lost and a link to see the real thing. Pharo-Preferences has ${method:BaselineOf class>>#markdownComment}$ for this purpose.'
]

{ #category : #wikiPages }
PePharoWiki class >> wikiPageDynabook [
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
PePharoWiki class >> wikiPageExternalProcesses [
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
PePharoWiki class >> wikiPageFullBlockClosure [
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
PePharoWiki class >> wikiPageGit [
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

[[[language=shell
git fetch origin master
git rebase origin/master
git push origin master
]]]
But, if you''re more comfortable in Iceberg, you can:
1. Drop to the command line and: ==git rebase origin/master== (assuming the remote is named ==origin==)
2. Get Iceberg to realize it''s out of sync with the local file repo. One way is to bring up the context menu on the project and then "Extra" -> "Recalculate dirty packages".
3. Repair repository - choose to discard image changes (don''t worry we''re not really going to do that). When the preview dialog comes up, select "DO NOT CHECKOUT..." from the dropdown. This will make sure that nothing in the image is changed except Iceberg and the local file repo will be in sync again.
!!!Conflicts
Here you''ll follow the Iceberg instructions for "No Conflicts", but with the following modifications:
# Choose, "Checkout packages already loaded"
# At the end, go into Epicea and revert the in image code changes that wipes out your changes

Alternatively, you could follow the git script for ""No Conflicts"" and then manually resolve the conflict on the command line.
!!Syncing a Fork (e.g. on GitHub)
If your personal fork is behind the canonical, from *GitHub docs>https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/syncing-a-fork* (assumes fork remote is named ==origin==, canonical is ==upstream==, and we want to sync the ==master== branch):
1. If needed, add remote(s) e.g. ==git remote add upstream git@github.com:magritte-metamodel/magritte.git==
1. ==git fetch upstream==
1. ==git merge upstream/master==
1. ==git push origin master==
!!Working on Multiple Features of the Same Project in the Same Image
Scenario: While working on a feature branch that I''ve made commits to, I want to commit a fix that''s part of an unrelated feature.
Solution: Here''s how to submit "just the second fix". NB: for *every* checkout described below, select ==DO NOT CHECKOUT ANY PACKAGES== in the preview window:
1. Checkout the commit on the first issue branch just before work began (i.e. the commit that''s already part of the repo)
2. Repair detached HEAD state by creating a "new branch from image commit" for the second feature
3. Commit second feature fix
4. Checkout the first feature branch. Remember that the second feature fix will now show as uncommitted, so if you want the second fix to remain loaded, when you make further commits to the first feature you''ll need to uncheck those changes. 
5. As needed, switch between feature branches to make additional commits to either feature.
!Declare Smalltalk
Does GitHub think you''re project is 80% HTML? Want to proudly proclaim that it is in fact Smalltalk?
Create a ==.gitattributes== file in the root folder with the following contents: ==*.st linguist-language=Smalltalk=='
]

{ #category : #wikiPages }
PePharoWiki class >> wikiPageLauncher [
	"This method was automatically generated."
	<wikiPage: 'Launcher'>
	^APWikiPage
		wiki: self
		name: 'Launcher'
		text: 
'!Add Template Example (*Hack*)
[[[language=smalltalk
officialGroup := PharoLauncher new templateRepository roots detect: [ :e | e name = ''Official distributions'' ].
officialGroup templatesAndGroups add: (self last copy 
	setName: ''GToolkit'' url: ''https://github.com/feenkcom/gtoolkit/releases/latest/download/GT.zip'' asUrl;
	yourself)
]]]
!Bug: Unzipping recent GToolkit ==gt-extra== folders
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
PePharoWiki class >> wikiPageMemoryHogs [
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
PePharoWiki class >> wikiPageMetacello [
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
!Trimming Load from General to Specific
It is helpful to have the spec for the latest version of Pharo be crystal clear and concise. The tradeoff is that the spec for older platforms gets more complex, but that''s much better than the reverse! However, how do you handle the case of features that were not available on older platforms (e.g. GT wasn''t available on early Pharo versions)? You''d like to say "for P9, do this; but for P8, do the same as for P9 except..." To handle cases like these, *Dale Hendrich expliains>https://groups.google.com/g/metacello/c/5ZGMm2yyx1w/m/ZG7OPOh3AQAJ*: "There are a handful of remove* methods available. See MetacelloAbstractVersionConstructor, `api` category, for the list of methods that can be used in a spec. ConfigurationOfMetacello happens to use all three remove* methods, since Metacello was undergoing significant changes during the early years." Here''s an example:
[[[language=smalltalk
spec
  for: #( #pharo4.x )
  do: [
    spec removePackage: ''Magritte-GT'' ]
]]]
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
PePharoWiki class >> wikiPageMoney [
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
The only thing everyone seems to agree on is ''''not'''' to use Floats. Many advocate ${class:ScaledDecimal}$, but Chris Cunningham points out in several places that the scale is only for display, and precision beyond that scale is kept and used, resulting in potentially surprising results which are inappropriate for money. *He explains>http://forum.world.st/Pharo-dev-Monetary-package-tp4692670p4692890.html*: "''''In general, [this is] NOT what you want when dealing with Money - if you have an amount, it is a definite amount, and not an approximate amount.  (With the possible exceptions of interim results - but for those, you probably need strict control over exactly how precise the interim results are - which isn''t readily available in ScaleDecimal).  This is the main reason I built the FixedDecimal package on SqueakSource.''''" There is also advice to use a "Binary Coded Decimal" for money. See ${wikiPage:Decimal_Numbers}$ for (much) more (gory) detail.
!Instance creation
One problem is that if one uses Pharo''s built in number literals, a float is created and the game is over before it has begun. For example, ==1.11 asScaledDecimal== has already introduced imprecision, but ==ScaledDecimal readFrom: ''1.11''== has not. Thus, I''m not clear about e.g. Aconcagua''s ==1 dollars==, which would seem to have the same problem as the first approach above. The following line from the Aconcagua paper [1] lead me down a rabbit hole which I''ve finally climbed out of after much research and thought:

   fc := 100 dollars * (1 + (0.1/1 year * 6 month)).

The problem is that everything I''ve read about money says "don''t use floats". It seems in order to use a class like ScaledDecimal or FixedDecimal to preserve precision, one must convert directly from a string e.g. do `ScaledDecimal readFrom: aString`. However, IIUC, using a message like `#dollars`, especially in the way demonstrated on a literal, means that except in a small subset of simple cases, you''ve already lost the precision, so an amount with a relatively simple fraction representation e.g. 59.99 = 5999/100, when converted to a ScaledDecimal, becomes 8442841926436127/140737488355328.

What am I missing? Can Aconcagua really be used in the way described above and in the paper, or was that just a “cool” demonstration (you gotta love “100 dollars” for intention revealing!) that is not necessarily practical in the real world?

1. http://sdmeta.gforge.inria.fr/Teaching/CoursAnnecy/0506-M1-COO/aconcagua-p292-wilkinson.pdf'
]

{ #category : #wikiPages }
PePharoWiki class >> wikiPageNetworking [
	"This method was automatically generated."
	<wikiPage: 'Networking'>
	^APWikiPage
		wiki: self
		name: 'Networking'
		text: 
'Deep into Pharo has a great Sockets chapter covering TCP.
!UDP
UDP seems to be pretty simple. Once you create a new socket, there are ''''sending'''' messages which take the data, ipAddress, and port. It seems you can also set the ipAddress and port once and then just push data to that destination.
!!Receiving
Here is an example of receiving data by Norbert Hartl *via Pharo Dev>http://forum.world.st/UDP-Listener-example-tp4362851p4363140.html*:
[[[
| localPort sourceAddress sourcePort buffer receivedBytes socket delay | 
localPort := 5000. 
sourceAddress := NetNameResolver addressFromString: ''255.255.255.255''. 
sourcePort := 4848. 

buffer := ByteArray new: 1000. 
delay := Delay forMilliseconds: 50. 

socket := Socket newUDP setPort: localPort. 
[[ receivedBytes := socket receiveDataInto: buffer fromHost: sourceAddress port: sourcePort. 
 receivedBytes isZero ] whileTrue: [ delay wait ]] 
        ensure: [ socket closeAndDestroy]. 
]]]
Two notes:
# The orignal used NetNameResolver, which is unnecessary if you''re using ipAddress strings instead of hostnames.
2. Norbert also commented: ''''Or you are better off testing it by using #receiveDataInto: instead of #receiveDataInto:fromHost:port: ''''
!!Sending
Here is a (possibly working) example of sending data by Steph Ducasse *via Pharo Dev>http://forum.world.st/SysLogSender-UDP-tp4745862.html*:
[[[
"Send formatted UDP message to host and port." 

        | sock | 
        sock := Socket newUDP. 
        sock setPeer: NetNameResolver localHostAddress port: 514. 
        sock sendData: ''hi''. 
        sock waitForSendDoneFor: Socket standardTimeout. 
        sock close 
]]]'
]

{ #category : #wikiPages }
PePharoWiki class >> wikiPageOOP [
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
PePharoWiki class >> wikiPageOSSubprocess [
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
PePharoWiki class >> wikiPageParsing [
	"This method was automatically generated."
	<wikiPage: #Parsing>
	^APWikiPage
		wiki: self
		name: #Parsing
		text: 
'What interests me is how to handle parsing in a generic way. How can we handle format input/output in a way that minimizes duplication and maximizes compatibility between libraries. If I define RTF grammar once, I don''t want to do it three more times to try out the four major parsing libraries. If I define the parsing in one direction, how much of that can be reused to reverse?
!PEG Grammars
There are apparently at least to syntaxes: the original - and more common - Byran Ford syntax, and Xtreams syntax.
!!Converting e.g. ABNF (e.g. from rfc) to PEG
I described my experience on Pharo Users, both documenting the twists and turns *here>http://forum.world.st/Xtreams-Extending-Bootstrap-tp4902579.html) as well as some more general useful lessons* *here>http://forum.world.st/Xtreams-Debugging-Grammars-tp4902581p4903438.html*:
> Two problems I found copy/pasting grammars from standard docs: 
> - Repititions (*) were prefix instead of postfix 
> - "\" had to be escaped to "\\" 

> I still wonder about debugging techniques, though. If one was building a grammar from scratch, it might be easy to start with blocks that are constantly working, but the grammar in RFC 5322 is very interwoven. It''s hard to see which rules are necessary up front.
!Available Options
!!PetitParser(2)
PetitParser was redesigned by Jan Kurs. Tudor Girba wrote *this thorough explanatory blog post>http://www.humane-assessment.com/blog/introducing-petitparser2/*. In summary:
- Optimization offers 2-5 time speed increase
- ==#asParser== -> ==#asPParser== so both lib versions can be loaded simultaneously. Per Tudor: "This transition is needed for parsers that rely on deeper constructs from the original PetitParser, such as concrete names of classes."
- More understandable because Parsers have been split into Nodes and Visitors.
- Streams eliminate need to have entire input in memory.
!!SmaCC
!!!Docs
  - *Website>http://www.refactoryworkers.com/SmaCC/ASTs.html*
  - *Swiki entry>http://wiki.squeak.org/squeak/3117*
  - *Antlr C\++ grammar>https://github.com/antlr/grammars-v4/blob/master/cpp/CPP14Lexer.g4* - how was this converted to SmaCC?
 !!!Repos
  - *Pharo port>https://github.com/SmaCCRefactoring/SmaCC*
  
!!Xtreams
VW Library ported to Pharo
- Repos
  - http://www.squeaksource.com/Xtreams, from which the Pharo 4 Config Browser loads
  - https://github.com/seandenigris/Xtreams-Pharo, which is a port of the above to GH, with some additional experiments/improvements/documentation
  - https://github.com/mkobetic/Xtreams
  - http://smalltalkhub.com/#!/~juampi/Xtreams/, which claims to be porting Xtreams to "Pharo 6". [Per Juan Pablo Sandoval](http://forum.world.st/Xtreams-Which-Repository-tp4887888p4887923.html):
> I am working on the repository #2, ~juampi/Xtreams.  It is a temporal fork from the repo #1. 

> At the moment, I was playing with the configuration of Xtreams to avoid the warnings and/or errors during the load on Pharo5. I think it is ok now for Pharo5. 

> The next steps are: 
> - Updating the code of the repo to latest code in VW. I did my first attempt, but as I am not a Xtreams/VW expert, it is taking more time than I expected. BTW, any suggestion for this step would be appreciated.
> - Improving the API of Xtreams.
  - PEGActor example available *per Chris Cunningham>http://forum.world.st/Xtreams-PEGParser-now-has-a-working-PEGActor-subclass-td4925586.html*
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
PePharoWiki class >> wikiPagePersistence [
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
PePharoWiki class >> wikiPagePillar [
	"This method was automatically generated."
	<wikiPage: #Pillar>
	^APWikiPage
		wiki: self
		name: #Pillar
		text: 
'*Pillar>https://github.com/pillar-markup/pillar-documentation* is a text document model with associated markup syntax. Its primary reason for existence is to have total control, with the usual caveat that some features (e.g. footnotes) may be missing or limited compared to mainstream external libraries. This is described at length *here>http://forum.world.st/why-Pillar-td4868487.html*. See *the documentation>https://ci.inria.fr/pharo-contribution/job/EnterprisePharoBook/lastSuccessfulBuild/artifact/book-result/PillarChap/Pillar.html* for more info.
!Annotations
- Parameters - available defined in class-side ==possibleParameters== (e.g. ${method:PRCitationAnnotation class>>#possibleParameters}$
${example:GtCoderExamples>>#scripter|label=''hi there''}$'
]

{ #category : #wikiPages }
PePharoWiki class >> wikiPageRefactoring [
	"This method was automatically generated."
	<wikiPage: 'Refactoring'>
	^APWikiPage
		wiki: self
		name: 'Refactoring'
		text: 
'!Common Scenarios
- *Scoping>https://gist.github.com/gcotelli/8a6afbbd04809f79aa6fff25674458db*
- *Statements, Adding>http://forum.world.st/Adding-a-statement-when-rewriting-td4668879.html*
- Syntax via *refactory.com>https://refactory.com/rewrite-tool/* (includes images, but code poorly formatted) or *U Illinois CS via wayback>https://web.archive.org/web/20150611033245/http://st-www.cs.illinois.edu/users/brant/Refactory/Rewrite.html* (no images, but code formatted better)
- ML Posts
  - *http://forum.world.st/RB-API-td3781019.html*
  - *http://forum.world.st/Classes-referenced-in-code-string-td4244214.html*
  - *http://forum.world.st/Adding-a-statement-programmatically-tp4454447p4459879.html*

- I found *http://www.refactory.com/tools/refactoring-browser/rewrite-tool* to be quite helpful re the basics. 

- ==look in the notes folder inside the ParseTreeRewriter chapter on github.== *per Steph>http://forum.world.st/Rewrite-rules-doc-tp4775759p4775928.html*
 - *https://ci.inria.fr/pharo-contribution/job/PharoForTheEnterprise/lastSuccessfulBuild/artifact/RewriteTool/RewriteTool.pier.pdf*
- *http://st-www.cs.illinois.edu/users/brant/Refactory/Lint.html via wayback>https://web.archive.org/web/20150611033230/http://st-www.cs.illinois.edu/users/brant/Refactory/Lint.html*
- *http://www.lukas-renggli.ch/blog/ob-rb-3*
- *http://www.lukas-renggli.ch/blog/ignoring-lint-rules*
!Change the class of an instance
""use with caution"": ==MyClass #adoptInstance: anObject== (thanks to Charles Monteiro via Pharo Discord)
!Deprecating Classes
Here''s an example script to rename all the classes in a hierarchy.

[[[
col := MADescriptionMorph allSubclasses.
col do: [ :e |
	oldClassName := e name.
	stem := (oldClassName allButFirst: 2) allButLast: ''Morph'' size.
	newClassName := ''MAMorphic'', stem.
	r := RBRenameClassRefactoring rename: e to: newClassName.
	r execute.
	newClassName asClass subclass: oldClassName
		instanceVariableNames: ''''
		classVariableNames: ''''
		package: ''Magritte-Deprecated3dot7'' ]
]]]

To tell Pharo the Deprecated package is... deprecated, define the following:
[[[
ManifestMagritteDeprecateddot class>>#isDeprecated
	^ true
]]]
!Previewing Changes
To analyze changes without actually applying them, send ==primitiveExecute== instead of ==execute==. GT allows one to easily previewing changes. First generation GT had a primitive Inspector view for viewing, but now provides a Coder-like tree where you can actually cherry pick individual or groups of changes. Adapted from Tudor Girba (via *Twitter>https://twitter.com/girba/status/1376526271929315332?s=20*):
[[[
env := RBNamespace new.
candidates := Smalltalk globals allClasses select: [ :e | e name beginsWith: ''Pe'' ].
(candidates copyFrom: 2 to: 3) do: [ :cls | (RBRenameClassRefactoring model: env rename: cls to: (cls name, ''New'')) primitiveExecute ].
env
]]]
!Semantic Analysis
Which classes are referenced in this source code?
[[[language=smalltalk
source := ''Object new. String new''.
ast := RBParser parseExpression: source. 
ast annotateInClass: UndefinedObject. 
(ast allChildren 
 select: [ :each | each isVariable and: [ each variableBinding isLiteralBinding ] ]) 
     collect: [ :each | each variableBinding binding value ].

   "--> an OrderedCollection(Object String)" 
]]]'
]

{ #category : #wikiPages }
PePharoWiki class >> wikiPageRewriteRules [
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
- *http://forum.world.st/Adding-a-statement-programmatically-tp4454447p4459879.html*
!!Examples
Replace all calls to ==#deprecated:== to ==#deprecated:on:in:== (to fix Pharo Issue 4718):
[[[language=smalltalk
        RBParseTreeRewriter new
                replace: ''``@object deprecated: ``@arg1 ''
                with: ''``@object deprecated: ``@arg1 on:('''''', dateString,  '''''') in:(''''Pharo'', versionNumber asString, '''''')''.
]]]'
]

{ #category : #wikiPages }
PePharoWiki class >> wikiPageSound [
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
PePharoWiki class >> wikiPageStrategyPattern [
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
PePharoWiki class >> wikiPageTesting_Examples [
	"This method was automatically generated."
	<wikiPage: 'Testing_Examples'>
	^APWikiPage
		wiki: self
		name: 'Testing_Examples'
		text: 
'!Object state
==StateSpecs== is a wonderful state specification library. It is hosted *on GH>https://github.com/dionisiydk/StateSpecs* and *the README>https://github.com/dionisiydk/StateSpecs#readme* gives quite a nice overview.

The main access point is ${method:Object>>#should}$.  ${class:SpecOfShouldExpression}$ is the internal workhorse where you can see all the built-in message you can send after ==should==.

To add your own class-specific messages,  subclass ${class:SpecOfShouldExpression}$ and redefine ${method:Object>>#should}$ to use your subclass. The one caveat is that it seems if you send ${method:SpecOfShouldExpression class>>#startingAt:}$, the global pragma/object setting described in ${class:SpecOfShouldExpression|show=#gtCoderCommentsFor:|label=''the class commen''}$ will prevent your subclass from being used. To work around this, just skip that message and define your message thusly:
[[[
MyDomainObject>>#should
	^ MyCustomShouldSpec new
		receiver: self;
		yourself
]]]
!Mocking
*https://github.com/dionisiydk/Mocketry*'
]

{ #category : #wikiPages }
PePharoWiki class >> wikiPageTime_Control [
	"This method was automatically generated."
	<wikiPage: #Time_Control>
	^APWikiPage
		wiki: self
		name: #Time_Control
		text: 
'!Time Control
- *http://www.manfred-lange.com/publications/TimeTravel.pdf*. There are *apparently>http://forum.world.st/Smalltalk-float-to-currency-how-to-tp86320p86334.html* other versions available.
- It came up in *a tangentially related discussion>http://forum.world.st/Smalltalk-float-to-currency-how-to-td86320i20.html#a86336* on the Seaside list'
]

{ #category : #wikiPages }
PePharoWiki class >> wikiPageTodo [
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
PePharoWiki class >> wikiPageTraits [
	"This method was automatically generated."
	<wikiPage: 'Traits'>
	^APWikiPage
		wiki: self
		name: 'Traits'
		text: 
'There is *great documentation in the Pharo Wiki>https://github.com/pharo-open-documentation/pharo-wiki/blob/master/General/Traits.md#create-and-use-a-new-trait*
!Gotchas
!!Super
!!!From clients
We might naively assume that we can can use ==super== to access and extend trait behavior. Something like:
[[[
ClassInheritingFromObjectAndUsingTrait>>#message
	self doSomething.
	super message.
]]] 
This does not work, and thinking further it becomes clear that ==super== already has a universal meaning (it is bound to ==Object== in the example above), and doesn''t change in the context of clients.

The solution is to alias the method when importing the Trait e.g. ==uses: TMyTrait @ {#myTraitMessage->#message}==. The above then becomes:
[[[
ClassInheritingFromObjectAndUsingTrait>>#message
	self doSomething.
	self myTraitMessage.
]]] 
!!!From Traits
What''s less clear is why this doesn''t work:
[[[
Trait>>#method
	self doSomething.
	super method.
]]] 
Even if the trait is installed in a class where ==super== responds to the message, an error will occur.

Here is an experience report that *I posted on Pharo Dev>http://forum.world.st/Trait-Change-in-Pharo-9-tp5119000.html*, but got no response:

In Pharo 9, the following fails to load: 

Metacello new 
        baseline: ''Magritte''; 
        repository: ''github://seandenigris/Magritte''; 
        load: ''Magritte-Bootstrap''. 

Specifically, this method fails to compile: 
TMagritteBootstrap >> doesNotUnderstand: aMessage 
          
        ^ self magritteDescription 
                        detect: [ :d | d accessor handlesSelector: aMessage selector ] 
                        ifFound: [ :handler | handler handleMessage: aMessage for: self ] 
                        ifNone: [ super doesNotUnderstand: aMessage ]. 

But instead signals that `send: #doesNotUnderstand: toSuperOf: 
TMagritteBootstrap` is “not supported”. There is a comment which is over my 
head: “Trait methods are copied to the users and only the last literal is 
updated. For directed super send the literal of the super send should be 
updated too.” 

I feel like this was working previously and would like to understand why 
it’s not now and how to fix it. '
]

{ #category : #wikiPages }
PePharoWiki class >> wikiPageVM [
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
PePharoWiki class >> wikiPageXML [
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

{ #category : #accessing }
PePharoWiki >> exampleReturningLiteralArray [
	
	^ #(
		"Name" "Aliases"
		'Adam' ('Bubba' 'Tiny')
		'Zed' nil
	)
]
