Extension { #name : #MAActionDescription }

{ #category : #'*PharoEnhancements-GToolkit' }
MAActionDescription class >> pePickUpOnGtAction: button withReciever: anObject [

	| icon label dropdownAptitude aptitude |
	icon := button icon.
	label := button label.
	
	dropdownAptitude := BrGlamorousWithDropdownAptitude
		handle: [
			BrButton new
				aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonIconAptitude;
				icon: icon ]
		content: [ (PeGtToolVariableBinder targetValue: anObject) treeElement ].
		
	button aptitude looks
		detect: [ :e | e isKindOf: BrGlamorousWithDropdownAptitude ]
		ifNone: [ button aptitude + dropdownAptitude ].
			
	button 
		icon: icon;
		label: label;
		fireEvent: BrDropdownShowWish new
		
	"The reason I have this method is to prevent a dependency to GT"
]
