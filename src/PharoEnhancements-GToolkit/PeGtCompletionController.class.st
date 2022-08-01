Class {
	#name : #PeGtCompletionController,
	#superclass : #GtCompletionController,
	#category : #'PharoEnhancements-GToolkit-Completion'
}

{ #category : #'event handling' }
PeGtCompletionController >> textDeleted: anEvent [
	self resetPopup.
	self startCompletionAt: anEvent fromIndex - 1
]
