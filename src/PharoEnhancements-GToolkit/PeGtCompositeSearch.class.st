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
PeGtCompositeSearch >> gtSpotterProcessorsFor: aSpotterStep [
	^ self children flatCollect: [ :c | c gtSpotterProcessorsFor: aSpotterStep ]
]
