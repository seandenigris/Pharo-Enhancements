Extension { #name : #MailMessage }

{ #category : #'*PharoEnhancements' }
MailMessage >> attachmentParts [

	^ self parts select: [ :part | part isAttachment ]
]

{ #category : #'*PharoEnhancements' }
MailMessage >> fieldNamed: aString ifPresent: presentBlock ifAbsent: aBlock [
	"return the value of the field with the specified name.  If there is more than one field, then return the first one"
	^ fields 
		at: aString asLowercase 
		ifPresent: [ :matchingFields | presentBlock value: matchingFields first ]
		ifAbsent: [ aBlock value ].
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
MailMessage >> isHtml [

	^ self fieldNamed: 'content-type'
		ifPresent: [ :field | field mainValue = 'text/html' ]
		ifAbsent: [ false ].
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
