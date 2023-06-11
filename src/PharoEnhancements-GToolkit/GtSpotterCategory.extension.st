Extension { #name : #GtSpotterCategory }

{ #category : #'*PharoEnhancements-GToolkit' }
GtSpotterCategory >> gtViewItemsFor: aView [
	<gtView>

	^ aView forward
		title: 'Items';
		priority: 5;
		object: self items;
		view: #gtLiveFor:;
		actionUpdateButton
]
