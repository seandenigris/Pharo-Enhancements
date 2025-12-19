Extension { #name : 'LeToolbarElement' }

{ #category : '*PharoEnhancements-GToolkit' }
LeToolbarElement >> initialize [
	super initialize.
	self initializeToolbarElement.
	
	self flag: 'If there are no issues after playing with this for a bit, propose upstream change'.
	self layout: BlLinearLayout vertical.
	
	self addChild: self toolbarElement as: #toolbar.
	
	self addAptitude: (BrLayoutResizerAptitude new
		hInherit: self;
		vAnyToFitContent: self;
		hInherit: self toolbarElement;
		vAnyToFitContent: self toolbarElement).
]
