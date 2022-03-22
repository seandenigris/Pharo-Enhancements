Class {
	#name : #PeTomlStandardTableNode,
	#superclass : #PeTomlParseNode,
	#instVars : [
		'leftBracketToken',
		'key',
		'rightBracketToken'
	],
	#category : #'PharoEnhancements-GToolkit-TOML'
}

{ #category : #generated }
PeTomlStandardTableNode >> acceptVisitor: aParseVisitor [

	^ aParseVisitor visitStandardTable: self
]

{ #category : #generated }
PeTomlStandardTableNode >> key [

	^ key
]

{ #category : #generated }
PeTomlStandardTableNode >> key: anObject [

	self setParent: self key to: nil.
	key := anObject.
	self setParent: self key to: self
]

{ #category : #generated }
PeTomlStandardTableNode >> leftBracketToken [

	^ leftBracketToken
]

{ #category : #generated }
PeTomlStandardTableNode >> leftBracketToken: aSmaCCToken [

	leftBracketToken := aSmaCCToken
]

{ #category : #generated }
PeTomlStandardTableNode >> otherVariables [

	^ #( #key )
]

{ #category : #generated }
PeTomlStandardTableNode >> rightBracketToken [

	^ rightBracketToken
]

{ #category : #generated }
PeTomlStandardTableNode >> rightBracketToken: aSmaCCToken [

	rightBracketToken := aSmaCCToken
]

{ #category : #generated }
PeTomlStandardTableNode >> tokenVariables [

	^ #( #leftBracketToken #rightBracketToken )
]
