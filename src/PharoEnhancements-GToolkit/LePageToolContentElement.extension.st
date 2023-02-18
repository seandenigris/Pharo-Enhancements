Extension { #name : #LePageToolContentElement }

{ #category : #'*PharoEnhancements-GToolkit' }
LePageToolContentElement >> initializeHeaderElement [
	headerElement := BrHorizontalPane new alignCenter.
	headerElement
		clipChildren: false;
		margin: (BlInsets
				top: 5
				left: 8
				bottom: 10
				right: 0).
				
	self flag: 'PharoEnhancements hack follows...'.
	headerElement layout: BlFlowLayout horizontal
]

{ #category : #'*PharoEnhancements-GToolkit' }
LePageToolContentElement >> peAsLePageElement [
	^ PeLePageElement on: self
]
