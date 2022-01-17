Class {
	#name : #PeBindableGtTool,
	#superclass : #Object,
	#instVars : [
		'tab',
		'toolContentElement',
		'targetValue'
	],
	#category : #'PharoEnhancements-GToolkit-Variable-Sharing'
}

{ #category : #testing }
PeBindableGtTool class >> canModel: anElement [
	^ anElement isKindOf: LePageToolContentElement
]

{ #category : #accessing }
PeBindableGtTool >> gtViewTargetVariablesOn: aView [

	<gtView>
	^ aView list
		title: 'Target Vars.';
		items: self variables asOrderedCollection;
		itemText: #name;
		yourself
]

{ #category : #accessing }
PeBindableGtTool >> peGtPharoSourceCoderTreeChildrenForValue: anObject [
	| variableNodes |
	variableNodes := (self variables asSortedCollection: #name ascending) collect: [ :e | PeGtVariableBinder from: e to: anObject in: self ].
	^ variableNodes "copyWith: PeGtNewVariable new"
]

{ #category : #accessing }
PeBindableGtTool >> peGtPharoSourceCoderTreeInitializeNode: aNodeElement [
	(aNodeElement childNamed: #label) text: self toolTitle.
	(aNodeElement childNamed: #bind) visibility: BlVisibility hidden
]

{ #category : #accessing }
PeBindableGtTool >> pharoSnippets [
	^ self snippets select: [ :e | e isKindOf: LePharoSnippetViewModel ]
]

{ #category : #accessing }
PeBindableGtTool >> printOn: aStream [
	aStream 
		nextPutAll: self tabTitle;
		nextPutAll: ' > ';
		nextPutAll: self toolTitle
]

{ #category : #accessing }
PeBindableGtTool >> sharedBindingAt: aSymbol put: anObject [

	^ (self sharedBindings bindingOf: aSymbol) value: anObject
]

{ #category : #accessing }
PeBindableGtTool >> sharedBindings [
	^ self pharoSnippets atRandom coderViewModel sharedBindings
]

{ #category : #accessing }
PeBindableGtTool >> snippets [
	^ OrderedCollection streamContents: [ :str |
		self snippetsViewModel children do: [ :snip |
			str nextPut: snip.
			snip allSnippetChildrenBreadthFirstDo: [ :child | str nextPut: child ] ] ]
]

{ #category : #accessing }
PeBindableGtTool >> snippetsViewModel [

	^ self toolContentElement snippetsViewModel
]

{ #category : #accessing }
PeBindableGtTool >> tab [

	^ tab
]

{ #category : #accessing }
PeBindableGtTool >> tab: anObject [

	tab := anObject
]

{ #category : #accessing }
PeBindableGtTool >> tabTitle [
	^ self tab model title
]

{ #category : #accessing }
PeBindableGtTool >> toolContentElement [
	
	^ toolContentElement
]

{ #category : #accessing }
PeBindableGtTool >> toolContentElement: anObject [

	toolContentElement := anObject
]

{ #category : #accessing }
PeBindableGtTool >> toolTitle [
	^ self toolContentElement titleElement titleElement text asString
]

{ #category : #accessing }
PeBindableGtTool >> variables [

	| result |
	result := Bag new.
	self pharoSnippets do: [ :s |
		| ast variables |
		ast := s snippetModel coder rbAST.
		variables := ast allChildren select: [ :n | n isTempVariable or: [ n isUndeclaredVariable ] ].
		variables do: [ :var | 
			result 
				detect: [ :e | e name = var name ] 
				ifNone: [ result add: var ] ] ].
	^ result
]
