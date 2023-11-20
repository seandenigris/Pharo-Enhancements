Class {
	#name : #PePyDataSeries,
	#superclass : #Object,
	#instVars : [
		'pythonInstance'
	],
	#category : #'PharoEnhancements-PolyMath'
}

{ #category : #accessing }
PePyDataSeries >> asDataSeries [
	| rawRecords |
	rawRecords := self toDictionary.
	^ DataSeries newFrom: rawRecords associations
]

{ #category : #accessing }
PePyDataSeries >> chart [
	| aData aBarWidthScale |
	aData := GtPlotterDataGroup new values: self asDataSeries sortDescending associations.
	aData := aData colored: Color blue.
	aData := aData labelled: [ :e | e key ].
	
	aBarWidthScale := GtPlotterLinearScale new 
		domainFrom: 0 
		to: [ 7836 ] value.
	
	^ GtPlotterHorizontalBarChart new
		barHeightData: [ :e | e ];
		barWidthData: [ :e | e value ];
		barWidthScale: aBarWidthScale;
		with: aData
]

{ #category : #accessing }
PePyDataSeries >> chartNotNil [
	| aData aBarWidthScale dataArray |
	dataArray := self asDataSeries sortDescending
		removeKey: nil;
		associations.
	aData := GtPlotterDataGroup new values: dataArray.
	aData := aData colored: Color blue.
	aData := aData labelled: [ :e | e key ].
	
	aBarWidthScale := GtPlotterLinearScale new 
		domainFrom: 0 
		to: [ 
			dataArray 
				inject: 0 into: [ :anAmount :eachValue | 
					anAmount max: eachValue value ]  ] value.
	
	^ GtPlotterHorizontalBarChart new
		barHeightData: [ :e | e ];
		barWidthData: [ :e | e value ];
		barWidthScale: aBarWidthScale;
		with: aData
]

{ #category : #accessing }
PePyDataSeries >> crossTabulateWith: rhs [
	"
	crosstab function doc: https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.crosstab.html
	fillna trick via https://stackoverflow.com/a/33304212"
	
	| cmd |
	cmd := PBApplication uniqueInstance newCommandSourceFactory
		source: 'pd.crosstab(self.fillna(''missing''), rhs.fillna(''missing''), dropna=False, margins=True)';
		addBindings: { 
			#self -> self pythonInstance.
			#rhs -> rhs pythonInstance }.
			
	^ self frameClass fromCommand: cmd
]

{ #category : #accessing }
PePyDataSeries >> frameClass [
	^ PePyDataFrame
]

{ #category : #accessing }
PePyDataSeries >> pythonInstance [
	^ pythonInstance
]

{ #category : #'as yet unclassified' }
PePyDataSeries >> pythonInstance: aString [ 
	pythonInstance := aString
]

{ #category : #accessing }
PePyDataSeries >> toCsv [
	"Preserves order, but not type"
	^ PBApplication uniqueInstance newCommandSourceFactory
		source: 'self.to_csv()';
		bindingAt: #self put: self pythonInstance;
		sendAndWait.
]

{ #category : #accessing }
PePyDataSeries >> toDictionary [
	"Preserves type, but not order"
	^ PBApplication uniqueInstance newCommandSourceFactory
		source: 'self.to_dict()';
		bindingAt: #self put: self pythonInstance;
		sendAndWait.
]

{ #category : #accessing }
PePyDataSeries >> toJson [
	"Preserves type, but not order"
	^ PBApplication uniqueInstance newCommandSourceFactory
		source: 'self.to_json()';
		bindingAt: #self put: self pythonInstance;
		sendAndWait.
]

{ #category : #accessing }
PePyDataSeries >> valueCounts [
	| cmd |
	cmd := PBApplication uniqueInstance newCommandSourceFactory
		source: 'self.value_counts(dropna=False)';
		bindingAt: #self put: self pythonInstance.
	^ self class fromCommand: cmd
]
