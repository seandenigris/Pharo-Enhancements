Class {
	#name : #PeUnquotedKeyNode,
	#superclass : #PeTomlNode,
	#instVars : [
		'uNQUOTED_KEYToken'
	],
	#category : #'PharoEnhancements-GToolkit-TOML'
}

{ #category : #generated }
PeUnquotedKeyNode >> acceptVisitor: aTomlVisitor [

	^ aTomlVisitor visitUnquotedKey: self
]

{ #category : #generated }
PeUnquotedKeyNode >> tokenVariables [

	^ #( #uNQUOTED_KEYToken )
]

{ #category : #generated }
PeUnquotedKeyNode >> uNQUOTED_KEYToken [

	^ uNQUOTED_KEYToken
]

{ #category : #generated }
PeUnquotedKeyNode >> uNQUOTED_KEYToken: aSmaCCToken [

	uNQUOTED_KEYToken := aSmaCCToken
]
