Extension { #name : 'Float' }

{ #category : '*PharoEnhancements' }
Float >> sinh [

	^ (self exp - (self negated) exp) / 2.
]
