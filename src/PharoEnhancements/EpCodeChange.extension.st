Extension { #name : #EpCodeChange }

{ #category : #'*PharoEnhancements' }
EpCodeChange class >> allAffectingPackagesNamed: aBlock [
	| nodes entries filter filteredEntries groups |
	"To see diffs on the changes, you could do:
	events collect: [ :e | 
		DiffModel new
			showOptions: true;
			leftText: (e accept: EpOldStateVisitor new);
			rightText: (e accept: EpNewStateVisitor new);
			contextClass: e class;
			buildWithSpec ]"
	nodes := EpFileLogNode fromAllLogsIn: EpMonitor current sessionStore baseLocator.
	nodes do: [ :node | node populateReferencedNodesWith: nodes ].
	entries := nodes flatCollect: [ :n | n log entries ].
	filter := EpAndFilter
		withAll:
			{(EpImpactCodeChangeFilter new
				environment: self class environment;
				yourself).
			(EpPluggableFilter new condition: [ :e | e content isCodeChange and: [ aBlock value: e content affectedPackageName ] ]).
			EpPluggableFilter noTriggerFilter}.
	filteredEntries := entries select: [ :e | filter accepts: e ].
	filteredEntries sort: [ :a :b | (a tagAt: #time) > (b tagAt: #time) ].
	groups := filteredEntries
		groupedBy: [ :e | 
			(e content respondsTo: #methodAffected)
				ifFalse: [ '?' ]
				ifTrue: [ e content methodAffected ] ].
	^ groups collect: [ :col | col first content ] as: OrderedCollection.
]

{ #category : #'*PharoEnhancements' }
EpCodeChange class >> allSourceCodeMatching: regexString [
	| nodes entries filter filteredEntries groups |
	"To see diffs on the changes, you could do:
	events collect: [ :e | 
		DiffModel new
			showOptions: true;
			leftText: (e accept: EpOldStateVisitor new);
			rightText: (e accept: EpNewStateVisitor new);
			contextClass: e class;
			buildWithSpec ]"
	nodes := EpFileLogNode fromAllLogsIn: EpMonitor current sessionStore baseLocator.
	nodes do: [ :node | node populateReferencedNodesWith: nodes ].
	entries := nodes flatCollect: [ :n | n log entries ].
	filter := EpAndFilter
		withAll:
			{(EpImpactCodeChangeFilter new
				environment: self class environment;
				yourself).
			(EpPluggableFilter new condition: [ :e | e content isCodeChange and: [ e content peNewSourceCode matches: regexString ] ]).
			EpPluggableFilter noTriggerFilter}.
	filteredEntries := entries select: [ :e | filter accepts: e ].
	filteredEntries sort: [ :a :b | (a tagAt: #time) > (b tagAt: #time) ].
	groups := filteredEntries
		groupedBy: [ :e | 
			(e content respondsTo: #methodAffected)
				ifFalse: [ '?' ]
				ifTrue: [ e content methodAffected ] ].
	^ groups collect: [ :col | col first content ] as: OrderedCollection.
]

{ #category : #'*PharoEnhancements' }
EpCodeChange >> peNewSourceCode [
	^ ''
]
