Class {
	#name : #PeGtSubInstancesFilter,
	#superclass : #GtFilter,
	#instVars : [
		'rootClass'
	],
	#category : #'PharoEnhancements-GToolkit-Spotter'
}

{ #category : #accessing }
PeGtSubInstancesFilter >> applyFilter [

	| matchedClasses |
	matchedClasses := self rootClass withAllSubclasses select: [ :cls | cls peCanHandleFromString: self context text ].
	
	matchedClasses do: [ :cls |
		| newInstances |
		newInstances  := cls gtSpotterItemsFromString: self context text.
		self addItems: newInstances.
		"self filteredItems: { matchedClass }" ].
		
	^ self filteredItems
]

{ #category : #accessing }
PeGtSubInstancesFilter >> rootClass [

	^ rootClass
]

{ #category : #accessing }
PeGtSubInstancesFilter >> rootClass: anObject [

	rootClass := anObject
]
