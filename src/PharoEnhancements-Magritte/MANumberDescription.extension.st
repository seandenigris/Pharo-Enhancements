Extension { #name : #MANumberDescription }

{ #category : #'*PharoEnhancements-Magritte' }
MANumberDescription >> defaultJsonReader [

	^ [ :input | input asNumber ]
]
