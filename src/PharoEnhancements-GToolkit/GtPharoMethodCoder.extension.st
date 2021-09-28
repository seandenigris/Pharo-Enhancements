Extension { #name : 'GtPharoMethodCoder' }

{ #category : '*PharoEnhancements-GToolkit' }
GtPharoMethodCoder >> debugAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 21>

	coderAddOns
		addMainAction: 'Debug AddOn' translated
		icon: BrGlamorousVectorIcons debug
		action: [ :anEditorElement | self debugSelectionOrMethodFrom: anEditorElement ]
]
