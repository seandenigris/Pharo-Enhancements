Extension { #name : #PBApplication }

{ #category : #'*PharoEnhancements-GToolkit' }
PBApplication class >> exampleCommandSourceFactory [
	<gtExample>
	
	^ self
		given: [ '1 + x' ]
		when: [ :src |
			PBApplication uniqueInstance newCommandSourceFactory
				source: src;
				bindings: { #x -> 2 };
		sendAndWait ]
		then: [ :result | result should equal: 3 ]
]

{ #category : #'*PharoEnhancements-GToolkit' }
PBApplication >> newCommandSourceFactory [
	^ self executionHandler newCommandSourceFactory
]

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
