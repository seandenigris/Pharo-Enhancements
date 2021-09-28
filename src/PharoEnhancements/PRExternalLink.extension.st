Extension { #name : 'PRExternalLink' }

{ #category : '*PharoEnhancements' }
PRExternalLink class >> titled: aString targeting: aUrl [
	| result title |
	result := self fromReference: aUrl asString.
	title := PRText content: aString.
	^ result
		add: title;
		yourself
]
