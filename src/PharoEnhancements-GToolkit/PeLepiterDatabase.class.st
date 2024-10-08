Class {
	#name : #PeLepiterDatabase,
	#superclass : #Object,
	#instVars : [
		'project',
		'name',
		'folder'
	],
	#category : #'PharoEnhancements-GToolkit-Lepiter'
}

{ #category : #accessing }
PeLepiterDatabase class >> all [
	^ PeLepiterProject all flatCollect: #databases
]

{ #category : #'instance creation' }
PeLepiterDatabase class >> allFromDefaultFolder [
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

{ #category : #utilities }
PeLepiterDatabase class >> databaseAt: folder [
	LeDatabasesRegistry default defaultLogicalDatabase databasesDo: [ :db |
		db localStoreRootDirectory resolve = folder resolve
			 ifTrue: [ ^ db ] ].
	^ nil
]

{ #category : #views }
PeLepiterDatabase class >> gtViewDashboardOn: aView [
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
		actionUpdateButton
]

{ #category : #utilities }
PeLepiterDatabase class >> loadDatabaseAt: folder [
	| ldb db |
	folder exists ifFalse: [ ^ self ].
	ldb := LeDatabasesRegistry defaultLogicalDatabase.
	
	"Properties internally prevents duplicates, so we don't need a guard"
	ldb properties addRegisteredDirectory: folder.
	
	(ldb hasDatabaseAt: folder) ifTrue: [ ^ self databaseAt: folder ].
	db := LeLocalStoreLoad current loadAndMonitorFrom: folder.
	^ ldb addDB: db.
]

{ #category : #accessing }
PeLepiterDatabase class >> reloadAll [
	LeDatabasesRegistry defaultLogicalDatabase
		saveProperties;
		reload
]

{ #category : #comparing }
PeLepiterDatabase >> = rhs [
	self species = rhs species ifFalse: [ ^ false ].
	^ self folder asFileReference = rhs folder asFileReference
]

{ #category : #accessing }
PeLepiterDatabase >> actionButtons [
	| result |
	result := OrderedCollection new.
	self existsOnDisk ifFalse: [ 
		^ result 
			add: (self 
				buttonLabelled: 'Create DB' 
				action: [ self createDatabaseOnDisk ]);
			yourself ].
	self isLoaded ifFalse: [ 
		^ result 
			add: (self 
				buttonLabelled: 'Load DB'
				action: [ self load ]);
			yourself ] .
	^ self needsSync 
		ifTrue: [ 
			result 
				add: (self 
					buttonLabelled: 'Commit DB'
					action: [ self syncDatabase ]);
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
PeLepiterDatabase >> buttonLabelled: aString action: aBlock [
	^ BrButton new
		aptitude: (BrGlamorousButtonRectangularAptitude + BrGlamorousButtonExteriorAptitude + 
			(BrGlamorousButtonLabelAptitude new selectedColor: Color black));
		label: aString;
		action: aBlock;
		yourself
]

{ #category : #actions }
PeLepiterDatabase >> commitCommand [
	"Commits unstaged/untracked files only under the DB folder"

	^ 'cd "' , self repositoryLocation fullName , '"; git add -A '
		, self relativeDatabasePath fullName surroundedByDoubleQuotes
		, '; git commit -m ' , self commitMessage surroundedByDoubleQuotes
]

{ #category : #actions }
PeLepiterDatabase >> commitDatabase [
	LibC system: self commitCommand
]

{ #category : #accessing }
PeLepiterDatabase >> commitMessage [
	^ 'lepiter-sync ', self relativeDatabasePath fullName
]

{ #category : #actions }
PeLepiterDatabase >> createDatabaseOnDisk [
	self folder ensureCreateDirectory.
]

{ #category : #testing }
PeLepiterDatabase >> existsOnDisk [
	^ self folder exists
]

{ #category : #accessing }
PeLepiterDatabase >> exportForGitHub [
	self load pagesDo: [ :p |
		| visitor |
		visitor := LeGitHubExporterVisitor new.
		p acceptVisitor: visitor.
		(self folder parent / 'doc--md-export' / p title asFilename, 'md') ensureCreateFile writeStreamDo: [ :fStr | fStr << visitor stream contents ] ]
]

{ #category : #accessing }
PeLepiterDatabase >> folder [
	^ folder
]

{ #category : #accessing }
PeLepiterDatabase >> folder: anObject [
	folder := anObject
]

{ #category : #testing }
PeLepiterDatabase >> hasUnstaged [
	"Adapted from BaselineOf class>>#gitHasUnstaged, which could probably be moved to IceRepository, but then would still have to be copied here (unless there was also a class-side utility)"
	| unstagedCmd cmd exitCodeString |
	
	"Adapted from https://stackoverflow.com/a/5139672"
	unstagedCmd := 'git diff --quiet --exit-code ', self relativeDatabasePath fullName surroundedByDoubleQuotes, '; echo $?'.
	
	cmd := 'cd "' , self repositoryLocation fullName , '"; ' , unstagedCmd.
	exitCodeString := LibC resultOfCommand: cmd.
	^ exitCodeString trimRight asNumber = 1
]

{ #category : #testing }
PeLepiterDatabase >> hasUntracked [
	| untrackedCmd cmd |
	
	"Adapted from https://stackoverflow.com/a/5139672"
	untrackedCmd := 'git ls-files --others --exclude-standard --directory --no-empty-directory ', self relativeDatabasePath fullName surroundedByDoubleQuotes.
	
	cmd := 'cd "' , self repositoryLocation fullName , '"; ' , untrackedCmd.
	^ (LibC resultOfCommand: cmd) isNotEmpty.
]

{ #category : #comparing }
PeLepiterDatabase >> hash [
	^ self folder hash
]

{ #category : #accessing }
PeLepiterDatabase >> isDefault [
	^ self project databases size = 1 or: [ self folder base = 'default' ]
]

{ #category : #accessing }
PeLepiterDatabase >> isLoaded [
	^ self loadedDatabase isNotNil
]

{ #category : #actions }
PeLepiterDatabase >> load [
	^ self class loadDatabaseAt: self folder
]

{ #category : #accessing }
PeLepiterDatabase >> loadedDatabase [
	^ self class databaseAt: folder
]

{ #category : #accessing }
PeLepiterDatabase >> name [
	| realDB |
	realDB := self class databaseAt: folder.
	realDB ifNil: [ ^ name ].
	^ realDB properties databaseName ifNil: [ ^ name ]
]

{ #category : #accessing }
PeLepiterDatabase >> name: anObject [
	name := anObject
]

{ #category : #accessing }
PeLepiterDatabase >> needsSync [
	^ self hasUnstaged or: [ self hasUntracked ]
]

{ #category : #printing }
PeLepiterDatabase >> printOn: aStream [
	aStream
		nextPutAll: self  name
]

{ #category : #accessing }
PeLepiterDatabase >> project [
	^ project
]

{ #category : #accessing }
PeLepiterDatabase >> project: anObject [
	project := anObject
]

{ #category : #actions }
PeLepiterDatabase >> relativeDatabasePath [
	^ self folder relativeTo: self repositoryLocation
]

{ #category : #testing }
PeLepiterDatabase >> repositoryLocation [
	^ self project repositoryIsIceberg
		ifTrue: [ self project repository location ]
		ifFalse: [ self project repository ]
]

{ #category : #accessing }
PeLepiterDatabase >> statusIcon [
	self existsOnDisk ifFalse: [ ^ BrGlamorousIcons graycircle ].
	self isLoaded ifFalse: [ ^ BrGlamorousIcons redcircle ] .
	^ self needsSync 
		ifTrue: [ BrGlamorousIcons yellowcircle ] 
		ifFalse: [ BrGlamorousIcons greencircle ]
]

{ #category : #actions }
PeLepiterDatabase >> syncDatabase [
	self commitDatabase.
	self project repositoryIsIceberg ifTrue: [ self project repairIceRepository ]
]
