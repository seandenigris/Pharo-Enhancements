*PharoEnhancements
macLock: aBoolean
	"Adapted from https://macosx.com/threads/lock-unlock-files-with-the-terminal.317350/"
	| keyword commandTemplate command |
	OSPlatform current isMacOSX ifFalse: [ ^ self ].
	keyword := aBoolean
		ifTrue: [ 'uchg' ]
		ifFalse: [ 'nouchg' ].
	commandTemplate := 'chflags {keyword} "{fileName}"'.
	command := commandTemplate format: { 
		#keyword -> keyword.
		#fileName -> self fullName } asDictionary.
	LibC system: command