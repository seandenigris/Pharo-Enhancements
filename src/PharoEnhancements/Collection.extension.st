Extension { #name : 'Collection' }

{ #category : '*PharoEnhancements' }
Collection >> detectMax: aBlock overThreshold: aMagnitude [
	"Just like detectMax:, but only consider values greater than aNumber. For example: 
		#(1 2) detectMax: #yourself overThreshold: 3 >>> nil
		#(1 2) detectMax: #yourself overThreshold: 1 >>> 2
		
	`detectMax: aBlock` could be rewritten as `detectMax: aBlock overThreshold: MinusInfinity"

	| maxElement maxValue |
	self do: [:each | | val | 
		maxValue isNil
			ifFalse: [
				val := aBlock value: each.
				(val > maxValue and: [val > aMagnitude]) ifTrue: [
					maxElement := each.
					maxValue := val]]
			ifTrue: [
				maxValue := aBlock value: each.
				maxValue > aMagnitude ifTrue: [maxElement := each]]].
	^ maxElement
]
