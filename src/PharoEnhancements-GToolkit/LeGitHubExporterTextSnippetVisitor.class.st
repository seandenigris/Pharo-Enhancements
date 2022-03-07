Class {
	#name : #LeGitHubExporterTextSnippetVisitor,
	#superclass : #Object,
	#traits : 'TSmaCCCompositeVisitor + (TLeContentNodeVisitor - {#acceptNode:})',
	#classTraits : 'TSmaCCCompositeVisitor classTrait + TLeContentNodeVisitor classTrait',
	#instVars : [
		'stream',
		'level',
		'externalPicturesWriter'
	],
	#category : #'PharoEnhancements-GToolkit-Lepiter-Exporting'
}

{ #category : #accessing }
LeGitHubExporterTextSnippetVisitor >> level [

	^ level
]

{ #category : #accessing }
LeGitHubExporterTextSnippetVisitor >> level: anObject [

	level := anObject
]

{ #category : #'instance creation' }
LeGitHubExporterTextSnippetVisitor >> newLine [
	^ Character cr asString
]

{ #category : #accessing }
LeGitHubExporterTextSnippetVisitor >> stream [

	^ stream
]

{ #category : #accessing }
LeGitHubExporterTextSnippetVisitor >> stream: anObject [

	stream := anObject
]

{ #category : #generated }
LeGitHubExporterTextSnippetVisitor >> visitCodeBlock: aCodeBlock [
	
	self stream
		<< '```smalltalk'
		<< aCodeBlock code source
		<< '```'.
	 ^ self visitContent: aCodeBlock
]

{ #category : #generated }
LeGitHubExporterTextSnippetVisitor >> visitDocumenterAnnotation: aDocumenterAnnotation [
	| annotationVisitor |
	annotationVisitor := LeGitHubExporterAnnotationVisitor new 
		stream: stream";
		nestingLevel: nestingLevel;
		externalPicturesWriter: self externalPicturesWriter".
	aDocumenterAnnotation annotation acceptVisitor: annotationVisitor
]

{ #category : #generated }
LeGitHubExporterTextSnippetVisitor >> visitHeader: aHeader [
	self stream nextPutAll: aHeader source
]

{ #category : #generated }
LeGitHubExporterTextSnippetVisitor >> visitPageLink: aPageLink [

	self stream
		nextPutAll: '[', aPageLink link value, '](', aPageLink link value, '.md)'
]

{ #category : #generated }
LeGitHubExporterTextSnippetVisitor >> visitText: aText [
	self stream << aText content
]
