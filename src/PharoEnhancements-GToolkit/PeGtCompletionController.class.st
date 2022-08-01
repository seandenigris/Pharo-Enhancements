Class {
	#name : #PeGtCompletionController,
	#superclass : #GtCompletionController,
	#category : #'PharoEnhancements-GToolkit-Completion'
}

{ #category : #accessing }
PeGtCompletionController >> cursorChanged: anEvent [ 
	self startCompletionAt: anEvent cursors cursors atRandom position 
]

{ #category : #'event handling' }
PeGtCompletionController >> textDeleted: anEvent [
	self resetPopup.
	self startCompletionAt: anEvent fromIndex - 1
]

{ #category : #accessing }
PeGtCompletionController >> textEditorHandlers [
	| startEditModeHandler |
	textEditorHandlers ifNotNil: [ ^ textEditorHandlers ].
	
	startEditModeHandler := BlEventHandler
		on: BrTextEditorCursorChangedEvent
		do: [ :event | self cursorChanged: event ].
	
	^ textEditorHandlers := super textEditorHandlers copyWith: startEditModeHandler
]
