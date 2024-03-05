Extension { #name : #Timespan }

{ #category : #'*PharoEnhancements' }
Timespan >> workDatesDo: aBlock [
 	"Exclude Saturday and Sunday"

	self do: aBlock with: start asDate when: [ :d | d dayOfWeek > 1 and: [ d dayOfWeek < 7 ] ].
]

{ #category : #'*PharoEnhancements' }
Timespan >> workDays [

	^ self dates count: [ :aDate | 
		| isWeekend |
		isWeekend := #('Saturday' 'Sunday') includes: aDate weekday.
		isWeekend not ]
]
