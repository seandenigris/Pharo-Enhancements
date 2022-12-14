Class {
	#name : #PeGtInstancesFilter,
	#superclass : #Object,
	#instVars : [
		'rootClass'
	],
	#category : #'PharoEnhancements-GToolkit-Spotter'
}

{ #category : #accessing }
PeGtInstancesFilter >> applyInScope: aStream context: aSpotterContext [

	| canHandle newInstances input |
	input := aSpotterContext searchQuery trimmed.
	canHandle := self rootClass peCanHandleFromString: input.
	canHandle ifFalse: [ ^ { } ].
		
	newInstances  := self rootClass gtSpotterItemsFromString: input.
		
	^ newInstances asAsyncStream
]

{ #category : #accessing }
PeGtInstancesFilter >> rootClass [

	^ rootClass
]

{ #category : #accessing }
PeGtInstancesFilter >> rootClass: anObject [

	rootClass := anObject
]
