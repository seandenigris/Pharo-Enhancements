Extension { #name : #ByteString }

{ #category : #'*PharoEnhancements' }
ByteString >> surroundedByDoubleQuotes [
	^ self surroundedBy: '"'
]
