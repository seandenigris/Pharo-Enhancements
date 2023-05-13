Extension { #name : #GtHomeSection }

{ #category : #'*PharoEnhancements-GToolkit' }
GtHomeSection >> buttonTitled: aString iconFileNamed: iconName tooltip: tipString inspecting: aValuable [
	^ GtToolButtonStencil new 
		title: aString;
		icon: (self iconFromFileNamed: iconName);
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
