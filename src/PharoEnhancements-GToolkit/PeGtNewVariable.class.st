Class {
	#name : 'PeGtNewVariable',
	#superclass : 'Object',
	#category : 'PharoEnhancements-GToolkit-Variable-Sharing',
	#package : 'PharoEnhancements-GToolkit',
	#tag : 'Variable-Sharing'
}

{ #category : 'accessing' }
PeGtNewVariable >> peGtPharoSourceCoderTreeChildrenForValue: anObject [
	^ #()
]

{ #category : 'accessing' }
PeGtNewVariable >> peGtPharoSourceCoderTreeInitializeNode: aNodeElement [
		(aNodeElement childNamed: #label) text: 'New binding...'.
		(aNodeElement childNamed: #bind) visibility: BlVisibility visible
]
