Extension { #name : #GtTranscriptNextBuilder }

{ #category : #'*PharoEnhancements-GToolkit' }
GtTranscriptNextBuilder >> putObject: anObject [

	| clickAttr |
	clickAttr := BrTextClickAttribute new 
		action: [ :aText :aTarget :aTextEditor :anEvent | 
			anEvent target phlow spawnObject: anObject ].
	self
		attribute: clickAttr;	
		putAll: anObject printString
]
