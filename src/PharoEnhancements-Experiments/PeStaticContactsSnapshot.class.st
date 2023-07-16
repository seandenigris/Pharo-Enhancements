Class {
	#name : #PeStaticContactsSnapshot,
	#superclass : #Object,
	#instVars : [
		'privateCollection'
	],
	#category : #'PharoEnhancements-Experiments'
}

{ #category : #filtering }
PeStaticContactsSnapshot >> itemsWithUID: aUID [

	^ self snapshotFromSelectBlock: [ :anItem | 
		anItem uid = aUID ] 
]

{ #category : #accessing }
PeStaticContactsSnapshot >> privateCollection [
	^ privateCollection
]

{ #category : #accessing }
PeStaticContactsSnapshot >> privateCollection: anObject [
	privateCollection := anObject
]

{ #category : #filtering }
PeStaticContactsSnapshot >> snapshotFromSelectBlock: aBlock [

	| matches |
	
	matches := self privateCollection select: aBlock.
	
	"Use explicit class name because subclasses will add mutators, but we still want to return a static snaphot"
	^ PeStaticContactsSnapshot new
		privateCollection matches asArray;
		yourself
]
