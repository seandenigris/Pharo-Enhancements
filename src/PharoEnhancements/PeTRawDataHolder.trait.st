Trait {
	#name : #PeTRawDataHolder,
	#instVars : [
		'rawData'
	],
	#category : #PharoEnhancements
}

{ #category : #accessing }
PeTRawDataHolder >> rawData [
	^ rawData
]

{ #category : #accessing }
PeTRawDataHolder >> rawData: anObject [
	rawData := anObject
]

{ #category : #accessing }
PeTRawDataHolder >> rawDataAt: aString [

	^ self 
		rawDataAt: aString 
		reader: #yourself
]

{ #category : #accessing }
PeTRawDataHolder >> rawDataAt: aString reader: aValuable [
		
	^ self 
		rawDataAt: aString 
		reader: aValuable 
		ifAbsent: [ nil ]
]

{ #category : #accessing }
PeTRawDataHolder >> rawDataAt: aString reader: aValuable ifAbsent: absentBlock [
		
	^ self rawData 
		at: aString
		ifPresent: aValuable
		ifAbsent: absentBlock
]

{ #category : #accessing }
PeTRawDataHolder >> rawDataGtViewFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Raw Data';
		priority: 75;
		object: [ self rawData ];
		view: #gtTreeFor:context:;
		inspectButtonFor: [ self rawData ]
]
