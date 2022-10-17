Extension { #name : #GtSpotterSearch }

{ #category : #'*PharoEnhancements-GToolkit' }
GtSpotterSearch >> itemSpawnAfter: aBlock [
	
	self itemActLogic: [ :anObject :step :spotterElement |
		aBlock cull: anObject cull: step cull: spotterElement.
		spotterElement phlow spawnObject: anObject ]
]

{ #category : #'*PharoEnhancements-GToolkit' }
GtSpotterSearch >> pePreviewObject: aBlock [

	self previewElement: [ :anObject |
		| previewObject |
		previewObject := aBlock value: anObject.
		(previewObject gtViewsFor: GtPhlowView empty) originalView
			asElementDo: [ :anElement | anElement ] ]
			
	"Adapted from GtSpotterSearch>>#privateDefaultPreviewElementFor:"
]

{ #category : #'*PharoEnhancements-GToolkit' }
GtSpotterSearch >> peSend: aBlock [
	
	self itemActLogic: [ :anObject :step :spotterElement |
		| result |
		result := aBlock cull: anObject cull: step cull: spotterElement.
		spotterElement phlow spawnObject: result ]
]
