Extension { #name : #BaselineOf }

{ #category : #'*PharoEnhancements' }
BaselineOf class >> allPackagesDeeply [

	| projects |
	projects := Set new.
	self project version 
		withDeep: [ :each | each projects collect: #version ]
		relationDo: [ :a :b |  projects add: a; add: b ].
	^ projects flatCollect: [ :prj | 
		prj packages 
			select: [ :pkg | pkg workingCopy isNotNil ]
			thenCollect: [ :pkg | pkg workingCopy package correspondingRPackage ] ].
]

{ #category : #'*PharoEnhancements' }
BaselineOf class >> gitHasUnstaged [
	| unstagedCmd cmd exitCodeString |
	self iceRepository ifNil: [ ^ false ].
	"Adapted from https://stackoverflow.com/a/5139672"
	unstagedCmd := 'git diff --quiet --exit-code; echo $?'.
	cmd := 'cd "' , self iceRepository location fullName , '"; ', unstagedCmd.
	exitCodeString := LibC resultOfCommand: cmd.
	^ exitCodeString trimRight asNumber = 1
]

{ #category : #'*PharoEnhancements' }
BaselineOf class >> iconFolder [
	^ self iceRepository location / 'icons'
]
