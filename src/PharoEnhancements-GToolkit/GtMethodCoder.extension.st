Extension { #name : #GtMethodCoder }

{ #category : #'*PharoEnhancements-GToolkit' }
GtMethodCoder >> debugAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 21>

	coderAddOns
		addMainAction: 'Debug AddOn' translated
		icon: BrGlamorousVectorIcons debug
		action: [ :anEditorElement | self debugSelectionOrMethodFrom: anEditorElement ]
]
