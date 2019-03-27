Extension { #name : #String }

{ #category : #'*PharoEnhancements' }
String >> asEncodedUrl [
	| encodedString |
	encodedString := String streamContents: [ :out | 
		self do: [ :each | 
			(each codePoint < 127 and: [ each ~= Character space ])
				ifTrue: [ out nextPut: each ]
				ifFalse: [ out nextPutAll: each asString urlEncoded ] ] ].
	^ encodedString asUrl
]

{ #category : #'*PharoEnhancements' }
String >> surroundedByDoubleQuotes [
	^ self surroundedBy: '"'
]
