"
Check out my Dashboard Coder tab.

I distinguish the following statuses:
- up-to-date
- changes needing to be comitted
- unloaded but available DB
- no DB

An uncovered case is when DB changes have been committed elsewhere i.e. there is an incoming commit with {{gtMethod:PeLepiterProject>>#commitMessage}}
"
Class {
	#name : #PeLepiterProject,
	#superclass : #Object,
	#instVars : [
		'repository',
		'databaseFolder',
		'name'
	],
	#category : #'PharoEnhancements-GToolkit'
}

{ #category : #accessing }
PeLepiterProject class >> all [
	| baselines |
	baselines := BaselineOf allSubclasses 
		select: [ :e | e iceRepository isNotNil ]
		thenCollect: [ :e | self fromBaseline: e ].
	^ (self allFromDefaultFolder copyWithAll: baselines) sort: #hasDatabase descending, #name ascending
]

{ #category : #'instance creation' }
PeLepiterProject class >> allFromDefaultFolder [
	| defaultFolder dbs |
	defaultFolder := FileLocator documents / 'lepiter'.
	dbs := defaultFolder allDirectories select: [ :subFolders | subFolders files anySatisfy: [ :file | file basename = 'lepiter.properties' ] ].
	^ dbs collect: [ :e | 
		self new 
			name: e basename capitalized;
			databaseFolder: e; 
			repository: defaultFolder; 
			yourself ]
]

{ #category : #'instance creation' }
PeLepiterProject class >> fromBaseline: aBaselineOf [
	^ self new
		name: (aBaselineOf name allButFirst: 'BaselineOf' size);
		repository: aBaselineOf iceRepository; 
		yourself
]

{ #category : #views }
PeLepiterProject class >> gtViewDashboardOn: aView [
	<gtClassView>
	^ aView columnedList
		title: 'Dashboard' translated;
		priority: 80;
		items: [ self all ];
		column: 'Status' 
			icon: [ :p | p statusIcon ]
			width: 75;
		column: 'Name' text: [ :p | p asString asRopedText ];
		column: 'Actions' 
			icon: [ :p | p actionButtons first ]
			width: 500;
		actionUpdateButtonTooltip: 'Update'
]

{ #category : #accessing }
PeLepiterProject >> actionButtons [
	| result |
	result := OrderedCollection new.
	self hasDatabase ifFalse: [ 
		^ result 
			add: (self 
				buttonLabelled: 'Create DB' 
				action: [ self createDatabase ]);
			yourself ].
	self database ifNil: [ 
		^ result 
			add: (self 
				buttonLabelled: 'Load DB'
				action: [ self loadDatabase ]);
			yourself ] .
	^ self hasUnstaged 
		ifTrue: [ 
			result 
				add: (self 
					buttonLabelled: 'Commit DB'
					action: [ self commitDatabase ]);
				yourself ] 
		ifFalse: [ 
			result 
				add: (BrLabel new
					aptitude: BrGlamorousLabelAptitude;
					text: 'Up to date';
					yourself);
				yourself. ]
]

{ #category : #private }
PeLepiterProject >> buttonLabelled: aString action: aBlock [
	^ BrButton new
		aptitude: (BrGlamorousButtonRectangularAptitude + BrGlamorousButtonExteriorAptitude + 
			(BrGlamorousButtonLabelAptitude new selectedColor: Color black));
		label: aString;
		action: aBlock;
		yourself
]

{ #category : #actions }
PeLepiterProject >> commitDatabase [
	"Commits all unstaged files in the repo to make it easy for when the default location contains multiple DB folders. For safety/control, might want to restrict to files just in the DB folder, which you can specify instead of `-A` e.g. `lepiter/*`"
	| commitCommand |
	commitCommand := 'cd "' , self repositoryLocation fullName
		, '"; git add -A; git commit -m ' , self commitMessage.
	LibC system: commitCommand.
	self repositoryIsIceberg ifTrue: [ self repairIceRepository ]
]

{ #category : #accessing }
PeLepiterProject >> commitMessage [
	^ 'lepiter-sync'
]

{ #category : #actions }
PeLepiterProject >> createDatabase [
	self databaseFolder ensureCreateDirectory.
]

{ #category : #accessing }
PeLepiterProject >> database [
	| folder |
	folder := self databaseFolder ifNil: [ ^ nil ].
	LeDatabasesRegistry default defaultLogicalDatabase databasesDo: [ :db |
		db localStoreRootDirectory resolve = folder resolve
			 ifTrue: [ ^ db ] ].
	^ nil
]

{ #category : #accessing }
PeLepiterProject >> databaseFolder [
	databaseFolder ifNotNil: [ :dbf | ^ dbf ].
	^ self repository ifNotNil: [ self repositoryLocation / 'lepiter' ].
]

{ #category : #accessing }
PeLepiterProject >> databaseFolder: anObject [
	databaseFolder := anObject
]

{ #category : #testing }
PeLepiterProject >> hasDatabase [
	^ self databaseFolder exists
]

{ #category : #testing }
PeLepiterProject >> hasUnstaged [
	"Copied from BaselineOf class>>#gitHasStaged, which could probably be moved to IceRepository, but then would still have to be copied here (unless there was also a class-side utility)"
	| unstagedCmd cmd exitCodeString |
	
	"Adapted from https://stackoverflow.com/a/5139672"
	unstagedCmd := 'git diff --quiet --exit-code; echo $?'.
	
	cmd := 'cd "' , self repositoryLocation fullName , '"; ' , unstagedCmd.
	exitCodeString := LibC resultOfCommand: cmd.
	^ exitCodeString trimRight asNumber = 1
]

{ #category : #actions }
PeLepiterProject >> loadDatabase [
	| ldb db |
	self databaseFolder exists ifFalse: [ ^ self ].
	ldb := LeDatabasesRegistry defaultLogicalDatabase.
	
	"Properties internally prevents duplicates, so we don't need a guard"
	ldb properties addRegisteredDirectory: self databaseFolder.
	
	(ldb hasDatabaseAt: self databaseFolder) ifTrue: [ ^ self ].
	db := LeLocalStoreLoad current loadAndMonitorFrom: self databaseFolder.
	ldb addDB: db.
]

{ #category : #accessing }
PeLepiterProject >> name [
	^ name
]

{ #category : #accessing }
PeLepiterProject >> name: anObject [
	name := anObject
]

{ #category : #printing }
PeLepiterProject >> printOn: aStream [
	aStream
		nextPutAll: self  name
]

{ #category : #actions }
PeLepiterProject >> repairIceRepository [
	| repairCommand branch strategy |
	repairCommand := IceTipCheckoutModel new.
	branch := (IceTipRepositoryModel on: self repository) branchModel.
	strategy := repairCommand checkoutStrategies last.
	self assert: (strategy isKindOf: IceCheckoutDoNotLoadPackages).
	repairCommand
		checkoutStrategy: strategy;
		commitish: branch;
		diff;
		checkout
]

{ #category : #testing }
PeLepiterProject >> repository [
	^ repository
]

{ #category : #accessing }
PeLepiterProject >> repository: anObject [
	repository := anObject
]

{ #category : #actions }
PeLepiterProject >> repositoryIsIceberg [
	^ (self repository isKindOf: AbstractFileReference) not
]

{ #category : #testing }
PeLepiterProject >> repositoryLocation [
	^ self repositoryIsIceberg
		ifTrue: [ self repository location ]
		ifFalse: [ self repository ]
]

{ #category : #accessing }
PeLepiterProject >> statusIcon [
	self hasDatabase ifFalse: [ ^ BrGlamorousIcons graycircle ].
	self database ifNil: [ ^ BrGlamorousIcons redcircle ] .
	^ self hasUnstaged 
		ifTrue: [ BrGlamorousIcons yellowcircle ] 
		ifFalse: [ BrGlamorousIcons greencircle ]
]
