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
		'baseline'
	],
	#category : #'PharoEnhancements-GToolkit'
}

{ #category : #accessing }
PeLepiterProject class >> all [
	| instances |
	instances := BaselineOf allSubclasses 
		select: [ :e | e iceRepository isNotNil ]
		thenCollect: [ :e | self fromBaseline: e ].
	^ instances sort: #hasDatabase descending, #name ascending
]

{ #category : #'instance creation' }
PeLepiterProject class >> fromBaseline: aBaselineOf [
	^ self new
		baseline: aBaselineOf;
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
	^ self baseline gitHasUnstaged 
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

{ #category : #accessing }
PeLepiterProject >> baseline [
	^ baseline
]

{ #category : #accessing }
PeLepiterProject >> baseline: aBaselineOf [
	baseline := aBaselineOf
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
	| repairCommand branch strategy commitCommand |
	commitCommand := 'cd "' , self iceRepository location fullName
				, '"; git add lepiter/*; git commit -m ', self commitMessage.
	LibC system: commitCommand.
	
	repairCommand := IceTipCheckoutModel new.
	branch := (IceTipRepositoryModel on: self iceRepository) branchModel.
	strategy := repairCommand checkoutStrategies last.
	self assert: (strategy isKindOf: IceCheckoutDoNotLoadPackages).
	repairCommand
		checkoutStrategy: strategy;
		commitish: branch;
		diff;
		checkout
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
	^ self iceRepository ifNotNil: [ :repo | repo location / 'lepiter' ].
]

{ #category : #testing }
PeLepiterProject >> hasDatabase [
	^ self databaseFolder exists
]

{ #category : #testing }
PeLepiterProject >> hasUnstaged [
	^ self baseline gitHasUnstaged
]

{ #category : #accessing }
PeLepiterProject >> iceRepository [
	^ self baseline iceRepository
]

{ #category : #actions }
PeLepiterProject >> loadDatabase [
	| db |
	self databaseFolder exists ifFalse: [ ^ self ].
	db := LeLocalStoreLoad current loadAndMonitorFrom: self databaseFolder.
	LeDatabasesRegistry default defaultLogicalDatabase addDB: db
]

{ #category : #accessing }
PeLepiterProject >> name [
	^ self baseline name allButFirst: 'BaselineOf' size
]

{ #category : #printing }
PeLepiterProject >> printOn: aStream [
	aStream
		nextPutAll: self  name
]

{ #category : #accessing }
PeLepiterProject >> statusIcon [
	self hasDatabase ifFalse: [ ^ BrGlamorousIcons graycircle ].
	self database ifNil: [ ^ BrGlamorousIcons redcircle ] .
	^ self baseline gitHasUnstaged 
		ifTrue: [ BrGlamorousIcons yellowcircle ] 
		ifFalse: [ BrGlamorousIcons greencircle ]
]
