Extension { #name : #RBVariableNode }

{ #category : #'*PharoEnhancements-GToolkit' }
RBVariableNode >> peGtPharoSourceCoderTreeChildren [
	^ #()
]

{ #category : #'*PharoEnhancements-GToolkit' }
RBVariableNode >> peGtPharoSourceCoderTreeInitializeNode: aNodeElement [
	(aNodeElement childNamed: #label) text: self name.
	(aNodeElement childNamed: #bind) visibility: BlVisibility visible
]
