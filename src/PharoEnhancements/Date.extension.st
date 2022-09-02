Extension { #name : #Date }

{ #category : #'*PharoEnhancements' }
Date >> addYears: anInteger [

	^ self anniversaryInYear: self year + anInteger
]

{ #category : #'*PharoEnhancements' }
Date >> anniversariesThrough: laterDate [
	| laterYymmdd yymmdd |
	"To easily compare the dates, we shift the year, month, and day digits, so they do not overlap. We end up with e.g. 2020-02-04 becoming 2020.0204 and 2022-02-04 becoming 2022.0204, so simple subtraction shows they are 2 whole years apart"
	laterYymmdd := laterDate dayMonthYearDo: [ :d :m :y | (y * 100 + m) * 100 + d ].
	yymmdd := self dayMonthYearDo: [ :d :m :y | (y * 100 + m) * 100 + d ].
	^ (laterYymmdd - yymmdd) // 10000
	"This algorithm is the result of an interesting discussion on Discord Pharo general channel around 11/11/2020 between Esteban Maringolo, Martin McClure and 'Gus'. Each came up with an algorithm, but Gus' was the most concise. This is not surprising, since Gus mentioned working in superannuation and pension. After being optimized by Dave Mason, it also turned out to be the fastest. The optimization was to replace the multiple divisions with multiplcations and a single division. The optimized algorithm is the code you see here, except that the order is flipped i.e. in Dave's the argument is the earlier date, but we take it to be the later one. The other versions and examples can be found in commit a5dddae"
]

{ #category : #'*PharoEnhancements' }
Date >> anniversariesThroughExample [
	<gtExample>
	| data |
	data := { 
		"Leap year to non leap year"
		{ '2/28/1980'. '2/27/1985'. 4 }.
		{ '2/28/1980'. '2/28/1985'. 5 }.
		{ '2/29/1980'. '2/28/1985'. 4 }.
		{ '2/29/1980'. '3/1/1985'. 5 }.
		{ '3/1/1980'. '2/28/1985'. 4 }.
		{ '3/1/1980'. '3/1/1985'. 5 }.
		
		"Leap year to leap year"
		{ '2/28/1980'. '2/27/1984'. 3 }.
		{ '2/28/1980'. '2/28/1984'. 4 }.
		{ '2/29/1980'. '2/28/1984'. 3. }.
		{ '2/29/1980'. '2/29/1984'. 4. }.
		{ '2/29/1980'. '3/1/1984'. 4. }.
		{ '3/1/1980'. '2/29/1984'. 3 }.
		{ '3/1/1980'. '3/1/1984'. 4 }.
		
		"Non leap year to leap year"
		{ '2/28/1981'. '2/28/1988'. 7 }.
		{ '3/1/1981'. '2/29/1988'. 6 }.
		{ '3/1/1981'. '3/1/1988'. 7 }.
	}.
	
	data do: [ :e | 
		| anniversaries startDate endDate expectedAgeInYears |
		startDate := e first.
		endDate := e second.
		expectedAgeInYears := e third.
		anniversaries := startDate asDate anniversariesThrough: endDate asDate.
		self assert: anniversaries equals: expectedAgeInYears ]
]

{ #category : #'*PharoEnhancements' }
Date >> anniversaryInYear: aNumber [

	| isDayOfYearConsistent adjustment |
	isDayOfYearConsistent := 
	(Year isLeapYear: self year) = (Year isLeapYear: aNumber) 
		or: [ self monthIndex < 3 ].
	adjustment := isDayOfYearConsistent
		ifTrue: [ 0 ]
		ifFalse: [
			(Year isLeapYear: self year)
				ifTrue: [ -1 ]
				ifFalse: [ 1 ] ].
	^ Date year: aNumber day: self dayOfYear + adjustment.
]

{ #category : #'*PharoEnhancements' }
Date >> isAnniversaryReachedBy: aDate [
			
	^ (self anniversaryInYear: aDate year) <= aDate
]

{ #category : #'*PharoEnhancements' }
Date >> isLeapDay [
	(Year isLeapYear: self year) ifFalse: [ ^ false ].
	^ self monthIndex = 2 and: [ self dayOfMonth = 29 ]
]

{ #category : #'*PharoEnhancements' }
Date >> subtractYears: anInteger [
	^ self addYears: anInteger negated
]

{ #category : #'*PharoEnhancements' }
Date >> yearsSince: aDate [
	"Returns aNumber whose fractional part = fraction of the year from last to next anniversary rounded to the day. Makes the arbitrary choice that 2/29 -> 3/1 in non-leap years. For explanation about why that's arbitrary, see https://stackoverflow.com/questions/9/how-do-i-calculate-someones-age-based-on-a-datetime-type-birthday"
	| fullYears lastAnniversary nextAnniversary partialYear anniversaryThisYear hasReachedAnniversary |
	
	anniversaryThisYear := aDate anniversaryInYear: self year.
	hasReachedAnniversary := anniversaryThisYear <= self.
	hasReachedAnniversary
		ifTrue: [
			lastAnniversary := anniversaryThisYear.
			nextAnniversary := aDate anniversaryInYear: self year + 1 ]
		ifFalse: [
			lastAnniversary := aDate anniversaryInYear: self year - 1.
			nextAnniversary := anniversaryThisYear ].
	
	fullYears := lastAnniversary year - aDate year.
	
	partialYear := (self - lastAnniversary) / (nextAnniversary - lastAnniversary).
	
	^ fullYears + partialYear
]
