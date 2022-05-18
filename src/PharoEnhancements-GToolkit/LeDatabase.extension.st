Extension { #name : #LeDatabase }

{ #category : #'*PharoEnhancements-GToolkit' }
LeDatabase >> initialize [
	super initialize.
	readOnly := false.
	pagesByType := IdentityDictionary new.
	pagesByUuid := Dictionary new.
	"Populate all the page types"
	LePageType allSubclassesDo: [ :pageType |
		pagesByType
			at: pageType pageTypeClass
			ifAbsentPut: [ Dictionary new ] ].
	blocksByUID := Dictionary new.
	self ensureExplicitLinksStorage.
	self weak
		when: LePageTitleChanged 
		send: #onPageTitleChanged: 
		to: self.
]

{ #category : #'*PharoEnhancements-GToolkit' }
LeDatabase >> updatePageTypes [
	LePageType allSubclassesDo: [ :pageType |
		pagesByType
			at: pageType pageTypeClass
			ifAbsentPut: [ Dictionary new ] ].
			
	"Copy-pasted from LeDatabase>>#initialize"
]
