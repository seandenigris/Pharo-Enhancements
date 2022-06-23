Extension { #name : #GtSpotterStart }

{ #category : #'*PharoEnhancements-GToolkit' }
GtSpotterStart >> gtSpotterAddressBookFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority:  1000;
		allCandidates: [ :x | {GtABAddressBook default} ];
		title: 'Address books';
		itemName: [ :addressBook | addressBook label ];
		matchSubstring;
		candidatesLimit: 5;
		wantsToDisplayOnEmptyQuery: true
]
