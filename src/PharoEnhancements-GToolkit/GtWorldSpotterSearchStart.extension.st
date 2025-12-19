Extension { #name : 'GtWorldSpotterSearchStart' }

{ #category : '*PharoEnhancements-GToolkit' }
GtWorldSpotterSearchStart >> gtSpotterContainingSubPartsFor: aSearch [
	<gtSearch>
	self hasKnowledgeBase
		ifFalse: [ ^ aSearch empty ].
	self hasChildren
		ifFalse: [ ^ aSearch empty ].
	
	^ aSearch explicit
		priority: 23;
		title: 'Page contents';
		search: [ :aContext |
			[
			| filter results |
			results := OrderedCollection new.
			filter := LeSubstringFilter new
				caseSensitive: false;
				query: aContext searchQuery.
			self knowledgeBase pagesDo: [ :eachPage |
				(filter isMatchedItem: eachPage)
					ifTrue: [ results add: eachPage ] ].
			results asAsyncStream
			] asAsyncFuture asAsyncStream flatten
		];
		itemName: #spotterItemName
]

{ #category : '*PharoEnhancements-GToolkit' }
GtWorldSpotterSearchStart >> peGtSSearchNewPageFor: aStep [
	<gtSearch>
	
	self hasKnowledgeBase ifFalse: [ ^ self ].
	
	^ aStep explicit
		title: 'New Page';
		priority: 50;
		itemName: [ :aPage | 'Create new page: ', aPage title ];
		"previewObject: [ :aPageTitle | LePage named: aPageTitle ];"
		search: [ :context | 
				| isExistingPage pageTitle |
				pageTitle := context searchQuery trimmed.
				isExistingPage := self knowledgeBase pagesByName anySatisfy: [ :eachPage | 
					eachPage title = pageTitle ].
				isExistingPage 
					ifFalse: [ { LePage named: pageTitle } ]
					ifTrue: [ #() ] ];
		send: [ :aPage :spotterStep | self knowledgeBase addPage: aPage ]
		
	"Adapted from the disabled #gtSpotterNewPageFor:"
]
