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
	template: '{self}[{index}]'
		format: { 
			#self -> self pythonVariableName.
			#index -> index printString }.
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
			template: '{self}.head({n})'
			format: { 
				#self -> self pythonVariableName.
				#n -> anInteger asString }.
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
PePyDataFrame >> pythonVariableName [

	^ pythonVariableName
]

{ #category : #accessing }
PePyDataFrame >> pythonVariableName: anObject [

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
	template: '{self}.to_json()'
		format: { 
			#self -> self pythonVariableName };
	sendAndWait.
]
