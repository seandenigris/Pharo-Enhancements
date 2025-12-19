Extension { #name : 'MacOSXPlatform' }

{ #category : '*PharoEnhancements' }
MacOSXPlatform >> isARM [
	"Doesn't report correct result when ARM VM is launched from Rosetta Launcher. Reported on Discord on 2/3"
	^ (LibC resultOfCommand: 'arch') = 'arm64'
	
	"Adapted from https://stackoverflow.com/a/65259353"
]
