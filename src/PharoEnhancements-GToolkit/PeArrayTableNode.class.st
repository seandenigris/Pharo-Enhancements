Class {
	#name : #PeArrayTableNode,
	#superclass : #PeTomlNode,
	#instVars : [
		'leftBracketTokens',
		'key',
		'rightBracketTokens'
	],
	#category : #'PharoEnhancements-GToolkit-TOML'
}

{ #category : #generated }
PeArrayTableNode >> acceptVisitor: aTomlVisitor [

	^ aTomlVisitor visitArrayTable: self
]

{ #category : #generated }
PeArrayTableNode >> compositeTokenVariables [

	^ #( #leftBracketTokens #rightBracketTokens )
]

{ #category : #'generated-initialize-release' }
PeArrayTableNode >> initialize [
	super initialize.
	leftBracketTokens := OrderedCollection new: 2.
	rightBracketTokens := OrderedCollection new: 2.
]

{ #category : #generated }
PeArrayTableNode >> key [

	^ key
]

{ #category : #generated }
PeArrayTableNode >> key: anObject [

	self setParent: self key to: nil.
	key := anObject.
	self setParent: self key to: self
]

{ #category : #generated }
PeArrayTableNode >> leftBracketTokens [

	^ leftBracketTokens
]

{ #category : #generated }
PeArrayTableNode >> leftBracketTokens: anOrderedCollection [

	leftBracketTokens := anOrderedCollection
]

{ #category : #generated }
PeArrayTableNode >> otherVariables [

	^ #( #key )
]

{ #category : #generated }
PeArrayTableNode >> rightBracketTokens [

	^ rightBracketTokens
]

{ #category : #generated }
PeArrayTableNode >> rightBracketTokens: anOrderedCollection [

	rightBracketTokens := anOrderedCollection
]
