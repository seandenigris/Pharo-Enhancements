Extension { #name : 'ZnUrl' }

{ #category : '*PharoEnhancements' }
ZnUrl >> matchesDomain: aString [

	^ self host endsWith: aString
]
