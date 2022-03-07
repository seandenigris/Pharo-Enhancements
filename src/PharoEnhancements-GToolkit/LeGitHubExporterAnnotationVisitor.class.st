Class {
	#name : #LeGitHubExporterAnnotationVisitor,
	#superclass : #Object,
	#traits : 'TLeAnnotationParseNodeVisitor',
	#classTraits : 'TLeAnnotationParseNodeVisitor classTrait',
	#instVars : [
		'stream',
		'externalPicturesWriter'
	],
	#category : #'PharoEnhancements-GToolkit-Lepiter-Exporting'
}

{ #category : #accessing }
LeGitHubExporterAnnotationVisitor >> stream [

	^ stream
]

{ #category : #accessing }
LeGitHubExporterAnnotationVisitor >> stream: anObject [

	stream := anObject
]

{ #category : #generated }
LeGitHubExporterAnnotationVisitor >> visitClassAnnotation: aClassAnnotation [
	
	self 
		writeBehaviorOrMethod: aClassAnnotation nameNode behavior 
		annotation: aClassAnnotation 
		string: aClassAnnotation nameNode source
]

{ #category : #generated }
LeGitHubExporterAnnotationVisitor >> visitMethodAnnotation: aMethodAnnotation [
		
	self 
		writeBehaviorOrMethod: aMethodAnnotation nameNode peImageObject 
		annotation: aMethodAnnotation 
		string: aMethodAnnotation nameNode source
]

{ #category : #generated }
LeGitHubExporterAnnotationVisitor >> writeBehaviorOrMethod: aClassOrMethod annotation: anAnnotation string: aString [

	| destination label |
	(anAnnotation doesReferenceExist not or: [ aClassOrMethod package peIceRepository isNil ]) ifTrue: [
		self stream
			<< $`
			<< aString
			<< $`.
		^ self ].
		
	self flag: 'GH will accept relative links for same repo, but what''s the gain vs. absolute URLs that work from any repo?'.
	"destination := String streamContents: [ :str |
		(aClassOrMethod gitHubUrl pathSegments last: 3)
			do: [ :seg | str << '/' << seg ] ]."

	label := anAnnotation hasLabel
		ifTrue: [ anAnnotation label ]
		ifFalse: [ aString ].

	self stream
		nextPut: $[;
		nextPutAll: label;
		nextPutAll: '](';
		nextPutAll: aClassOrMethod gitHubUrl asString;
		nextPut: $)
]
