Extension { #name : #GtPhlowView }

{ #category : #'*PharoEnhancements-GToolkit' }
GtPhlowView >> inspectButtonFor: aValuable [

	self actionButtonIcon: BrGlamorousVectorIcons inspect
			tooltip: 'Inspect ', self title
			action: [ :aButton :aTab | 
				aButton phlow spawnObject: aValuable value ]
]
