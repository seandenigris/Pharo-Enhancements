tests
testSubtractYears

	| start increment cases expected |
	cases := { 
		{ '3/1/2016'. 1. '3/1/2015' }.
		
		"Leap year"
		{ '2/29/2016'. 4. '2/29/2012' }.
		{ '2/29/2016'. 1. '3/1/2015' }.
	}.
	
	cases do: [ :e |
		start := e first asDate.
		increment := e second.
		expected := e third asDate.
		
		self assert: (start subtractYears: increment) equals: expected ]