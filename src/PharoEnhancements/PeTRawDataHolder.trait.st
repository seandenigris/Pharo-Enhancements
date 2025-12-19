Trait {
	#name : 'PeTRawDataHolder',
	#instVars : [
		'rawData'
	],
	#category : 'PharoEnhancements',
	#package : 'PharoEnhancements'
}

{ #category : 'instance creation' }
PeTRawDataHolder classSide >> fromDictionary: aDictionary [

	^ self new
		rawData: aDictionary;
		yourself
]

{ #category : 'accessing' }
PeTRawDataHolder >> rawData [
	^ rawData
]

{ #category : 'accessing' }
PeTRawDataHolder >> rawData: anObject [
	rawData := anObject
]

{ #category : 'accessing' }
PeTRawDataHolder >> rawDataAt: aString [

	^ self 
		rawDataAt: aString 
		reader: #yourself
]

{ #category : 'accessing' }
PeTRawDataHolder >> rawDataAt: aString ifAbsent: absentBlock [
		
	^ self 
		rawDataAt: aString 
		reader: #yourself 
		ifAbsent: absentBlock
]

{ #category : 'accessing' }
PeTRawDataHolder >> rawDataAt: aString reader: aValuable [
		
	^ self 
		rawDataAt: aString 
		reader: aValuable 
		ifAbsent: [ nil ]
]

{ #category : 'accessing' }
PeTRawDataHolder >> rawDataAt: aString reader: aValuable ifAbsent: absentBlock [
		
	^ self rawData 
		at: aString
		ifPresent: aValuable
		ifAbsent: absentBlock
]

{ #category : 'accessing' }
PeTRawDataHolder >> rawDataGtViewFor: aView context: aContext [
	<gtView>
	
	^ self 
		rawDataGtViewFor: aView 
		context: aContext 
		do: [ :resultView |
			resultView actionUpdateButton ]
]

{ #category : 'accessing' }
PeTRawDataHolder >> rawDataGtViewFor: aView context: aContext do: aBlock [
	"If you want to customize the view (e.g. reload latest data via API on update button), send this message from your view method"
	
	| result |
	result := aView explicit
		title: 'Raw Data';
		priority: 75;
		stencil: [ 
			(self rawData 
				gtTreeFor: aView 
				context: aContext) asElement ];
		inspectButtonFor: [ self rawData ].
		
	aBlock value: result.
	
	^ result
]

{ #category : 'accessing' }
PeTRawDataHolder >> rawDataXml: aBlock reader: aValuable ifAbsent: absentBlock [
		
	| el |
	el := aBlock value: self rawData .
	
	^ el
		ifNotNil: [ aValuable value: el ] 
		ifNil: [ absentBlock value ].
]

{ #category : 'accessing' }
PeTRawDataHolder >> rawDataXmlAt: aString reader: aValuable ifAbsent: absentBlock [
		
	| el |
	el := self rawData 
		elementAt: aString
		ifAbsent: [ ^ absentBlock value ].
		
	^ aValuable value: el
]

{ #category : 'accessing' }
PeTRawDataHolder >> rawDataXmlGtViewFor: aView context: aContext do: aBlock [
	"If you want to customize the view (e.g. reload latest data via API on update button), send this message from your view method"
	
	| result |
	result := aView forward
		title: 'XML';
		priority: 75;
		object: [ self rawData ];
		view: #gtItemsFor:;
		inspectButtonFor: [ self rawData ].
		
	aBlock value: result.
	
	^ result
]
