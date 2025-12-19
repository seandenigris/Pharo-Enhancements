"
There are three instance side methods subclasses have to implement to handle four page type transitions:
1. `#install` for taking over from another element type
2. `#uninstall` for handing over control to another element type
3. `#reset` for when the new element type is the same, but the model has changed

Subclasses must also implement class-side `#isClassFor:` which takes `anLePageToolContentElement` and answers whether it is the correct wrapper for it.
"
Class {
	#name : 'PeLePageElement',
	#superclass : 'Object',
	#instVars : [
		'contentElement'
	],
	#category : 'PharoEnhancements-GToolkit-Lepiter',
	#package : 'PharoEnhancements-GToolkit',
	#tag : 'Lepiter'
}

{ #category : 'instance creation' }
PeLePageElement class >> on: anLePageToolContentElement [

	| cls |
	cls := self subclasses 
		detect: [ :c | c isClassFor: anLePageToolContentElement ]
		ifNone: [ self ].
	^ cls new
		contentElement: anLePageToolContentElement;
		yourself
]

{ #category : 'accessing' }
PeLePageElement >> contentElement [
	^ contentElement
]

{ #category : 'accessing' }
PeLePageElement >> contentElement: anLePageToolContentElement [
	contentElement := anLePageToolContentElement
]

{ #category : 'accessing' }
PeLePageElement >> onPageViewModelChanged [
	
	| isFromVanillaPageElement isToVanillaPageElement newElementClass newElement |
	newElementClass := self pageType pageElementClass.
	isFromVanillaPageElement := self class = PeLePageElement.
	isToVanillaPageElement := newElementClass = PeLePageElement.
	
	isFromVanillaPageElement 
		ifTrue: [ 
			isToVanillaPageElement ifTrue: [ 
				"From vanilla to vanilla"
				^ self ] ]
		ifFalse: [ 
			"From custom type..."
			self class = newElementClass 
				ifTrue: [ 
					"... to same custom type"
					self reset. 
					^ self ]
				ifFalse: [ 
					"... to another type"
					self uninstall ] ].
	
	isToVanillaPageElement ifTrue: [ ^ self ].
	
	newElement := newElementClass on: self contentElement.
	newElement install
]

{ #category : 'accessing' }
PeLePageElement >> pageType [
	^ self contentElement pageViewModel pageModel type
]

{ #category : 'accessing' }
PeLePageElement >> reset [
	self subclassResponsibility
]

{ #category : 'accessing' }
PeLePageElement >> uninstall [
	self subclassResponsibility
]
