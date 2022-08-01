Class {
	#name : #PeGtDelegatedSearch,
	#superclass : #Object,
	#instVars : [
		'delegate',
		'message'
	],
	#category : #'PharoEnhancements-GToolkit-Spotter'
}

{ #category : #'magritte-descriptions' }
PeGtDelegatedSearch class >> to: aValuable message: aSymbol [ 

	^ self new
		delegate: aValuable;
		message: aSymbol;
		yourself
]

{ #category : #accessing }
PeGtDelegatedSearch >> delegate [

	^ delegate
]

{ #category : #accessing }
PeGtDelegatedSearch >> delegate: aValuable [

	delegate := aValuable
]

{ #category : #accessing }
PeGtDelegatedSearch >> gtSpotterOn: aStep [
	<gtSearch>
	
	^ self delegate value perform: self message with: aStep
]

{ #category : #accessing }
PeGtDelegatedSearch >> message [

	^ message
]

{ #category : #accessing }
PeGtDelegatedSearch >> message: anObject [

	message := anObject
]
