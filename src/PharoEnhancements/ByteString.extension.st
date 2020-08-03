Extension { #name : #ByteString }

{ #category : #'*PharoEnhancements' }
ByteString >> copyToClipboard [
	Clipboard clipboardText: self
]
