Extension { #name : #ShiftClassBuilder }

{ #category : #'*PharoEnhancements' }
ShiftClassBuilder >> allSlots [

 	^ self builderEnhancer allSlotsForBuilder: self
]
