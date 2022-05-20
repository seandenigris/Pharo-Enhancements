Extension { #name : #ShDefaultBuilderEnhancer }

{ #category : #'*PharoEnhancements' }
ShDefaultBuilderEnhancer >> allSlotsForBuilder: aBuilder [

 	^ aBuilder layoutDefinition allSlots
]
