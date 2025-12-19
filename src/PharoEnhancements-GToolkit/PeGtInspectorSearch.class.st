"
Returns the receiver object of all open tools
"
Class {
	#name : 'PeGtInspectorSearch',
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

{ #category : 'as yet unclassified' }
PeGtInspectorSearch >> gtSpotterOn: aSearch [
	<gtSearch>
	
	^ aSearch list
		title: 'Inspected Objects';
		priority: 50;
		items: [ self inspectedObjects ];
		filterBySubstring
]

{ #category : 'as yet unclassified' }
PeGtInspectorSearch >> inspectedObjects [

	^ PeGtToolVariableBinder allSpaces flatCollect: [ :world | 
		| tabModels tools |
		tabModels := world peGtPharoSourceCoderTreeChildrenForValue: nil.
		tools := tabModels flatCollect: [ :tm | tm peGtPharoSourceCoderTreeChildrenForValue: nil ].
		tools 
			collect: #receiverObject
			thenReject: #isClass ]
]
