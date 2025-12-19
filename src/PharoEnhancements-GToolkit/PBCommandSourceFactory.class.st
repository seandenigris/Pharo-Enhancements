Class {
	#name : 'PBCommandSourceFactory',
	#superclass : 'PBCommandFactory',
	#instVars : [
		'source',
		'isLastStatementResult'
	],
	#category : 'PharoEnhancements-GToolkit-Python',
	#package : 'PharoEnhancements-GToolkit',
	#tag : 'Python'
}

{ #category : 'example' }
PBCommandSourceFactory class >> example [
	<gtExample>
	
	^ PBApplication uniqueInstance newCommandSourceFactory
		sourceWithResult: 'range(1,11)';
		sendAndWait.
]

{ #category : 'accessing' }
PBCommandSourceFactory >> addAllBindings: convertibleToDictionary [

	convertibleToDictionary asDictionary keysAndValuesDo: [ :key :value |
		self bindingAt: key put: value ]
]

{ #category : 'accessing' }
PBCommandSourceFactory >> instructionsWithNotifyAtEnd [
	"Copy pasted from superclass because instVars were being used directly, but should be via accessors i.e. we need them to be"

	^ String streamContents: [ :stream |
		stream 
			<< self script withUnixLineEndings;
			lf;
			<< 'notify(';
			<< self resultExpression;
			<< ', ';
			print: command id;
			<< ')' ].
]

{ #category : 'accessing' }
PBCommandSourceFactory >> isLastStatementResult [
	^ isLastStatementResult
]

{ #category : 'accessing' }
PBCommandSourceFactory >> isLastStatementResult: anObject [
	isLastStatementResult := anObject
]

{ #category : 'accessing' }
PBCommandSourceFactory >> reset [
	super reset.
	source := ''.
	isLastStatementResult := false.
	command := PBCommandString new.
]

{ #category : 'accessing' }
PBCommandSourceFactory >> resultExpression [

	^ self isLastStatementResult
		ifFalse: [ #None ]
		ifTrue: [ self source lines last ]
]

{ #category : 'accessing' }
PBCommandSourceFactory >> returnLastStatement [
	isLastStatementResult := true
]

{ #category : 'accessing' }
PBCommandSourceFactory >> script [

	self isLastStatementResult ifFalse: [ ^ self source ].
	
	^ String streamContents: [ :str |
		self source lines allButLast
			do: [ :line | str << line ]
			separatedBy: [ str lf ] ]
]

{ #category : 'accessing' }
PBCommandSourceFactory >> source [
	^ source
]

{ #category : 'accessing' }
PBCommandSourceFactory >> source: aString [
	source := aString
]

{ #category : 'accessing' }
PBCommandSourceFactory >> sourceWithResult: aString [
	source := aString.
	self isLastStatementResult: true
]

{ #category : 'accessing' }
PBCommandSourceFactory >> template: aString format: convertibleToDictionary [

	| filled |
	filled := aString format: convertibleToDictionary asDictionary.
	self source: filled
]
