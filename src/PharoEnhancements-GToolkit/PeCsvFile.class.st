Class {
	#name : 'PeCsvFile',
	#superclass : 'Object',
	#instVars : [
		'reference'
	],
	#category : 'PharoEnhancements-GToolkit-CSV',
	#package : 'PharoEnhancements-GToolkit',
	#tag : 'CSV'
}

{ #category : 'instance creation' }
PeCsvFile class >> on: file [
	^ self new
		reference: file;
		yourself
]

{ #category : 'accessing' }
PeCsvFile >> file [
	^ reference
]

{ #category : 'accessing' }
PeCsvFile >> file: anObject [
	reference := anObject
]

{ #category : 'accessing' }
PeCsvFile >> headers [

	^ self reader readHeader
]

{ #category : 'importing' }
PeCsvFile >> importAs: aClass [
	
	| fieldDescriptions reader |
	fieldDescriptions := aClass new magritteDescription children.
	reader := self reader.
	reader
		skipHeader;
		recordClass: aClass.
			
	self headers do: [ :e | | description |
		description := fieldDescriptions detect: [ :d | 
			d 
				propertyAt: #field 
				ifPresent: [ :fieldName | fieldName = e ] 
				ifAbsent: [ false ] ].
		reader
			addField: description accessor writeSelector
			converter: description rmsConverter ].
	^ reader upToEnd
]

{ #category : 'accessing' }
PeCsvFile >> reader [

	^ PeSignalingCsvReader on: self reference readStream.
]

{ #category : 'accessing' }
PeCsvFile >> reference [
	^ reference
]

{ #category : 'accessing' }
PeCsvFile >> reference: anObject [
	reference := anObject
]
