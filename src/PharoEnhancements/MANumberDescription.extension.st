Extension { #name : #MANumberDescription }

{ #category : #'*PharoEnhancements' }
MANumberDescription >> defaultJsonReader [

	^ [ :input | input asNumber ]
]
