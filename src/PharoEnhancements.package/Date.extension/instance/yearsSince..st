*PharoEnhancements
yearsSince: aDate
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