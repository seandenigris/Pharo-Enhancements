Extension { #name : #LibC }

{ #category : #'*PharoWiki' }
LibC class >> exampleRunAndWait [
	<gtExample>
	| errorStatus |
	errorStatus := LibC system: 'sleep 2'.
	self assert: errorStatus = 0
]
