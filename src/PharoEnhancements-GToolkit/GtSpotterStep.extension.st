Extension { #name : 'GtSpotterStep' }

{ #category : '*PharoEnhancements-GToolkit' }
GtSpotterStep >> actOn: aCandidate dueTo: anEventType from: aSpotterElement [
	"Perform an action associated with the given candidate item.
	(can be triggered by doubleClick: or keyboard Enter press)"
	| anAnnouncement aCantidateProcessor anObjectToActOn |
	self
		assert: [ aCandidate isNotNil ]
		description: [ 'Spotter can not perform an action due to ', 
			anEventType asString, 
			' if there is no candidate' ].

	hasActedOn := true.
	self terminateProcessors.

	self spotter historize: aCandidate.
	
	aCantidateProcessor := aCandidate processor.
	anObjectToActOn := aCantidateProcessor objectToActOn: aCandidate item from: self.
	
	anAnnouncement := self spotter notifyActOn: anObjectToActOn for: anEventType.
	anAnnouncement isActedUpon
		ifFalse: [ aCantidateProcessor actOn: anObjectToActOn for: self from: aSpotterElement ].
		
	Smalltalk globals at: #PeGtSpotterResult put: anObjectToActOn
]

{ #category : '*PharoEnhancements-GToolkit' }
GtSpotterStep >> bindResultAs: aSymbol [
	
	self spotter announcer when: GtSpotterActOn do: [ :anc :ancer |
		self spotter attachedElementDo: [ :spotElement |
			spotElement space root children first tabs content 
				allChildrenBreadthFirstDetect: [ :e | (e isKindOf: GtInspector) and: [ e object = self origin ] ] 
				ifFound: [ :insp | insp playgroundElement pageElement pageViewModel snippetBindings at: #contact put: anc element ] ] ]
]
