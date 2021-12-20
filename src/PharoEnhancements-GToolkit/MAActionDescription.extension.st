Extension { #name : #MAActionDescription }

{ #category : #'*PharoEnhancements-GToolkit' }
MAActionDescription class >> pePickUpOnGtAction: anAction of: anObject using: aDescription [

	^ anAction explicit
		stencil: [ 
			"Adapted from GtSpotterDropdownButtonStencil>>#create"
			| aButton |
			aButton := BrButton new.
			
			aButton
				icon: BrGlamorousVectorIcons repair;
				label: aDescription label;
				aptitude: BrGlamorousButtonWithIconAptitude;
				addAptitude: (BrGlamorousWithDropdownAptitude
					handle: [ BrButton new
						icon: BrGlamorousVectorIcons repair;
						label: aDescription label;
						aptitude:
							BrGlamorousButtonWithIconAptitude
								- BrGlamorousButtonWithLabelTooltipAptitude
								- BrGlamorousButtonExteriorAptitude ]
						content: [ 
							(PeGtToolVariableBinder targetValue: anObject) treeElement 
								vFitContent; 
								hFitContent; 
								yourself ]);
				yourself ].

	"The reason I have this method is to prevent a dependency to GT"
]
