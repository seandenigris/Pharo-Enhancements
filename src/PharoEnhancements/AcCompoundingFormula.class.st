Class {
	#name : #AcCompoundingFormula,
	#superclass : #Object,
	#instVars : [
		'presentValue',
		'nominalRate',
		'timeUnits',
		'periods'
	],
	#category : #'PharoEnhancements-Aconcagua'
}

{ #category : #calculating }
AcCompoundingFormula >> calculate [
	
	| exponent parenthesized |
	exponent := self periods * self timeUnits.
	parenthesized := 1 + (self nominalRate / self periods).
	^ self presentValue * (parenthesized raisedTo: exponent)
]

{ #category : #accessing }
AcCompoundingFormula >> excelFormula [

	 | template |
	template := '= {PV} * (1 + {r}/{n}) ^ ({n} * {t})'.
	 
	^ template format: {
		'PV' -> self presentValue amount asFloat displayString.
		'r' -> self nominalRate displayString.
		'n' -> self periods displayString.
		't' -> self timeUnits displayString.
	 } asDictionary.
]

{ #category : #accessing }
AcCompoundingFormula >> nominalRate [
	^ nominalRate
]

{ #category : #accessing }
AcCompoundingFormula >> nominalRate: anObject [
	nominalRate := anObject
]

{ #category : #accessing }
AcCompoundingFormula >> periods [
	^ periods ifNil: [ 1 ]
]

{ #category : #accessing }
AcCompoundingFormula >> periods: anObject [
	periods := anObject
]

{ #category : #accessing }
AcCompoundingFormula >> presentValue [
	^ presentValue
]

{ #category : #accessing }
AcCompoundingFormula >> presentValue: anObject [
	presentValue := anObject
]

{ #category : #accessing }
AcCompoundingFormula >> timeUnits [
	^ timeUnits
]

{ #category : #accessing }
AcCompoundingFormula >> timeUnits: anObject [
	timeUnits := anObject
]
