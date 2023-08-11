Class {
	#name : #PeInformingLogger,
	#superclass : #SignalLogger,
	#category : #'PharoEnhancements-GToolkit-Loggers'
}

{ #category : #registering }
PeInformingLogger >> nextPut: anAnnouncement [
	UIManager default inform: anAnnouncement
]
