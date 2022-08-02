Extension { #name : #SpecOfShouldExpression }

{ #category : #'*PharoEnhancements-StateSpecs' }
SpecOfShouldExpression >> equalTemplate: aString format: aCollection [
	| rhs |
	rhs := aString format: aCollection.
	^ self equal: rhs
]
