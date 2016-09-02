*PharoEnhancements
verifiedCopyTo: aReference
	| result |
	result := self copyTo: aReference.
	(self isMD5Equal: aReference) ifFalse: [ self error: 'Copy hash has changed!' ].
	^ result