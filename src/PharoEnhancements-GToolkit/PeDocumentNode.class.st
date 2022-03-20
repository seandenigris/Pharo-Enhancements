Class {
	#name : #PeDocumentNode,
	#superclass : #PeTomlNode,
	#instVars : [
		'expressions',
		'nLTokens'
	],
	#category : #'PharoEnhancements-GToolkit-TOML'
}

{ #category : #generated }
PeDocumentNode >> acceptVisitor: aTomlVisitor [

	^ aTomlVisitor visitDocument: self
]

{ #category : #generated }
PeDocumentNode >> compositeNodeVariables [

	^ #( #expressions )
]

{ #category : #generated }
PeDocumentNode >> compositeTokenVariables [

	^ #( #nLTokens )
]

{ #category : #generated }
PeDocumentNode >> expressions [

	^ expressions
]

{ #category : #generated }
PeDocumentNode >> expressions: anOrderedCollection [

	self setParents: self expressions to: nil.
	expressions := anOrderedCollection.
	self setParents: self expressions to: self
]

{ #category : #'generated-initialize-release' }
PeDocumentNode >> initialize [
	super initialize.
	expressions := OrderedCollection new: 2.
	nLTokens := OrderedCollection new: 2.
]

{ #category : #generated }
PeDocumentNode >> nLTokens [

	^ nLTokens
]

{ #category : #generated }
PeDocumentNode >> nLTokens: anOrderedCollection [

	nLTokens := anOrderedCollection
]
