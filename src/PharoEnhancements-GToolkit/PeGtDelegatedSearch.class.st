Class {
	#name : 'PeGtDelegatedSearch',
	#superclass : 'Object',
	#instVars : [
		'delegate',
		'message',
		'configuration'
	],
	#category : 'PharoEnhancements-GToolkit-Spotter',
	#package : 'PharoEnhancements-GToolkit',
	#tag : 'Spotter'
}

{ #category : 'magritte-descriptions' }
PeGtDelegatedSearch class >> to: aValuable message: aSymbol [ 

	^ self to: aValuable message: aSymbol configured: #yourself
]

{ #category : 'magritte-descriptions' }
PeGtDelegatedSearch class >> to: aValuable message: aSymbol configured: configBlock [

	^ self new
		delegate: aValuable;
		message: aSymbol;
		configuration: configBlock;
		yourself
]

{ #category : 'accessing' }
PeGtDelegatedSearch >> configuration [
	^ configuration ifNil: #yourself
]

{ #category : 'accessing' }
PeGtDelegatedSearch >> configuration: anObject [
	configuration := anObject
]

{ #category : 'accessing' }
PeGtDelegatedSearch >> delegate [

	^ delegate
]

{ #category : 'accessing' }
PeGtDelegatedSearch >> delegate: aValuable [

	delegate := aValuable
]

{ #category : 'accessing' }
PeGtDelegatedSearch >> gtSpotterOn: aStep [
	<gtSearch>
	
	| search |
	search := self delegate value perform: self message with: aStep.
	self configuration value: search.
	^ search
]

{ #category : 'accessing' }
PeGtDelegatedSearch >> message [

	^ message
]

{ #category : 'accessing' }
PeGtDelegatedSearch >> message: anObject [

	message := anObject
]
