Extension { #name : #LeTime }

{ #category : #'*PharoEnhancements-GToolkit' }
LeTime >> < aTime [
	^ self class = aTime class and: [ 
		self time < aTime time ]
]

{ #category : #'*PharoEnhancements-GToolkit' }
LeTime >> threeWayCompareTo: aTime [
	^ self time threeWayCompareTo: aTime time
]
