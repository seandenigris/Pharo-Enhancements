Extension { #name : #LePythonSnippetElement }

{ #category : #'*PharoEnhancements-GToolkit' }
LePythonSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.

	self updateLanguageLabel.
	self coder
		pythonApplicationStrategy: self serverStrategy;
		pharoBindings: self snippetViewModel snippetBindings;
		selfObject: self snippetViewModel selfObject.
]
