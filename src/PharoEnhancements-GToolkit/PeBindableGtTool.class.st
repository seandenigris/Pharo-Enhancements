Class {
	#name : 'PeBindableGtTool',
	#superclass : 'Object',
	#instVars : [
		'tab',
		'targetValue',
		'toolElement'
	],
	#category : 'PharoEnhancements-GToolkit-Variable-Sharing',
	#package : 'PharoEnhancements-GToolkit',
	#tag : 'Variable-Sharing'
}

{ #category : 'testing' }
PeBindableGtTool class >> canModel: anElement [

	anElement class = GtPagerWrapperElement ifTrue: [ ^ false ].
	
	^ anElement id = #tool asBlocElementId
]

{ #category : 'accessing' }
PeBindableGtTool class >> on: aToolElement [
	
	| cls |
	cls := self.
	aToolElement
		allChildrenBreadthFirstDetect: [ :e | (e isKindOf: LePageToolContentTreeElement) and: [ e id = #content asBlocElementId ] ]
		ifFound: [ :e | cls := PeBindableLepiterTool ].
		
	^ cls new
		toolElement: aToolElement;
		yourself
]

{ #category : 'accessing' }
PeBindableGtTool class >> on: aToolElement inTab: aTabModel [
	^ (self on: aToolElement)
		tab: aTabModel;
		yourself
]

{ #category : 'accessing' }
PeBindableGtTool >> gtViewTargetVariablesOn: aView [

	<gtView>
	^ aView list
		title: 'Target Vars.';
		items: self variables asOrderedCollection;
		itemText: #name;
		yourself
]

{ #category : 'accessing' }
PeBindableGtTool >> peGtPharoSourceCoderTreeChildrenForValue: anObject [
	| variableNodes sortedVariables |
	sortedVariables := self variables asSortedCollection: #name ascending.
	variableNodes := sortedVariables collect: [ :e | 
		PeGtVariableBinder from: e to: anObject in: self ].
	^ variableNodes "copyWith: PeGtNewVariable new"
]

{ #category : 'accessing' }
PeBindableGtTool >> peGtPharoSourceCoderTreeInitializeNode: aNodeElement [
	(aNodeElement childNamed: #label) text: self toolTitle.
	(aNodeElement childNamed: #bind) visibility: BlVisibility hidden
]

{ #category : 'accessing' }
PeBindableGtTool >> pharoSnippets [
	^ self snippets select: [ :e | e isKindOf: LePharoSnippetViewModel ]
]

{ #category : 'accessing' }
PeBindableGtTool >> printOn: aStream [
	aStream 
		nextPutAll: self tabTitle;
		nextPutAll: ' > ';
		nextPutAll: self toolTitle
]

{ #category : 'accessing' }
PeBindableGtTool >> receiverObject [
	^ self snippetCoderViewModelAtRandom evaluationContext receiverObject
]

{ #category : 'accessing' }
PeBindableGtTool >> sharedBindingAt: aSymbol put: anObject [

	^ (self sharedBindings bindingOf: aSymbol) value: anObject
]

{ #category : 'accessing' }
PeBindableGtTool >> sharedBindings [
	^ self snippetCoderViewModelAtRandom sharedBindings
]

{ #category : 'accessing' }
PeBindableGtTool >> snippetCoderViewModelAtRandom [
	^ self pharoSnippets atRandom coderViewModel
]

{ #category : 'accessing' }
PeBindableGtTool >> snippets [

	^ OrderedCollection streamContents: [ :str |
		self toolElement 
			allChildrenBreadthFirstDetect: [ :e | e id = #playground asBlocElementId ]
			ifFound: [ :playground | str nextPutAll: playground page allChildrenDepthFirst ].
   		         
		self toolElement 
			allChildrenBreadthFirstDetect: [ :e | e id = #page asBlocElementId ]
			ifFound: [ :aPage | 
				aPage snippetsViewModel children do: [ :snip |
					str nextPut: snip.
					snip allSnippetChildrenBreadthFirstDo: [ :child | str nextPut: child ] ] ] ]
]

{ #category : 'accessing' }
PeBindableGtTool >> tab [

	^ tab
]

{ #category : 'accessing' }
PeBindableGtTool >> tab: anObject [

	tab := anObject
]

{ #category : 'accessing' }
PeBindableGtTool >> tabTitle [
	^ self tab model title
]

{ #category : 'accessing' }
PeBindableGtTool >> toolElement [
	^ toolElement
]

{ #category : 'accessing' }
PeBindableGtTool >> toolElement: anObject [
	toolElement := anObject
]

{ #category : 'accessing' }
PeBindableGtTool >> toolTitle [
	
	(self toolElement isKindOf: GtCoderElement)
		ifTrue: [ ^ self toolElement shortTitle asString, ' Class' ].
		
	^ (((self toolElement childNamed: #content) childNamed: #header) childNamed: #label) text asString
]

{ #category : 'accessing' }
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
