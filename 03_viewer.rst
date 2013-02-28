.. _viewer:

#############################
Standards Viewer
#############################

WARES includes a viewer program for navigating the X12 document standards 
heirarchy, as well as a full data-driven mapper tool. The viewer is based on 
standards table data from DISA.

Viewer Structure
=============================

EDI standards provide a hierarchical, structured approach to representing     
the information in business documents. The viewer accurately reflects this    
hierarchy, with each level of the standards having a corresponding            
documentation window in the viewer. These documentation windows may be        
selected from the Standards menu.                                             

Levels of the standards hierarchy are interrelated through detail tables.     
Sets have detail tables which show segments within the sets. Segments and     
composites have tables showing their element members. Identifier type data    
elements have corresponding code tables. Each detail table is shown in a      
columnar popup display in the viewer. These popups are accessible from the    
documentation windows, or from the popups at higher levels.                   

The viewer hierarchy is navigated with certain keystrokes. Pressing 
:kbd:`<Enter>` on a line of a detail popup moves to a detail popup at the 
next-lower level of the standards hierarchy. Pressing :kbd:`[F1]` on a popup 
line views the standards documentation page for the next-lower level. In the 
documentation windows, pressing :kbd:`[SF1]` displays the detail table for that 
page. Pressing :kbd:`<Esc>` moves from a lower level to a higher one.

The following table shows viewer detail popup and documentation window        
levels, and the keystroke relationships between levels::                     
                              
 ┌────────────────────────────────────────────────────────────────────────┐   
 │                                                                        │  
 │                                                 [SF1]   [F1]  <Enter>  │   
 │  Sets Selection Popup                                   ──┐      ──┐   │  
 │  │ Sets Documentation Window                     ──┐    <─┘        │   │  
 │  │ │ Set Details Table                           <─┘    ──┐      <─┤   │  
 │  │ │ │ Segments Documentation Window             ──┐    <─┘        │   │  
 │  │ │ │ │ Segment Details Table                   <─┘    ──┬──┐   <─┤   │  
 │  │ │ │ │ │ Composite Structures Window           ──┐    <─┘  │     │   │  
 │  │ │ │ │ │ │ Composite Details Table             <─┘    ──┐  │   <─┤   │  
 │  │ │ │ │ │ │ │ Data Elements Window              ──┐    <─┘<─┘     │   │  
 │  │ │ │ │ │ │ │ │ Element Codes Details Table     <─┘    ──┐      <─┤   │  
 │  │ │ │ │ │ │ │ │ │ Element Code Documentation           <─┘      <─┘   │  
 │                                                                        │  
 └────────────────────────────────────────────────────────────────────────┘   

Viewer Action Keys
=============================

The viewer uses five types of interface elements to display information:      
menus, windows, popups, messages, and text. The active keys for each part of  
the interface are shown in the following table:                                            

+----------+----------+-----------------------------------------------------+
| MENUS    | <Up>     |  Move the selection highlight up one entry          | 
+----------+----------+-----------------------------------------------------+   
|          | <Down>   |  Move the selection highlight down one entry        |
+----------+----------+-----------------------------------------------------+    
|          | <Home>   |  Move the selection to the first entry of the menu  |
+----------+----------+-----------------------------------------------------+    
|          | <End>    |  Move the selection to the last entry of the menu   |
+----------+----------+-----------------------------------------------------+    
|          | <Enter>  |  Select the highlighted entry                       |
+----------+----------+-----------------------------------------------------+ 
|          | [F1]     |  Display help for the highlighted entry             |
+----------+----------+-----------------------------------------------------+    
+----------+----------+-----------------------------------------------------+
| WINDOWS  | [F1]     |  Display help for the current entry of the window   |
+----------+----------+-----------------------------------------------------+    
|          | [F3]     |  Zoom the entry into a text window                  |
+----------+----------+-----------------------------------------------------+    
|          | [F10]    |  Use the window's menu                              |
+----------+----------+-----------------------------------------------------+    
|          | [SF1]    |  Display the detail table for the current record    |
+----------+----------+-----------------------------------------------------+    
|          | [SF10]   |  Display a list of selected records                 |
+----------+----------+-----------------------------------------------------+    
+----------+----------+-----------------------------------------------------+
| POPUPS   | <Up>     |  Move the highlight up one line                     |
+----------+----------+-----------------------------------------------------+    
|          | <Down>   |  Move the highlight down one line                   |
+----------+----------+-----------------------------------------------------+ 
|          | <Enter>  |  Display the detail popup for the highlighted line  |
+----------+----------+-----------------------------------------------------+ 
|          | [F1]     |  Show the window for the highlighted line           |
+----------+----------+-----------------------------------------------------+    
+----------+----------+-----------------------------------------------------+
| MESSAGES | <Enter>  | Close the message                                   |
+----------+----------+-----------------------------------------------------+    
+----------+----------+-----------------------------------------------------+
| TEXT     | <Esc>    | Close the Zoom Text or Help Text window             |
+----------+----------+-----------------------------------------------------+    

Corrections to Table Data
=============================

In the standards viewer, DISA table data was altered for consistency between 
standards versions. Changes in presentation are itemized following.

Apostrophes
-----------------------------

Where doubled apostrophe characters were found in text, they were changed to the 
quote mark (\"). Left apostrophe characters (\`) were changed to apostrophes 
(\'). (The left apostrophe, or backtick, is not in the permissible character set 
for use with EDI.)

Maxuse
-----------------------------

Whenever the Maxuse column in Set Details was not filled in, the null value was 
replaced with the number `1`.  

Repeats
-----------------------------

Null values in the Repeat column of Set Details were replaced with `0`. 

Spelling
-----------------------------

Numerous spelling errors in the data were detected but not corrected.

Conditions and requirements
-----------------------------

In the standards, the "Condition Designator" has a "Condition Code" and a 
"Requirement", and the "Relational Conditions" have a "Condition Code" and a 
"Requirement." The Condition Designator is alternately referred to as the 
"Requirement Designator" in the standards, and this nomenclature is adopted in 
the viewer. The Requirement Designator (detail tables column "Req") has a 
requirement code, and Relational Conditions have a condition code (detail tables 
column "Cond") and a Relation reference list (column "Relation").

In the standards, requirement codes with related element lists are displayed in 
syntax notes along with the note text. The viewer has additional columns for 
the Condition Codes and Relation lists in the detail table displays as stated in 
the previous paragraph. The syntax notes text is displayed in the Segments and 
Composites windows without the code values. Element reference lists in syntax 
codes are shown as a sequence of two-digit numbers in the standards. In the 
viewer, the lists are shown as reference numbers separated by commas. When more 
than one relational condition applies to an element, the condition codes and 
relation lists are separated by semicolons.

Requirement designator
-----------------------------

Table data for the standards uses a `C` in the Requirement Designator to show 
that a relational condition exists. Published standards now use `X` instead of 
`C`, and the viewer has changed the table data for consistency.

Semantic notes
-----------------------------

Semantic notes are annotated in the published standards by adding a `Z` to the 
Requirement Designator. A separate notes indicator column displays the semantic 
notes indicator `Z` in the viewer.

Component data elements
-----------------------------

Simple Data Elements may be made up of multiple parts, as is the case with DE 
103. The viewer separates code values by part in the Data Element details table. 
A length for the parts is also maintained internally in the data, although not 
shown in the details tables. Data Element parts are not described within the 
body of the standards.

Standards Inconsistencies
=============================

Inconsistencies in standards versions and usage are noted as follows.

Maxuse and repeat
-----------------------------

The Maximum Use column is defined in DE 905 as type=N0, min=1, max=7. The 
standards represent an unlimited use with the notation `>1`. Since this violates 
the numeric data element definition, the number `9999999` is used in data 
transmission to show an infinite repeat. The standards use the same notation for 
DE 910, Loop Repeat Count. The viewer preserves the standards notation `>1` 
despite this inconsistency.

Loop and segment requirement
-----------------------------

The requirement designation for an unbounded loop is implicitly the same as the 
requirement designation of the loop's first segment. However, a separate column 
explicitly defines the loop repeat, whereas the first segment's maximum use 
designation could have implicitly defined the loop repeat. 
