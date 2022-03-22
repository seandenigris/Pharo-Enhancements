Class {
	#name : #PeTomlKeyValueNode,
	#superclass : #PeTomlParseNode,
	#instVars : [
		'key',
		'equalToken',
		'value'
	],
	#category : #'PharoEnhancements-GToolkit-TOML'
}

{ #category : #generated }
PeTomlKeyValueNode >> acceptVisitor: aParseVisitor [

	^ aParseVisitor visitKeyValue: self
]

{ #category : #generated }
PeTomlKeyValueNode >> equalToken [

	^ equalToken
]

{ #category : #generated }
PeTomlKeyValueNode >> equalToken: aSmaCCToken [

	equalToken := aSmaCCToken
]

{ #category : #generated }
PeTomlKeyValueNode >> key [

	^ key
]

{ #category : #generated }
PeTomlKeyValueNode >> key: anObject [

	self setParent: self key to: nil.
	key := anObject.
	self setParent: self key to: self
]

{ #category : #generated }
PeTomlKeyValueNode >> otherVariables [

	^ #( #key #value )
]

{ #category : #generated }
PeTomlKeyValueNode >> tokenVariables [

	^ #( #equalToken )
]

{ #category : #generated }
PeTomlKeyValueNode >> value [

	^ value
]

{ #category : #generated }
PeTomlKeyValueNode >> value: anObject [

	self setParent: self value to: nil.
	value := anObject.
	self setParent: self value to: self
]
