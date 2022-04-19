Class {
	#name : #PBCommandSourceFactory,
	#superclass : #PBCommandFactory,
	#instVars : [
		'statements',
		'resultAssignment'
	],
	#category : #'PharoEnhancements-GToolkit'
}

{ #category : #accessing }
PBCommandSourceFactory >> assignLastStatement [
]

{ #category : #accessing }
PBCommandSourceFactory >> bindings: convertibleToDictionary [

	convertibleToDictionary asDictionary keysAndValuesDo: [ :aSymbol :anObject |
		self bindingAt: aSymbol put: anObject ].
]

{ #category : #accessing }
PBCommandSourceFactory >> buildCommand [

	resultAssignment ifNotNil: [ 
		| lastStatement |
		lastStatement := statements last.
		lastStatement string: resultAssignment, ' = ', lastStatement string. ].
	
	statements do: [ :statement | self << statement ].
	^ super buildCommand
]

{ #category : #accessing }
PBCommandSourceFactory >> resultAssignment: aSymbol [
	resultAssignment := aSymbol
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
