Extension { #name : #EpClassChange }

{ #category : #'*PharoEnhancements' }
EpClassChange >> peNewSourceCode [
	^ self behaviorAffected comment content
]
