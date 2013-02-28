.. _5xa:

#############################
Resolve Errors
#############################

Delete Duplicates
=============================

PURPOSE.

Select Delete Duplicates to remove status 0 records from the RECEIVES file. The records to be deleted are shown in the DI.RCV.DUPLICATES report. Only document records more than seven days old will be deleted.

CAUSES OF DUPLICATIONS.

Documents may be received with transaction identifiers matching records already present in the RECEIVE_HISTORY archive file. Some of the reasons why this might occur follow:

+ Your trading partner may have reset a sequence counter in his EDI software, causing the software to repeat transaction control counters. Such duplicated control numbers represent new documents which should be imported.
+ Your partner may have repeated an EDI transmission to the VAN. Maybe another of his trading partners lost a downloaded file, and the retransmission included a repeat of your data. In this event, these documents should not be imported.
+ You have imported the same downloaded data twice. This might be necessary if a download was successful, but a program error interrupted the importing process. Then the duplicated records should be deleted.
+ The document may not be a duplicate. Possibly documents with uncorrectable errors were set to status 0 to be deleted later.

Erase Rejected
=============================

PURPOSE.

Select Erase Rejected to remove status 1, 2 or 3 records from the RECEIVES file. The EDI.RCV.REJECTS, EDI.RCV.MAPERRORS and EDI.RCV.TESTS reports show the records to be deleted. Only documents which are more than seven days old will be deleted.

CAUSES OF REJECTION ERRORS.

All received documents are validated against either maps or standards for compliance. When documents are received in a test transmission or are received without an active map for the partner and set of the document, the documents will by received at status 3 (test). These documents are listed in the EDI.RCV.TESTS report.

Any standards compliance errors in test documents will cause the received documents to be rejected. Two types of errors will cause received production documents to be rejected. All set errors result in document rejection, and the following segment error codes produce rejected documents:

1	Unrecognized segment ID
3	Mandatory segment missing
6	Segment Not in Defined Transaction Set
7	Segment Not in Defined Sequence

The EDI.RCV.REJECTS report lists documents rejected due to standards compliance errors.

The import process may fail for documents which comply with the associated standards. Generally this would mean that the document map contains an error, not that the documents are defective. These documents should still be deleted if the map is not corrected and the documents are not reprocessed in a timely manner. ("Timely manner" is defined to be one week by convention in the EDI community.) These documents are listed in the EDI.RCV.MAPERRORS report.

RECOVERING ERRORS.

When a partner record is set to permit document editing, EDI*Atlas allows documents in the Receives and Transmits files to be edited. First use the errors review to identify the exact errors requiring correction. Then use the edit window to change the document text and correct the errors. Save the corrections, then change the document record status to 3 (test) or 4
(production) and save the record. This will reprocess the record and recover the error.

Archive Accepted
=============================

Select Archive Accepted to move records imported with element errors into the RECEIVE_HISTORY file. Received documents to be archived are listed in the EDI.RCV.ACCEPTS report. Only those accepted documents which are more than seven days old will be archived.

These errors should be reviewed before archival. Standards errors are reported to your trading partners through 997 functional Acknowledgments. However, your partner may not be able to process the acknowledgments, or his translation software may not interpret standards errors adequately.

If errors occur consistently with any trading partner, then display the documents with errors in the Exchange/Trading/Receives Document window. Print the document text with an included error report. This print form is designed for FAX transmission to your partner, so that the errors can be reviewed and corrected without analyzing the 997 Functional Acknowledgments. 

Archive Unacknowledged
=============================

PURPOSE.

Select File Unacknowledged to archive document records which are awaiting acknowledgment into the History file. The records to be archived are shown in the EDI.TRX.UNACKNOW report. Only documents which are more than seven days old will be archived.

ACKNOWLEDGMENT PROCESSING.

By convention, an acknowledgment should be returned on the same day that a document is received. This guarantees the transmitting partner for a document that an acknowledgment can be received within 24 hours. When an acknowledgment is not received, one of the following reasons and resolutions should be used:

+ Your trading partner may be unable to send acknowledgments. In this case, set the trading partner Acknowledge Documents to "No." Then archive the unacknowledged transmitted documents after one week.
+ The exchange was lost in transmission to the VAN. Verify this using the Exchanges and Provider Status reports. Retransmit lost transmissions.
+ Your partner did not import the exchange due to a processing error. If your partner is unable to recover from this error, the VAN should reload the data so that your partner can download it again.
