Extension { #name : #MAToManyRelationDescription }

{ #category : #'*PharoEnhancements-Magritte' }
MAToManyRelationDescription >> defaultJsonReader [

	^ [ :input | self fromString: input ].
]
