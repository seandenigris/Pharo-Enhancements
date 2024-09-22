Extension { #name : #Class }

{ #category : #'*PharoEnhancements-GToolkit' }
Class >> peAPIDocumentation [
	| pragmas doc apiList |
	pragmas := Pragma allNamed: #apiDocumentation from: self to: Object.
	doc := PRDocument new
		add:
			(PRHeader new
				text: 'Messages / API';
				level: 1);
		yourself.
	apiList := PRUnorderedList new.
	pragmas
		do: [ :e | 
			| messageTitle descriptionString descriptionPillar |
			messageTitle := GtMethodAnnotation
				withParameters:
					(PRParameters
						withAll:
							{(PRParameter
								keyNode: (PRParameterKey named: 'name')
								valueNode: (PRParameterValue value: e method printString)).
							(PRParameter
								keyNode: (PRParameterKey named: 'label')
								valueNode: (PRParameterValue value: ('#', e method selector surroundedBy: '''')))}).
			descriptionString := (e method pragmaAt: #description:) 
				ifNotNil: [ :dp | dp arguments first ]
				ifNil: [ e method firstComment ].
			descriptionPillar := PRPillarParser parse: descriptionString.
			descriptionPillar
				select: [ :p | p isHeader ]
				thenDo: [ :h | h level: h level + 2 ].
			apiList
				add:
					(PRListItem new
						add: messageTitle;
						add: (PRText content: ' - ');
						add: descriptionPillar;
						yourself);
				yourself ].
	^ doc 
			add: apiList;
			yourself
]

{ #category : #'*PharoEnhancements-GToolkit' }
Class >> peDocumentationGtButtonFor: anAction [
	<gtClassAction>
	
	| project loadedDB repo |
	repo := self package peIceRepository ifNil: [ ^ anAction noAction ].
	project := PeLepiterProject new
		repository: repo; 
		yourself.
	loadedDB := project defaultDatabase loadedDatabase ifNil: [ ^ anAction noAction ].
			
	^ anAction button
		tooltip: 'Open Lepiter DB';
		priority: 4;
		icon: BrGlamorousVectorIcons note;
		action: [ :aButton | 
			| aPage |
			aPage := loadedDB tableOfContents ifNil: [ loadedDB pages atRandom ].
			aButton phlow spawnTool: aPage asPhlowTool ]
]

{ #category : #'*PharoEnhancements-GToolkit' }
Class >> peGenerateCommentFromAPI [
	self comment: (PRPillarWriter write: self peAPIDocumentation)
]
