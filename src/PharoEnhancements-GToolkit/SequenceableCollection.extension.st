Extension { #name : #SequenceableCollection }

{ #category : #'*PharoEnhancements-GToolkit' }
SequenceableCollection >> gtItemsSearchFor: aSearch [
	<gtSearch>
	
	^ aSearch list
		priority: 10;
		title: 'Items';
		items: [ self ];
		filterBySubstring;
		withoutItemsLimit
]
