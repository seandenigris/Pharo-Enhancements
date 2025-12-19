Class {
	#name : 'PeGtCompositeSearch',
	#superclass : 'Object',
	#instVars : [
		'children'
	],
	#category : 'PharoEnhancements-GToolkit-Spotter',
	#package : 'PharoEnhancements-GToolkit',
	#tag : 'Spotter'
}

{ #category : 'accessing' }
PeGtCompositeSearch >> children [

	^ children ifNil: [ children := OrderedCollection new ]
]

{ #category : 'accessing' }
PeGtCompositeSearch >> children: anObject [

	children := anObject
]

{ #category : 'accessing' }
PeGtCompositeSearch >> childrenAdd: aSource [

	self children add: aSource
]

{ #category : 'accessing' }
PeGtCompositeSearch >> gtSpotterSearchesInContext: aSpotterContext [
	^ self children asAsyncStream
]
