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
		column: 'Name' text: [ :p | p asString asRopedText ]
]

{ #category : #accessing }
PeLepiterProject >> baseline [
	^ baseline
]

{ #category : #accessing }
PeLepiterProject >> baseline: aBaselineOf [
	baseline := aBaselineOf
]

{ #category : #accessing }
PeLepiterProject >> commitDatabase [
	| repairCommand branch strategy commitCommand |
	commitCommand := 'cd "' , self iceRepository location fullName
				, '"; git add lepiter/*; git commit -m lepiter-sync'.
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

{ #category : #accessing }
PeLepiterProject >> iceRepository [
	^ self baseline iceRepository
]

{ #category : #accessing }
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

{ #category : #accessing }
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
