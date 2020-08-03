Extension { #name : #ByteString }

{ #category : #'*PharoEnhancements-Magritte' }
ByteString >> copyToClipboardDescription [
	<magritteActionDescription>
	^ MAActionDescription new
			action: #copyToClipboard;
			yourself
			
]
