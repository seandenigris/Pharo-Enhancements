baselines
baseline: spec
	<baseline>

	spec for: #'common' do: [
		spec 
			baseline: 'PharoEnhancements' with: [
				spec repository: 'github://seandenigris/Pharo-Enhancements/src' ];
			baseline: 'Calypso' with: [
				spec repository: 'github://pharo-ide/Calypso' ].
		"spec group: #default with: #(PharoEnhancements)" ].