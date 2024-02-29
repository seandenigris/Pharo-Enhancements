Class {
	#name : #PeSignalingCsvReader,
	#superclass : #NeoCSVReader,
	#category : #'PharoEnhancements-GToolkit-CSV'
}

{ #category : #accessing }
PeSignalingCsvReader >> do: aBlock [
	| recordsProcessed |
	recordsProcessed := 0.
	super do: [ :e | 
		aBlock value: e.
		recordsProcessed := recordsProcessed + 1.
		recordsProcessed asBeaconSignal emit.
		Processor yield ]
]
