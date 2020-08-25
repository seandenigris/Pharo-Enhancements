Class {
	#name : #PP2DateParser,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'upToTwoDigits',
		'upToFourDigits',
		'mmddyyyy',
		'shortMonthDescription'
	],
	#category : #'PharoEnhancements-PetitParser2'
}

{ #category : #accessing }
PP2DateParser >> mmddyyyy [
	| separator |
	separator := $/ asPParser.
	^ (upToTwoDigits, separator, upToTwoDigits, separator, upToFourDigits) flatten ==> #asDate
]

{ #category : #accessing }
PP2DateParser >> shortMonthDescription [
	^ (Month nameParser, #space asPParser, upToTwoDigits, ', ' asPParser, upToFourDigits) flatten ==> #asDate.
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
PP2DateParser >> upToFourDigits [
	^ self upToDigits: 4
]

{ #category : #accessing }
PP2DateParser >> upToTwoDigits [
	^ self upToDigits: 2
]
