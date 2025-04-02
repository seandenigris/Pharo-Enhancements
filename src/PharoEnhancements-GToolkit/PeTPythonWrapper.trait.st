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
PeTPythonWrapper >> configureCommandFactory: aCommandFactory [
	^ aCommandFactory
		addAllBindings: { #self -> self pythonInstance };
		yourself
]

{ #category : #accessing }
PeTPythonWrapper >> newCommandFactory [
	^ self newCommandSourceFactory
]

{ #category : #accessing }
PeTPythonWrapper >> newCommandSourceFactory [
	^ self configureCommandFactory: self application newCommandSourceFactory
]

{ #category : #accessing }
PeTPythonWrapper >> newCommandStringFactory [
	^ self configureCommandFactory: self application newCommandStringFactory
]

{ #category : #accessing }
PeTPythonWrapper >> pythonInstance [
	^ pythonInstance
]

{ #category : #accessing }
PeTPythonWrapper >> pythonInstance: anObject [
	pythonInstance := anObject
]
