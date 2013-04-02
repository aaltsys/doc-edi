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

Table 5.  Process Outline, Receiving data.

+------+-----------------------------------------------------------------------+
| Step | Description                                                           |
+======+=======================================================================+
|| End -- Originating Partner Application and Transfer                         |
|| - - - - - - - - - - - - - FTP Process - - - - - - - - - - - - - - - -       |
|| Start -- Receiving Partner Transfer and Application                         |
+------+-----------------------------------------------------------------------+
| A.1  || Connect to FTP site                                                  |
|      || Copy files in directory /ftp/B_to_A/* to /CONNECT/RCV/*              |
+------+-----------------------------------------------------------------------+
| A.2  | Concatenate files from /CONNECT/RCV/ into /CONNECT/RECEIVE.EDI        |
+------+-----------------------------------------------------------------------+
| A.3  | Archive RECEIVE.EDI in filename /CONNECT/HISTORY/yymmddAA.RC$         |
+------+-----------------------------------------------------------------------+
| A.4  | Separate data into documents and write them to RECEIVES table         |
+------+-----------------------------------------------------------------------+
| A.5  || Validate documents against corresponding EDI standards version       |
|      || (Write 997 Functional Acknowledgments in TRANSMITS table for later)  |
+------+-----------------------------------------------------------------------+
| A.6  | Translate accepted documents into application database                |
+------+-----------------------------------------------------------------------+

Table 6.  Process Outline, Transmitting data.  

+------+-----------------------------------------------------------------------+
| Step | Description                                                           |
+======+=======================================================================+ 
| B.1  | Extract data to send to a single partner                              |
+------+-----------------------------------------------------------------------+
| B.2  | Update database to mark extracted records                             |
+------+-----------------------------------------------------------------------+
| B.3  | Write EDI document records in TRANSMITS table                         |
+------+-----------------------------------------------------------------------+
| B.4  | Concatenate EDI documents in file /CONNECT/SND/TRANSMIT.TX$           |
+------+-----------------------------------------------------------------------+
| B.5  | Archive TRANSMIT.TX$ in file /CONNECT/HISTORY/yymmddAA.TX$            |
+------+-----------------------------------------------------------------------+
| B.6  || Connect to FTP site                                                  |
|      || Copy file /CONNECT/HISTORY/yymmddAA.TX$ to directory /ftp/A_to_B/    |
+------+-----------------------------------------------------------------------+
+------+-----------------------------------------------------------------------+
|| End -- Originating Partner Application and Transfer                         |
|| - - - - - - - - - - - - - FTP Process - - - - - - - - - - - - - - - -       |
|| Start -- Receiving Partner Transfer and Application                         |
+------+-----------------------------------------------------------------------+

In the tables above, WARES performs receiving actions steps A.2-6 using menu 
selection :menuselection:`Exchange --> Interchange --> Receive`. 
WARES performs transmitting actions steps B.1-5 using menu selection 
:menuselection:`Exchange --> Interchange --> Transmit`. [#]_
The combination of steps A.2-6 and B.1-5 are performed by selection 
:menuselection:`Exchange --> Interchange --> Send/Receive`.

Download the DOS batch file :download:`ftp.bat <_downloads/ftp.bat>` for a DOS 
script to handle operating system files for data exchange. 

Where WARES is run in a multiuser environment, we use program :program:`lftp`
to perform actual FTP transfers using a cron job on the Linux file server. 

A sample configuration file :download:`waresedi.conf <_downloads/waresedi.cnf>` 
is provided to use with :program:`lftp`. Server configuration is described 
elsewhere in our documentation at http://servers.aaltsys.info.

----------

.. [#] The transmit process is problematic with multiple trading partners. 
   By default WARES bundles all data to transmit into one file, to be parsed and 
   distributed by a VAN. A replacement process which would transmit data for 
   each partner separately, sending it to the correct FTP site, is not currently 
   provided. 
