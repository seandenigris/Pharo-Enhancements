Class {
	#name : #PeTOMLParser,
	#superclass : #SmaCCGLRParser,
	#category : #'PharoEnhancements-GToolkit-TOML'
}

{ #category : #generated }
PeTOMLParser class >> ambiguousTransitions [
^#(
#[ 0 202 1 33] 
#[ 0 202 1 37] 
#[ 0 242 1 77] 
#[ 0 86 0 254] 
#[ 1 2 1 97]
	).
]

{ #category : #'generated-accessing' }
PeTOMLParser class >> cacheId [
	^'2022-03-20T09:15:11.603969-04:00'
]

{ #category : #generated }
PeTOMLParser class >> definitionComment [
"/*
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
""License""); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing,
  software distributed under the License is distributed on an
  ""AS IS"" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  KIND, either express or implied.  See the License for the
  specific language governing permissions and limitations
  under the License.
*/

%glr;
%annotate_tokens;
%root Toml;
%prefix Pe;
%suffix Node;
/*grammar toml;*/

/*
 * Parser Rules
 */

document : expression 'expression' (<NL> expression 'expression')* {{}};

expression : key_value 'keyValue' comment 'comment' | table comment 'comment' | comment 'comment' {{}};

comment: <COMMENT>? ;

key_value : key 'key' ""="" value 'value' {{}};

key : simple_key | dotted_key;

simple_key : quoted_key | unquoted_key ;

unquoted_key : <UNQUOTED_KEY> 'string' {{Key}};

quoted_key :  <BASIC_STRING> 'string' | <LITERAL_STRING> 'string' {{Key}};

dotted_key : simple_key (""."" simple_key)+ {{Key}};

value : string 'string' | integer | floating_point | bool_ | date_time | array_ | inline_table {{}};

string : <BASIC_STRING> 'string' | <ML_BASIC_STRING> 'string' | <LITERAL_STRING> 'string' | <ML_LITERAL_STRING> 'string' ;

integer : <DEC_INT> | <HEX_INT> | <OCT_INT> | <BIN_INT> ;

floating_point : <FLOAT> | <INF> | <NAN> ;

bool_ : <BOOLEAN> ;

date_time : <OFFSET_DATE_TIME> | <LOCAL_DATE_TIME> | <LOCAL_DATE> | <LOCAL_TIME> ;

array_ : ""["" array_values? comment_or_nl ""]"" ;

array_values : (comment_or_nl value 'value' nl_or_comment "","" array_values comment_or_nl) | comment_or_nl value 'value' nl_or_comment "",""? ;

comment_or_nl : (<COMMENT>? <NL>)* ;
nl_or_comment : (<NL> <COMMENT>?)* ;

table : standard_table | array_table ;

standard_table : ""["" key 'key' ""]"" {{}};

inline_table : ""{"" inline_table_keyvals ""}"" ;

inline_table_keyvals : inline_table_keyvals_non_empty? ;

inline_table_keyvals_non_empty : key 'key' ""="" value 'value' ("","" inline_table_keyvals_non_empty)? ;

array_table : ""["" ""["" key 'key' ""]"" ""]"" {{}};

/*
 * Lexer Rules
 */

<whitespace> : [\ \t]+ ;
<NL> : (\r? \n)+ ;
<COMMENT> : \# ([^\n])* ;

<DIGIT> : [0-9] ;
<ALPHA> : [A-Za-z] ;

# booleans
<BOOLEAN> : true | false ;

# strings
<ESC> : \\ ([\""\\\/bfnrt] | <UNICODE> | <EX_UNICODE>) ;
<ML_ESC> : \\ \r? \n | <ESC> ;
<UNICODE> : u <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> ;
<EX_UNICODE> : U <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> <HEX_DIGIT> ;
<BASIC_STRING> : \"" (<ESC> | [^\""\\\n])* \"" ;
<ML_BASIC_STRING> : \""\""\"" (<ML_ESC> | [^\""\\])* \""\""\"" ;
<LITERAL_STRING> : \' ([^\'\n])* \' ;
<ML_LITERAL_STRING> : \'\'\' ( [^\\\'] | \'[^\'] | \'\'[^\'] )* \'\'\';
# floating point numbers
<EXP> : (e | E) [\+\-]? <ZERO_PREFIXABLE_INT> ;
<ZERO_PREFIXABLE_INT> : <DIGIT> (<DIGIT> | _ <DIGIT>)* ;
<FRAC> : \. <ZERO_PREFIXABLE_INT> ;
<FLOAT> : <DEC_INT> ( <EXP> | <FRAC> <EXP>?) ;
<INF> : [\+\-]? inf ;
<NAN> : [\+\-]? nan ;
# integers
<HEX_DIGIT> : [A-Fa-f] | <DIGIT> ;
<DIGIT_1_9> : [1-9] ;
<DIGIT_0_7> : [0-7] ;
<DIGIT_0_1> : [0-1] ;
<DEC_INT> : [\+\-]? (<DIGIT> | (<DIGIT_1_9> (<DIGIT> | _ <DIGIT>)+)) ;
<HEX_INT> : 0x <HEX_DIGIT> (<HEX_DIGIT> | _ <HEX_DIGIT>)* ;
<OCT_INT> : 0o <DIGIT_0_7> (<DIGIT_0_7> | _ <DIGIT_0_7>)* ;
<BIN_INT> : 0b <DIGIT_0_1> (<DIGIT_0_1> | _ <DIGIT_0_1>)* ;
# dates
<YEAR> : <DIGIT> <DIGIT> <DIGIT> <DIGIT> ;
<MONTH> : <DIGIT> <DIGIT> ;
<DAY> : <DIGIT> <DIGIT> ;
<DELIM> : T | t | \  ;
<HOUR> : <DIGIT> <DIGIT> ;
<MINUTE> : <DIGIT> <DIGIT> ;
<SECOND> : <DIGIT> <DIGIT> ;
<SECFRAC> : \. <DIGIT>+ ;
<NUMOFFSET> : (\+ | \-) <HOUR> \: <MINUTE> ;
<OFFSET> : Z | <NUMOFFSET> ;
<PARTIAL_TIME> : <HOUR> \: <MINUTE> \: <SECOND> <SECFRAC>? ;
<FULL_DATE> : <YEAR> \- <MONTH> \- <DAY> ;
<FULL_TIME> : <PARTIAL_TIME> <OFFSET> ;
<OFFSET_DATE_TIME> : <FULL_DATE> <DELIM> <FULL_TIME> ;
<LOCAL_DATE_TIME> : <FULL_DATE> <DELIM> <PARTIAL_TIME> ;
<LOCAL_DATE> : <FULL_DATE> ;
<LOCAL_TIME> : <PARTIAL_TIME> ;
# keys
<UNQUOTED_KEY> : (<ALPHA> | <DIGIT> | \- | _)+ ;"
]

{ #category : #generated }
PeTOMLParser class >> reduceTable [
^#(
	#(33 0 #nil 1084417 false) 
	#(33 1 #liftFirstValue: 1084418 false) 
	#(38 1 #liftFirstValue: 1282049 false) 
	#(38 1 #reduceActionForquoted_key2: 1282050 false) 
	#(37 1 #reduceActionForquoted_key2: 1231873 false) 
	#(31 0 #reduceActionFor__NL__expression__expression___1: 936961 false) 
	#(32 1 #reduceActionForexpression3: 976899 false) 
	#(35 1 #liftFirstValue: 1156097 false) 
	#(36 1 #liftFirstValue: 1188866 false) 
	#(36 1 #liftFirstValue: 1188865 false) 
	#(35 1 #liftFirstValue: 1156098 false) 
	#(56 1 #liftFirstValue: 2128897 false) 
	#(56 1 #liftFirstValue: 2128898 false) 
	#(29 2 #reduceActionFordocument1: 901121 false) 
	#(32 2 #liftFirstValue: 976897 false) 
	#(41 1 #reduceActionFor_____simple_key__1: 1384449 false) 
	#(39 2 #reduceActionFordotted_key1: 1359873 false) 
	#(32 2 #liftFirstValue: 976898 false) 
	#(57 3 #reduceActionForstandard_table1: 2169857 false) 
	#(31 2 #reduceActionFor__NL__expression__expression___2: 936962 false) 
	#(52 0 #reduceActionFor__NL__expression__expression___1: 2068481 false) 
	#(59 0 #reduceActionForinline_table_keyvals1: 2260993 false) 
	#(46 1 #liftFirstValue: 1750017 false) 
	#(43 1 #liftFirstValue: 1517569 false) 
	#(43 1 #liftFirstValue: 1517570 false) 
	#(43 1 #liftFirstValue: 1517571 false) 
	#(43 1 #liftFirstValue: 1517572 false) 
	#(45 1 #reduceActionForfloating_point1: 1704961 false) 
	#(45 1 #reduceActionForfloating_point2: 1704962 false) 
	#(45 1 #reduceActionForfloating_point3: 1704963 false) 
	#(44 1 #reduceActionForinteger1: 1644545 false) 
	#(44 1 #reduceActionForinteger2: 1644546 false) 
	#(44 1 #reduceActionForinteger3: 1644547 false) 
	#(44 1 #reduceActionForinteger4: 1644548 false) 
	#(47 1 #reduceActionForinteger1: 1771521 false) 
	#(47 1 #reduceActionForinteger2: 1771522 false) 
	#(47 1 #reduceActionForinteger3: 1771523 false) 
	#(47 1 #reduceActionForinteger4: 1771524 false) 
	#(34 3 #reduceActionForkey_value1: 1107969 false) 
	#(42 1 #liftFirstValue: 1413121 false) 
	#(42 1 #liftFirstValue: 1413122 false) 
	#(42 1 #liftFirstValue: 1413123 false) 
	#(42 1 #liftFirstValue: 1413124 false) 
	#(42 1 #liftFirstValue: 1413125 false) 
	#(42 1 #liftFirstValue: 1413126 false) 
	#(42 1 #reduceActionForvalue7: 1413127 false) 
	#(40 2 #reduceActionFor_____simple_key_1: 1384449 false) 
	#(41 2 #reduceActionFor__NL__expression__expression___2: 1384450 false) 
	#(30 2 #reduceActionFor__NL__expression__expression__1: 936961 false) 
	#(50 1 #reduceActionForcomment_or_nl1: 2052097 false) 
	#(59 1 #reduceActionForcomment_or_nl1: 2260994 false) 
	#(61 5 #reduceActionForarray_table1: 2424833 false) 
	#(48 3 #reduceActionForarray_1: 1857537 false) 
	#(55 0 #reduceActionFor__NL__expression__expression___1: 2106369 false) 
	#(51 1 #reduceActionFor_____simple_key_1: 2068481 false) 
	#(52 2 #reduceActionFor__NL__expression__expression___2: 2068482 false) 
	#(58 3 #reduceActionForinline_table1: 2212865 false) 
	#(48 4 #reduceActionForarray_2: 1857538 false) 
	#(49 3 #reduceActionForarray_values2: 1906690 false) 
	#(53 1 #reduceActionForcomment_or_nl1: 2089985 false) 
	#(51 2 #reduceActionFor__COMMENT____NL__2: 2068482 false) 
	#(60 3 #reduceActionForinline_table_keyvals_non_empty1: 2320385 false) 
	#(49 4 #reduceActionForarray_values3: 1906691 false) 
	#(54 1 #reduceActionFor_____simple_key_1: 2106369 false) 
	#(55 2 #reduceActionFor__NL__expression__expression___2: 2106370 false) 
	#(54 2 #reduceActionFor__NL__expression__expression__1: 2106370 false) 
	#(60 5 #reduceActionForinline_table_keyvals_non_empty2: 2320386 false) 
	#(49 6 #reduceActionForarray_values1: 1906689 false)
	).
]

{ #category : #generated }
PeTOMLParser class >> scannerClass [
	^PeTOMLScanner
]

{ #category : #generated }
PeTOMLParser class >> startingStateFordocument [

	^ 1
]

{ #category : #generated }
PeTOMLParser class >> symbolNames [

	^ #( '","' '"."' '"="' '"["' '"]"' '"{"' '"}"' '<whitespace>'
	     '<NL>' '<COMMENT>' '<BOOLEAN>' '<BASIC_STRING>' '<ML_BASIC_STRING>'
	     '<LITERAL_STRING>' '<ML_LITERAL_STRING>' '<FLOAT>' '<INF>'
	     '<NAN>' '<DEC_INT>' '<HEX_INT>' '<OCT_INT>' '<BIN_INT>'
	     '<OFFSET_DATE_TIME>' '<LOCAL_DATE_TIME>' '<LOCAL_DATE>'
	     '<LOCAL_TIME>' '<UNQUOTED_KEY>' 'B e g i n' 'document'
	     '(<NL> expression ''expression'')'
	     '(<NL> expression ''expression'')*'
	     'expression' 'comment' 'key_value' 'key' 'simple_key'
	     'unquoted_key' 'quoted_key' 'dotted_key' '("." simple_key)'
	     '("." simple_key)+' 'value' 'string' 'integer' 'floating_point'
	     'bool_' 'date_time' 'array_' 'array_values' 'comment_or_nl'
	     '(<COMMENT>? <NL>)' '(<COMMENT>? <NL>)*' 'nl_or_comment'
	     '(<NL> <COMMENT>?)' '(<NL> <COMMENT>?)*' 'table' 'standard_table'
	     'inline_table' 'inline_table_keyvals' 'inline_table_keyvals_non_empty'
	     'array_table' 'E O F' 'error' )
]

{ #category : #generated }
PeTOMLParser class >> symbolTypes [

	^ #( #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken
	     #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken
	     #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken
	     #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken
	     #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken
	     #SmaCCToken #SmaCCToken #PeDocumentNode #PeDocumentNode
	     #OrderedCollection #OrderedCollection #PeTomlNode #SmaCCToken
	     #PeKeyValueNode #Object #Object #PeKeyNode #Object #PeKeyNode
	     #OrderedCollection #OrderedCollection #Object #SmaCCToken
	     #OrderedCollection #OrderedCollection #SmaCCToken #OrderedCollection
	     #OrderedCollection #OrderedCollection #OrderedCollection
	     #OrderedCollection #OrderedCollection #OrderedCollection
	     #OrderedCollection #OrderedCollection #PeTomlNode #PeStandardTableNode
	     #OrderedCollection #OrderedCollection #OrderedCollection
	     #PeArrayTableNode #SmaCCToken #SmaCCErrorNode )
]

{ #category : #generated }
PeTOMLParser class >> transitionTable [
^#(
#[1 0 9 0 4 0 6 0 9 0 37 0 10 0 49 0 12 0 21 0 14 0 25 0 27 0 29 0 29 0 33 0 32 0 37 0 33 0 41 0 34 0 45 0 35 0 49 0 36 0 49 0 37 0 49 0 38 0 45 0 39 0 65 0 56 0 65 0 57 0 65 0 61 0 6 0 62] 
#[1 0 77 0 4 0 49 0 12 0 21 0 14 0 25 0 27 0 81 0 35 0 49 0 36 0 49 0 37 0 49 0 38 0 81 0 39] 
#[0 0 10 0 9 0 62] 
#[0 0 14 0 2 0 3 0 5] 
#[0 0 18 0 2 0 3 0 5] 
#[0 0 22 0 2 0 3 0 5] 
#[0 0 0 0 62] 
#[1 0 26 0 9 0 85 0 31 0 26 0 62] 
#[0 0 30 0 9 0 62] 
#[1 0 6 0 9 0 89 0 10 0 89 0 33 0 6 0 62] 
#[0 0 93 0 3] 
#[1 0 97 0 2 0 34 0 3 0 34 0 5 0 101 0 40 0 105 0 41] 
#[0 0 38 0 2 0 3 0 5] 
#[0 0 42 0 2 0 3 0 5] 
#[0 0 46 0 3 0 5] 
#[1 0 6 0 9 0 109 0 10 0 109 0 33 0 6 0 62] 
#[0 0 50 0 9 0 10 0 62] 
#[0 0 54 0 9 0 10 0 62] 
#[1 0 49 0 12 0 21 0 14 0 25 0 27 0 113 0 35 0 49 0 36 0 49 0 37 0 49 0 38 0 113 0 39] 
#[0 0 117 0 5] 
#[1 0 121 0 9 0 125 0 30 0 58 0 62] 
#[0 0 62 0 9 0 62] 
#[1 0 129 0 4 0 133 0 6 0 201 0 11 0 201 0 12 0 201 0 13 0 201 0 14 0 201 0 15 0 157 0 16 0 161 0 17 0 165 0 18 0 169 0 19 0 173 0 20 0 177 0 21 0 181 0 22 0 185 0 23 0 189 0 24 0 193 0 25 0 197 0 26 0 201 0 42 0 201 0 43 0 201 0 44 0 201 0 45 0 201 0 46 0 201 0 47 0 201 0 48 0 229 0 58] 
#[1 0 233 0 12 0 21 0 14 0 25 0 27 0 233 0 36 0 233 0 37 0 233 0 38] 
#[0 0 66 0 2 0 3 0 5] 
#[1 0 97 0 2 0 70 0 3 0 70 0 5 0 237 0 40] 
#[0 0 74 0 9 0 62] 
#[0 0 241 0 5] 
#[0 0 78 0 9 0 10 0 62] 
#[1 0 9 0 4 0 6 0 9 0 37 0 10 0 49 0 12 0 21 0 14 0 25 0 27 0 245 0 32 0 37 0 33 0 41 0 34 0 45 0 35 0 49 0 36 0 49 0 37 0 49 0 38 0 45 0 39 0 65 0 56 0 65 0 57 0 65 0 61 0 6 0 62] 
#[0 0 82 0 9 0 62] 
#[1 0 86 0 4 0 86 0 5 0 86 0 6 0 86 0 9 0 86 0 10 0 86 0 11 0 86 0 12 0 86 0 13 0 86 0 14 0 86 0 15 0 86 0 16 0 86 0 17 0 86 0 18 0 86 0 19 0 86 0 20 0 86 0 21 0 86 0 22 0 86 0 23 0 86 0 24 0 86 0 25 0 86 0 26 0 249 0 49 0 253 0 50 1 1 0 52] 
#[1 0 90 0 7 0 49 0 12 0 21 0 14 0 25 0 27 1 5 0 35 0 49 0 36 0 49 0 37 0 49 0 38 1 5 0 39 1 9 0 59 1 13 0 60] 
#[0 0 94 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 98 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 102 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 106 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 110 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 114 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 118 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 122 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 126 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 130 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 134 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 138 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 142 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 146 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 150 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 154 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 158 0 9 0 10 0 62] 
#[0 0 162 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 166 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 170 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 174 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 178 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 182 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 186 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 190 0 2 0 3 0 5] 
#[0 0 194 0 2 0 3 0 5] 
#[0 1 17 0 5] 
#[0 0 198 0 9 0 62] 
#[1 0 86 0 5 0 86 0 9 0 86 0 10 1 21 0 50 1 1 0 52] 
#[1 0 129 0 4 1 25 0 5 0 133 0 6 1 29 0 11 1 29 0 12 1 29 0 13 1 29 0 14 1 29 0 15 0 157 0 16 0 161 0 17 0 165 0 18 0 169 0 19 0 173 0 20 0 177 0 21 0 181 0 22 0 185 0 23 0 189 0 24 0 193 0 25 0 197 0 26 1 29 0 42 1 29 0 43 1 29 0 44 1 29 0 45 1 29 0 46 1 29 0 47 1 29 0 48 0 229 0 58] 
#[1 0 202 0 4 0 202 0 5 0 202 0 6 0 7 0 9 0 11 0 10 0 202 0 11 0 202 0 12 0 202 0 13 0 202 0 14 0 202 0 15 0 202 0 16 0 202 0 17 0 202 0 18 0 202 0 19 0 202 0 20 0 202 0 21 0 202 0 22 0 202 0 23 0 202 0 24 0 202 0 25 0 202 0 26 1 41 0 51] 
#[0 1 45 0 3] 
#[0 1 49 0 7] 
#[0 0 206 0 7] 
#[0 0 210 0 9 0 10 0 62] 
#[0 1 53 0 5] 
#[0 0 214 0 1 0 5 0 7 0 9 0 10 0 62] 
#[1 0 218 0 1 0 218 0 5 0 218 0 9 0 218 0 10 1 57 0 53 1 61 0 55] 
#[0 0 222 0 4 0 5 0 6 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26] 
#[0 1 65 0 9] 
#[0 0 226 0 4 0 5 0 6 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26] 
#[1 0 129 0 4 0 133 0 6 1 69 0 11 1 69 0 12 1 69 0 13 1 69 0 14 1 69 0 15 0 157 0 16 0 161 0 17 0 165 0 18 0 169 0 19 0 173 0 20 0 177 0 21 0 181 0 22 0 185 0 23 0 189 0 24 0 193 0 25 0 197 0 26 1 69 0 42 1 69 0 43 1 69 0 44 1 69 0 45 1 69 0 46 1 69 0 47 1 69 0 48 0 229 0 58] 
#[0 0 230 0 1 0 5 0 7 0 9 0 10 0 62] 
#[0 0 234 0 1 0 5 0 7 0 9 0 10 0 62] 
#[1 1 73 0 1 0 238 0 5 0 238 0 9 0 238 0 10] 
#[1 0 242 0 1 0 242 0 5 0 15 0 9 0 242 0 10 1 81 0 54] 
#[0 0 246 0 4 0 5 0 6 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26] 
#[1 1 85 0 1 0 250 0 7] 
#[1 0 86 0 4 0 254 0 5 0 86 0 6 0 19 0 9 0 19 0 10 0 86 0 11 0 86 0 12 0 86 0 13 0 86 0 14 0 86 0 15 0 86 0 16 0 86 0 17 0 86 0 18 0 86 0 19 0 86 0 20 0 86 0 21 0 86 0 22 0 86 0 23 0 86 0 24 0 86 0 25 0 86 0 26 1 89 0 49 1 93 0 50 1 1 0 52] 
#[1 1 2 0 1 1 2 0 5 1 2 0 9 0 23 0 10] 
#[0 1 6 0 1 0 5 0 9 0 10] 
#[1 0 49 0 12 0 21 0 14 0 25 0 27 1 5 0 35 0 49 0 36 0 49 0 37 0 49 0 38 1 5 0 39 1 101 0 60] 
#[1 0 86 0 5 0 86 0 9 0 86 0 10 1 105 0 50 1 1 0 52] 
#[1 0 129 0 4 0 133 0 6 1 29 0 11 1 29 0 12 1 29 0 13 1 29 0 14 1 29 0 15 0 157 0 16 0 161 0 17 0 165 0 18 0 169 0 19 0 173 0 20 0 177 0 21 0 181 0 22 0 185 0 23 0 189 0 24 0 193 0 25 0 197 0 26 1 29 0 42 1 29 0 43 1 29 0 44 1 29 0 45 1 29 0 46 1 29 0 47 1 29 0 48 0 229 0 58] 
#[0 1 10 0 1 0 5 0 9 0 10] 
#[0 1 14 0 7] 
#[0 1 18 0 5 0 9 0 10]
	).
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionFor__COMMENT____NL__2: nodes [

	| result |
	result := Array new: 2.
	result at: 2 put: (nodes at: 1).
	result at: 1 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionFor__NL__expression__expression__1: nodes [

	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionFor__NL__expression__expression___1: nodes [

	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionFor__NL__expression__expression___2: nodes [

	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionFor_____simple_key_1: nodes [

	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionFor_____simple_key__1: nodes [

	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: ((nodes at: 1) at: 1) to: (result at: 1).
	self add: ((nodes at: 1) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForarray_1: nodes [

	| result |
	result := Array new: 6.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self addAll: ((nodes at: 2) at: 1) to: (result at: 2).
	self addAll: ((nodes at: 2) at: 2) to: (result at: 3).
	result at: 4 put: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForarray_2: nodes [

	| result |
	result := Array new: 6.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self addAll: ((nodes at: 2) at: 1) to: (result at: 2).
	self addAll: ((nodes at: 2) at: 2) to: (result at: 3).
	self addAll: ((nodes at: 2) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 2) at: 4) to: (result at: 6).
	self addAll: ((nodes at: 3) at: 1) to: (result at: 2).
	self addAll: ((nodes at: 3) at: 2) to: (result at: 3).
	result at: 4 put: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForarray_table1: nodes [

	| result |
	result := PeArrayTableNode new.
	result addToken: (nodes at: 1) to: result leftBracketTokens.
	result addToken: (nodes at: 2) to: result leftBracketTokens.
	result key: (nodes at: 3).
	result addToken: (nodes at: 4) to: result rightBracketTokens.
	result addToken: (nodes at: 5) to: result rightBracketTokens.
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForarray_values1: nodes [

	| result |
	result := nodes at: 5.
	self addAllFirst: ((nodes at: 1) at: 1) to: (result at: 1).
	self addAllFirst: ((nodes at: 1) at: 2) to: (result at: 2).
	self addFirst: (nodes at: 2) to: (result at: 3).
	self addAllFirst: ((nodes at: 3) at: 1) to: (result at: 1).
	self addAllFirst: ((nodes at: 3) at: 2) to: (result at: 2).
	self addFirst: (nodes at: 4) to: (result at: 4).
	self addAll: ((nodes at: 6) at: 1) to: (result at: 1).
	self addAll: ((nodes at: 6) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForarray_values2: nodes [

	| result |
	result := Array new: 4.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	self addAll: ((nodes at: 1) at: 1) to: (result at: 1).
	self addAll: ((nodes at: 1) at: 2) to: (result at: 2).
	self add: (nodes at: 2) to: (result at: 3).
	self addAll: ((nodes at: 3) at: 1) to: (result at: 1).
	self addAll: ((nodes at: 3) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForarray_values3: nodes [

	| result |
	result := Array new: 4.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	self addAll: ((nodes at: 1) at: 1) to: (result at: 1).
	self addAll: ((nodes at: 1) at: 2) to: (result at: 2).
	self add: (nodes at: 2) to: (result at: 3).
	self addAll: ((nodes at: 3) at: 1) to: (result at: 1).
	self addAll: ((nodes at: 3) at: 2) to: (result at: 2).
	self add: (nodes at: 4) to: (result at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForcomment_or_nl1: nodes [

	| result |
	result := nodes at: 1.
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionFordocument1: nodes [

	| result |
	result := PeDocumentNode new.
	result addNode: (nodes at: 1) to: result expressions.
	result addTokens: ((nodes at: 2) at: 1) to: result nLTokens.
	result addNodes: ((nodes at: 2) at: 2) to: result expressions.
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionFordotted_key1: nodes [

	| result |
	result := PeKeyNode new.
	result addTokens: ((nodes at: 2) at: 1) to: result periodTokens.
	result addTokens: ((nodes at: 2) at: 2) to: result strings.
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForexpression3: nodes [

	| result |
	result := PeExpressionNode new.
	result comment: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForfloating_point1: nodes [

	| result |
	result := Array new: 3.
	result at: 1 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForfloating_point2: nodes [

	| result |
	result := Array new: 3.
	result at: 2 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForfloating_point3: nodes [

	| result |
	result := Array new: 3.
	result at: 3 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForinline_table1: nodes [

	| result |
	result := Array new: 6.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self addAll: ((nodes at: 2) at: 1) to: (result at: 2).
	self addAll: ((nodes at: 2) at: 2) to: (result at: 3).
	self addAll: ((nodes at: 2) at: 3) to: (result at: 4).
	self addAll: ((nodes at: 2) at: 4) to: (result at: 5).
	result at: 6 put: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForinline_table_keyvals1: nodes [

	| result |
	result := Array new: 4.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForinline_table_keyvals_non_empty1: nodes [

	| result |
	result := Array new: 4.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	self add: (nodes at: 1) to: (result at: 1).
	self add: (nodes at: 2) to: (result at: 2).
	self add: (nodes at: 3) to: (result at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForinline_table_keyvals_non_empty2: nodes [

	| result |
	result := nodes at: 5.
	self addFirst: (nodes at: 1) to: (result at: 1).
	self addFirst: (nodes at: 2) to: (result at: 2).
	self addFirst: (nodes at: 3) to: (result at: 3).
	self addFirst: (nodes at: 4) to: (result at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForinteger1: nodes [

	| result |
	result := Array new: 4.
	result at: 1 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForinteger2: nodes [

	| result |
	result := Array new: 4.
	result at: 2 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForinteger3: nodes [

	| result |
	result := Array new: 4.
	result at: 3 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForinteger4: nodes [

	| result |
	result := Array new: 4.
	result at: 4 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForkey_value1: nodes [

	| result |
	result := PeKeyValueNode new.
	result key: (nodes at: 1).
	result equalToken: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForquoted_key2: nodes [

	| result |
	result := PeKeyNode new.
	result addToken: (nodes at: 1) to: result strings.
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForstandard_table1: nodes [

	| result |
	result := PeStandardTableNode new.
	result leftBracketToken: (nodes at: 1).
	result key: (nodes at: 2).
	result rightBracketToken: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
PeTOMLParser >> reduceActionForvalue7: nodes [

	| result |
	result := PeValueNode new.
	result leftBraceToken: ((nodes at: 1) at: 1).
	result addObjects: ((nodes at: 1) at: 2) to: result keies.
	result addTokens: ((nodes at: 1) at: 3) to: result equalTokens.
	result addObjects: ((nodes at: 1) at: 4) to: result values.
	result addTokens: ((nodes at: 1) at: 5) to: result commaTokens.
	result rightBraceToken: ((nodes at: 1) at: 6).
	^ result
]
