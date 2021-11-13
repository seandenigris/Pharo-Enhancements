Extension { #name : #BlElement }

{ #category : #'*PharoEnhancements-GToolkit' }
BlElement >> gtAllShortcutsFor: aView [
	<gtView>
	| shortcuts |
	shortcuts := SortedCollection sortUsing: (#combination collatedBy: #displayString).
	self withAllParentsDo: [ :e | shortcuts addAll: e shortcuts ].
	shortcuts ifEmpty: [ ^ aView empty ].
	^ aView columnedList
		title: 'Shortcuts (All)' translated;
		priority: 11;
		items: [ shortcuts asArray ];
		column: 'Name' text: [ :each | each name ifNil: [ each gtDisplayString ] ];
		column: 'Combination' text: [ :each | each combination gtDisplayString ]
]
