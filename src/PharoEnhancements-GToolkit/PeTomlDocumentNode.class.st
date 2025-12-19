Class {
	#name : 'PeTomlDocumentNode',
	#superclass : 'PeTomlParseNode',
	#instVars : [
		'expressions',
		'nLTokens'
	],
	#category : 'PharoEnhancements-GToolkit-TOML',
	#package : 'PharoEnhancements-GToolkit',
	#tag : 'TOML'
}

{ #category : 'generated' }
PeTomlDocumentNode >> acceptVisitor: aParseVisitor [

	^ aParseVisitor visitDocument: self
]

{ #category : 'generated' }
PeTomlDocumentNode >> compositeNodeVariables [

	^ #( #expressions )
]

{ #category : 'generated' }
PeTomlDocumentNode >> compositeTokenVariables [

	^ #( #nLTokens )
]

{ #category : 'generated' }
PeTomlDocumentNode >> expressions [

	^ expressions
]

{ #category : 'generated' }
PeTomlDocumentNode >> expressions: anOrderedCollection [

	self setParents: self expressions to: nil.
	expressions := anOrderedCollection.
	self setParents: self expressions to: self
]

{ #category : 'generated-initialize-release' }
PeTomlDocumentNode >> initialize [
	super initialize.
	expressions := OrderedCollection new: 2.
	nLTokens := OrderedCollection new: 2.
]

{ #category : 'generated' }
PeTomlDocumentNode >> nLTokens [

	^ nLTokens
]

{ #category : 'generated' }
PeTomlDocumentNode >> nLTokens: anOrderedCollection [

	nLTokens := anOrderedCollection
]
