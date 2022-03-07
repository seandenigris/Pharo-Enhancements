Extension { #name : #LeClassNameArgumentNode }

{ #category : #'*PharoEnhancements-GToolkit' }
LeClassNameArgumentNode >> isMetaSide [
	^ self className endsWith: ' class'
]
