Class {
	#name : #PeKeyValueNode,
	#superclass : #PeTomlNode,
	#instVars : [
		'key',
		'equalToken',
		'value'
	],
	#category : #'PharoEnhancements-GToolkit-TOML'
}

{ #category : #generated }
PeKeyValueNode >> acceptVisitor: aTomlVisitor [

	^ aTomlVisitor visitKeyValue: self
]

{ #category : #generated }
PeKeyValueNode >> equalToken [

	^ equalToken
]

{ #category : #generated }
PeKeyValueNode >> equalToken: aSmaCCToken [

	equalToken := aSmaCCToken
]

{ #category : #generated }
PeKeyValueNode >> key [

	^ key
]

{ #category : #generated }
PeKeyValueNode >> key: anObject [

	self setParent: self key to: nil.
	key := anObject.
	self setParent: self key to: self
]

{ #category : #generated }
PeKeyValueNode >> otherVariables [

	^ #( #key #value )
]

{ #category : #generated }
PeKeyValueNode >> tokenVariables [

	^ #( #equalToken )
]

{ #category : #generated }
PeKeyValueNode >> value [

	^ value
]

{ #category : #generated }
PeKeyValueNode >> value: anObject [

	self setParent: self value to: nil.
	value := anObject.
	self setParent: self value to: self
]
