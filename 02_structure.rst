.. _documents:

#############################
EDI Documents
#############################

.. _sets:

Transaction Set
=============================

A transaction set is the definition of the meaningful data collection exchanged 
between two parties which comprises a complete business document. Each 
transaction set is composed of a specific assemblage of segments that represent 
a common business document (for example, a purchase order or an invoice). Each 
transaction set consists of the transaction set header (ST) as the first segment 
and contains at least one data segment before the transaction set trailer (SE).

Data Segment
=============================

A segment is the intermediate unit of information in a transaction set. Segments 
consist of logically related data elements in a defined sequence. EDI Standards
describe the relationship between segments which combine to form a transaction 
set. Specifically, set definitions list segments in their sequence of 
occurrence, designate them as required mandatory or optional or floating, and
define their frequency of repeating or group looping.

Segment identifier
---------------------------
  
A unique segment identifier comprises the first characters of the segment. 
This identifier is a combination of two or three letters or digits.

Requirement designator
------------------------------
  
One of the following three designators defines a segment's requirement to 
appear in the transaction set:

+----------------+-------------------------------------------------------+
| Mandatory (M)  | This segment shall appear at least once               |
+----------------+-------------------------------------------------------+
| Optional (O)   | This segment appears at the option of the sender      |
+----------------+-------------------------------------------------------+
| Floating (F)   | This designation is used with the NTE segment, which  |
|                | may appear anywhere within the transaction set        |
+----------------+-------------------------------------------------------+

Sequence
---------------------------
  
Each segment is assigned to a specific position in the sequence of segments in 
the transaction set. Within a transmission, segments shall appear in this 
order except for segments which are designated *Floating*.

Maximum Use
---------------------------
  
Each segment is permitted to appear in succession a maximum number of times at 
a specific location within a transaction set. The symbol `>1` indicates that 
a segments may be used one or more times at its specific location in the 
transaction set.

Loops
---------------------------
  
In the transaction set tables, the segments comprising a loop are designated 
by the loop identifier at the starting segment, and the level indicating the 
continuation of the loop. The loop repeat next to the loop identifier shows 
the number of times the loop may be used at that specific location. The symbol 
`>1` indicates that a loop may be used one or more times.

+ Loops may be nested within other loops. The level column in the standards 
  indicates the current nesting level.

+ If the requirement designator of the first segment in a loop is Mandatory, 
  at least one iteration of the loop must occur.

+ If a loop is used, the first segment shall be used in each loop iteration.

+ Mandatory segments within a loop are mandatory only if the loop is used.

Exchange Control Segments
=============================

Each data exchange has control segments which envelope the entire exchange,
additional segments to group like documents, and segments which indicate the 
start and end of each document. These special segments are as follows:
  
+---------+---------------------++---------+---------------------+
| Segment | Segment Name        || Segment | Segment Name        |
+=========+=====================++=========+=====================+
| ISA     | Interchange Start   || IEA     | Interchange End     | 
+---------+---------------------++---------+---------------------+
| GS      | Group Start         || GE      | Group End           |
+---------+---------------------++---------+---------------------+
| ST      | Set Start           || SE      | Set End             |
+---------+---------------------++---------+---------------------+
  
Control segments contain additional information about the exchange, including 
sequence numbers which may be used to manage the exchange process. Some of 
this information is described following:
  
+--------+---------------------+---------------------+-----------------------+
| Segment| Control sequence    | Included information elements               |
+========+=====================+=====================+=======================+
| ISA    | Interchange Control | transmit Date, Time | Sender, Receiver IDs  |
+--------+---------------------+---------------------+-----------------------+
| IEA    | Interchange control | number of included groups                   |
+--------+---------------------+---------------------+-----------------------+
| GS     | Group Control       | group ID, Date, Time| Sender, Receiver codes|
+--------+---------------------+---------------------+-----------------------+
| GE     | Group control       | number of included sets                     |
+--------+---------------------+---------------------+-----------------------+
| ST     | Set Control Number  | transaction set ID (defined in DE 143)      |                 
+--------+---------------------+---------------------+-----------------------+
| SE     | Set Control Number  | number of included segments                 |
+--------+---------------------+---------------------+-----------------------+
  
Additionally, the first data element of each transaction set start segment 
(ST) is an identifier of the set type. Codes for element `143` in the Data 
Element Dictionary list possible set identifiers.

EDI standards associate a functional group identifier code with each set 
identifier in DE 143. Functional Group Identifier codes are defined in the 
Data Element Dictionary under element `479`, Functional Group Identifier. 
In cases where no functional group is given, the transaction set assumes the 
functional group ID of the functional group with which it is transmitted.

Notes and Comments
=============================

| Where notes are provided, these are considered part of the standard. 
| Comments are not a part of the standard. 
| Multiple notes and comments may appear for the same segment.

---------  
  
.. _segments:

#############################
 Segments
#############################

A segment is the intermediate unit of information in a transaction set. Segments 
consist of logically related data elements in a defined sequence. Each segment 
has a unique identifier that comprises the first characters of the segment. When 
segments are combined to form a transaction set, their relationship to the 
transaction set is defined by a segment requirement designator and a segment 
sequence. Some segments may be repeated, and groups of segments may be repeated 
as loops.

Segment Name Heading
=============================

Segment identifier
-----------------------------

Each segment has a unique identifier comprised of two or three letters or 
digits. This identifier is the first entry in the segment data.

Segment terminator 
-----------------------------

Each segment ends with a segment terminator specified by the sender in the 
Interchange Control Header segment (ISA). The segment terminator must be 
different from the data element separator, described below. The segment 
terminator and data element and subelement separators must not appear in a 
data element value except for possibly Binary Data Element `785`.

Data element separator 
-----------------------------

Each data element in a segment is preceded by a separator character, or, in 
the case of composite data structures, a subelement separator. The data 
element separator and subelement separator must be different from the segment 
terminator.

If optional data elements occurring at the end of a segment are not used, the 
data element separators need not be transmitted. Similarly, subelement 
separators at the end of a composite data structure need not be transmitted.

Segment Details Body
=============================

Data Element Position
-----------------------------

Data elements are assigned a specific position within a segment. In a 
transmission, the segment is terminated after the last data element used.
In this case, the presence of the segment terminator signifies that the 
remaining data elements have been omitted. The omission of data elements 
other than at the end of a segment is signified by successive data element 
separators, or, in the case of a composite data structure, subelement 
separators.

Data Element Reference Designator
---------------------------------

Each data element in a segment is assigned a number to indicate its sequential 
position within that segment. The counting of positions starts with `01` for 
the first data element and is incremented by one for each successive element 
to the end of the segment.

Data Element
-----------------------------

A data element can represent a qualifier, a value, or text. Each data element 
is identified by a reference number. Reference numbers which begin with a 
`C` or an `S` indicate that the data element is a composite.

Requirement Designator 
-----------------------------

One of the following three requirement designators specifies the need for a data 
element to appear within the segment:

+---------------------+--------------------------------------------------------+
| Mandatory (M)       | This element is required to appear in the segment      |
+---------------------+--------------------------------------------------------+
| Optional (O)        | The occurrence of this data element is optional        |
+---------------------+--------------------------------------------------------+
| Relational (X or C) | A relational condition applies to this element         |
+---------------------+--------------------------------------------------------+

Relational Conditions 
-----------------------------

Relational Conditions may exist between two or more data elements within a 
segment based on the presence or absence of one of those data elements. 
Relational conditions are specified by a condition code, `P`, `R`, `E`, `C`, or 
`L`, and the identities of the related elements. The types of relational 
conditions are further documented in the syntax notes entry help. 

*In the standards viewer, relational conditions are indicated by an "X" in the 
Requirement column.*

Segment Notes footer
=============================

Notes and Comments 
-----------------------------

Syntax and semantic notes which appear under the segment are considered part of 
the standard. Where comments are included, they are not considered part of the 
standard.

Syntax Notes 
-----------------------------

Dependencies based on the presence or absence of other data elements are shown 
as syntax notes. The dependencies described by these notes are also represented 
by the relational condition codes described above.

Semantic Notes 
-----------------------------

Semantic notes provide additional information about the intended meaning of a 
data element in the context of a segment. The note may also define a 
relationship among data elements based on the presence of one or more values in 
one if the data elements. Semantic notes are part of the standard.

Comments 
-----------------------------

Comments are provided to clarify or aid in understanding the intended use of 
the segment. Comments are not considered part of the standard.

----------

.. _composites:

#############################
Composites
#############################

A composite data structure consists of two or more logically related component 
data elements in a defined sequence. (The component data elements are defined in 
the Data Element Dictionary.) The specification of composite data structures 
consists of the following parts.

Composites Name Header
=============================

Description 
-----------------------------

Each composite data structure is named and defined in a description statement 
that specifies the purpose of the composite.

Reference Identifier 
-----------------------------

Each composite data structure has a unique four-character reference identifier. 
The first character of the identifier is an `S` when the composite data 
structure is used in a control segment and a `C` when it is used in a data 
segment. The remaining characters are digits.

Composites Details Body
=============================

Composite Details Table  
-----------------------------
A detail table presents the component elements of the composite structure and 
is displayed in the Detail Body tab.

Component Data Elements 
-----------------------------

When component data elements are combined to form a composite data structure, 
their relationship to the composite data structure is defined by a component 
data element sequence and a component data element requirement designator.

Sequence Number 
-----------------------------

The component data element sequence number indicates an element's position in 
the composite data structure. 

*This column is labeled "Seq" in the details table.*

Requirement Designator 
-----------------------------

A component data element is assigned one of three requirement designators: 
`M` for mandatory, `O` for optional, or `X` for conditional relationships.

*The "Cond" and "Relation" columns show relational conditions, which are further 
defined in the syntax notes entry help. The requirement designator is in column 
"Req" of the details table.* 

Composite Notes Footer
=============================

Notes and Comments 
-----------------------------

Notes and comments are provided to clarify or aid in understanding the intended 
use of the composite data structure. Notes are part of the standard, while 
comments are not.

----------

.. _elements:

#############################
 Elements
#############################

Simple data elements are the basic units used in constructing composite data 
structures and segments, which in turn comprise transaction sets in ASC X12.

A data element can represent a qualifier, a value, or text (such as a 
description). Each data element is identified by a number used for reference in 
the Data Element Dictionary, which defines specifications for each data element. 
This specification consists of the following parts.

Element Name Header
=============================

Description 
-----------------------------

Each data element is defined in a description statement that specifies the 
purpose of the data element.

Type 
-----------------------------

A data element may be of one of eight types: numeric, decimal, identifier, 
string, date, time, binary, or fixed-length string. 

*The requirements of each element type are stated in the help for the "TYPE" 
entry.*

Length 
-----------------------------

This is the range, minimum to maximum, of the number of character positions 
available to represent the data element value. A data element may be of variable 
length with range from minimum to maximum, or it may be of fixed length in which 
the minimum is equal to the maximum. Length is defined differently for numbers 
than for other types of data elements. 

*The range length is shown in the standard as "MIN" and "MAX". Refer to the help 
for "MIN" and "MAX" entries for further information.*

Reference Number 
-----------------------------

Data elements are identified by a unique reference number. This reference number 
is used in all segments. Reference numbers which begin with a `C` or an `S` 
indicate that the data element is a composite rather than a simple data element.

Element Details Body
=============================

Code Values 
-----------------------------

Data Element code values, definitions, and explanations are listed for data 
elements of type `ID` (identifier). An identifier data element must always 
contain a value from a predefined list of values. A sample table of code values 
and their descriptions are shown in the table below.
 
+------+-------+------+----------------------------------------------+
| Part | Code  | Para | Code Definition                              |
+======+=======+======+==============================================+
|      | A     | 1    | Shipper's Weight Agreement                   |
+------+-------+------+----------------------------------------------+
|      | C     | 1    | Consignee Scale Weight                       |
+------+-------+------+----------------------------------------------+
|      | D     | 1    | Destination Weight Agreement                 |
+------+-------+------+----------------------------------------------+
|      | E     | 1    | Estimated Weight                             |
+------+-------+------+----------------------------------------------+
|      | F     | 1    | Public Scale Weight on Behalf of Consignee   |
+------+-------+------+----------------------------------------------+
|    . | .     | .    |    . . .                                     |
+------+-------+------+----------------------------------------------+