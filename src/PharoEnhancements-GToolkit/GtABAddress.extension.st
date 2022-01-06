Extension { #name : #GtABAddress }

{ #category : #'*PharoEnhancements-GToolkit' }
GtABAddress >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ city = anObject city and: [ self country = anObject country ]
]
