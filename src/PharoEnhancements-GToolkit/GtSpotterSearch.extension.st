Extension { #name : 'GtSpotterSearch' }

{ #category : '*PharoEnhancements-GToolkit' }
GtSpotterSearch >> pePreviewObject: aBlock [

	self previewElement: [ :anObject |
		| previewObject |
		previewObject := aBlock value: anObject.
		(previewObject gtViewsFor: GtPhlowView empty) originalView
			asElementDo: [ :anElement | anElement ] ]
			
	"Adapted from GtSpotterSearch>>#privateDefaultPreviewElementFor:"
]
