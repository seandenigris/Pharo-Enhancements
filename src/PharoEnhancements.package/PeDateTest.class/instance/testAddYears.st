tests
testAddYears

	| start increment cases expected |
	cases := { 
		{ '3/1/2016'. 1. '3/1/2017' }.
		
		"Leap year"
		{ '2/29/2016'. 4. '2/29/2020' }.
		{ '2/29/2016'. 1. '3/1/2017' }.
	}.
	
	cases do: [ :e |
		start := e first asDate.
		increment := e second.
		expected := e third asDate.
		
		self assert: (start addYears: increment) equals: expected ]