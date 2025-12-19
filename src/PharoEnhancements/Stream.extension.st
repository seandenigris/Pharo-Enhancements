Extension { #name : 'Stream' }

{ #category : '*PharoEnhancements' }
Stream >> display: anObject [
	"Have anObject print itself on the receiver."

	anObject displayStringOn: self
]
