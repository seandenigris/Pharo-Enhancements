Class {
	#name : 'PeGtCollectedSearch',
	#superclass : 'Object',
	#instVars : [
		'children'
	],
	#category : 'PharoEnhancements-GToolkit-Spotter',
	#package : 'PharoEnhancements-GToolkit',
	#tag : 'Spotter'
}

{ #category : 'accessing' }
PeGtCollectedSearch >> children [

	^ children ifNil: [ children := OrderedCollection new ]
]

{ #category : 'accessing' }
PeGtCollectedSearch >> children: anObject [

	children := anObject
]

{ #category : 'accessing' }
PeGtCollectedSearch >> childrenAdd: aSource [

	self children add: aSource
]

{ #category : 'accessing' }
PeGtCollectedSearch >> gtSpotterSearchesInContext: aSpotterContext [
	^ self children asAsyncStream flatCollect: [ :c | c gtSpotterSearchesInContext: aSpotterContext ]
]
