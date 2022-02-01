Extension { #name : #Dictionary }

{ #category : #'*PharoEnhancements' }
Dictionary >> arrayAt: sourceKey toDictionaryWithKeysFrom: idKey [
	"Useful for results returned say from JSON, where nested object collections are returned as indexed collections, when there is a field (like name or ID) which could clearly be used as a key making the graph much easier to navigate"

	| valueDict resultArray |
	resultArray := self at: sourceKey ifAbsent: [ ^ self ].
	
	valueDict := resultArray 
		inject: Dictionary new 
		into: [ :d :e |
			| idKeyValue |
			idKeyValue := e at: idKey.
			d 
				at: idKeyValue put: e;
				yourself ].
	^ self 
		at: sourceKey 
		put: valueDict;
		yourself
]
