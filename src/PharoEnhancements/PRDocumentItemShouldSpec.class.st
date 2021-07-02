Class {
	#name : #PRDocumentItemShouldSpec,
	#superclass : #SpecOfShouldExpression,
	#category : #'PharoEnhancements-Core'
}

{ #category : #accessing }
PRDocumentItemShouldSpec >> equalPillarMarkup: aString [
	^ (PRPillarWriter write: self receiver) should equal: aString
]
