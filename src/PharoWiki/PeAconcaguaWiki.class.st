"
- ""Aconcagua provides a model that represents measures as first class objects, that is, an object that encapsulates a number with its unit."" *per G. Cotelli>http://forum.world.st/ANN-New-Aconcagua-Chalten-packages-tp1301458p1301460.html* 
!History
It was *originally announced>http://forum.world.st/ANN-Aconcagua-tp1403566.html* in 2006 on the VW list by Hernan W. when it was open sourced by Mercat Software.
!Repositories
Apparently *ba-st on GH>https://github.com/ba-st/aconcagua* is the community supported one. ""I don't know if call it canonical. But certainly it is the version the community is maintaining. It's a fork of the mtaborda repo and converted to tonel format. I don't know how it was migrated from Sthub, but it was before any tool for migrating the history existed. I think it must contain all the functionality available in Sthub."" *per G. Cotelli>http://forum.world.st/Aconcagua-Canonical-Repo-s-tp5105449p5105462.html*
!Older / Other
- *Hernan on StHub>http://smalltalkhub.com/HernanWilkinson/Aconcagua/commits.html* - last commit 2016 RE Pharo 4; most before that from 2014
- *Maxi on StHub>http://smalltalkhub.com/maxi/Aconcagua/commits.html* - last commit 2015, includes a bunch of my fixes; last commit says ""same as GH""; unclear if contains all code from Hernan's
- *Benoit's on StHub>http://smalltalkhub.com/BenoitAstruc/Aconcagua/commits.html* - just two ""hack"" commits re Chalten
- *DeNigris AddOns on StHub>http://smalltalkhub.com/SeanDeNigris/AconcaguaAddOns/mc/* - time, magritte, temperature, pressure, money, weights; in 2015 *I had asked>http://forum.world.st/Aconcagua-Common-Measurement-Systems-td4813202.html* if something like this existed, but got no response. The Magritte AddOn gives you MAMeasureDescription, which represents an Aconcagua Measure. It mostly acts like a number field mapped to its amount. You just have to tell it which unit to use to convert the amount number into a Measure. 

Example usage: 
        MAMeasureDescription new 
                accessor: #replacementPrice; 
                label: 'Replacement Price'; 
                unit: AmDollar new; 
                yourself 

Then, you can type 100 in a Magritte form and ""100 dollars"" will be saved to the model. Enjoy!

"
Class {
	#name : #PeAconcaguaWiki,
	#superclass : #Object,
	#traits : 'TAPWiki',
	#classTraits : 'TAPWiki classTrait',
	#category : #PharoWiki
}

{ #category : #wikiPages }
PeAconcaguaWiki class >> wikiPageDocumentation [
	"This method was automatically generated."
	<wikiPage: 'Documentation'>
	^APWikiPage
		wiki: self
		name: 'Documentation'
		text: 
'- *"Arithmetic with Measurements on Dynamically Typed OO Language" paper>http://stephane.ducasse.free.fr/Teaching/CoursAnnecy/0506-M1-COO/aconcagua-p292-wilkinson.pdf*
- *Chalten paper>http://stephane.ducasse.free.fr/Teaching/CoursAnnecy/0506-M1-COO/A%20New%20Object-Oriented%20Model%20of%20the%20Gregorian%20Calendar.pdf*'
]

{ #category : #wikiPages }
PeAconcaguaWiki class >> wikiPageFloat_Madness [
	"This method was automatically generated."
	<wikiPage: 'Float Madness'>
	^APWikiPage
		wiki: self
		name: 'Float Madness'
		text: 
'- *I thought I had found a hashing bug, but was schooled by Eliot re float comparison>http://forum.world.st/Aconcagua-Hashing-Bug-td4759622.html#a4759745*
!David Simmons on Using Integers and ScaledDecimals
http://forum.world.st/ScaledDecimal-conversion-and-equality-question-tp3359724p3359751.html'
]

{ #category : #wikiPages }
PeAconcaguaWiki class >> wikiPageFor_Further_Research [
	"This method was automatically generated."
	<wikiPage: 'For Further Research'>
	^APWikiPage
		wiki: self
		name: 'For Further Research'
		text: 
'- Reducing i.e. to present measures in the "most tidy" representation e.g. "125 dollars" instead of "12500 cents", "10 cups" instead of "480 teaspoons", etc. *I asked on Pharo Users ML>http://forum.world.st/Aconcagua-Documentation-tp4759781.html* in 2014 but got no answer. I also pointed out that according to the Chalten paper, reducing should be built-in but doesn''t currently seem to work: ==It seems this used to work...  10 years * 12 months / 24 months = 5 years “The model automatically simplifies units”... Anyone know why it was changed?"==
!Canonical Repo and Other Packages
- 3/20/2015 - *I reached out to Hernan W>http://forum.world.st/Who-maintains-Aconcagua-amp-Chalten-td4813575.html*, who created the library, RE the canonical location, but didn''t get anything definitive.
- 2009-10-08 - *Some packages announced by G. Cotelli>http://forum.world.st/ANN-New-Aconcagua-amp-Chalten-packages-td1301458.html*, which I assume made their way to GH
'
]

{ #category : #wikiPages }
PeAconcaguaWiki class >> wikiPageInstance_Creation [
	"This method was automatically generated."
	<wikiPage: 'Instance Creation'>
	^APWikiPage
		wiki: self
		name: 'Instance Creation'
		text: 
'!To Singleton or Not to Singleton
In *this interesting thread on SO>https://stackoverflow.com/questions/23744072/aconcagua-measure-library-storing-baseunits*, Benoit suggested using singletons:

==Yes the mile base unit must be a singleton, you can take a look at the Chalten framework which is using Aconcagua, in particular the TimeUnitsGlobal class. For the Number method part, in Chalten it''s done this way :

Number>>#daysMeasure
    ^TimeUnits day with: self
Although I have an issue with the way it''s done there because I can''t found a way to use Fuel with such units after that.==

He relates a problem with this approach when wanting to serialize via Fuel: ==I can''t found a way to use Fuel with such units after that.==, which I later ran into:

==I finally ran into the Fuel problem you were talking about. I ended evaluating MyBaseUnit allInstancesDo: [ :e | e becomeForward: singletonInstanceOfMyBaseUnit ] after materialization. I wonder whether in practice it''s really important to require aBaseUnit \== aBaseUnit. For my simple cases, it''d be much easier to treat them as value objects..==

Hernan however, then gave a different prespective:

==units are not really singletons but they use the original #= to see if two units are the same and the default implementation of #= verifies identity with #\==, but that can be overridden if necessary. The reason I did it that way is because I thought it was the most generic implementation. The easiest way to use them is to store units in global variables, therefore you can define:

Smalltalk at: #Mile put: (BaseUnit named: ''mile'' etc etc).

And then you can do 2*Mile witch makes a lot of sense because... it is like saying that "the knowledge of mile is global"

Another way to do it is how Chalten does it. That is to have a class that knows each unit and you can access them with messages like "TimeUnits day"

The idea is to avoid having to create a class per unit that does not make any sense... Another possibility is to 1) modify #= on Unit and use the uni''s name to verify if two units are the equal 2) Subclass BaseUnit and do 1) :-)=='
]

{ #category : #wikiPages }
PeAconcaguaWiki class >> wikiPageMoney [
	"This method was automatically generated."
	<wikiPage: 'Money'>
	^APWikiPage
		wiki: self
		name: 'Money'
		text: 
'Hernan W. *wrote>http://forum.world.st/Money-units-tp68797.html* ''''"We use Aconcagua as the base measure model for our financial applications... The idea of aconcagua is to represent any kind of measure. All our financial math is based on it... for example an interest rate is an instance of InterestRate (not included in Aconcagua) that is a subclass of Evaluation (at the begging called Formula) that is polimorphic with any other measure. That way all the financial formulas are reified and they can participate in any math operation with other measures, evaluations or even numbers... (measures and numbers are polimorphic also). Let me know if you have any problem. "''''
!Other Work
- Avi Bryant''s Money package on SqS *as mentioned by sebastian Sastre>http://forum.world.st/Money-units-tp68797.html*. In *Avi''s words>http://forum.world.st/Smalltalk-float-to-currency-how-to-tp86320p86326.html*, ''''I wouldn''t call it industry hardened, but I''ve posted what we use in Dabble to http://squeaksource.com/Money .  It uses the MoneyBag  approach to dealing with currency that I remember seeing as a pattern  somewhere... ''''
- *http://www.smalltalkhub.com/#!/~MarcusDenker/Units* - has pre-defined units, perhaps in contrast to Aconcagua?
- *From Ben Coman in 2012>http://forum.world.st/Quantities-and-Units-tp4274976.html*:
	- http://www.squeaksource.com/Units.html
	- http://www.cincomsmalltalk.com/publicRepository/Quantities.html
	- http://www.smalltalking.net/goodies/Dolphin/ (scroll to bottom) 
	- http://comments.gmane.org/gmane.comp.lang.smalltalk.squeak.general/55894
- *http://www.squeaksource.com/Money.html*. *According to Paul DeBruicker>http://forum.world.st/Pharo-dev-Monetary-package-tp4692670p4693053.html*, ''''"For anybody who cares it originally comes from last chapter of Smalltalk Best Practices Patterns by Kent Beck and was uploaded by Avi Bryant.  I''ve been decreasing the code quality for a little while.  ;)''''
- David Shaffer posted *a little solution>http://forum.world.st/Smalltalk-float-to-currency-how-to-tp86320p86325.html* on the Seaside ML
- Chris Muller *mentioned>http://forum.world.st/Re-Money-ScaledDecimal-is-it-really-appropriate-tp86365.html* that ''''Martin Fowler weighs in on a Money implementations in his book, "Analysis Patterns".''''

In 2015, I made *an appeal on Pharo Users>http://forum.world.st/Modeling-Money-Units-tp4838614.html* to clarify the situation, but got no answer:
''''There are several tools: Aconcagua, Money, Units; and at least two classes to overcome the imprecision of Floats: ScaledDecimal, FixedDecimal... 

I found one thread where Hernan said they use Aconcagua [1], another from Squeak implying that ScaledDecimal is broken [2]. A third seemed to say that FixedDecimal would be better [3], which I hadn''t heard in the handful of times money has been discussed on list (usually ScaledDecimal comes up). 

For a simple case where someone wanted to write a small personal accounting app, which tool and which type would be the best place to start? 

Thanks! 

[1] http://forum.world.st/Money-units-tp68797p68800.html
[2] http://forum.world.st/Seaside-Re-Money-ScaledDecimal-is-it-really-appropriate-tt46446.html
[3] http://forum.world.st/Pharo-dev-Monetary-package-tt4692670.html''''
!Units
- *Positive experience report>http://forum.world.st/Pharo-dev-Monetary-package-tp4692670p4692706.html* by Denis Kudriashov: ''''In past I used Units package to model money. It is very convinient to calculate currency exchange operations.''''
!Chris Cunningham Explains Fixed Decimal
*From Pharo Dev 2013>http://forum.world.st/Pharo-dev-Monetary-package-tp4692670p4692890.html*
''''First, is FixedDecimal used in the Money package?  I didn''t see is referenced there, so I''m curious where it came from.

There is a definite different between ScaledDecimal and FixedDecimal.  ScaledDecimal  (unless it''s been changed recently) keeps the full precision of the original number.  FixedDecimal (and Money, from my short perusal of it), do not - they make sure that the displayed value is exactly what the internal value is.  As an example, check out the following:

x := ((1/3) asScaledDecimal: 2).
x 		 		 				==> 0.33s2
x = (1/3)							==> true
((33/100) asScaledDecimal: 2)			==> 0.33s2
x = ((33/100) asScaledDecimal: 2)		==> false (!)
x + x								==> 0.67s2 (!)

In general, the last 2 statements are NOT what you want when dealing with Money - if you have an amount, it is a definite amount, and not an approximate amount.  (With the possible exceptions of interim results - but for those, you probably need strict control over exactly how precise the interim results are - which isn''t readily available in ScaleDecimal).  This is the main reason I built the FixedDecimal package on SqueakSource.  There, the above statements show:

x := ((1/3) asFixedDecimal: 2).
x 		 		 				==> 0.33
x = (1/3)							==> true
((33/100) asFixedDecimal: 2)			==> 0.33
x = ((33/100) asFixedDecimal: 2)			==> true
x + x								==> 0.66

From my perspecive, ScaledDecimal is great when you want to keep as much precision as possible, but need to SHOW less precision.  It reminds me of science, where you have this measurement that is way more precise than you can really measure, so you ''scale'' it back to a precision that is reliable.''''
'
]
