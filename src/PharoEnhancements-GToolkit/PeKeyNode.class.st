Class {
	#name : #PeKeyNode,
	#superclass : #PeTomlNode,
	#instVars : [
		'strings',
		'periodTokens'
	],
	#category : #'PharoEnhancements-GToolkit-TOML'
}

{ #category : #generated }
PeKeyNode >> acceptVisitor: aTomlVisitor [

	^ aTomlVisitor visitKey: self
]

{ #category : #generated }
PeKeyNode >> compositeTokenVariables [

	^ #( #strings #periodTokens )
]

{ #category : #'generated-initialize-release' }
PeKeyNode >> initialize [
	super initialize.
	strings := OrderedCollection new: 2.
	periodTokens := OrderedCollection new: 2.
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
PeKeyNode >> strings [

	^ strings
]

{ #category : #generated }
PeKeyNode >> strings: anOrderedCollection [

	strings := anOrderedCollection
]
