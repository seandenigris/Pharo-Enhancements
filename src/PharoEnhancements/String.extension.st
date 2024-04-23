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
String >> asFilename [
	"`#asFileName` leaves in $: which mac doesn't like"
	| result |
	result := result := self asFileName collect: [ :c |
		| isUnsafeChar |
		isUnsafeChar := c isSeparator or: [ ':/\,.' includes: c ].
		isUnsafeChar ifTrue: [ $_ ] ifFalse: [ c ] ].
	self assert: (#('' '/' '..' '.' '\') includes: result) not. "Aggressively protect against wonky FS resolution of special strings"
	^ result
]

{ #category : #'*PharoEnhancements' }
String >> copyToClipboard [

	Clipboard clipboardText: self
]

{ #category : #'*PharoEnhancements' }
String >> isValidAbsoluteURL [

	^ [ self asUrl isAbsolute ]
		on: Error
		do: [ false ]
]

{ #category : #'*PharoEnhancements' }
String >> surroundedByDoubleQuotes [
	^ self surroundedBy: '"'
]
