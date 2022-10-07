Class {
	#name : #PeGtSubInstancesFilter,
	#superclass : #Object,
	#traits : 'TGtSpotterFilter',
	#classTraits : 'TGtSpotterFilter classTrait',
	#instVars : [
		'rootClass'
	],
	#category : #'PharoEnhancements-GToolkit-Spotter'
}

{ #category : #accessing }
PeGtSubInstancesFilter >> applyInScope: aStream context: aSpotterContext [

	| matchedClasses instances |
	matchedClasses := self rootClass withAllSubclasses select: [ :cls | cls peCanHandleFromString: aSpotterContext searchQuery ].
	
	instances := matchedClasses flatCollect: [ :cls |
		cls gtSpotterItemsFromString: aSpotterContext searchQuery ].
		
	^ instances asAsyncStream
]

{ #category : #accessing }
PeGtSubInstancesFilter >> rootClass [

	^ rootClass
]

{ #category : #accessing }
PeGtSubInstancesFilter >> rootClass: anObject [

	rootClass := anObject
]
