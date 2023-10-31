Extension { #name : #MAToManyRelationDescription }

{ #category : #'*PharoEnhancements' }
MAToManyRelationDescription >> defaultJsonReader [

	^ [ :input | self fromString: input ].
]
