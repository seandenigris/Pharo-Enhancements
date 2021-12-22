Extension { #name : #Object }

{ #category : #'*PharoEnhancements-GToolkit' }
Object >> peGtActionPickUpFor: anAction [
	<gtAction>
	^ anAction explicit
		stencil: [ 
			"Adapted from GtSpotterDropdownButtonStencil>>#create"
			| aButton |
			aButton := BrButton new.
			
			aButton
				icon: BrGlamorousVectorIcons repair;
				label: 'aDescription label';
				action: [ self pePickUp ];
				aptitude: BrGlamorousButtonWithIconAptitude;
				addAptitude: (BrGlamorousWithDropdownAptitude
					handle: [ BrButton new
						icon: BrGlamorousVectorIcons repair;
						label: 'aDescription label';
						aptitude:
							BrGlamorousButtonWithIconAptitude
								- BrGlamorousButtonWithLabelTooltipAptitude
								- BrGlamorousButtonExteriorAptitude ]
						content: [ 
							(PeGtToolVariableBinder targetValue: self) treeElement 
								vFitContent; 
								hFitContent; 
								yourself ]);
				yourself ].

	"The reason I have this method is to prevent a dependency to GT"
]
