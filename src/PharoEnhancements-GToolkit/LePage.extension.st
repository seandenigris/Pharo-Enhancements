Extension { #name : 'LePage' }

{ #category : '*PharoEnhancements-GToolkit' }
LePage >> asContentUIModel [
	<return: #LeContentViewModel>
	^ self type asContentUIModel
]

{ #category : '*PharoEnhancements-GToolkit' }
LePage class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		addFirst: (#type -> #pageType);
		addFirst: (#basicUid -> #uid);
		yourself
]

{ #category : '*PharoEnhancements-GToolkit' }
LePage >> peGtExpandCollapseButtonFor: anAction [
	<lePageAction>
	
	^ anAction button
		icon: BrGlamorousVectorIcons upwardsDownwards;
		action: [ :aButton :aModel :c :d |
			aModel pageElement treeElement viewModel root allChildrenNodesBreadthFirst
				detect: [ :node | node isExpanded ]
				ifFound: [ :node | aModel pageElement treeElement collapseAll ]
				ifNone: [ aModel pageElement treeElement expandAll ] ]
]

{ #category : '*PharoEnhancements-GToolkit' }
LePage >> snippetBuilder [
	^ self type snippetBuilder
]
