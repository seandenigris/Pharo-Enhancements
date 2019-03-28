Extension { #name : #String }

{ #category : #'*PharoEnhancements' }
String >> asEncodedUrl [
	"Send this instead of `#asUrl` if I potentially have characters not allowed by the URL spec, which Zinc enforces on input to its parser. Example: `'https://en.wikipedia.org/wiki/Česká republika' asEncodedUrl`"

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
