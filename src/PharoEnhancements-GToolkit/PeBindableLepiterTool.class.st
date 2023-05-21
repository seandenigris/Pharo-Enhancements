Class {
	#name : #PeBindableLepiterTool,
	#superclass : #PeBindableGtTool,
	#category : #'PharoEnhancements-GToolkit-Variable-Sharing'
}

{ #category : #accessing }
PeBindableLepiterTool >> toolTitle [
	
	^ (((self toolElement childNamed: #content) childNamed: #header) childNamed: #title) text asString
]
