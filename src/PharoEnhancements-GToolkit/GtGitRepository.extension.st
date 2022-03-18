Extension { #name : #GtGitRepository }

{ #category : #'*PharoEnhancements-GToolkit' }
GtGitRepository >> gtChangesFor: aView context: aContext [

	<gtView>
	<gtRepositoryView>
	| aViewModel changes chosen |
	chosen := Set new.

	aViewModel := self viewModel.

	self lepiterWorkingCopy ifNil: [ ^ aView empty ].
	changes := self workingCopyDiff treeToShow.
	(changes isNil or: [ changes isEmpty ]) ifTrue: [ 
		self repository isModified ifTrue: [ self refreshDirtyPackages ].
		^ aView empty ].

	changes do: [ :change | 
		change value hasChanges ifTrue: [ chosen add: change ] ].

	^ aView tree
		  title: 'Changes';
		  items: [ changes children ];
		  children: #children;
		  expandUpTo: 3;
		  priority: 1;
		  stencil: [ :anIceNode | 
			  | element |
			  element := BlElement new
				             layout: BlLinearLayout horizontal alignCenterLeft;
				             constraintsDo: [ :c | 
					             c horizontal matchParent.
					             c vertical fitContent ];
				             margin: (BlInsets all: 3);
				             constraintsDo: [ :c | c vertical fitContent ];
				             aptitude:
					             (BrGlamorousWithContextMenuAptitude content: [ 
							              BrGlamorousSimpleContextMenuContent new
		items: { 
			'Browse' -> [ :e | 
				anIceNode value canBeBrowsed ifTrue: [ 
					e phlow spawnObject: anIceNode value definition target ] ].
			'Revert changes' -> [ :e | 
				self workingCopy diffToReferenceCommit 
					revertChanges: anIceNode ] };
								              yourself ]).
			  anIceNode value hasChanges ifTrue: [ 
				  element addChild: (BrCheckbox new
						   aptitude: BrGlamorousCheckboxAptitude
							   +
								   (BrGlamorousWithLabelTooltipAptitude new text:
										    'Select for Commit');
						   checked: true;
						   whenCheckedDo: [ chosen add: anIceNode value ];
						   margin: (BlInsets right: 8);
						   whenUncheckedDo: [ 
							   chosen remove: anIceNode value ifAbsent: [  ] ]) ].
			  element
				  addChild:
					  (anIceNode value icon asElement constraintsDo: [ :c | 
							   c linear horizontal alignCenter ]);
				  addChild: (BrLabel new
						   aptitude: BrGlamorousLabelAptitude;
						   text: anIceNode value name asString asRopedText;
						   padding: (BlInsets
								    top: 0
								    left: 6
								    bottom: 0
								    right: 3);
						   constraintsDo: [ :c | c linear horizontal alignCenter ]) ];
		  actionDropdownButtonLabel: 'Commit'
		  tooltip: 'Commit changes'
		  content: [ :aDropdown :aTarget | 
			  | editor button saveAction |
			  editor := BrEditor new
				            aptitude: BrGlamorousRegularEditorAptitude;
				            text: aViewModel commitMessage;
				            hMatchParent;
				            vFitContentLimited;
				            requestFocus.
			  editor selecter
				  all;
				  select.

			  saveAction := [ 
			                aViewModel
				                executeCommit: editor editor text asString
				                withChanges: chosen.
			                button disable.
			                aDropdown enqueueTask:
				                (BlTaskAction new action: [ 
					                 aDropdown dispatchEvent:
						                 (BrDropdownHideWish new anchor: aDropdown) ]).
			                aDropdown phlow fireUpdateWish ].

			  editor addEditorShortcut: (BlShortcutWithAction new
					   combination: BlKeyCombination primaryS;
					   action: saveAction).

			  button := BrButton new.
			  button
				  aptitude: BrGlamorousButtonWithIconAptitude;
				  icon: BrGlamorousVectorIcons accept;
				  label: 'Commit';
				  disabled: editor text isEmpty;
				  action: saveAction.

			  editor editor
				  when: BrTextEditorModifiedEvent
				  do: [ :anEvent | button disabled: anEvent text isEmpty ].

			  BrVerticalPane new
				  hExact: 400;
				  vFitContentLimited;
				  padding: (BlInsets all: 10);
				  addChildren: { 
						  editor.
						  button } ]
]
