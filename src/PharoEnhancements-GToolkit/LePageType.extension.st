Extension { #name : #LePageType }

{ #category : #'*PharoEnhancements-GToolkit' }
LePageType >> peCustomizePageToolContentTreeElement: aLePageToolContentElement [
	| header |
	header := aLePageToolContentElement headerElement.
	header removeChildNamed: #peHeader
]

{ #category : #'*PharoEnhancements-GToolkit' }
LePageType >> snippetBuilder [
	^ LeParentSnippetBuilder new
		parent: self page;
		database: self page database.
]
