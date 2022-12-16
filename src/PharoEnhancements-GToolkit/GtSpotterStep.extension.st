Extension { #name : #GtSpotterStep }

{ #category : #'*PharoEnhancements-GToolkit' }
GtSpotterStep >> bindResultAs: aSymbol [
	
	self spotter announcer when: GtSpotterActOn do: [ :anc :ancer |
		self spotter attachedElementDo: [ :spotElement |
			spotElement space root children first tabs content 
				allChildrenBreadthFirstDetect: [ :e | (e isKindOf: GtInspector) and: [ e object = self origin ] ] 
				ifFound: [ :insp | insp playgroundElement pageElement pageViewModel snippetBindings at: #contact put: anc element ] ] ]
]
