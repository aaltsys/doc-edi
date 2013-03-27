: server-based EDI exchange
rem @ECHO OFF
CLS
echo parameters: 1=Directory, (2=Filename), 3=Archive, 4=Selection
echo %1 %2 %3 %4

CD %1
IF $%4$==$$ GOTO EXIT
IF $%4$==$SND$ GOTO SND
IF NOT $%4$==$R@S$ GOTO RECEIVE

rem transmit process
:SND
IF NOT EXIST .\TRANSMIT.EDI GOTO RECEIVE
COPY .\TRANSMIT.EDI .\SND\%3
COPY .\TRANSMIT.EDI .\HISTORY\%3
DEL .\TRANSMIT.EDI

:RECEIVE
IF $%4$==$RCV$ GOTO RCV
IF NOT $%4$==$R@S$ GOTO EXIT

rem receive process
:RCV
ECHO . > RECEIVE.EDI
COPY .\RCV\*.T??+\RECEIVE.EDI .\RECEIVE.EDI
COPY .\RECEIVE.EDI .\HISTORY\%3
DEL .\RCV\*.T??
GOTO EXIT

:EXIT
CD ..
