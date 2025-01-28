Extension { #name : #LeTextualSnippetViewModel }

{ #category : #'*PharoEnhancements-GToolkit' }
LeTextualSnippetViewModel >> promoteToPageGtActionFor: anAction [
	<gtAction>

	^ anAction button
		tooltip: 'Promote to page';
		icon: BrGlamorousVectorIcons upwards;
		target: LeSnippetContextMenuActionTarget uniqueInstance;
		priority: 10;
		action: [ :aButton :aSnippetElement | aSnippetElement snippetModel promoteToPage ]
]
