Extension { #name : #PBApplication }

{ #category : #'*PharoEnhancements-GToolkit' }
PBApplication >> sendSource: aString withBindings: convertibleToDictionary [
	
	| statements commandFactory |
	statements := LeUninterpretedPythonStatement statementsFrom: aString.
	commandFactory := self newCommandFactory.
	convertibleToDictionary asDictionary keysAndValuesDo: [ :aSymbol :anObject |
		commandFactory bindingAt: aSymbol put: anObject ].
	statements do: [ :statement | commandFactory << statement ].
	^ commandFactory sendAndWait.
	
	"Adapted from GtPythonCoderModel>>#bindAndExecute:"
]
