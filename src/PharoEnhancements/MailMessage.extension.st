Extension { #name : #MailMessage }

{ #category : #'*PharoEnhancements' }
MailMessage >> timestamp [
	| dateField dateString isWeekdayPresent safeDateString |
	dateField := self 
		fieldNamed: 'date'
		ifAbsent: [ 
			self 
				fieldNamed: 'delivery-date'
				ifAbsent: [ ^ nil ] ].
	"These header values seem to start with a weekday e.g. 'Thu, ' which breaks Pharo's DateAndTime parsing"
	dateString := dateField mainValue.
	isWeekdayPresent := dateString includes: $,.
	safeDateString := isWeekdayPresent
		ifTrue: [ 
			| dateStringNoWeekday |
			dateStringNoWeekday := dateString copyAfter: $,.
			dateStringNoWeekday trimLeft ]
		ifFalse: [ dateString ].
	^ [ safeDateString asDateAndTime ]
		on: Error
		do: [ nil ]
]
