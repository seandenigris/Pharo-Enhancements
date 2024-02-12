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
	self flag: 'Currently this customization point is disabled in favor of handling focus events'.
	textEditorHandlers ifNotNil: [ ^ textEditorHandlers ].
	
	startEditModeHandler := BlEventHandler "Start edit mode"
			on: BrTextEditorCursorChangedEvent
			do: [ :event | self cursorChanged: event ].
	
	^ textEditorHandlers := super textEditorHandlers "copyWith: startEditModeHandler"
]

{ #category : #accessing }
PeGtCompletionController >> textElementFilters [
	
	textElementFilters ifNotNil: [ ^ textElementFilters ].
	
	^ textElementFilters := {
		self activeShortcutHandler.
		self inactiveShortcutHandler.
		BlEventHandler on: BlBlurEvent do: [ :event | self removePopupOnLostFocus ].
		"BlEventHandler on: BlClickEvent do: [ :event | self removePopup ]. REMOVED"
		BlEventHandler on: BlFocusEvent do: [ :event | self startCompletion ] "ADDED"
	}
]
