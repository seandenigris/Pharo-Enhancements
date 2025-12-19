Class {
	#name : 'PeTomlArrayTableNode',
	#superclass : 'PeTomlParseNode',
	#instVars : [
		'leftBracketTokens',
		'key',
		'rightBracketTokens'
	],
	#category : 'PharoEnhancements-GToolkit-TOML',
	#package : 'PharoEnhancements-GToolkit',
	#tag : 'TOML'
}

{ #category : 'generated' }
PeTomlArrayTableNode >> acceptVisitor: aParseVisitor [

	^ aParseVisitor visitArrayTable: self
]

{ #category : 'generated' }
PeTomlArrayTableNode >> compositeTokenVariables [

	^ #( #leftBracketTokens #rightBracketTokens )
]

{ #category : 'generated-initialize-release' }
PeTomlArrayTableNode >> initialize [
	super initialize.
	leftBracketTokens := OrderedCollection new: 2.
	rightBracketTokens := OrderedCollection new: 2.
]

{ #category : 'generated' }
PeTomlArrayTableNode >> key [

	^ key
]

{ #category : 'generated' }
PeTomlArrayTableNode >> key: anObject [

	self setParent: self key to: nil.
	key := anObject.
	self setParent: self key to: self
]

{ #category : 'generated' }
PeTomlArrayTableNode >> leftBracketTokens [

	^ leftBracketTokens
]

{ #category : 'generated' }
PeTomlArrayTableNode >> leftBracketTokens: anOrderedCollection [

	leftBracketTokens := anOrderedCollection
]

{ #category : 'generated' }
PeTomlArrayTableNode >> otherVariables [

	^ #( #key )
]

{ #category : 'generated' }
PeTomlArrayTableNode >> rightBracketTokens [

	^ rightBracketTokens
]

{ #category : 'generated' }
PeTomlArrayTableNode >> rightBracketTokens: anOrderedCollection [

	rightBracketTokens := anOrderedCollection
]
