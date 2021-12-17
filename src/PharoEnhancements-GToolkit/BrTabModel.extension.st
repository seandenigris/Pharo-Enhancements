Extension { #name : #BrTabModel }

{ #category : #'*PharoEnhancements-GToolkit' }
BrTabModel >> peGtPharoSourceCoderTreeChildrenForValue: anObject [
	^ OrderedCollection streamContents: [ :str | 
		self model root allChildrenBreadthFirstDo: [ :e |
			(PeBindableGtTool canModel: e) ifTrue: [ 
				| instance |
				instance := PeBindableGtTool new
					tab: self;
					toolContentElement: e;
					yourself.
				str nextPut: instance ] ] ]
]

{ #category : #'*PharoEnhancements-GToolkit' }
BrTabModel >> peGtPharoSourceCoderTreeInitializeNode: aNodeElement [
		(aNodeElement childNamed: #label) text: self model title.
		(aNodeElement childNamed: #bind) visibility: BlVisibility hidden
]
