Extension { #name : #SmaCCParser }

{ #category : #'*PharoEnhancements-GToolkit' }
SmaCCParser class >> simulateRule: nameString parse: inputString [
	| simulator |
	simulator := SmaCCParserSimulator on: self definitionString.
	simulator setupFor: nameString.
	^ [ simulator simulateParse: inputString ]
		on: SmaCCParserSimulationError 
		do: [ :err | 
			"(ab?)use of assert:equals: gives access to the parse tree on failure"
			self assert: err equals: true ].
]
