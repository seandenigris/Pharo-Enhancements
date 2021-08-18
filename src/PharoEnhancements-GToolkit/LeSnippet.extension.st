Extension { #name : 'LeSnippet' }

{ #category : '*PharoEnhancements-GToolkit' }
LeSnippet >> moveToPage: aPage [
	self page removeSnippet: self.
	aPage addSnippet: self
]
