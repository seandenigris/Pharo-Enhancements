Extension { #name : #PRExternalLink }

{ #category : #'*PharoEnhancements-GToolkit' }
PRExternalLink class >> titled: aString targeting: aUrl [
	| result title |
	result := self fromReference: aUrl asString.
	title := PRText content: aString.
	^ result
		add: title;
		yourself
]
