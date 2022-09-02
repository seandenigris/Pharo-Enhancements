Extension { #name : #GtHomeSection }

{ #category : #'*PharoEnhancements-GToolkit' }
GtHomeSection >> buttonTitled: aString iconFileNamed: iconName tooltip: tipString inspecting: anObject [
	^ GtToolButtonStencil new 
		title: aString;
		icon: (self iconFromFileNamed: iconName);
		iconSize: 50@50;
		action: [ :card | 
			self
				showSpaceWithTitle: aString
				with:
					(GtInspector
						createOn: anObject) maximized
				from: card ];
		description: tipString.
]

{ #category : #'*PharoEnhancements-GToolkit' }
GtHomeSection >> iconFromFileNamed: aString [
	| result |
	result := GtFileUtility imageElementFromFileReference: self iconFolder / aString.
	^ result
		alignBottomCenter;
		yourself	
]
