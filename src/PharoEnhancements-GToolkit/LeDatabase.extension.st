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
LeDatabase >> tocEnsured [
	"Create a flat TOC page with ONE text snippet per page"

	| tocTitle tocPage pages |
	
	tocTitle := 'TOC'.
	
	"Find or create the TOC page"
	tocPage := (self pages
		detect: [ :p | p title = tocTitle ]
		ifFound: [ :p | ^ p ]
		ifNone: [ self pageBuilder title: tocTitle; add ]).
	
	"Optional: clear existing snippets on the TOC page
	(tocPage respondsTo: #snippets) ifTrue: [
		(tocPage snippets copy) do: [ :snippet |
			(tocPage respondsTo: #removeSnippet:)
				ifTrue: [ tocPage removeSnippet: snippet ] ] ]."
	
	"Collect pages to link (exclude TOC itself)"
	pages := (self pages
		select: [ :p |
			p title notNil
			and: [ p title notEmpty
			and: [ p ~= tocPage ] ] ])
		asSortedCollection: [ :a :b | a title < b title ].
	
	"Add one snippet per page"
	pages do: [ :page |
		tocPage addSnippet:
			(LeTextSnippet string: '[[' , page title , ']]') ].

	^ tocPage
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
