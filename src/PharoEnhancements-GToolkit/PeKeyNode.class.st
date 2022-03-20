Class {
	#name : #PeKeyNode,
	#superclass : #PeTomlNode,
	#instVars : [
		'bASIC_STRINGTokens',
		'lITERAL_STRINGTokens',
		'uNQUOTED_KEYTokens',
		'periodTokens'
	],
	#category : #'PharoEnhancements-GToolkit-TOML'
}

{ #category : #generated }
PeKeyNode >> acceptVisitor: aTomlVisitor [

	^ aTomlVisitor visitKey: self
]

{ #category : #generated }
PeKeyNode >> bASIC_STRINGTokens [

	^ bASIC_STRINGTokens
]

{ #category : #generated }
PeKeyNode >> bASIC_STRINGTokens: anOrderedCollection [

	bASIC_STRINGTokens := anOrderedCollection
]

{ #category : #generated }
PeKeyNode >> compositeTokenVariables [

	^ #( #bASIC_STRINGTokens #lITERAL_STRINGTokens #uNQUOTED_KEYTokens
	     #periodTokens )
]

{ #category : #'generated-initialize-release' }
PeKeyNode >> initialize [
	super initialize.
	bASIC_STRINGTokens := OrderedCollection new: 2.
	lITERAL_STRINGTokens := OrderedCollection new: 2.
	uNQUOTED_KEYTokens := OrderedCollection new: 2.
	periodTokens := OrderedCollection new: 2.
]

{ #category : #generated }
PeKeyNode >> lITERAL_STRINGTokens [

	^ lITERAL_STRINGTokens
]

{ #category : #generated }
PeKeyNode >> lITERAL_STRINGTokens: anOrderedCollection [

	lITERAL_STRINGTokens := anOrderedCollection
]

{ #category : #generated }
PeKeyNode >> periodTokens [

	^ periodTokens
]

{ #category : #generated }
PeKeyNode >> periodTokens: anOrderedCollection [

	periodTokens := anOrderedCollection
]

{ #category : #generated }
PeKeyNode >> uNQUOTED_KEYTokens [

	^ uNQUOTED_KEYTokens
]

{ #category : #generated }
PeKeyNode >> uNQUOTED_KEYTokens: anOrderedCollection [

	uNQUOTED_KEYTokens := anOrderedCollection
]
