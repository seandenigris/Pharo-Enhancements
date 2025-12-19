Extension { #name : 'GtHomeToolsSection' }

{ #category : '*PharoEnhancements-GToolkit' }
GtHomeToolsSection >> newMorphicWorldButtonStencil [
	<gtToolButton>

	^ GtToolButtonStencil new 
		title: 'Morphic World';
		priority: 60;
		icon: BrGlamorousVectorIcons largeWindow;
		action: [ :card | card space host openMorphicWorld ];
		description: 'The legacy Morphic World interface and tools.'
]
