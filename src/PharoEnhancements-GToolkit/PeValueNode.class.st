Class {
	#name : #PeValueNode,
	#superclass : #PeTomlNode,
	#instVars : [
		'leftBraceToken',
		'keies',
		'equalTokens',
		'values',
		'commaTokens',
		'rightBraceToken'
	],
	#category : #'PharoEnhancements-GToolkit-TOML'
}

{ #category : #generated }
PeValueNode >> acceptVisitor: aTomlVisitor [

	^ aTomlVisitor visitValue: self
]

{ #category : #generated }
PeValueNode >> commaTokens [

	^ commaTokens
]

{ #category : #generated }
PeValueNode >> commaTokens: anOrderedCollection [

	commaTokens := anOrderedCollection
]

{ #category : #generated }
PeValueNode >> compositeTokenVariables [

	^ #( #equalTokens #commaTokens )
]

{ #category : #generated }
PeValueNode >> equalTokens [

	^ equalTokens
]

{ #category : #generated }
PeValueNode >> equalTokens: anOrderedCollection [

	equalTokens := anOrderedCollection
]

{ #category : #'generated-initialize-release' }
PeValueNode >> initialize [
	super initialize.
	keies := OrderedCollection new: 2.
	equalTokens := OrderedCollection new: 2.
	values := OrderedCollection new: 2.
	commaTokens := OrderedCollection new: 2.
]

{ #category : #generated }
PeValueNode >> keies [

	^ keies
]

{ #category : #generated }
PeValueNode >> keies: anOrderedCollection [

	self setParent: self keies to: nil.
	keies := anOrderedCollection.
	self setParent: self keies to: self
]

{ #category : #generated }
PeValueNode >> leftBraceToken [

	^ leftBraceToken
]

{ #category : #generated }
PeValueNode >> leftBraceToken: aSmaCCToken [

	leftBraceToken := aSmaCCToken
]

{ #category : #generated }
PeValueNode >> otherVariables [

	^ #( #keies #values )
]

{ #category : #generated }
PeValueNode >> rightBraceToken [

	^ rightBraceToken
]

{ #category : #generated }
PeValueNode >> rightBraceToken: aSmaCCToken [

	rightBraceToken := aSmaCCToken
]

{ #category : #generated }
PeValueNode >> tokenVariables [

	^ #( #leftBraceToken #rightBraceToken )
]

{ #category : #generated }
PeValueNode >> values [

	^ values
]

{ #category : #generated }
PeValueNode >> values: anOrderedCollection [

	self setParent: self values to: nil.
	values := anOrderedCollection.
	self setParent: self values to: self
]
