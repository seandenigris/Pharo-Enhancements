Extension { #name : #GtHomeSection }

{ #category : #'*PharoEnhancements-GToolkit' }
GtHomeSection >> buttonTitled: aString iconFileNamed: iconable tooltip: tipString inspecting: aValuable [

	| icon |
	icon := iconable isString
		ifTrue: [ self iconFromFileNamed: iconable ]
		ifFalse: [ GtFileUtility imageElementFromFileReference: iconable ].

	^ GtToolButtonStencil new 
		title: aString;
		icon: icon;
		iconSize: 50@50;
		action: [ :card | 
			self
				showSpaceWithTitle: aString
				with:
					(GtInspector
						createOn: aValuable value) maximized
				from: card ];
		description: tipString.
]

{ #category : #'*PharoEnhancements-GToolkit' }
GtHomeSection >> iconFromFileNamed: aString [
	
	^ GtFileUtility imageElementFromFileReference: self iconFolder / aString.
]
