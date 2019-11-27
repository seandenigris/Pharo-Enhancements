Extension { #name : #Date }

{ #category : #'*PharoEnhancements-PetitParser2' }
Date class >> grammar [
	| separator number mmddyy shortMonthDesc |
	separator := $/ asPParser.
	number := #digit asPParser star flatten.
	
	mmddyy := number, separator, number, separator, number.
	shortMonthDesc := Month nameParser, #space asPParser, number, ', ' asPParser, number.
	^ (mmddyy / shortMonthDesc) flatten
]

{ #category : #'*PharoEnhancements-PetitParser2' }
Date class >> parser [
	^ self grammar ==> #asDate
]
