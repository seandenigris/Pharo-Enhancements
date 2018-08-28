tests
testYearsSince

	| start end cases expected |
	"See #yearsSince: method comment for explanation of return value"
	cases := { 
		{ '1/1/2018'. '1/2/2018'. 1 / 365 }.
		{ '1/1/2018'. '1/1/2019'. 1 }.
		{ '1/1/2018'. '1/2/2019'. 1 + (1 / 365) }.
		
		"Leap year"
		{ '1/1/2016'. '1/1/2017'. 1 }.
		{ '2/28/2016'. '3/1/2016'. 2 / 366 }.
	}.
	
	cases do: [ :e |
		start := e first asDate.
		end := e second asDate.
		expected := e third.
		
		self assert: (end yearsSince: start) equals: expected ]