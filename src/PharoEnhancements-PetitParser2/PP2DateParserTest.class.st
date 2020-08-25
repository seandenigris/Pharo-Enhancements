Class {
	#name : #PP2DateParserTest,
	#superclass : #TestCase,
	#instVars : [
		'result'
	],
	#category : #'PharoEnhancements-PetitParser2'
}

{ #category : #tests }
PP2DateParserTest >> failParse: input rule: aSymbol [
	self
		parse: input
		rule: aSymbol
		do: [ self assert: result isPetit2Failure ]
]

{ #category : #tests }
PP2DateParserTest >> parse: input rule: aSymbol [
	self
		parse: input
		rule: aSymbol
		do: [ self deny: result isPetit2Failure ]
]

{ #category : #tests }
PP2DateParserTest >> parse: input rule: aSymbol do: aBlock [ 
	| parser |
	parser := PP2DateParser new perform: aSymbol.
	result := parser end parse: input.
	aBlock value
]

{ #category : #tests }
PP2DateParserTest >> testMmddyyyy [
	self parse: '12/24/2019' rule: #mmddyyyy.
	self assert: result equals: '12/24/2019' asDate.
	
	self failParse: '123/24/2019' rule: #mmddyyyy.
	self failParse: '12/124/2019' rule: #mmddyyyy.
	self failParse: '12/12/20191' rule: #mmddyyyy.
	self failParse: '12!12/2019' rule: #mmddyyyy.
	self failParse: '12/12!2019' rule: #mmddyyyy.
	self failParse: '12/12//2019' rule: #mmddyyyy.
]

{ #category : #tests }
PP2DateParserTest >> testShortMonthDescription [
	| badInput |
	self parse: 'Apr 28, 2018' rule: #shortMonthDescription.
	self assert: result equals: 'Apr 28, 2018' asDate.
	
	badInput := #(
			'Apri 28, 2018' 	"Partial month > 3 chars"
			'Apr 128, 2018' 	"3+ digit day"
			'Apr 28, 12018' 	"5+ digit year"
			'Apr 28% 2018' 		"Other than comma before year"
			'apr 28, 2018'		"Uncapitalized month"
			'Apr  28, 2018'		"Extra spaces"
	).
	badInput do: [ :i | self failParse: i rule: #shortMonthDescription ].
]
