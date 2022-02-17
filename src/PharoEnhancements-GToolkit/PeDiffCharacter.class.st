Class {
	#name : #PeDiffCharacter,
	#superclass : #Object,
	#instVars : [
		'status',
		'character'
	],
	#category : #'PharoEnhancements-GToolkit'
}

{ #category : #accessing }
PeDiffCharacter >> character [

	^ character
]

{ #category : #accessing }
PeDiffCharacter >> character: anObject [

	character := anObject
]

{ #category : #accessing }
PeDiffCharacter >> isAdded [
	^ self status = $+
]

{ #category : #accessing }
PeDiffCharacter >> isRemoved [
	^ self status = $-
]

{ #category : #accessing }
PeDiffCharacter >> isUnchanged [
	^ self status = Character space
]

{ #category : #accessing }
PeDiffCharacter >> printOn: aStream [
	status ifNotNil: [ aStream nextPut: status ].
	character ifNotNil: [ aStream nextPut: character ]
]

{ #category : #accessing }
PeDiffCharacter >> status [

	^ status
]

{ #category : #accessing }
PeDiffCharacter >> status: anObject [

	status := anObject
]

{ #category : #accessing }
PeDiffCharacter >> textAttributes [
	self isRemoved 
		ifTrue: [ ^ {
			BlTextDecorationAttribute new lineThrough.
    		BlTextHighlightAttribute paint: BrGlamorousColors errorBackgroundColor } ].
	self isAdded
		ifTrue: [ ^ {
			BlFontWeightAttribute bold.
    		BlTextHighlightAttribute paint: BrGlamorousColors class>>#successBackgroundColor } ].
	^ { BlTextForegroundAttribute paint: Color black }
]
