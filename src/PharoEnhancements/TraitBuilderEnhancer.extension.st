Extension { #name : #TraitBuilderEnhancer }

{ #category : #'*PharoEnhancements' }
TraitBuilderEnhancer >> allSlotsForBuilder: aBuilder [

 	| resultingSlots |

 	resultingSlots := self
 		eliminateDuplicates: aBuilder layoutDefinition slots , aBuilder traitComposition asTraitComposition slotsCopy
 		withSuperclassSlots: (aBuilder superclass ifNil: [#()] ifNotNil:[ :x | x allSlots]).

 	^ resultingSlots
]

{ #category : #'*PharoEnhancements' }
TraitBuilderEnhancer >> configureClass: newClass superclass: superclass withLayoutType: layoutType slots: slots [
	| resultingSlots |
	self validateTraitComposition: self traitComposition ofClass: builder oldClass.

	resultingSlots := self allSlotsForBuilder: builder.

	newClass superclass: superclass withLayoutType: layoutType slots: resultingSlots
]
