Extension { #name : #RBNode }

{ #category : #'*PharoEnhancements' }
RBNode >> peTransformer [
	^ PeAST_Transformer on: self
]
