Extension { #name : #MAReferenceDescription }

{ #category : #'*PharoEnhancements-GToolkit' }
MAReferenceDescription >> gtSearchDelegateTo: anObjectValuable message: aSymbol [
	self gtSearchDelegateTo: anObjectValuable message: aSymbol do: #yourself
]

{ #category : #'*PharoEnhancements-GToolkit' }
MAReferenceDescription >> gtSearchDelegateTo: anObjectValuable message: aSymbol do: configBlock [
	| source |
	source := PeGtDelegatedSearch 
		to: anObjectValuable 
		message: aSymbol
		configured: configBlock.
	self gtSearchSource: source
]
