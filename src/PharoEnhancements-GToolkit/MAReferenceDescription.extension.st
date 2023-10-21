Extension { #name : #MAReferenceDescription }

{ #category : #'*PharoEnhancements-GToolkit' }
MAReferenceDescription >> gtSearchDelegateTo: anObjectValuable message: aSymbol [
	self gtSearchDelegateTo: anObjectValuable message: aSymbol transform: nil
]

{ #category : #'*PharoEnhancements-GToolkit' }
MAReferenceDescription >> gtSearchDelegateTo: anObjectValuable message: aSymbol transform: sendBlock [
	| source |
	source := PeGtDelegatedSearch 
		to: anObjectValuable 
		message: aSymbol
		transform: sendBlock.
	self gtSearchSource: source
]
