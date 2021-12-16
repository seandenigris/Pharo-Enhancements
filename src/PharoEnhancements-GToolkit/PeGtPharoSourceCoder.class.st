Class {
	#name : #PeGtPharoSourceCoder,
	#superclass : #Object,
	#instVars : [
		'tab',
		'editorElement'
	],
	#category : #'PharoEnhancements-GToolkit'
}

{ #category : #testing }
PeGtPharoSourceCoder class >> canModel: anElement [
	^ anElement class = GtSourceCoderEditorElement and: [ anElement textualCoderViewModel coderModel isKindOf: GtPharoSnippetCoder ]
]

{ #category : #accessing }
PeGtPharoSourceCoder >> coderModel [

	^ self viewModel coderModel
]

{ #category : #accessing }
PeGtPharoSourceCoder >> editorElement [

	^ editorElement
]

{ #category : #accessing }
PeGtPharoSourceCoder >> editorElement: anObject [

	editorElement := anObject
]

{ #category : #accessing }
PeGtPharoSourceCoder >> gtViewTargetVariablesOn: aView [

	<gtView>
	^ aView list
		title: 'Target Vars.';
		items: self variables;
		itemText: #name;
		yourself
]

{ #category : #accessing }
PeGtPharoSourceCoder >> printOn: aStream [
	aStream 
		nextPutAll: self tabTitle;
		nextPutAll: ' > ';
		nextPutAll: self toolContentElement titleElement titleElement text asString
]

{ #category : #accessing }
PeGtPharoSourceCoder >> snippets [
	^ self snippetsViewModel children
]

{ #category : #accessing }
PeGtPharoSourceCoder >> snippetsViewModel [

	^ self toolContentElement snippetsViewModel
]

{ #category : #accessing }
PeGtPharoSourceCoder >> tab [

	^ tab
]

{ #category : #accessing }
PeGtPharoSourceCoder >> tab: anObject [

	tab := anObject
]

{ #category : #accessing }
PeGtPharoSourceCoder >> tabTitle [
	^ self tab model title
]

{ #category : #accessing }
PeGtPharoSourceCoder >> toolContentElement [

	self editorElement
		allParentsDetect: [ :e | e isKindOf: LePageToolContentElement ]
		ifFound: [ :tce | ^ tce ] 
		ifNone: [ self error: 'No tool content element' ]
]

{ #category : #accessing }
PeGtPharoSourceCoder >> variables [

	^ self snippets flatCollect: [ :s |
	| ast |
		ast := s snippetModel coder rbAST.
		ast allChildren select: [ :n | n isTempVariable or: [ n isUndeclaredVariable ] ] ]
]

{ #category : #accessing }
PeGtPharoSourceCoder >> viewModel [

	^ self editorElement textualCoderViewModel
]
