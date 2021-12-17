Class {
	#name : #PeGtVariableBinder,
	#superclass : #Object,
	#instVars : [
		'tool',
		'variable',
		'targetValue'
	],
	#category : #'PharoEnhancements-GToolkit-Variable-Sharing'
}

{ #category : #accessing }
PeGtVariableBinder class >> from: anRBVariable to: anObject in: aTool [
	^ self new
		variable: anRBVariable;
		targetValue: anObject;
		tool: aTool;
		yourself 
]

{ #category : #accessing }
PeGtVariableBinder >> peGtPharoSourceCoderTreeChildren [
	^ #()
]

{ #category : #accessing }
PeGtVariableBinder >> peGtPharoSourceCoderTreeChildrenForValue: anObject [
	^ #()
]

{ #category : #accessing }
PeGtVariableBinder >> peGtPharoSourceCoderTreeInitializeNode: aNodeElement [
		(aNodeElement childNamed: #label) text: self variable name.
		(aNodeElement childNamed: #bind) 
			visibility: BlVisibility visible;
			action: [ 
					self tool 
						sharedBindingAt: self variable name 
						put: self targetValue ]
]

{ #category : #accessing }
PeGtVariableBinder >> targetValue [

	^ targetValue ifNil: [ PeGtSpotterResult ]
]

{ #category : #accessing }
PeGtVariableBinder >> targetValue: anObject [

	targetValue := anObject
]

{ #category : #accessing }
PeGtVariableBinder >> tool [

	^ tool
]

{ #category : #accessing }
PeGtVariableBinder >> tool: anObject [

	tool := anObject
]

{ #category : #accessing }
PeGtVariableBinder >> variable [

	^ variable
]

{ #category : #accessing }
PeGtVariableBinder >> variable: anObject [

	variable := anObject
]
