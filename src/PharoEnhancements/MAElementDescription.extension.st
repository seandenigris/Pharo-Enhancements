Extension { #name : #MAElementDescription }

{ #category : #'*PharoEnhancements' }
MAElementDescription >> defaultJsonReader [

	^ [ :input | self fromString: input ].
]

{ #category : #'*PharoEnhancements' }
MAElementDescription >> jsonFieldName: aString [
	^ self propertyAt: #jsonFieldName put: aString
]

{ #category : #'*PharoEnhancements' }
MAElementDescription >> jsonReader [

	^ self propertyAt: #jsonReader ifAbsent: [ self defaultJsonReader ]
]

{ #category : #'*PharoEnhancements' }
MAElementDescription >> jsonReader: aBlock [
	"
	aBlock 
		- 1st argument - the input string
		- 2nd (optional) argument - this description
		- return value - a value appropriate to the field e.g. aDate for MADateDescription."
	^ self propertyAt: #jsonReader put: aBlock
]
