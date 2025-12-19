Extension { #name : 'LeDatabase' }

{ #category : '*PharoEnhancements-GToolkit' }
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

{ #category : '*PharoEnhancements-GToolkit' }
LeDatabase >> pagesByDate [

	^ pagesByDate ifNil: [ 
			pagesByDate := SortedCollection new 
				sortBlock: #latestEditTime descending.
			pagesByType valuesDo: [ :aCollectionOfPages |
				pagesByDate addAll: aCollectionOfPages ].
			pagesByDate ]
]

{ #category : '*PharoEnhancements-GToolkit' }
LeDatabase >> updatePageTypes [

	"Copy-pasted from LeDatabase>>#initialize"
	LePageType allSubclassesDo: [ :pageType |
		pagesByType
			at: pageType pageTypeClass
			ifAbsentPut: [ Dictionary new ] ].
			
	"Reader/writer mappings now cached"
	LeJsonV4 cleanUp.
]
