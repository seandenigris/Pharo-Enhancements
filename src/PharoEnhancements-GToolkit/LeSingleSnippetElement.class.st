"
Adapted from {{gtClass:LeCoderCommentElement}}, which Coder uses for class comments.
"
Class {
	#name : #LeSingleSnippetElement,
	#superclass : #BlElement,
	#traits : 'TLeWithFontSize',
	#classTraits : 'TLeWithFontSize classTrait',
	#instVars : [
		'snippetElement'
	],
	#category : 'PharoEnhancements-GToolkit'
}

{ #category : #accessing }
LeSingleSnippetElement >> editorMode: aMode [
]

{ #category : #accessing }
LeSingleSnippetElement >> hasStableIds [
	^ false
]

{ #category : #initialization }
LeSingleSnippetElement >> initializeForClassName: aSymbol [
	"Only needed for potential refactoring/unification with LeCoderCommentElement"

	| page |

	page := LePharoClassDatabase uniqueInstance pageNamed: aSymbol.
	self initializeForPage: page
]

{ #category : #initialization }
LeSingleSnippetElement >> initializeForPage: aPage [
	"Hook in case we decide to allow full pages in Ideas"
	| snippet |

	snippet := aPage children first.
	self initializeForSnippet: snippet
]

{ #category : #initialization }
LeSingleSnippetElement >> initializeForSnippet: aSnippet [
	| viewModel snippetView |

	viewModel := aSnippet asSnippetViewModel.
	viewModel coderViewModel addShortcut: 
		(BrEditorLineEndingShortcut new combination: (LeSnippetElement keyboardShortcut: #NewLine)).
	snippetView := viewModel snippetView.
	snippetView needsEmbellishments: false.
	snippetElement := snippetView asElement.
	snippetElement vFitContent; hFitContent.
	snippetElement snippetViewModel: viewModel.
	snippetElement padding: (BlInsets all: 10).

	self initializeFontSizeShortcuts.
	self constraintsDo: [ :c |
		c vertical matchParent.
		c horizontal matchParent. ].
	self addChild: snippetElement.

]

{ #category : #accessing }
LeSingleSnippetElement >> itemCount [
	^ 1
]

{ #category : #accessing }
LeSingleSnippetElement >> itemTypeAt: aPosition [
	^ BrTextEditorLineSegmentType
]

{ #category : #accessing }
LeSingleSnippetElement >> onAttached: anEditorElement [
]

{ #category : #accessing }
LeSingleSnippetElement >> page [ 
	"Answer the page used to hold the receiver's class comment"

	^ snippetElement page
]

{ #category : #accessing }
LeSingleSnippetElement >> styler: aStyler [
]

{ #category : #accessing }
LeSingleSnippetElement >> text: aText [
]
