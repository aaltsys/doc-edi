.. _5t: 

############################# 
 EDI Operations
############################# 

Exchange Receiving Steps
============================= 

#. Use menu selection :menuselection:`Exchange --> Interchange --> Receive` to 
   retrieve waiting documents from your trading partners. (Schedule process 
   ECOM_RCV to automate this program step.) 

#. Run the EDI.RECEIVES report from menu :menuselection:`Exchange --> -Reports` 
   to show all errors or exceptions in received data. 

   If document exceptions are found, process the records in the receives file, 
   menu selection :menuselection:`Exchange --> Trading --> Receives`. 

   + Review and print forms for any new errored records, status 1, 2, or 5. FAX 
     or email forms containing errors to trading partners. 
   + Edit and correct standards and map errors (status 1 and 2) and post the 
     documents, or set uncorrectable errors to status 0. 
   + Post test documents (status 3) by setting their status to 4, if desired. 
   + Review documents accepted with errors (status 5), then archive documents 
     from menu (:menuselection:`Exchange --> Interchange --> Archive Accepted`). 
   + Delete any received documents on status 0 using menu selection 
     :menuselection:`Exchange --> Interchange --> Delete Duplicates`. 

#. Select :menuselection:`Exchange --> Interchange --> Transmit` to send 
   Functional Acknowledgments of received data back to your trading partners. 
   (Schedule process ECOM_SND to automate this program step.) 

#. Run the EDI.TRANSMITS report from menu :menuselection:`Exchange --> -Reports` 
   and resolve missing functional acknowledgments with your trading partners. 

Inventory Management Steps
=============================

#. From the entry menu, query the Receipts Inbound window for receipts with 
   status less than 2. Complete the records, then perform the receiving. 

#. Query the Orders Pending window for orders with status less than 2. 
   Complete or correct the records, posting orders to be shipped. 

#. Process today's orders into shipments and perform the shipping. 

Exchange Sending Steps
=============================

#. At menu selection :menuselection:`Exchange --> Interchange --> Transmit`, 
   send Receiving Advice (944) and Shipping Advice (945) response documents. 
   (This step may be automated with the scheduler, process ECOM_SND.)

#. Run the EDI.EXCHANGES report from menu :menuselection:`Exchange --> -Reports` 
   for today's exchanges. Verify that all exchanges are complete.

----------

.. _warehouse-receiving:

#############################
943/944 Warehouse Receiving
#############################

When receiving goods on behalf of an account, a warehouse receives advance 
**943 Warehouse Stock Transfer Shipment Advice** documents. Once goods are 
physically received in the warehouse, the account is informed of the actions 
through transmitted **944 Warehouse Stock Transfer Receipt Advice** documents. 
The basic outline of the receiving process is:

#. A data receiving step writes held receipts on file 
#. Receipts are reviewed and prepared for tallying 
#. The warehouse performs a physical unloading, tally and putaway 
#. Each receipt is reconciled with the physical tally 
#. Advice documents are transmitted back to the customer account 

A full outline of this process is presented in Table 1.

Table 1.  943 / 944 Process Outline.

+------+------------------+-------------------------------------------------------------+
| Step | Description      | Description                                                 |
+======+==================+=============================================================+
| A.1  | Trading Partner  | Produce **943 Warehouse Stock Transfer Shipment**           | 
+------+------------------+-------------------------------------------------------------+
| A.2  |                  | Transmit documents                                          | 
+------+------------------+-------------------------------------------------------------+ 
|      | Exchange Provider| (When using an EDI Provider VAN or an FTP site)             |
+------+------------------+-------------------------------------------------------------+
| B.1  | WARES Exchange   | Receive pending data                                        | 
+------+------------------+-------------------------------------------------------------+
| B.2  |                  | Process data stream into 943 documents in RECEIVES          | 
+------+------------------+-------------------------------------------------------------+
| B.3  |                  || Validate documents against EDI standards                   | 
|      |                  || Write **997 Functional Acknowledgments** to TRANSMITS      |
+------+------------------+-------------------------------------------------------------+
| B.4  |                  | Translate accepted 943 documents into held RECEIPTS         |  
+------+------------------+-------------------------------------------------------------+ 
| C.1  | WARES Inventory  | Print receiving tally forms for held receipts records       |   
+------+------------------+-------------------------------------------------------------+  
| C.2  | (warehouse)      | Receive, unload, tally, putaway goods in warehouse          |
+------+------------------+-------------------------------------------------------------+ 
| C.3  |                  | Finish Receiving, check OSDR, change held to verified       |
+------+------------------+-------------------------------------------------------------+
| D.1  | WARES Exchange   |Write **944 Stock Transfer Receipt Advice** to TRANSMITS     |
+------+------------------+-------------------------------------------------------------+
| D.2  |                  | Transmit documents                                          | 
+------+------------------+-------------------------------------------------------------+ 
|      | Exchange Provider| (When using an EDI Provider VAN or an FTP site)             |
+------+------------------+-------------------------------------------------------------+
| E.1  | Trading Partner  | Download waiting 944 documents and translate them           | 
+------+------------------+-------------------------------------------------------------+
| E.2  |                  | Update inventory and location records                       | 
+------+------------------+-------------------------------------------------------------+

The above 943/944 process has several program steps, but only limited user 
input is required. This interplay of programs and user entry is documented in 
the following table.

Table 2.  943 / 944 Chart -- Programs, Processes, and User Interactions. 

+-----+------------------------------+----------+-----------------------------+
|Step | Menu Selection of Action     | Type     | Name or Description         |
+=====+==============================+==========+=============================+ 
| B.1 | Exchange/Interchange/Receive || PROCESS || ECOM_RCV                   | 
|     |                              || PROGRAM || EDI.EXCHANGE               |
+-----+------------------------------+----------+-----------------------------+
| B.2 |                              | PROGRAM  | EDI.RECEIVE                 | 
+-----+------------------------------+----------+-----------------------------+
| B.3 |                              | PROGRAM  | EDI.RCV.VALIDATE            | 
+-----+------------------------------+----------+-----------------------------+
| B.4 |                              | PROGRAM  | EDI.RCV.IMPORT              | 
+-----+------------------------------+----------+-----------------------------+
| C.1 | Inventory/Receipts           || WINDOW  || Review Status 0 Receipts   | 
|     |                              || PRINT   || RECEIPTS.TALLY             | 
+-----+------------------------------+----------+-----------------------------+
| C.2 |                              |          | Unload, tally, putaway      |
+-----+------------------------------+----------+-----------------------------+
| C.3 | Inventory/Receipts           | ENTRY    | Reconcile and update status | 
+-----+------------------------------+----------+-----------------------------+
| D.1 |                              | PROGRAM  | POST_EDI.TRANSMIT           | 
+-----+------------------------------+----------+-----------------------------+
| D.2 | Exchange/Interchange/Transmit|| PROCESS || ECOM_SND                   | 
|     |                              || PROGRAM || EDI.EXCHANGE               | 
|     |                              || PROGRAM || EDI.TRANSMIT               |
+-----+------------------------------+----------+-----------------------------+

----------

.. _warehouse-shipping:

#############################
940/945 Warehouse Shipping
#############################

When shipping goods on behalf of an account, a warehouse receives advance 
**940 Warehouse Shipment Order** documents. Once goods are physically shipped 
from the warehouse, the account is informed of the actions through transmitted 
**945 Warehouse Shipping Advice** documents. The basic outline of the shipping 
process is:

#. A data receiving step writes shipping orders on file 
#. Orderss are reviewed against inventory and shipments are built 
#. The warehouse performs physical picking, packing and shipping 
#. Each shipment is reconciled and verified 
#. Advice documents are transmitted back to the customer account 

Table 3 outlines how account **940 Warehouse Shipping Order** documents are 
received through EDI and processed in WARES Inventory. Shipments for these 
orders then generate documents such as the **945 Warehouse Shipping Advice**, 
**204 Motor Carrier Shipment Information**, and **856 Ship Notice/Manifest** 
responses which are sent back to the account.

Table 3.  940 / 945 Process Outline.

+------+------------------+-------------------------------------------------------------+
| Step | Description      | Description                                                 |
+======+==================+=============================================================+
| A.1  | Trading Partner  | Produce 940 Warehouse Shipping Order documents              |
+------+------------------+-------------------------------------------------------------+
| A.2  |                  | Transmit 940 documents                                      |
+------+------------------+-------------------------------------------------------------+ 
|      | Exchange Provider| (When using an EDI Provider VAN or an FTP site)             |
+------+------------------+-------------------------------------------------------------+
| B.1  | WARES Exchange   | Receive pending data at warehouse                           |
+------+------------------+-------------------------------------------------------------+
| B.2  |                  | Process data stream into 940 documents in RECEIVES          |
+------+------------------+-------------------------------------------------------------+
| B.3  |                  || Validate documents against EDI standards                   |
|      |                  || Write 997 Functional Acknowledgments to TRANSMITS          |
+------+------------------+-------------------------------------------------------------+
| B.4  |                  || Translate accepted 940 documents into Pending ORDERS       |
+------+------------------+-------------------------------------------------------------+
| C.1  | WARES Orders     || Complete and check Order data                              |
|      |                  || Set problem records to Held status                         |
+------+------------------+-------------------------------------------------------------+
| C.2  |                  | Review Held Orders, makes any corrections                   |
+------+------------------+-------------------------------------------------------------+
| C.3  |                  | Review product availability per account instructions        |
+------+------------------+-------------------------------------------------------------+
| C.4  |                  | Build Shipments from unfilled Pending Orders                |
+------+------------------+-------------------------------------------------------------+
| D.1  | WARES Inventory  || Review Shipment records for completeness                   |
|      |                  || Print Picking Tickets, Bills of Lading, other forms        |
+------+------------------+-------------------------------------------------------------+
| D.2  | (warehouse)      | Pick, pack, and ship to shipments in the warehouse          |
+------+------------------+-------------------------------------------------------------+
| D.3  |                  | Complete and verify shipment records in WARES               |
+------+------------------+-------------------------------------------------------------+
| E.1  | WARES Exchange   || Write 945 Warehouse Shipping Advice to TRANSMITS           |
|      |                  || Update Pending ORDERS as completed orders                  |
|      |                  || Write other documents: 856 ASN, 204 B/L, et cetera         |
+------+------------------+-------------------------------------------------------------+
| E.2  |                  | Transmit documents                                          |
+------+------------------+-------------------------------------------------------------+ 
|      | Exchange Provider| (When using an EDI Provider VAN or an FTP site)             |
+------+------------------+-------------------------------------------------------------+
| F.1  | Trading Partner  | Download waiting documents and translate them               |
+------+------------------+-------------------------------------------------------------+
| F.2  |                  | Update sales order records and invoice shipments            |
+------+------------------+-------------------------------------------------------------+

Table 4 charts the user interactions in the above 940/945 process. In step B.1, 
select Exchange/Interchange/Receive to download EDI documents. This program 
sequence culminates with orders on file with status 1 or 2.

The warehouse staff corrects and posts entries on held orders in step C.2. Step 
C.3 reviews posted Orders for product availability per account instructions. 
Then orders are built into allocated Shipments in step C.4.

In step D.1, allocated shipments are reviewed for completeness and forms are 
printed. Completed shipments are changed to status 3 (Verified) in step D.3. 
Finally, response documents are retransmitted in step E.2.

Table 4.  940/945 Chart -- Programs / Processes / User Interactions. 

+-----+----------------------------------+----------+-----------------------------+
|Step | Menu Selection of Action         | Type     | Name or Description         |
+=====+==================================+==========+=============================+ 
| B.1 | Exchange/Interchange/Receive     || PROCESS || ECOM_RCV                   | 
|     |                                  || PROGRAM || EDI.EXCHANGE               |
+-----+----------------------------------+----------+-----------------------------+
| B.2 |                                  | PROGRAM  | EDI.RECEIVE                 | 
+-----+----------------------------------+----------+-----------------------------+
| B.3 |                                  | PROGRAM  | EDI.RCV.VALIDATE            | 
+-----+----------------------------------+----------+-----------------------------+
| B.4 |                                  | PROGRAM  | EDI.RCV.IMPORT              | 
+-----+----------------------------------+----------+-----------------------------+
| C.1 |                                  | PROGRAM  | POST_ORDERS                 |
+-----+----------------------------------+----------+-----------------------------+
| C.2 | Inventory/Orders Pending         |  WINDOW  | Review Status 0,1 Orders    | 
+-----+----------------------------------+----------+-----------------------------+
| C.3 | Inventory/Orders/Review Orders   | PROGRAM  | ORDERS.REVIEW               | 
+-----+----------------------------------+----------+-----------------------------+
| C.4 | Inventory/Orders/Build Shipments | PROGRAM  | ORDERS.CALC                 |
+-----+----------------------------------+----------+-----------------------------+
| D.1 | Inventory/Shipments              || WINDOW  || Review status 1 Shipments  | 
|     |                                  || PRINT   || SHIPMENTS.BOL              | 
+-----+----------------------------------+----------+-----------------------------+
| D.2 |                                  |          | Pick, pack and ship         |
+-----+----------------------------------+----------+-----------------------------+
| D.3 | Inventory/Shipments              | WINDOW   | Verify complete shipments   | 
+-----+----------------------------------+----------+-----------------------------+
| E.1 |                                  || PROGRAM || POST_EDI.TRANSMIT          |
|     |                                  || PROGRAM || EDI.SUBS,ORDERS            | 
|     |                                  || PROGRAM || POST_EDI.TRANSMIT          | 
+-----+----------------------------------+----------+-----------------------------+
| E.2 | Exchange/Interchange/Transmit    || PROCESS || ECOM_SND                   | 
|     |                                  || PROGRAM || EDI.EXCHANGE               | 
|     |                                  || PROGRAM || EDI.TRANSMIT               | 
+-----+----------------------------------+----------+-----------------------------+

----------

#############################
846 Inventory Reporting
#############################

The 846 Inventory Inquiry/Advice transaction set allows trading partners to 
reconcile their inventory with your records.

Process
=============================

The Inventory 846 process first displays a Select Details (XQ) collector 
window. Use the index selection options to specify the criteria for the lots 
you wish to include in the Advice records. Then press [F9] to create the 
transaction sets.

Each completed transaction set is written to the TRANSMITS file, and will be 
sent during the next EDI Transmit.  One or more advice transactions will be 
created depending on the number of lot detail records being reported.

846 Program Notes
=============================

Process record EDI_846 controls 846 inventory reporting. 846 reporting could be 
automated by scheduling this process. The EDI documents are built by program POST_EDI.TRANSMIT. The parameters for this program are:

  846: the transaction set identifier,
  PARTNER_846: the dictionary fieldname that evaluates to a partner key, and
  DETAILS: the name of the file being processed.

The 846 process selects only inventory lots with quantity greater than zero for 
reporting, and the lots are sorted by account and then stock number.

The DETAILS dictionary field PARTNER_846 is evaluated for each record to 
determine the partner identifier, and a reporting break occurs whenever the 
partner identifier changes.  Lot records with a null partner key, without an 
846 map, or where the map status is less than 2 will not be reported.  (The 
PARTNER_846 dictionary returns null when an 846 map is not found.)
