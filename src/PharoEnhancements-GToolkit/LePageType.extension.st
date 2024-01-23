Extension { #name : #LePageType }

{ #category : #'*PharoEnhancements-GToolkit' }
LePageType >> asContentUIModel [
	^ LePageViewModel new pageModel: self page
]

{ #category : #'*PharoEnhancements-GToolkit' }
LePageType >> pageElementClass [
	^ PeLePageElement
]

{ #category : #'*PharoEnhancements-GToolkit' }
LePageType >> snippetBuilder [
	^ LeParentSnippetBuilder new
		parent: self page;
		database: self page database.
]

{ #category : #'*PharoEnhancements-GToolkit' }
LePageType class >> updatePrimaryDBPageTypes [

	LeDatabasesRegistry defaultPrimaryDatabase updatePageTypes
]
