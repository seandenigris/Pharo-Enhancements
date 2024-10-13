Extension { #name : #DateAndTime }

{ #category : #'*PharoEnhancements' }
DateAndTime >> asFileNameCompatibleString [
	| stream |
	stream := String new writeStream.
	self printYMDOn: stream.
	stream << 'T'.
	self printHMSWithDashesOn: stream.
	^ stream contents
]

{ #category : #'*PharoEnhancements' }
DateAndTime >> printUS [

	^ self asDate mmddyyyy, ' @ ', self asTime printMinutes.
]
