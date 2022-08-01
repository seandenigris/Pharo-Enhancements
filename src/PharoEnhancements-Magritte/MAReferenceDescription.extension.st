Extension { #name : #MAReferenceDescription }

{ #category : #'*PharoEnhancements-Magritte' }
MAReferenceDescription >> gtSearchDelegateTo: anObjectValuable message: aSymbol [
	| source |
	source := PeGtDelegatedSearch 
		to: anObjectValuable 
		message: aSymbol.
	self gtSearchSource: source
]
