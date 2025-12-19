Trait {
	#name : 'PeTEnumerable',
	#category : 'PharoEnhancements',
	#package : 'PharoEnhancements'
}

{ #category : 'enumerating' }
PeTEnumerable >> anySatisfy: aBlock [

	^ self privateEnumerable anySatisfy: aBlock
]

{ #category : 'random' }
PeTEnumerable >> atRandom [

	^ self privateEnumerable atRandom
]

{ #category : 'enumerating' }
PeTEnumerable >> collect: aBlock [
	
	^ self privateEnumerable collect: aBlock.
]

{ #category : 'enumerating' }
PeTEnumerable >> collectAsSet: aBlock [
	
	^ self privateEnumerable collectAsSet: aBlock.
]

{ #category : 'enumerating' }
PeTEnumerable >> count: aBlock [
	
	^ self privateEnumerable count: aBlock.
]

{ #category : 'accessing' }
PeTEnumerable >> detect: aBlock [

	^ self privateEnumerable detect: aBlock
]

{ #category : 'accessing' }
PeTEnumerable >> detect: aBlock ifFound: foundBlock ifNone: exceptionBlock [

	^ self privateEnumerable detect: aBlock ifFound: foundBlock ifNone: exceptionBlock
]

{ #category : 'accessing' }
PeTEnumerable >> detect: aBlock ifNone: exceptionBlock [

	^ self privateEnumerable detect: aBlock ifNone: exceptionBlock
]

{ #category : 'accessing' }
PeTEnumerable >> detectMax: aBlock [

	^ self privateEnumerable detectMax: aBlock
]

{ #category : 'enumerating' }
PeTEnumerable >> detectMax: aBlock overThreshold: aNumber [

	^ self privateEnumerable detectMax: aBlock overThreshold: aNumber
]

{ #category : 'accessing' }
PeTEnumerable >> do: aBlock [

	^ self privateEnumerable do: aBlock
]

{ #category : 'enumerating' }
PeTEnumerable >> do: doBlock separatedBy: separatorBlock [

	^ self privateEnumerable do: doBlock separatedBy: separatorBlock
]

{ #category : 'enumerating' }
PeTEnumerable >> flatCollect: aBlock [
	
	^ self privateEnumerable flatCollect: aBlock.
]

{ #category : 'enumerating' }
PeTEnumerable >> flatCollect: aBlock as: aClass [
	
	^ self privateEnumerable flatCollect: aBlock as: aClass
]

{ #category : 'enumerating' }
PeTEnumerable >> flatCollectAsSet: aBlock [
	
	^ self privateEnumerable flatCollectAsSet: aBlock.
]

{ #category : 'enumerating' }
PeTEnumerable >> groupedBy: aBlock [
	
	^ self privateEnumerable groupedBy: aBlock.
]

{ #category : 'testing' }
PeTEnumerable >> ifEmpty: aBlock [

	^ self privateEnumerable ifEmpty: aBlock
]

{ #category : 'testing' }
PeTEnumerable >> includes: anObject [

	^ self privateEnumerable includes: anObject
]

{ #category : 'testing' }
PeTEnumerable >> includesAny: anObject [

	^ self privateEnumerable includesAny: anObject
]

{ #category : 'accessing' }
PeTEnumerable >> inject: thisValue into: binaryBlock [ 

	^ self privateEnumerable inject: thisValue into: binaryBlock 
]

{ #category : 'enumerating' }
PeTEnumerable >> isEmpty [

	^ self privateEnumerable isEmpty
]

{ #category : 'accessing' }
PeTEnumerable >> max: aBlock [

	^ self privateEnumerable max: aBlock
]

{ #category : 'accessing' }
PeTEnumerable >> noneSatisfy: aBlock [

	^ self privateEnumerable noneSatisfy: aBlock
]

{ #category : 'enumerating' }
PeTEnumerable >> privateEnumerable [
	^ self explicitRequirement
]

{ #category : 'enumerating' }
PeTEnumerable >> reject: aBlock [
	
	^ self privateEnumerable reject: aBlock.
]

{ #category : 'enumerating' }
PeTEnumerable >> select: aBlock [
	
	^ self privateEnumerable select: aBlock.
]

{ #category : 'enumerating' }
PeTEnumerable >> select: selectBlock thenCollect: collectBlock [
	
	^ self privateEnumerable select: selectBlock thenCollect: collectBlock
]

{ #category : 'enumerating' }
PeTEnumerable >> size [

	^ self privateEnumerable size
]
