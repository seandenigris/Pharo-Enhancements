Class {
	#name : #PeGtCompletionStrategy,
	#superclass : #GtStringsCompletionStrategy,
	#instVars : [
		'minimumPrefixLength'
	],
	#category : #'PharoEnhancements-GToolkit-Completion'
}

{ #category : #accessing }
PeGtCompletionStrategy >> completionPrefixAt: anIndex in: blText [
	| startIndex |
	anIndex < self minimumPrefixLength
		ifTrue: [ ^ nil ].
	(anIndex = 0 and: [ self minimumPrefixLength = 0 ])
		ifTrue: [ ^ '' ].
	startIndex := anIndex.
	[ (self isSeparatorCharacter: (blText at: startIndex))
		ifTrue: [ ^ anIndex - startIndex < self minimumPrefixLength
				ifTrue: [ nil ]
				ifFalse: [ (blText copyFrom: startIndex + 1 to: anIndex) asString ] ].
	startIndex := startIndex - 1.
	startIndex >= 1 ] whileTrue.
	^ (blText copyFrom: 1 to: anIndex) asString
]

{ #category : #accessing }
PeGtCompletionStrategy >> minimumPrefixLength [
	"Minimum length of the prefix before the completion popup appears"

	^ minimumPrefixLength ifNil: [ 1 ]
]

{ #category : #accessing }
PeGtCompletionStrategy >> minimumPrefixLength: aNumber [

	minimumPrefixLength := aNumber
]
