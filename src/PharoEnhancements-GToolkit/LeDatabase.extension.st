Extension { #name : #LeDatabase }

{ #category : #'*PharoEnhancements-GToolkit' }
LeDatabase >> updatePageTypes [
	LePageType subclassesDo: [ :pageType |
		pagesByType
			at: pageType pageTypeClass
			ifAbsentPut: [ Dictionary new ] ].
			
	"Copy-pasted from LeDatabase>>#initialize"
]
