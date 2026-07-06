Class {
	#name : 'PeLeMoveToPage',
	#superclass : 'Object',
	#instVars : [
		'skipIfExists',
		'targetPage',
		'sourceSnippets',
		'isTopOfPage'
	],
	#category : 'PharoEnhancements-GToolkit',
	#package : 'PharoEnhancements-GToolkit'
}

{ #category : 'accessing' }
PeLeMoveToPage >> addSnippetSelector [

	^ self isTopOfPage
		ifTrue: [ #addFirstSnippet: ]
		ifFalse: [ #addSnippet: ]
]

{ #category : 'as yet unclassified' }
PeLeMoveToPage >> execute [

	| snippetsToAdd |
	
	snippetsToAdd := self isTopOfPage
		ifTrue: [ self sourceSnippets reversed ]
		ifFalse: [ self sourceSnippets ].
		
	snippetsToAdd do: [ :aSnippet | 
		aSnippet removeSelf.
		self targetPage 
			perform: self addSnippetSelector 
			with: aSnippet ]
]

{ #category : 'accessing' }
PeLeMoveToPage >> isTopOfPage [

	^ self maLazyInstVarUsing: self isTopOfPageDescription
]

{ #category : 'accessing' }
PeLeMoveToPage >> isTopOfPage: aBoolean [

	isTopOfPage := aBoolean
]

{ #category : 'accessing' }
PeLeMoveToPage >> isTopOfPageDescription [
	<magritteDescription>
	
	^ MABooleanDescription new
		accessor: #isTopOfPage;
		default: false;
		yourself
]

{ #category : 'accessing' }
PeLeMoveToPage >> lepiterDatabase [

	^ LeDatabasesRegistry defaultLogicalDatabase
]

{ #category : 'as yet unclassified' }
PeLeMoveToPage >> magritteFormExecuting [

	| builder |
	builder := self magritteDescription elementBuilderFor: self.
	builder addButtons: #(execute).
	^ builder element
]

{ #category : 'as yet unclassified' }
PeLeMoveToPage >> mementoClass [

	^ MAStraightMemento
]

{ #category : 'accessing' }
PeLeMoveToPage >> sourceSnippets [
	^ sourceSnippets ifNil: [ sourceSnippets := OrderedCollection new ]
]

{ #category : 'accessing' }
PeLeMoveToPage >> sourceSnippets: anObject [
	sourceSnippets := anObject
]

{ #category : 'accessing' }
PeLeMoveToPage >> sourceSnippetsAdd: aSnippet [
	^ self sourceSnippets add: aSnippet
]

{ #category : 'accessing' }
PeLeMoveToPage >> targetPage [
	^ targetPage
]

{ #category : 'accessing' }
PeLeMoveToPage >> targetPage: anObject [
	targetPage := anObject
]

{ #category : 'accessing' }
PeLeMoveToPage >> targetPageDescription [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
		accessor: #targetPage;
		classes: { LePage };
		gtSearchDelegateTo: self lepiterDatabase message: #gtSpotterContentFor:;
		yourself.
]
