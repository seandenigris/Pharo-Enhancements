Extension { #name : #GtSpotterSearch }

{ #category : #'*PharoEnhancements-GToolkit' }
GtSpotterSearch >> itemSpawnAfter: aBlock [
	
	self itemActLogic: [ :anObject :step :spotterElement |
		aBlock cull: anObject cull: step cull: spotterElement.
		spotterElement phlow spawnObject: anObject ]
]
