Extension { #name : #GtWorld }

{ #category : #'*PharoEnhancements-GToolkit' }
GtWorld class >> allToolsBind: aSymbol to: anObject [
	| editors coderViewModels |
	editors := self allInstances flatCollect: [ :w | 
		w root 
			allChildrenBreadthFirstDetect: [ :e | e class = BrTabGroup ]
			ifFound: [ :tabGroup | 
				tabGroup tabs flatCollect: [ :tabs | 
					tabs model ifNotNil: [ :space | 
						space root 
							allChildrenBreadthFirstSelect: [ :e | e class = GtSourceCoderEditorElement ] ] 
							ifNil: [ #() ] ] ] ].
	coderViewModels := editors collectAsSet: #textualCoderViewModel.
	coderViewModels do: [ :cvm | cvm localBindings localAt: aSymbol put: anObject ]
]

{ #category : #'*PharoEnhancements-GToolkit' }
GtWorld class >> dismissAllNotifications [
	| badges |
	badges := GtWorld allInstances collect: [ :w | 
    w root 
        allChildrenBreadthFirstDetect: [ :e | e class = BrTabGroup ]
        ifFound: [ :tabGroup | 
            tabGroup 
            	allChildrenBreadthFirstDetect: [ :e | e class = GtNotificationsBadgeElement ]
            	ifFound: [ :bdg | bdg ] ] ].
badges do: [ :badge | badge notifications asArray do: #requestRemoval ]
]

{ #category : #'*PharoEnhancements-GToolkit' }
GtWorld >> peGtPharoSourceCoderTreeChildrenForValue: anObject [

	^ self root
		allChildrenBreadthFirstDetect: [ :e | e class = BrTabGroup ]
		ifFound: [ :tabGroup | tabGroup tabs reject: [ :e | e model isNil ] ]
]
