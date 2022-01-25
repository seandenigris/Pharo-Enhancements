Extension { #name : #LePageType }

{ #category : #'*PharoEnhancements-GToolkit' }
LePageType >> peCustomizePageToolContentTreeElement: aLePageToolContentElement [
	aLePageToolContentElement withTitleAndRemoveAction
]

{ #category : #'*PharoEnhancements-GToolkit' }
LePageType >> snippetBuilder [
	^ LeParentSnippetBuilder new
		parent: self page;
		database: self page database.
]
