Extension { #name : 'AbstractFileReference' }

{ #category : '*PharoEnhancements-GToolkit' }
AbstractFileReference >> gtXDocsCleanFolder [
	"Old xdocs was creating empty folders every time we viewed a class"
	self directories select: [ :e | e children isEmpty ] thenDo: #delete
]
