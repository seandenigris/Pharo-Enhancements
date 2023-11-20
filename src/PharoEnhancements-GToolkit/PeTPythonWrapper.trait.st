Trait {
	#name : #PeTPythonWrapper,
	#instVars : [
		'pythonInstance'
	],
	#category : #'PharoEnhancements-GToolkit'
}

{ #category : #accessing }
PeTPythonWrapper >> application [
	^ PBApplication uniqueInstance
]

{ #category : #accessing }
PeTPythonWrapper >> newCommandFactory [
	^ self application newCommandSourceFactory
		addAllBindings: {#self -> self pythonInstance};
		yourself
]

{ #category : #accessing }
PeTPythonWrapper >> pythonInstance [
	^ pythonInstance
]

{ #category : #accessing }
PeTPythonWrapper >> pythonInstance: anObject [
	pythonInstance := anObject
]
