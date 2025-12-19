Extension { #name : 'TBlTextStyleable' }

{ #category : '*PharoEnhancements-GToolkit' }
TBlTextStyleable >> strikethrough [
	self attributesBuilder attribute: BlTextDecorationAttribute new lineThrough
]
