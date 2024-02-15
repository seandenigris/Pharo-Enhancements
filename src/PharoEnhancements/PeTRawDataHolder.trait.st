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
PeTRawDataHolder >> rawDataGtViewFor: aView context: aContext [
	<gtView>
	
	^ self 
		rawDataGtViewFor: aView 
		context: aContext 
		do: [ :resultView |
			resultView actionUpdateButton ]
]

{ #category : #accessing }
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
