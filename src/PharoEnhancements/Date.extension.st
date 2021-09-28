Extension { #name : 'Date' }

{ #category : '*PharoEnhancements' }
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

{ #category : '*PharoEnhancements' }
Date >> anniversariesThrough: laterDate [
	| laterYymmdd yymmdd |
	"To easily compare the dates, we shift the year, month, and day digits, so they do not overlap. We end up with e.g. 2020-02-04 becoming 2020.0204 and 2022-02-04 becoming 2022.0204, so simple subtraction shows they are 2 whole years apart"
	laterYymmdd := laterDate dayMonthYearDo: [ :d :m :y | (y * 100 + m) * 100 + d ].
	yymmdd := self dayMonthYearDo: [ :d :m :y | (y * 100 + m) * 100 + d ].
	^ (laterYymmdd - yymmdd) // 10000
	"This algorithm is the result of an interesting discussion on Discord Pharo general channel around 11/11/2020 between Esteban Maringolo, Martin McClure and 'Gus'. Each came up with an algorithm, but Gus' was the most concise. This is not surprising, since Gus mentioned working in superannuation and pension. After being optimized by Dave Mason, it also turned out to be the fastest. The optimization was to replace the multiple divisions with multiplcations and a single division. The optimized algorithm is the code you see here, except that the order is flipped i.e. in Dave's the argument is the earlier date, but we take it to be the later one. The other versions and examples can be found in commit a5dddae"
]

{ #category : '*PharoEnhancements' }
Date >> anniversariesThroughExample [
	<gtExample>
	| data |
	data := { 
		'2/28/2020' -> 39.
		'2/29/2020' -> 40.
		'3/1/2020' -> 40. }.
	data do: [ :e | 
		| anniversaries |
		anniversaries := '2/29/1980' asDate anniversariesThrough: e key asDate.
		self assert: anniversaries equals: e value ]
]

{ #category : '*PharoEnhancements' }
Date >> subtractYears: anInteger [
	^ self addYears: anInteger negated
]

{ #category : '*PharoEnhancements' }
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
