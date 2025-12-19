Extension { #name : 'MacOSResolver' }

{ #category : '*PharoEnhancements' }
MacOSResolver >> temp [
	"On OSX, which symlinks tmp, some versions make the link only-root-writable. See https://apple.stackexchange.com/questions/257753/osx-tmp-not-writable-operation-not-permitted"
	| tmpLinkTarget |
	tmpLinkTarget := '/private/tmp' asFileReference.
	^ tmpLinkTarget exists
		ifFalse: [ '/tmp' asFileReference ]
		ifTrue: [ tmpLinkTarget ]
]
