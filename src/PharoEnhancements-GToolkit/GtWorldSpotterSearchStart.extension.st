Extension { #name : #GtWorldSpotterSearchStart }

{ #category : #'*PharoEnhancements-GToolkit' }
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
