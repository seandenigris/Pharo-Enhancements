Extension { #name : #GtTranscriptNextBuilder }

{ #category : #'*PharoEnhancements-GToolkit' }
GtTranscriptNextBuilder >> putObject: anObject [

	| clickAttr |
	clickAttr := BrTextClickAttribute new 
		action: [ :aTBrTextEditorTextualPiece :aWorldElement :anEditorElement :anEvent | 
			"anEditorElement - not!"
			anEvent target phlow spawnObject: 1 ].
	self
		cr;
		attribute: clickAttr;	
		putAll: anObject printString
]
