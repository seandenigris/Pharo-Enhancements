*PharoEnhancements
addYears: anInteger

	| targetYear isLeapDay |
	targetYear := self year + anInteger.
	
	isLeapDay := self monthIndex = 2 and: [ self dayOfMonth = 29 ].
	isLeapDay
		ifTrue: [ 
			^ self class 
					year: targetYear
					day: self start dayOfYear ].
	
	^ self class 
			year: targetYear
			month: self monthIndex
			day: self dayOfMonth