Class {
	#name : #PeInformingLogger,
	#superclass : #SignalLogger,
	#category : #'PharoEnhancements-GToolkit-Loggers'
}

{ #category : #registering }
PeInformingLogger >> nextPut: anAnnouncement [
	UIManager default inform: anAnnouncement
	
	"v.s. handle: anAnnouncement
	anAnnouncement target isNumber ifFalse: [ ^ self ].
	anAnnouncement target \\ 5000 = 0 ifFalse: [ ^ self ].
	UIManager default defer: [ UIManager default inform: anAnnouncement target asString ]."
]
