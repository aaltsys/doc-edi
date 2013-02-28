.. _5o:

############################# 
EDI Overview
############################# 

EDI automates information exchange between trading partners, and it reduces the 
information processing work as well. The process of EDI may consolidate many 
types of information exchange, performing all transfers at the same time. The 
following topics show how a single process for data exchange can be decomposed 
into two types of warehouse operations, receiving and shipping, each with its 
own operational sequence.

----------

TRANSFERRING EDI DATA THROUGH FTP

Traditional EDI uses store-and-forward mail service bureaus, or Value Added 
Networks (VANs), to transfer data. These networks provide data consolidation, 
distribution, storage, reporting, and other services to guarantee reliable data 
transfer. Desktop e-mail software cannot replace the functions of a VAN, 
because e-mail lacks the automation, data replication, and consolidation and 
distribution functions which a VAN provides. However, EDI data may be 
transferred using FTP (File Transfer Protocol) through an Internet Service 
Provider (ISP) without recourse to a VAN.

Table 5.  Process Outline.  

+------+-----------------------------------------------------------------------+
| Step | Description                                                           |
+======+=======================================================================+ 
| A.1  | Extract data to send to a single partner                              |
+------+-----------------------------------------------------------------------+
| A.2  | Update database to mark extracted records                             |
+------+-----------------------------------------------------------------------+
| A.3  | Convert data to EDI documents and save in \CONNECT\TRANSMIT.EDI       |
+------+-----------------------------------------------------------------------+
| A.4  | Archive TRANSMIT.EDI in file \CONNECT\HISTORY\yymmddAA.SND            |
+------+-----------------------------------------------------------------------+
| A.5  | FTP TRANSMIT.EDI file to site, appending to filename \FTP\RECEIVE.EDI |
+------+-----------------------------------------------------------------------+
+------+-----------------------------------------------------------------------+
|| End -- Originating Partner Application and Transfer                         |
|| - - - - - - - - - - - - - FTP Process - - - - - - - - - - - - - - - -       |
|| Start -- Receiving Partner Transfer and Application                         |
+------+-----------------------------------------------------------------------+
+------+-----------------------------------------------------------------------+
| B.1  || Access FTP site                                                      |
|      || copy \FTP\RECEIVE.EDI to \CONNECT\RECEIVE.EDI                        |
|      || then delete \FTP\RECEIVE.EDI                                         |
+------+-----------------------------------------------------------------------+
| B.2  | Archive RECEIVE.EDI in filename \CONNECT\HISTORY\yymmddAA.RCV         |
+------+-----------------------------------------------------------------------+
| B.3  | Separate data into documents and write them to RECEIVES file          |
+------+-----------------------------------------------------------------------+
| B.4  || Validate documents against corresponding EDI standards version       |
|      || Write 997 Functional Acknowledgments to TRANSMITS file               |
+------+-----------------------------------------------------------------------+
| B.5  | Translate accepted documents into application database                |
+------+-----------------------------------------------------------------------+

In the table above, WARES Exchange performs all receiving actions in one step  
using menu selection :menuselection:`Exchange --> Interchange --> Receive`.  
All that is required is to replace the CONNECT.BAT operating system file with a 
program to perform the FTP file copy.

The transmit process is more problematic when trading with multiple partners. 
The default WARES Exchange process bundles all data to transmit into one file, 
to be parsed and distributed by the VAN. A replacement process which would 
transmit data for each partner separately, sending it to the correct FTP site, 
would be required. 
