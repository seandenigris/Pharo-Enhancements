baselines
baseline: spec
	<baseline>

	spec for: #'common' do: [
		spec project: 'PharoSpd' with: [
			spec
				className: 'ConfigurationOfPharoSpd';
				repository: 'http://ss3.gemstone.com/ss/PharoSpd';
				loads: 'IDE' ].
		spec project: 'TWM' with: [
			spec
				className: 'ConfigurationOfTilingWindowManager';
				versionString: #'stable';
				repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main';
				postLoadDoIt: #afterLoadingTWM ].
		spec
			package: 'LED' with: [ spec repository: 'http://smalltalkhub.com/mc/PharoExtras/LEDMorph/main' ];
			package: 'MorphicExtrasSpd-Leds' with: [ spec repository: 'http://ss3.gemstone.com/ss/ExtensionsSpd' ];
			package: 'Dashboard' with: [ spec
				repository: 'http://ss3.gemstone.com/ss/PharoSpd';
				requires: #('LED' 'MorphicExtrasSpd-Leds');
				postLoadDoIt: #afterLoadingDashboard ].
		spec group: #default with: #(PharoSpd TWM) ].