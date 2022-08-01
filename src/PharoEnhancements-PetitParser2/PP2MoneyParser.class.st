Class {
	#name : #PP2MoneyParser,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'upToTwoDigits'
	],
	#category : #'PharoEnhancements-PetitParser2'
}

{ #category : #accessing }
PP2MoneyParser class >> exampleCents [
	<gtExample>
	^ self
		given: [ '0.13' ]
		when: [ :input | self parse: input ]
		then: [ :result | result should equal: 0.13 ]
]

{ #category : #accessing }
PP2MoneyParser class >> exampleHundreds [
	<gtExample>
	^ self
		given: [ '123.45' ]
		when: [ :input | self parse: input ]
		then: [ :result | result should equal: 123.45 ]
]

{ #category : #accessing }
PP2MoneyParser class >> exampleNoCommas [
	<gtExample>
	^ self
		given: [ '1234.56' ]
		when: [ :input | self parse: input ]
		then: [ :result | result should equal: 1234.56 ]
]

{ #category : #accessing }
PP2MoneyParser class >> exampleWithCommas [
	<gtExample>
	^ self
		given: [ '1,234.56' ]
		when: [ :input | self parse: input ]
		then: [ :result | result should equal: 1234.56 ]
]

{ #category : #accessing }
PP2MoneyParser >> start [
	| dollars cents upToThreeDigits comma |
	upToThreeDigits := self upToDigits: 3.
	comma := $, asPParser optional ==> [ :n | '' ].
	dollars := (self upToDigits: 3) separatedBy: comma.
	cents := ($. asPParser ==> #asString, self twoDigits) "optional".
	^ dollars, cents ==> [ :n | 
		| resultString |
		resultString := n flatten flatCollect: #yourself as: String.
		resultString asNumber ]
]

{ #category : #accessing }
PP2MoneyParser >> twoDigits [
	^ #digit asPParser plus min: 2; max: 2; flatten
]

{ #category : #accessing }
PP2MoneyParser >> upToDigits: anInteger [
	^ #digit asPParser plus min: 1; max: anInteger; flatten
]

{ #category : #accessing }
PP2MoneyParser >> upToTwoDigits [
	^ self upToDigits: 2
]
