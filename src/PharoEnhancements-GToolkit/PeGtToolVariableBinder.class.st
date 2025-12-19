Class {
	#name : 'PeGtToolVariableBinder',
	#superclass : 'Object',
	#instVars : [
		'targetValue'
	],
	#category : 'PharoEnhancements-GToolkit-Variable-Sharing',
	#package : 'PharoEnhancements-GToolkit',
	#tag : 'Variable-Sharing'
}

{ #category : 'accessing' }
PeGtToolVariableBinder class >> allSpaces [

	^ BlParallelUniverse all flatCollect:  #spaces
]

{ #category : 'accessing' }
PeGtToolVariableBinder class >> allTabs [

	^ GtWorld allInstances flatCollect: [ :w | 
    		w root 
        		allChildrenBreadthFirstDetect: [ :e | e class = BrTabGroup ]
		        ifFound: [ :tabGroup | 
   		         tabGroup tabs ] ].
]

{ #category : 'accessing' }
PeGtToolVariableBinder class >> allToolTabs [

	^ self allTabs reject: [ :e | e model isNil ]
]

{ #category : 'accessing' }
PeGtToolVariableBinder class >> forLastSpotterResult [
	^ self targetValue: PeGtSpotterResult
]

{ #category : 'accessing' }
PeGtToolVariableBinder class >> gtViewTargetsOn: aView [

	<gtView>
	<gtClassView>
	^ aView explicit
		title: 'Spotter';
		stencil: [ self forLastSpotterResult treeElement ]
]

{ #category : 'accessing' }
PeGtToolVariableBinder class >> targetValue: anObject [
	^ self new
		targetValue: anObject;
		yourself
]

{ #category : 'accessing' }
PeGtToolVariableBinder >> gtViewTargetsOn: aView [

	<gtView>
	<gtClassView>
	^ aView explicit
		title: 'Tools';
		priority: 25;
		stencil: [ self treeElement ]
]

{ #category : 'accessing' }
PeGtToolVariableBinder >> targetValue [
	^ targetValue
]

{ #category : 'accessing' }
PeGtToolVariableBinder >> targetValue: anObject [
	targetValue := anObject
]

{ #category : 'accessing' }
PeGtToolVariableBinder >> treeElement [
	^ BrSimpleTree new
			nodeStencil: [ 
				BrHorizontalPane new
					vFitContent;
					hMatchParent;
					alignCenterLeft;
					cellSpacing: 5;
					addChild: (BrLabel new aptitude: BrGlamorousLabelAptitude) as: #label;
					addChild: (BrButton new
						beTinySize;
						aptitude: BrGlamorousButtonWithLabelAptitude new;
						label: 'Bind')
					as: #bind ];
				nodeDataBinder: [ :aNodeElement :anInstance | anInstance peGtPharoSourceCoderTreeInitializeNode: aNodeElement ];
				items: self class allSpaces lazy: [ :e | e peGtPharoSourceCoderTreeChildrenForValue: self targetValue ]
]
