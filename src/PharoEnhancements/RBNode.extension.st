Extension { #name : #RBNode }

{ #category : #'*PharoEnhancements' }
RBNode >> peTransformer [
	^ PeASTTransformer on: self
]
