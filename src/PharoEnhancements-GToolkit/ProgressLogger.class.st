Class {
	#name : #ProgressLogger,
	#superclass : #SignalLogger,
	#instVars : [
		'job'
	],
	#category : #'PharoEnhancements-GToolkit'
}

{ #category : #accessing }
ProgressLogger >> job [
	^ job
]

{ #category : #accessing }
ProgressLogger >> job: anObject [
	job := anObject
]

{ #category : #registering }
ProgressLogger >> nextPut: anAnnouncement [
	self job max: anAnnouncement target second.
	self job increment
]

{ #category : #'as yet unclassified' }
ProgressLogger >> run [
	self job
		max: 16000;
		run
]

{ #category : #'as yet unclassified' }
ProgressLogger >> runDuring: aBlock [
	self job: aBlock asJob.
	super runDuring: [ self job run ]
]
