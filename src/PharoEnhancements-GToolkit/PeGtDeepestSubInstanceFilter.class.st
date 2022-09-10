Class {
	#name : #PeGtDeepestSubInstanceFilter,
	#superclass : #GtFilter,
	#instVars : [
		'rootClass'
	],
	#category : #'PharoEnhancements-GToolkit-Spotter'
}

{ #category : #accessing }
PeGtDeepestSubInstanceFilter >> applyFilter [

	| matchedClass |
	matchedClass := self rootClass peClassForString: self context text.
	
	matchedClass ifNotNil: [ :cls |
		| newInstances |
		newInstances  := cls gtSpotterItemsFromString: self context text.
		self addItems: newInstances.
		"self filteredItems: { matchedClass }" ].
		
	^ self filteredItems
]

{ #category : #accessing }
PeGtDeepestSubInstanceFilter >> rootClass [

	^ rootClass
]

{ #category : #accessing }
PeGtDeepestSubInstanceFilter >> rootClass: anObject [

	rootClass := anObject
]
