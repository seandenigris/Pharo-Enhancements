Extension { #name : #ShSlotChangeDetector }

{ #category : #'*PharoEnhancements' }
ShSlotChangeDetector >> initialize [
	super initialize.
	builderAccessor := [ :e | e allSlots asArray ].
	classAccessor := [ :e | e allSlots asArray].
	comparer := [ :a :b |  self compareSlotCollection: a with: b ]
]
