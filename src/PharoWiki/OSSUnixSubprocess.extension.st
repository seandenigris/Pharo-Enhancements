Extension { #name : #OSSUnixSubprocess }

{ #category : #'*PharoWiki' }
OSSUnixSubprocess class >> exampleRunAndWait [
	<gtExample>
	OSSUnixSubprocess new
		shellCommand: 'sleep 2';
		runAndWaitOnExitDo: [ :p | self assert: p isSuccess ]
]
