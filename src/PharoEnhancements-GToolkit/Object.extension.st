Extension { #name : #Object }

{ #category : #'*PharoEnhancements-GToolkit' }
Object >> gtDisplayText [
	
	^ self displayString asRopedText
]

{ #category : #'*PharoEnhancements-GToolkit' }
Object >> gtPrintFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Print';
		priority: 110;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self printString asRopedText ];
		actionUpdateButton
]

{ #category : #'*PharoEnhancements-GToolkit' }
Object class >> gtSpotterItemsFromString: aString [
	^ { self fromString: aString }
]

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
				label: 'Pick Up and Bind';
				action: [ self pePickUp ];
				aptitude: BrGlamorousButtonWithIconAptitude;
				addAptitude: (BrGlamorousWithDropdownAptitude
					handle: [ BrButton new
						icon: BrGlamorousVectorIcons repair;
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

	"The reason I have this method (vs. declaring an MAAction) is to prevent a dependency to Magritte"
]

{ #category : #'*PharoEnhancements-GToolkit' }
Object class >> peGtSpotterNewInstanceFor: aSearch [
	^ aSearch list
		title: 'New ' , self name;
		priority: 50;
		itemName: [ :result | '+ ', result gtDisplayText ];
		search: [ :aContext | { self fromString: aContext searchQuery trimmed } ]
]
