Extension { #name : #Measure }

{ #category : #'*PharoEnhancements' }
Measure >> compoundingFormula [
	
	^ AcCompoundingFormula new
		presentValue: self;
		yourself
]
