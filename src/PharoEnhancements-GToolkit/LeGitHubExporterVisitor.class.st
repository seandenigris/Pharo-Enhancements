Class {
	#name : 'LeGitHubExporterVisitor',
	#superclass : 'Object',
	#traits : 'TLeModelVisitor',
	#classTraits : 'TLeModelVisitor classTrait',
	#instVars : [
		'stream',
		'level',
		'externalPicturesWriter',
		'isOutline',
		'shouldIncludeTitle'
	],
	#category : 'PharoEnhancements-GToolkit-Lepiter-Exporting',
	#package : 'PharoEnhancements-GToolkit',
	#tag : 'Lepiter-Exporting'
}

{ #category : 'accessing' }
LeGitHubExporterVisitor >> isOutline [

	^ isOutline ifNil: [ false ]
]

{ #category : 'accessing' }
LeGitHubExporterVisitor >> isOutline: anObject [

	isOutline := anObject
]

{ #category : 'accessing' }
LeGitHubExporterVisitor >> level [

	^ level ifNil: [ level := -1 ]
]

{ #category : 'accessing' }
LeGitHubExporterVisitor >> level: anObject [

	level := anObject
]

{ #category : 'visiting' }
LeGitHubExporterVisitor >> newLine [
	^ Character cr asString
]

{ #category : 'accessing' }
LeGitHubExporterVisitor >> shouldIncludeTitle [

	^ shouldIncludeTitle ifNil: [ true ]
]

{ #category : 'accessing' }
LeGitHubExporterVisitor >> shouldIncludeTitle: aBoolean [
	shouldIncludeTitle := aBoolean
]

{ #category : 'accessing' }
LeGitHubExporterVisitor >> stream [

	^ stream ifNil: [ stream := ByteString new writeStream ]
]

{ #category : 'accessing' }
LeGitHubExporterVisitor >> stream: anObject [

	stream := anObject
]

{ #category : 'visiting' }
LeGitHubExporterVisitor >> visitContent: aLeContent [

	| children |
	children := aLeContent children.
	children ifEmpty: [ ^ self ].
	self level: self level + 1.
	children do: [ :child | 
			self stream cr.
			child acceptVisitor: self ].
	self level: self level - 1.
]

{ #category : 'as yet unclassified' }
LeGitHubExporterVisitor >> visitGitHubIssueSnippet: aLeGitHubIssueSnippet [ 
	self stream << aLeGitHubIssueSnippet contentAsString
]

{ #category : 'visiting' }
LeGitHubExporterVisitor >> visitPage: aLePage [

	(aLePage hasTitle and: [ self shouldIncludeTitle ]) ifTrue:
		[ self stream 
			<< '# ';
			<< aLePage title;
			cr; cr ].

	self visitContent: aLePage
]

{ #category : 'visiting' }
LeGitHubExporterVisitor >> visitPharoSnippet: aLePharoSnippet [

	self stream
		<< '```smalltalk'
		<< self newLine
		<< aLePharoSnippet code
		<< self newLine
		<< '```'
]

{ #category : 'visiting' }
LeGitHubExporterVisitor >> visitTextSnippet: aLeTextSnippet [

	self level * 4 timesRepeat: [ self stream nextPut: Character space ].
	(self isOutline or: [ self level > 0 ]) ifTrue: [ self stream << '- ' ].
		
	aLeTextSnippet ast acceptVisitor: (LeGitHubExporterTextSnippetVisitor new 
		stream: self stream;
		level: self level).";
		externalPicturesWriter: self externalPicturesWriter)."
		
	self visitTextualSnippet: aLeTextSnippet
]
