Class {
	#name : #PePyDataFrame,
	#superclass : #Object,
	#instVars : [
		'pyDataFrame',
		'pythonVariableName'
	],
	#category : #'PharoEnhancements-PolyMath'
}

{ #category : #accessing }
PePyDataFrame >> asDataFrame [
	^ DataFrame readFromJson: self toJson
]

{ #category : #accessing }
PePyDataFrame >> at: index [
	| cmd |
	cmd := PBApplication uniqueInstance newCommandSourceFactory
	source: 'self[index]';
	addAllBindings: { 
		#self -> self pythonInstance.
		#index -> index }.
	^ self seriesClass fromCommand: cmd
]

{ #category : #accessing }
PePyDataFrame >> commandDo: aBlock [
	^ aBlock value: PBApplication uniqueInstance newCommandSourceFactory
]

{ #category : #accessing }
PePyDataFrame >> head: anInteger [
	
	^ self commandDo: [ :cmd |
		cmd
			source: 'self.head(n)';
			addAllBindings: { 
				#self -> self pythonInstance.
				#n -> anInteger }.
		self class fromCommand: cmd ].
]

{ #category : #accessing }
PePyDataFrame >> pyDataFrame [

	^ pyDataFrame
]

{ #category : #accessing }
PePyDataFrame >> pyDataFrame: anObject [

	pyDataFrame := anObject
]

{ #category : #accessing }
PePyDataFrame >> pythonInstance [

	^ pythonVariableName
]

{ #category : #accessing }
PePyDataFrame >> pythonInstance: anObject [

	pythonVariableName := anObject
]

{ #category : #accessing }
PePyDataFrame >> seriesClass [
	^ PePyDataSeries
]

{ #category : #accessing }
PePyDataFrame >> toJson [
	"Preserves type, but not order"
	^ PBApplication uniqueInstance newCommandSourceFactory
		source: 'self.to_json()';
		bindingAt: #self put: self pythonInstance;
		sendAndWait.
]
