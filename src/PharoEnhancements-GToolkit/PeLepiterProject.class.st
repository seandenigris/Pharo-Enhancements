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
		'name',
		'databaseRootFolder'
	],
	#category : #'PharoEnhancements-GToolkit'
}

{ #category : #accessing }
PeLepiterProject class >> all [
	| baselines |
	baselines := BaselineOf allSubclasses  asOrderedCollection
		select: [ :e | e iceRepository isNotNil ]
		thenCollect: [ :e | self fromBaseline: e ].
	^ (baselines add: self default; yourself) sort: #hasDatabases descending, #name ascending
]

{ #category : #'instance creation' }
PeLepiterProject class >> allFromBaseline: aBaselineOf [
	| repoRoot lepiterFolder |
	repoRoot := aBaselineOf iceRepository location.
	lepiterFolder := repoRoot / 'lepiter'.
	lepiterFolder allDirectories.
	
	^ self new
		name: (aBaselineOf name allButFirst: 'BaselineOf' size);
		repository: aBaselineOf iceRepository; 
		yourself
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
PeLepiterProject class >> default [
	| repoLocation |
	repoLocation := FileLocator documents / 'lepiter'.
	^ self new 
		name: 'Lepiter Default';
		repository: repoLocation;
		databaseRootFolder: repoLocation; 
		yourself
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
	^ self gtViewDatabases: (self all flatCollect: #databases) on: aView
]

{ #category : #views }
PeLepiterProject class >> gtViewDatabases: aCollection on: aView [
	
	^ aView columnedList
		title: 'Databases' translated;
		priority: 80;
		items: [ aCollection ];
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
PeLepiterProject >> databaseRootFolder [
	databaseRootFolder ifNotNil: [ :dbf | ^ dbf ].
	^ self repository ifNotNil: [ self repositoryLocation / 'lepiter' ].
]

{ #category : #accessing }
PeLepiterProject >> databaseRootFolder: folder [
	databaseRootFolder := folder
]

{ #category : #accessing }
PeLepiterProject >> databases [
	| dbFolders defaultDB shouldIncludeDefaultDB dbs isDBFolder |
	
	isDBFolder := [ :folder | folder files anySatisfy: [ :file | file basename = 'lepiter.properties' ] ].
	
	"FS is resolution happy so we have to jump through hoops to unresolve"
	dbFolders := self databaseRootFolder exists
		ifTrue: [ self databaseRootFolder allDirectories asOrderedCollection select: [ :folder | folder ~= self databaseRootFolder asFileReference and: [ isDBFolder value: folder ] ] ]
		ifFalse: [ OrderedCollection new ].
	
	defaultDB := (self newDatabaseAt: self databaseRootFolder)
		name: self name;
		yourself.
		
	dbs := dbFolders collect: [ :e |
		(self newDatabaseAt: e)
			name: e base;
			yourself ].
	
	"We have to exclude the special case of Lepiter's default location, where the repo location and DB root are the same"
	shouldIncludeDefaultDB := (defaultDB folder exists and: [ defaultDB folder asFileReference ~= self repositoryLocation asFileReference ]) or: [ dbFolders isEmpty ].
	shouldIncludeDefaultDB ifTrue: [ dbs add: defaultDB ].
			
	^ dbs
]

{ #category : #views }
PeLepiterProject >> gtViewDashboardOn: aView [
	<gtView>
	^ self class gtViewDatabases: self databases on: aView
]

{ #category : #testing }
PeLepiterProject >> hasDatabases [
	^ self databases anySatisfy: #existsOnDisk
]

{ #category : #accessing }
PeLepiterProject >> name [
	^ name
]

{ #category : #accessing }
PeLepiterProject >> name: anObject [
	name := anObject
]

{ #category : #builders }
PeLepiterProject >> newDatabaseAt: location [
	"location - can be anything acceptable to #resolve: e.g. an absolute or relative string, path, or fileReference"
	^ PeLepiterDatabase new
		project: self;
		folder: (self databaseRootFolder resolve: location);
		yourself.
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
	(strategy isKindOf: IceCheckoutDoNotLoadPackages) ifFalse: [ self error: 'Danger: checkout may overwrite image changes. Abort!' ].
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
