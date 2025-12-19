Extension { #name : 'GtPlotterHorizontalTimeline' }

{ #category : '*PharoEnhancements-GToolkit' }
GtPlotterHorizontalTimeline >> createProjections: aCollectionOfDomainObjects [
	<gtExample>

	^ GtPlotterHorizontalValueProjectionsElement new
		scale: timeScale;
		scaleData: timelineDataBlock;
		constraintsDo: [ :c | c vertical matchParent. ];
		hideOverlapping;
		valueElement: [ :aGtPlotterSingleScaleContext |
			| domainObject |
			domainObject := aGtPlotterSingleScaleContext originalValue.
			BlElement new
				layout: (BlLinearLayout vertical alignCenter);
				addEventHandlerOn: BlClickEvent do: [ :evt | evt currentTarget phlow spawnObject: domainObject ];
				constraintsDo: [ :c |
					c vertical matchParent.
					c horizontal fitContent ];
				addChildren: { 
					BlTextElement new
						margin: (BlInsets bottom: self spacing);
						text: (projectionLabelFormat value: (projectionDataBlock value: aGtPlotterSingleScaleContext originalValue) asRopedText glamorousRegularFont).
					(projectionLineStencil arguments: {aGtPlotterSingleScaleContext originalValue}) asElement
						constraintsDo: [ :c | c vertical matchParent ].
				} ];
		valueStyle: [ :anElement | anElement ];
		valueLayout: [ :anElement :aGtPlotterScaleContext |
			anElement constraintsDo: [ :c |
				c frame vertical alignBottom.
				c frame horizontal alignCenterAt: aGtPlotterScaleContext mappedValue ];
				yourself ];
		values: aCollectionOfDomainObjects
]

{ #category : '*PharoEnhancements-GToolkit' }
GtPlotterHorizontalTimeline >> createTimelineDots: aCollectionOfDomainObjects [
	^ GtPlotterMarkersElement new
		horizontalMarkerLayout;
		scaleY: timeScale;
		x: [ :each | 0.5 ];
		y: timelineDataBlock;
		constraintsDo: [ :c | c vertical fitContent ];
		markerStyle: [ :anElement :scale |
			| domainObject |
			domainObject := scale originalValue.
			anElement
				size: 10@10;
				border: (BlBorder paint: Color black width: 2);
				background: Color black;
				addEventHandlerOn: BlClickEvent do: [ :evt | evt currentTarget phlow spawnObject: domainObject ] ];
		values: aCollectionOfDomainObjects
]
