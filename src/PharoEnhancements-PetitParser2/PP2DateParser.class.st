Class {
	#name : #PP2DateParser,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'mmddyyyy',
		'shortMonthDescription',
		'monthNumber',
		'day',
		'year'
	],
	#category : #'PharoEnhancements-PetitParser2'
}

{ #category : #accessing }
PP2DateParser class >> exampleMonthName [
	<gtExample>
	^ self
		given: [ 'March 14, 2022' ]
		when: [ :input | self parse: input ]
		then: [ :result | result should equal: '3/14/2022' asDate ]
]

{ #category : #accessing }
PP2DateParser class >> exampleMonthNumberImpossible [
	<gtExample>
	^ self
		given: [ '94/09/2017' ]
		when: [ :input | self parse: input ]
		then: [ :result | result should isPetit2Failure ]
]

{ #category : #accessing }
PP2DateParser class >> exampleTwoDigitYear [
	<gtExample>
	^ self
		given: [ '04/09/17' ]
		when: [ :input | self parse: input ]
		then: [ :result | result should equal: '04/09/17' asDate ]
]

{ #category : #accessing }
PP2DateParser >> day [
	^ self numberUpTo: 31.
]

{ #category : #accessing }
PP2DateParser >> from: startInteger digitsTo: endInteger [
	^ #digit asPParser plus 
		min: startInteger; 
		max: endInteger;
		flatten
]

{ #category : #accessing }
PP2DateParser >> mmddyyyy [
	| separator |
	separator := $/ asPParser / $- asPParser.
	^ (monthNumber, separator, day, separator, year) flatten ==> #asDate
]

{ #category : #accessing }
PP2DateParser >> monthNumber [
	^ self numberUpTo: 12
]

{ #category : #accessing }
PP2DateParser >> newMethod [
	"This is a new method"
]

{ #category : #accessing }
PP2DateParser >> numberUpTo: aNumber [
	^ (aNumber to: 1 by: -1) "Interval is reversed so that e.g. 14 doesn't match just the 1"
		inject: PP2FailingNode  new
		into: [ :result :e | 
			| node |
			node := e < 10
				ifTrue: [ '0' asPParser optional, e asString asPParser ]
				ifFalse: [ e asString asPParser ].
			result / node ].
]

{ #category : #accessing }
PP2DateParser >> shortMonthDescription [
	^ (Month nameParser, #space asPParser, day, ', ' asPParser, year) flatten ==> #asDate.
]

{ #category : #accessing }
PP2DateParser >> start [
	^ mmddyyyy / shortMonthDescription
]

{ #category : #accessing }
PP2DateParser >> upToDigits: anInteger [
	^ #digit asPParser plus min: 1; max: anInteger; flatten
]

{ #category : #accessing }
PP2DateParser >> whitespace [
	^ Character tab asPParser / Character space asPParser
]

{ #category : #accessing }
PP2DateParser >> year [
	^ self from: 2 digitsTo: 4
]
