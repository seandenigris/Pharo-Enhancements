Trait {
	#name : #PeTEnumerable,
	#category : #PharoEnhancements
}

{ #category : #enumerating }
PeTEnumerable >> anySatisfy: aBlock [

	^ self privateEnumerable anySatisfy: aBlock
]

{ #category : #enumerating }
PeTEnumerable >> collect: aBlock [
	
	^ self privateEnumerable collect: aBlock.
]

{ #category : #enumerating }
PeTEnumerable >> collectAsSet: aBlock [
	
	^ self privateEnumerable collectAsSet: aBlock.
]

{ #category : #accessing }
PeTEnumerable >> detect: aBlock [

	^ self privateEnumerable detect: aBlock
]

{ #category : #accessing }
PeTEnumerable >> detect: aBlock ifFound: foundBlock ifNone: exceptionBlock [

	^ self privateEnumerable detect: aBlock ifFound: foundBlock ifNone: exceptionBlock
]

{ #category : #accessing }
PeTEnumerable >> detect: aBlock ifNone: exceptionBlock [

	^ self privateEnumerable detect: aBlock ifNone: exceptionBlock
]

{ #category : #accessing }
PeTEnumerable >> do: aBlock [

	^ self privateEnumerable do: aBlock
]

{ #category : #enumerating }
PeTEnumerable >> do: doBlock separatedBy: separatorBlock [

	^ self privateEnumerable do: doBlock separatedBy: separatorBlock
]

{ #category : #enumerating }
PeTEnumerable >> flatCollect: aBlock [
	
	^ self privateEnumerable flatCollect: aBlock.
]

{ #category : #enumerating }
PeTEnumerable >> flatCollect: aBlock as: aClass [
	
	^ self privateEnumerable flatCollect: aBlock as: aClass
]

{ #category : #testing }
PeTEnumerable >> ifEmpty: aBlock [

	^ self privateEnumerable ifEmpty: aBlock
]

{ #category : #accessing }
PeTEnumerable >> max: aBlock [

	^ self privateEnumerable max: aBlock
]

{ #category : #enumerating }
PeTEnumerable >> privateEnumerable [
	^ self explicitRequirement
]

{ #category : #enumerating }
PeTEnumerable >> reject: aBlock [
	
	^ self privateEnumerable reject: aBlock.
]

{ #category : #enumerating }
PeTEnumerable >> select: aBlock [
	
	^ self privateEnumerable select: aBlock.
]

{ #category : #enumerating }
PeTEnumerable >> select: selectBlock thenCollect: collectBlock [
	
	^ self privateEnumerable select: selectBlock thenCollect: collectBlock
]

{ #category : #enumerating }
PeTEnumerable >> size [

	^ self privateEnumerable size
]
