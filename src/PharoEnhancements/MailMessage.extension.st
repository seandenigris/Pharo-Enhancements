Extension { #name : #MailMessage }

{ #category : #'*PharoEnhancements' }
MailMessage >> attachmentParts [

	^ self parts select: [ :part | part isAttachment ]
]

{ #category : #'*PharoEnhancements' }
MailMessage >> isAttachment [

	| disposition |
	disposition := self 
		fieldNamed: 'content-disposition' 
		ifAbsent: [ ^ false ].
		
	disposition ifNil: [ ^ false ] .
		
	^ disposition mainValue = 'attachment'
]

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
