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
