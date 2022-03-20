Class {
	#name : #PeStandardTableNode,
	#superclass : #PeTomlNode,
	#instVars : [
		'leftBracketToken',
		'key',
		'rightBracketToken'
	],
	#category : #'PharoEnhancements-GToolkit-TOML'
}

{ #category : #generated }
PeStandardTableNode >> acceptVisitor: aTomlVisitor [

	^ aTomlVisitor visitStandardTable: self
]

{ #category : #generated }
PeStandardTableNode >> key [

	^ key
]

{ #category : #generated }
PeStandardTableNode >> key: anObject [

	self setParent: self key to: nil.
	key := anObject.
	self setParent: self key to: self
]

{ #category : #generated }
PeStandardTableNode >> leftBracketToken [

	^ leftBracketToken
]

{ #category : #generated }
PeStandardTableNode >> leftBracketToken: aSmaCCToken [

	leftBracketToken := aSmaCCToken
]

{ #category : #generated }
PeStandardTableNode >> otherVariables [

	^ #( #key )
]

{ #category : #generated }
PeStandardTableNode >> rightBracketToken [

	^ rightBracketToken
]

{ #category : #generated }
PeStandardTableNode >> rightBracketToken: aSmaCCToken [

	rightBracketToken := aSmaCCToken
]

{ #category : #generated }
PeStandardTableNode >> tokenVariables [

	^ #( #leftBracketToken #rightBracketToken )
]
