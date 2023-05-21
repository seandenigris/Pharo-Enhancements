Extension { #name : #BlSpace }

{ #category : #'*PharoEnhancements-GToolkit' }
BlSpace >> peGtPharoSourceCoderTreeChildrenForValue: anObject [
	^ OrderedCollection streamContents: [ :str | 
		self root allChildrenBreadthFirstDo: [ :e |
			(PeBindableGtTool canModel: e) ifTrue: [ 
				| instance |
				instance := PeBindableGtTool on: e.
				str nextPut: instance ] ] ]
]

{ #category : #'*PharoEnhancements-GToolkit' }
BlSpace >> peGtPharoSourceCoderTreeInitializeNode: aNodeElement [
	(aNodeElement childNamed: #label) text: self title.
	(aNodeElement childNamed: #bind) visibility: BlVisibility hidden
]
