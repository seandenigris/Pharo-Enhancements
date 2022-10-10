Class {
	#name : #PeGtCompositeSearch,
	#superclass : #Object,
	#instVars : [
		'children'
	],
	#category : #'PharoEnhancements-GToolkit-Spotter'
}

{ #category : #accessing }
PeGtCompositeSearch >> children [

	^ children ifNil: [ children := OrderedCollection new ]
]

{ #category : #accessing }
PeGtCompositeSearch >> children: anObject [

	children := anObject
]

{ #category : #accessing }
PeGtCompositeSearch >> gtSpotterSearchesInContext: aSpotterContext [
	^ self children asAsyncStream flatCollect: [ :c | c gtSpotterSearchesInContext: aSpotterContext ]
]
