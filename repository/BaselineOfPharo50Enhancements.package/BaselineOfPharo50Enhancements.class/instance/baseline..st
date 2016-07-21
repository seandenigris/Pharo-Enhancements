baseline
baseline: spec
	<baseline>

	spec for: #'pharo5.x' do: [
		spec
			package: 'Morphic-Widgets-Pluggable' with: [
				spec repository: 'github://seandenigris/Pharo-Kernel-Extensions:master/repository' ];
			package: 'GT-Inspector' with: [
				spec repository: 'github://seandenigris/Pharo-Kernel-Extensions:master/repository' ] ]
