Extension { #name : #GtPlotterVerticalTimeline }

{ #category : #'*PharoEnhancements-GToolkit' }
GtPlotterVerticalTimeline >> createProjections: aCollectionOfDomainObjects [
	<gtExample>

	^ GtPlotterVerticalValueProjectionsElement new
		scale: timeScale;
		scaleData: timelineDataBlock;
		constraintsDo: [ :c | c horizontal matchParent ];
		hideOverlapping;
		valueElement: [ :aGtPlotterSingleScaleContext |
			| domainObject |
			domainObject := aGtPlotterSingleScaleContext originalValue.
			BlElement new
				layout: (BlLinearLayout horizontal alignCenter);
				addEventHandlerOn: BlClickEvent do: [ :evt | evt currentTarget phlow spawnObject: domainObject ];
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical fitContent ];
				addChildren: { 
					(projectionLineStencil arguments: {aGtPlotterSingleScaleContext originalValue}) asElement
						constraintsDo: [ :c | c horizontal matchParent ].
					BlTextElement new
						margin: (BlInsets left: self spacing);
						text: (projectionLabelFormat value: (projectionDataBlock value: aGtPlotterSingleScaleContext originalValue) asRopedText glamorousRegularFont)
				} ];
		valueStyle: [ :anElement | anElement ];
		valueLayout: [ :anElement :aGtPlotterScaleContext |
			anElement constraintsDo: [ :c |
				c frame horizontal alignLeft.
				c frame vertical alignCenterAt: aGtPlotterScaleContext mappedValue ];
				yourself ];
		values: aCollectionOfDomainObjects
]

{ #category : #'*PharoEnhancements-GToolkit' }
GtPlotterVerticalTimeline >> createTimelineDots: aCollectionOfDomainObjects [
	^ GtPlotterMarkersElement new
		scaleY: timeScale;
		x: [ :each | 0.5 ];
		y: timelineDataBlock;
		constraintsDo: [ :c | c horizontal fitContent ];
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
