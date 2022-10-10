Class {
	#name : #PeGtDeepestSubInstanceFilter,
	#superclass : #GtFilter,
	#instVars : [
		'rootClass'
	],
	#category : #'PharoEnhancements-GToolkit-Spotter'
}

{ #category : #accessing }
PeGtDeepestSubInstanceFilter >> applyInScope: aStream context: aSpotterContext [

	| matchedClass input result |
	input := aSpotterContext searchQuery trimmed.
	result := OrderedCollection new.

	matchedClass := self rootClass peClassForString: input.
	
	matchedClass ifNotNil: [ :cls |
		| newInstances |
		newInstances  := cls gtSpotterItemsFromString: input.
		result addAll: newInstances ].
		
	^ result asAsyncStream
]

{ #category : #accessing }
PeGtDeepestSubInstanceFilter >> rootClass [

	^ rootClass
]

{ #category : #accessing }
PeGtDeepestSubInstanceFilter >> rootClass: anObject [

	rootClass := anObject
]
