Extension { #name : #GtSpotterStart }

{ #category : #'*PharoEnhancements-GToolkit' }
GtSpotterStart >> gtSpotterAddressBookFor: aSearch [
	<gtSearch>
	
	^ aSearch list
		priority: 1000;
		items: [ :x | {GtABAddressBook default} ];
		title: 'Address books';
		itemName: [ :addressBook | addressBook label ];
		filterBySubstring;
		wantsToDisplayOnEmptyQuery: true
]
