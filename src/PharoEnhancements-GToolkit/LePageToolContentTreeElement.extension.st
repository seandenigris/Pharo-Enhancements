Extension { #name : 'LePageToolContentTreeElement' }

{ #category : '*PharoEnhancements-GToolkit' }
LePageToolContentTreeElement >> onPageViewModelChanged [
	| pageSnippetsTreeViewModel pageIncomingLinksViewModel |
	super onPageViewModelChanged.

	self pageViewModel ensurePageHasAtLeastOneSnippet.

	pageSnippetsTreeViewModel := LeSnippetsTreeViewModel new
		sharedSnippetContext: self pageViewModel sharedSnippetContext.

	pageIncomingLinksViewModel := self class incomingLinksViewModelClass new.

	snippetsViewModel := LeCompositeContentCollectionViewModel new
		addContentCollectionViewModel: pageSnippetsTreeViewModel;
		addContentCollectionViewModel: pageIncomingLinksViewModel;
		content: self pageViewModel pageModel.

	self primitiveUpdateTree.
	
	footerToolbarElement pageModel: self pageViewModel pageModel.

	self pageViewModel shouldFocusFirstSnippet
		ifTrue: [ pageSnippetsTreeViewModel focusFirstSnippet ].
		
	self flag: 'PharoEnhancements monkey patch to allow element customization, simulating page subclasses'.
	self peAsLePageElement onPageViewModelChanged.
]
