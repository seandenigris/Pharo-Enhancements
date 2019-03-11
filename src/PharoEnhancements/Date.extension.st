Extension { #name : #Date }

{ #category : #'*PharoEnhancements' }
Date >> addYears: anInteger [

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
]

{ #category : #'*PharoEnhancements' }
Date >> subtractYears: anInteger [
	^ self addYears: anInteger negated
]

{ #category : #'*PharoEnhancements' }
Date >> yearsSince: aDate [
	"Returns aNumber whose fractional part = fraction of the year from last to next anniversary rounded to the day"
	| fullYears lastAnniversary nextAnniversary partialYear |
	fullYears := 0.
	self year = aDate year ifTrue: [ fullYears := 0 ].
	fullYears := self year - aDate year.
	lastAnniversary := Date year: self year month: aDate monthIndex day: aDate dayOfMonth.
	nextAnniversary := Date year: self year + 1 month: aDate monthIndex day: aDate dayOfMonth.
	partialYear := (self - lastAnniversary) / (nextAnniversary - lastAnniversary).
	^ (self monthIndex > aDate monthIndex or: [ self monthIndex = aDate monthIndex and: [ self dayOfMonth >= aDate dayOfMonth ] ])
		ifTrue: [ fullYears + partialYear ]
		ifFalse: [ fullYears - partialYear ]
]
