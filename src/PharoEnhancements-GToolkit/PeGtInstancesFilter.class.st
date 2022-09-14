Class {
	#name : #PeGtInstancesFilter,
	#superclass : #GtFilter,
	#instVars : [
		'rootClass'
	],
	#category : #'PharoEnhancements-GToolkit-Spotter'
}

{ #category : #accessing }
PeGtInstancesFilter >> applyFilter [

	| canHandle newInstances |
	canHandle := self rootClass peCanHandleFromString: self context text.
	canHandle ifFalse: [ ^ self filteredItems ].
		
	newInstances  := self rootClass gtSpotterItemsFromString: self context text.
	self addItems: newInstances.
	"self filteredItems: { matchedClass }".
		
	^ self filteredItems
]

{ #category : #accessing }
PeGtInstancesFilter >> rootClass [

	^ rootClass
]

{ #category : #accessing }
PeGtInstancesFilter >> rootClass: anObject [

	rootClass := anObject
]
