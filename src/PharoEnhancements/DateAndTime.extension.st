Extension { #name : 'DateAndTime' }

{ #category : '*PharoEnhancements' }
DateAndTime >> printUS [

	^ self asDate mmddyyyy, ' @ ', self asTime printMinutes.
]
