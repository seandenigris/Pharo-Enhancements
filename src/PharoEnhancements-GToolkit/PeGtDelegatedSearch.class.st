Class {
	#name : #PeGtDelegatedSearch,
	#superclass : #Object,
	#instVars : [
		'delegate',
		'message',
		'transform'
	],
	#category : #'PharoEnhancements-GToolkit-Spotter'
}

{ #category : #'magritte-descriptions' }
PeGtDelegatedSearch class >> to: aValuable message: aSymbol [ 

	^ self to: aValuable message: aSymbol transform: nil
]

{ #category : #'magritte-descriptions' }
PeGtDelegatedSearch class >> to: aValuable message: aSymbol transform: sendBlock [

	^ self new
		delegate: aValuable;
		message: aSymbol;
		transform: sendBlock;
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
	
	| search |
	search := self delegate value perform: self message with: aStep.
	self transform ifNotNil: [ :trns | search send: trns ].
	^ search
]

{ #category : #accessing }
PeGtDelegatedSearch >> message [

	^ message
]

{ #category : #accessing }
PeGtDelegatedSearch >> message: anObject [

	message := anObject
]

{ #category : #accessing }
PeGtDelegatedSearch >> transform [
	^ transform
]

{ #category : #accessing }
PeGtDelegatedSearch >> transform: anObject [
	transform := anObject
]
