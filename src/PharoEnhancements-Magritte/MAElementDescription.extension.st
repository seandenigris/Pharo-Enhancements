Extension { #name : #MAElementDescription }

{ #category : #'*PharoEnhancements-Magritte' }
MAElementDescription >> defaultJsonReader [

	^ [ :input | self fromString: input ].
]

{ #category : #'*PharoEnhancements-Magritte' }
MAElementDescription >> jsonFieldName: aString [
	^ self propertyAt: #jsonFieldName put: aString
]

{ #category : #'*PharoEnhancements-Magritte' }
MAElementDescription >> jsonReader [

	^ self propertyAt: #jsonReader ifAbsent: [ self defaultJsonReader ]
]

{ #category : #'*PharoEnhancements-Magritte' }
MAElementDescription >> jsonReader: aBlock [
	"
	aBlock 
		- 1st argument - the input string
		- 2nd (optional) argument - this description
		- return value - a value appropriate to the field e.g. aDate for MADateDescription."
	^ self propertyAt: #jsonReader put: aBlock
]
