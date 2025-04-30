Extension { #name : #PeTEnumerable }

{ #category : #'*PharoEnhancements-GToolkit' }
PeTEnumerable >> itemsGtViewFor: aView [
	<gtView>
	
	^ (aView maColumnedListOf: self privateEnumerable atRandom class)
		title: 'Items';
		priority: 100;
		items: [ self privateEnumerable ];
		actionUpdateButton;
		inspectButtonFor: [ self privateEnumerable ].
]
