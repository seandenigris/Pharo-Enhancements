Class {
	#name : #PBCommandSourceFactory,
	#superclass : #PBCommandFactory,
	#instVars : [
		'statements',
		'resultVariableName'
	],
	#category : #'PharoEnhancements-GToolkit-Python'
}

{ #category : #accessing }
PBCommandSourceFactory >> bindings: convertibleToDictionary [

	convertibleToDictionary asDictionary keysAndValuesDo: [ :aSymbol :anObject |
		self bindingAt: aSymbol put: anObject ].
]

{ #category : #accessing }
PBCommandSourceFactory >> buildCommand [

	self resultVariableName ifNotNil: [ 
		| lastStatement |
		lastStatement := statements last.
		lastStatement string: self resultVariableName, ' = ', lastStatement string. ].
	
	statements do: [ :statement | self << statement ].
	^ super buildCommand
]

{ #category : #accessing }
PBCommandSourceFactory >> resultVariableName [
	^ resultVariableName
]

{ #category : #accessing }
PBCommandSourceFactory >> resultVariableName: aSymbol [
	resultVariableName := aSymbol
]

{ #category : #accessing }
PBCommandSourceFactory >> source: aString [
	statements := LeUninterpretedPythonStatement statementsFrom: aString.
]

{ #category : #accessing }
PBCommandSourceFactory >> template: aString format: convertibleToDictionary [

	| filled |
	filled := aString format: convertibleToDictionary asDictionary.
	self source: filled
]

{ #category : #accessing }
PBCommandSourceFactory >> useRandomVariableName [
	self resultVariableName: 'st', UUIDGenerator next asString36
]
