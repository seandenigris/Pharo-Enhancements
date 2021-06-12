Extension { #name : #BaselineOf }

{ #category : #'*PharoEnhancements' }
BaselineOf class >> gitHasUnstaged [
	| unstagedCmd cmd exitCodeString |
	"Adapted from https://stackoverflow.com/a/5139672"
	unstagedCmd := 'git diff --quiet --exit-code; echo $?'.
	cmd := 'cd "' , self iceRepository location fullName , '"; ', unstagedCmd.
	exitCodeString := LibC resultOfCommand: cmd.
	^ exitCodeString trimRight asNumber = 1
]
