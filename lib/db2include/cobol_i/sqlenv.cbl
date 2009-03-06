      *************************************************************************
      * 
      * Source File Name: SQLENV
      * 
      * (C) COPYRIGHT International Business Machines Corp. 1987, 1997
      * All Rights Reserved
      * Licensed Materials - Property of IBM
      * 
      * US Government Users Restricted Rights - Use, duplication or
      * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
      * 
      * Function = Include File defining:
      *              Environment Commands - Constants
      *              Environment Commands - Structures
      *              Environment Commands - Function Prototypes
      *              Environment Commands - Labels for SQLCODES
      * 
      * Operating System:Darwin
      * 
      **************************************************************************
      * Interface Parameters/Structures/Return Codes

      * Parameters for START USING DATABASE
      * USE = Share
       77  SQL-USE-SHR               PIC X(1) value "S"
                                     USAGE DISPLAY NATIVE.
      * USE = Exclusive
       77  SQL-USE-EXC               PIC X(1) value "X"
                                     USAGE DISPLAY NATIVE.
      * USE = Exclusive on Single Node
       77  SQL-USE-EXC-SN            PIC X(1) value "N"
                                     USAGE DISPLAY NATIVE.

      * Sizes for entries in sqledinfo, sqleninfo, sqledbstat, sqleusrstat,
      * sql_dir_entry, sqle_reg_nwbindery
      * Alias name
       77  SQL-ALIAS-SZ              PIC S9(4) COMP-5 VALUE 8.
      * User Id
       77  SQL-USERID-SZ             PIC S9(4) COMP-5 VALUE 30.
      * Max User Id Size
       77  SQL-MAX-USERID-SZ         PIC S9(4) COMP-5 VALUE 1024.
      * Auth Id
       77  SQL-AUTHID-SZ             PIC S9(4) COMP-5 VALUE 30.
      * Database name
       77  SQL-DBNAME-SZ             PIC S9(4) COMP-5 VALUE 8.
      * plugin name
       77  SQL-PLUGIN-NAME-SZ        PIC S9(4) COMP-5 VALUE 32.
      * GSS API plugin list
       77  SQL-SRVCON-GSSPLUGIN-LIST-SZ PIC S9(4) COMP-5 VALUE 255.

      * SQL_DRIVE_SZ has been deprecated but is kept to preserve
      * compatibility.It will be removed in future release. For new
      * applications, use SQL_DB_PATH_SZ.
      * Drive (Qualified) - OS/2
       77  SQL-DRIVE-SZ-DB2OS2       PIC S9(4) COMP-5 VALUE 2.
      * Drive (Qualified) - Windows
       77  SQL-DRIVE-SZ-DB2DOS       PIC S9(4) COMP-5 VALUE 2.
      * Drive (Qualified) - NT
       77  SQL-DRIVE-SZ-DB2WINT      PIC S9(4) COMP-5 VALUE 12.
      * Path (Qualified) - AIX/UNIX
       77  SQL-DRIVE-SZ-DB2AIX       PIC S9(4) COMP-5 VALUE 215.
       77  SQL-DRIVE-SZ              PIC S9(4) COMP-5 VALUE 215.

      * Database path (Qualified)
       77  SQL-DB-PATH-SZ            PIC S9(4) COMP-5 VALUE 215.

      * Internal db name
       77  SQL-INAME-SZ              PIC S9(4) COMP-5 VALUE 8.
      * Node name
       77  SQL-NNAME-SZ              PIC S9(4) COMP-5 VALUE 8.
      * Instance Name
       77  SQL-INSTNAME-SZ           PIC S9(4) COMP-5 VALUE 8.
      * Type of database
       77  SQL-DBTYP-SZ              PIC S9(4) COMP-5 VALUE 20.
      * Comment
       77  SQL-CMT-SZ                PIC S9(4) COMP-5 VALUE 30.
      * Local_lu
       77  SQL-LOCLU-SZ              PIC S9(4) COMP-5 VALUE 8.
      * Partner_lu
       77  SQL-RMTLU-SZ              PIC S9(4) COMP-5 VALUE 8.
      * Mode
       77  SQL-MODE-SZ               PIC S9(4) COMP-5 VALUE 8.
      * length of tpname
       77  SQL-TPNAME-SZ             PIC S9(4) COMP-5 VALUE 64.
      * Reserved
       77  SQL-NRESERVE-SZ           PIC S9(4) COMP-5 VALUE 0.
      * Alias name
       77  SQL-DBSTAT-ALIAS-SZ       PIC S9(4) COMP-5 VALUE 16.
      * Database name
       77  SQL-DBSTAT-DBNAME-SZ      PIC S9(4) COMP-5 VALUE 16.
      * Host database name
       77  SQL-LONG-NAME-SZ          PIC S9(4) COMP-5 VALUE 18.
      * collating sequence
       77  SQL-CS-SZ                 PIC S9(4) COMP-5 VALUE 256.
      * Parameter string
       77  SQL-PARAMETER-SZ          PIC S9(4) COMP-5 VALUE 512.
      * Network ID
       77  SQL-NETID-SZ              PIC S9(4) COMP-5 VALUE 8.
      * Maximum Path size
       77  SQL-PATH-SZ               PIC S9(4) COMP-5 VALUE 1024.
      * Host Name
       77  SQL-HOSTNAME-SZ           PIC S9(4) COMP-5 VALUE 255.
      * Computer Name
       77  SQL-COMPUTERNAME-SZ       PIC S9(4) COMP-5 VALUE 15.
      * Profile Name
       77  SQL-PROFILE-SZ            PIC S9(4) COMP-5 VALUE 235.
      * Option Name
       77  SQL-OPTION-SZ             PIC S9(4) COMP-5 VALUE 10.
      * DCE principal name size
       77  SQL-DCEPRIN-SZ            PIC S9(4) COMP-5 VALUE 1024.
      * Service Name
       77  SQL-SERVICE-NAME-SZ       PIC S9(4) COMP-5 VALUE 14.
      * TP Monitor Name
       77  SQL-TPMON-NAME-SZ         PIC S9(4) COMP-5 VALUE 19.
      * Symbolic Destination Name
       77  SQL-SYM-DEST-NAME-SZ      PIC S9(4) COMP-5 VALUE 8.
      * TM Database Name
       77  SQL-TMDATABASE-NAME-SZ    PIC S9(4) COMP-5 VALUE 8.
      * AR Library Name
       77  SQL-AR-SZ                 PIC S9(4) COMP-5 VALUE 32.
      * System Name
       77  SQL-SYSTEM-NAME-SZ        PIC S9(4) COMP-5 VALUE 21.
      * Remote Instance Name
       77  SQL-REMOTE-INSTNAME-SZ    PIC S9(4) COMP-5 VALUE 8.

      * Default DRDA accounting string.
       77  SQL-DFTDRDAACT-SZ         PIC S9(4) COMP-5 VALUE 25.
      * Dir/Route Path/Obj Name
       77  SQL-DIR-NAME-SZ           PIC S9(4) COMP-5 VALUE 255.
      * Client Comm. Protocol
       77  SQL-CLIENT-COMM-SZ        PIC S9(4) COMP-5 VALUE 31.
      * Sysadm Group name
       77  SQL-SYSADM-SZ             PIC S9(4) COMP-5 VALUE 8.
      * Group name limits have been increased to support 30 characters in
      * v8.2.  This will be further increased to 128 characters in a future
      * release.
      * Future Group name length
       77  SQL-SYSADM-GROUP-SZ       PIC S9(4) COMP-5 VALUE 128.
      * Netware fileserver name
       77  SQL-FILESERVER-SZ         PIC S9(4) COMP-5 VALUE 48.
      * Netware bindery name
       77  SQL-OBJECTNAME-SZ         PIC S9(4) COMP-5 VALUE 48.
      * Netware IPX socket
       77  SQL-IPXSOCKET-SZ          PIC S9(4) COMP-5 VALUE 4.
      * Netware userid
       77  SQL-NW-UID-SZ             PIC S9(4) COMP-5 VALUE 48.
      * Netware password
       77  SQL-NW-PSWD-SZ            PIC S9(4) COMP-5 VALUE 128.
      * Collate info size (256 + 4)
       77  SQL-COLLATE-INFO-SZ       PIC S9(4) COMP-5 VALUE 260.
      * Max accounting string
       77  SQL-ACCOUNT-STR-SZ        PIC S9(4) COMP-5 VALUE 199.
      * Discover protocols string size
       77  SQL-DSCVRCOMM-SZ          PIC S9(4) COMP-5 VALUE 35.

      * After an SQL CONNECT, the 5th token in the SQLCA identifies the DBMS
      * an application has connected to.  The following are values returned
      * from IBM DBMS.
       77  SQL-DBMS-ES10-OS2         PIC X(9) value "QOS/2 DBM"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-OS2          PIC X(6) value "QDB2/2"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-NT           PIC X(7) value "QDB2/NT"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-NT64         PIC X(9) value "QDB2/NT64"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-95           PIC X(15) value "QDB2/Windows 95"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-AIX          PIC X(9) value "QDB2/6000"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-AIX64        PIC X(10) value "QDB2/AIX64"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-AIX-PE       PIC X(12) value "QDB2/6000 PE"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-HPUX         PIC X(9) value "QDB2/HPUX"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-HPUX64       PIC X(9) value "QDB2/HP64"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-HPUXIA       PIC X(12) value "QDB2/HPUX-IA"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-HPUXIA64     PIC X(14) value "QDB2/HPUX-IA64"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-SUN          PIC X(8) value "QDB2/SUN"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-SUN64        PIC X(10) value "QDB2/SUN64"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-SUNX86       PIC X(11) value "QDB2/SUNX86"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-SUNX8664     PIC X(13) value "QDB2/SUNX8664"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-SNI          PIC X(8) value "QDB2/SNI"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-SCO          PIC X(8) value "QDB2/SCO"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-SGI          PIC X(8) value "QDB2/SGI"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-LINUXX8664   PIC X(15) value "QDB2/LINUXX8664"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-LINUXPPC64   PIC X(15) value "QDB2/LINUXPPC64"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-LINUXPPC     PIC X(13) value "QDB2/LINUXPPC"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-LINUXIA64    PIC X(14) value "QDB2/LINUXIA64"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-LINUXZ64     PIC X(13) value "QDB2/LINUXZ64"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-LINUX390     PIC X(13) value "QDB2/LINUX390"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-LINUX        PIC X(10) value "QDB2/LINUX"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-DYNIX        PIC X(8) value "QDB2/PTX"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-MVS          PIC X(4) value "QDB2"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-DARWIN       PIC X(11) value "QDB2/DARWIN"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-DB2-DARWIN64     PIC X(13) value "QDB2/DARWIN64"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-OS400            PIC X(3) value "QAS"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-SQLDS-VM         PIC X(9) value "QSQLDS/VM"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-SQLDS-VSE        PIC X(10) value "QSQLDS/VSE"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-LU62-SPM         PIC X(8) value "QLU62SPM"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-IDS-UNIX32       PIC X(10) value "IDS/UNIX32"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-IDS-UNIX64       PIC X(10) value "IDS/UNIX64"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-IDS-NT32         PIC X(8) value "IDS/NT32"
                                     USAGE DISPLAY NATIVE.
       77  SQL-DBMS-IDS-NT64         PIC X(8) value "IDS/NT64"
                                     USAGE DISPLAY NATIVE.

      * Parameters for Entry Type in sqledinfo
      * Database is LDAP
       77  SQL-LDAP                  PIC X(1) value "4"
                                     USAGE DISPLAY NATIVE.
      * Database is DCE
       77  SQL-DCE                   PIC X(1) value "3"
                                     USAGE DISPLAY NATIVE.
      * Database is Home
       77  SQL-HOME                  PIC X(1) value "2"
                                     USAGE DISPLAY NATIVE.
      * Database is Remote
       77  SQL-REMOTE                PIC X(1) value "1"
                                     USAGE DISPLAY NATIVE.
      * Database is Indirect
       77  SQL-INDIRECT              PIC X(1) value "0"
                                     USAGE DISPLAY NATIVE.

      * Parameters for adapter number in sqlectnd
      * Adapter number 0
       77  SQL-ADAPTER-0             PIC S9(4) COMP-5 VALUE 0.
      * Adapter number 1
       77  SQL-ADAPTER-1             PIC S9(4) COMP-5 VALUE 1.
      * Minimum adapter number
       77  SQL-ADAPTER-MIN           PIC S9(4) COMP-5 VALUE 0.
      * Maximum adapter number
       77  SQL-ADAPTER-MAX           PIC S9(4) COMP-5 VALUE 255.

      * Definitions of constants used for Structure IDs
      * DCS directory entry id
       77  SQL-DCS-STR-ID            PIC S9(4) COMP-5 VALUE 256.
      * Catalog node struct id
       77  SQL-NODE-STR-ID           PIC S9(4) COMP-5 VALUE 512.

      * Parameters for protocol types in sqlectnd
      * APPC
       77  SQL-PROTOCOL-APPC         PIC X VALUE x"00"
                                     USAGE DISPLAY NATIVE.
      * NETBIOS
       77  SQL-PROTOCOL-NETB         PIC X VALUE x"01"
                                     USAGE DISPLAY NATIVE.
      * APPN
       77  SQL-PROTOCOL-APPN         PIC X VALUE x"02"
                                     USAGE DISPLAY NATIVE.
      * TCP/IP v4 or v6
       77  SQL-PROTOCOL-TCPIP        PIC X VALUE x"03"
                                     USAGE DISPLAY NATIVE.
      * APPC using CPIC
       77  SQL-PROTOCOL-CPIC         PIC X VALUE x"04"
                                     USAGE DISPLAY NATIVE.
      * IPX/SPX
       77  SQL-PROTOCOL-IPXSPX       PIC X VALUE x"05"
                                     USAGE DISPLAY NATIVE.
      * Local IPC
       77  SQL-PROTOCOL-LOCAL        PIC X VALUE x"06"
                                     USAGE DISPLAY NATIVE.
      * Named Pipe
       77  SQL-PROTOCOL-NPIPE        PIC X VALUE x"07"
                                     USAGE DISPLAY NATIVE.
      * TCP/IP using SOCKS
       77  SQL-PROTOCOL-SOCKS        PIC X VALUE x"08"
                                     USAGE DISPLAY NATIVE.
      * TCP/IPv4
       77  SQL-PROTOCOL-TCPIP4       PIC X VALUE x"09"
                                     USAGE DISPLAY NATIVE.
      * TCP/IPv6
       77  SQL-PROTOCOL-TCPIP6       PIC X VALUE x"0A"
                                     USAGE DISPLAY NATIVE.
      * TCP/IPv4 using SOCKS
       77  SQL-PROTOCOL-SOCKS4       PIC X VALUE x"0B"
                                     USAGE DISPLAY NATIVE.
      * TCP/IP using SSL
       77  SQL-PROTOCOL-SSL          PIC X VALUE x"0C"
                                     USAGE DISPLAY NATIVE.
      * IPv4 using SSL
       77  SQL-PROTOCOL-SSL4         PIC X VALUE x"0D"
                                     USAGE DISPLAY NATIVE.
      * IPv6 using SSL
       77  SQL-PROTOCOL-SSL6         PIC X VALUE x"0E"
                                     USAGE DISPLAY NATIVE.

      * Security Type for APPC using CPIC
      * None
       77  SQL-CPIC-SECURITY-NONE    PIC S9(4) COMP-5 VALUE 0.
      * Same
       77  SQL-CPIC-SECURITY-SAME    PIC S9(4) COMP-5 VALUE 1.
      * Program
       77  SQL-CPIC-SECURITY-PROGRAM PIC S9(4) COMP-5 VALUE 2.

      * Security Type for TCP/IP
      * None
       77  SQL-TCPIP-SECURITY-NONE   PIC S9(4) COMP-5 VALUE 0.
      * TCP/IP SOCKS Support
       77  SQL-TCPIP-SECURITY-SOCKS  PIC S9(4) COMP-5 VALUE 1.
      * TCP/IP SSL Support
       77  SQL-TCPIP-SECURITY-SSL    PIC S9(4) COMP-5 VALUE 2.

      * Authentication Types
      * Authenticate on Server
       77  SQL-AUTHENTICATION-SERVER PIC S9(4) COMP-5 VALUE 0.
      * Authenticate on Client
       77  SQL-AUTHENTICATION-CLIENT PIC S9(4) COMP-5 VALUE 1.
      * Authenticate via DDCS
       77  SQL-AUTHENTICATION-DCS    PIC S9(4) COMP-5 VALUE 2.
      * Authenticate via DCE
       77  SQL-AUTHENTICATION-DCE    PIC S9(4) COMP-5 VALUE 3.
      * Auth at Server with encrypt
       77  SQL-AUTHENTICATION-SVR-ENCRYPT PIC S9(4) COMP-5 VALUE 4.
      * Auth via DDCS with encrypt
       77  SQL-AUTHENTICATION-DCS-ENCRYPT PIC S9(4) COMP-5 VALUE 5.
      * Auth via DCE or Server with Encrypt (Valid only at server)
       77  SQL-AUTHENTICATION-DCE-SVR-ENC PIC S9(4) COMP-5 VALUE 6.
      * Auth via Kerberos
       77  SQL-AUTHENTICATION-KERBEROS PIC S9(4) COMP-5 VALUE 7.
      * Auth via Kerberos or Server with Envrypt (Valid only at the server
       77  SQL-AUTHENTICATION-KRB-SVR-ENC PIC S9(4) COMP-5 VALUE 8.
      * Auth via GSS API plugin
       77  SQL-AUTHENTICATION-GSSPLUGIN PIC S9(4) COMP-5 VALUE 9.
      * Auth via GSS API plugin or Server with Encrypt (Valid only at
      * server)
       77  SQL-AUTHENTICATION-GSS-SVR-ENC PIC S9(4) COMP-5 VALUE 10.
      * Auth at server with encrypted data
       77  SQL-AUTHENTICATION-DATAENC PIC S9(4) COMP-5 VALUE 11.
      * Auth at server with or without encrypted data (Valid only at server)
       77  SQL-AUTHENTICATION-DATAENC-CMP PIC S9(4) COMP-5 VALUE 12.
      * Authentication Not Specified
       77  SQL-AUTHENTICATION-NOT-SPEC PIC S9(4) COMP-5 VALUE 255.

      * Data Flow Encryption Types
      * No encryption for connection
       77  SQL-NO-ENCRYPT            PIC S9(4) COMP-5 VALUE 1.
      * DH_DES_56
       77  SQL-DH-DES-56             PIC S9(4) COMP-5 VALUE 2.
      * DH_3DES_128
       77  SQL-DH-3DES-128           PIC S9(4) COMP-5 VALUE 3.
      * DH_3DES_192
       77  SQL-DH-3DES-192           PIC S9(4) COMP-5 VALUE 4.

      * Parameters for Create Database API Collating Sequences
      * Coll. Seq. from System
       77  SQL-CS-SYSTEM             PIC S9(4) COMP-5 VALUE 0.
      * Coll. Seq. from User
       77  SQL-CS-USER               PIC S9(4) COMP-5 VALUE -1.
      * Coll. Seq. (None)
       77  SQL-CS-NONE               PIC S9(4) COMP-5 VALUE -2.
      * Coll. Seq. from pre-v5
       77  SQL-CS-COMPATIBILITY      PIC S9(4) COMP-5 VALUE -4.
      * SYSTEM table + NLS function
       77  SQL-CS-SYSTEM-NLSCHAR     PIC S9(4) COMP-5 VALUE -8.
      * USER table + NLS function
       77  SQL-CS-USER-NLSCHAR       PIC S9(4) COMP-5 VALUE -9.
      * UTF-8S collation
       77  SQL-CS-IDENTITY-16BIT     PIC S9(4) COMP-5 VALUE -10.
      * Unicode Collation Algorithm V400 Normalization ON collation
       77  SQL-CS-UCA400-NO          PIC S9(4) COMP-5 VALUE -11.
      * Unicode Collation Algorithm V400 for Thai collation
       77  SQL-CS-UCA400-LTH         PIC S9(4) COMP-5 VALUE -12.
      * Unicode Collation Algorithm V400 for Slovakian collation
       77  SQL-CS-UCA400-LSK         PIC S9(4) COMP-5 VALUE -13.
      * Codeset aware Unicode Collation
       77  SQL-CS-UNICODE            PIC S9(4) COMP-5 VALUE -14.

      * Defines for Start Database Manager OPTION parameter and Stop
      * Database Manager OPTION and CALLERAC parameters
       77  SQLE-NONE                 PIC S9(4) COMP-5 VALUE 0.
       77  SQLE-FORCE                PIC S9(4) COMP-5 VALUE 1.
       77  SQLE-DROP                 PIC S9(4) COMP-5 VALUE 2.
       77  SQLE-CONTINUE             PIC S9(4) COMP-5 VALUE 3.
       77  SQLE-TERMINATE            PIC S9(4) COMP-5 VALUE 4.
       77  SQLE-ADDNODE              PIC S9(4) COMP-5 VALUE 5.
       77  SQLE-RESTART              PIC S9(4) COMP-5 VALUE 6.
       77  SQLE-STANDALONE           PIC S9(4) COMP-5 VALUE 7.

      * Defines for Start Database Manager & Add Node Tablespace type
      * No Temp Tablespaces
       77  SQLE-TABLESPACES-NONE     PIC S9(4) COMP-5 VALUE 0.
      * Temp Tablespaces like Specified Node
       77  SQLE-TABLESPACES-LIKE-NODE PIC S9(4) COMP-5 VALUE 1.
      * Temp Tablespaces like Catalog Node
       77  SQLE-TABLESPACES-LIKE-CATALOG PIC S9(4) COMP-5 VALUE 2.

      * Parameters for Drop Node Action
      * Verify
       77  SQL-DROPNODE-VERIFY       PIC S9(4) COMP-5 VALUE 1.

      * Parameters for indicating the stored procedure invocation was via
      * the CALL statement
       77  SQL-CALLPROC              PIC X(8) value "$SQL$CAL"
                                     USAGE DISPLAY NATIVE.

      * Default values for Segmented Tables parameters
      * Default number of segments-nonOS2
       77  SQL-DEF-NUMSEGS           PIC S9(4) COMP-5 VALUE 1.
      * OBSOLETE: Default max pages per seg
       77  SQL-DEF-SEGPAGES          PIC S9(9) COMP-5 VALUE 76800.
      * default extent size
       77  SQL-DEF-EXTSIZE           PIC S9(4) COMP-5 VALUE 32.

      * DUOW Connection Setting types used by sqleqryc() and
      * sqlesetc().Associated values are in sql.h, used in common with the
      * precompiler.
      * Connect type
       77  SQL-CONNECT-TYPE          PIC S9(4) COMP-5 VALUE 1.
      * Rules for changing connections
       77  SQL-RULES                 PIC S9(4) COMP-5 VALUE 2.
      * Disconnect type at syncpoint
       77  SQL-DISCONNECT            PIC S9(4) COMP-5 VALUE 3.
      * Syncpoint type
       77  SQL-SYNCPOINT             PIC S9(4) COMP-5 VALUE 4.
      * Maximum concurrent connections
       77  SQL-MAX-NETBIOS-CONNECTIONS PIC S9(4) COMP-5 VALUE 5.
      * Deferred Prepare
       77  SQL-DEFERRED-PREPARE      PIC S9(4) COMP-5 VALUE 6.
      * Node to connect to
       77  SQL-CONNECT-NODE          PIC S9(4) COMP-5 VALUE 7.
      * Node to attach to 
       77  SQL-ATTACH-NODE           PIC S9(4) COMP-5 VALUE 8.

      * SET CLIENT INFORMATION types used by sqleseti() and sqleqryi().
      * Client user name
       77  SQLE-CLIENT-INFO-USERID   PIC S9(4) COMP-5 VALUE 1.
      * Client workstation name
       77  SQLE-CLIENT-INFO-WRKSTNNAME PIC S9(4) COMP-5 VALUE 2.
      * Client application name
       77  SQLE-CLIENT-INFO-APPLNAME PIC S9(4) COMP-5 VALUE 3.
      * Client accounting string
       77  SQLE-CLIENT-INFO-ACCTSTR  PIC S9(4) COMP-5 VALUE 4.
      * Client programid identifier
       77  SQLE-CLIENT-INFO-PROGRAMID PIC S9(4) COMP-5 VALUE 5.
      * Client autocommit
       77  SQLE-CLIENT-INFO-AUTOCOMMIT PIC S9(4) COMP-5 VALUE 6.

      * Constants to be used to set AUTOCOMMIT.
       77  SQLE-CLIENT-AUTOCOMMIT-ON PIC X(1) value "Y"
                                     USAGE DISPLAY NATIVE.
       77  SQLE-CLIENT-AUTOCOMMIT-OFF PIC X(1) value "N"
                                     USAGE DISPLAY NATIVE.

      * SET CLIENT INFORMATION types maximum information lengths
      * Maximum client user information length
       77  SQLE-CLIENT-USERID-MAX-LEN PIC S9(4) COMP-5 VALUE 255.
      * Maximum client workstation information length
       77  SQLE-CLIENT-WRKSTNNAME-MAX-LEN PIC S9(4) COMP-5 VALUE 255.
      * Maximum client application information length
       77  SQLE-CLIENT-APPLNAME-MAX-LEN PIC S9(4) COMP-5 VALUE 255.
      * Maximum client accounting information length
       77  SQLE-CLIENT-ACCTSTR-MAX-LEN PIC S9(4) COMP-5 VALUE 200.
      * Maximum client program identifier length
       77  SQLE-CLIENT-PROGRAMID-MAX-LEN PIC S9(4) COMP-5 VALUE 80.
      * Maximum length for autocommit
       77  SQLE-CLIENT-AUTOCOMMIT-MAX-LEN PIC S9(4) COMP-5 VALUE 1.


      * A structure to identify an SQL statement.  The eyecatcher $SQL$CALL
      * identifies this as an EXEC SQL CALL statement.
      *************************************************************************
      * SQLSTMTID data structure
      **************************************************************************
       01 SQLSTMTID.
      * eye catcher
           05 SQLCSTID               PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * creator id
           05 SQLUSER                PIC X(128)
                                     USAGE DISPLAY NATIVE.
      * package name
           05 SQL-PKGNAME            PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * consistency token
           05 SQL-CONTOKEN           PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * reserved
           05 SQL-SECTNUM            PIC S9(4) COMP-5.
      * reserved
           05 SQL-WCHAR-INFO         PIC X
                                     USAGE DISPLAY NATIVE.
      * reserved
           05 SQL-F-CACHE-ROWS       PIC X
                                     USAGE DISPLAY NATIVE.
      * reserved
           05 SQL-BUFFER             PIC X(38)
                                     USAGE DISPLAY NATIVE.


      * Database Description Block structure

      * TableSpace types
       77  SQL-TBS-TYP-SMS           PIC X(1) value "S"
                                     USAGE DISPLAY NATIVE.
       77  SQL-TBS-TYP-DMS           PIC X(1) value "D"
                                     USAGE DISPLAY NATIVE.
       77  SQL-TBS-TYP-AUTO          PIC X(1) value "A"
                                     USAGE DISPLAY NATIVE.

      * TableSpace container types
      * path (directory)  SMS only
       77  SQL-TBSC-TYP-PATH         PIC X(1) value "P"
                                     USAGE DISPLAY NATIVE.
      * device (raw disk) DMS only
       77  SQL-TBSC-TYP-DEV          PIC X(1) value "D"
                                     USAGE DISPLAY NATIVE.
      * file (cooked file) DMS only
       77  SQL-TBSC-TYP-FILE         PIC X(1) value "F"
                                     USAGE DISPLAY NATIVE.

      * version 2 database descriptor
       77  SQLE-DBDESC-2             PIC X(8) value "SQLDBD02"
                                     USAGE DISPLAY NATIVE.
      * version 2 tableSpace descriptor
       77  SQLE-DBTSDESC-1           PIC X(8) value "SQLTS001"
                                     USAGE DISPLAY NATIVE.

      * Initial TableSpace names
      * system catalogs
       77  SQLCATTS-NAME             PIC X(11) value "SYSCATSPACE"
                                     USAGE DISPLAY NATIVE.
      * user tables
       77  SQLUSRTS-NAME             PIC X(10) value "USERSPACE1"
                                     USAGE DISPLAY NATIVE.
      * temp tables
       77  SQLTMPTS-NAME             PIC X(10) value "TEMPSPACE1"
                                     USAGE DISPLAY NATIVE.

      * tableSpace container descriptor
      *************************************************************************
      * SQLETSCDESC data structure
      * Table: Fields in the SQLETSCDESC Structure
      * |--------------------------------------------------------------------|
      * |Field Name|Data Type | Description                                  |
      * |----------|----------|----------------------------------------------|
      * |SQLCTYPE  |CHAR(1)   | Identifies the type of this container. See   |
      * |          |          | below for values.                            |
      * |----------|----------|----------------------------------------------|
      * |SQLCSIZE  |INTEGER   | Size of the container identified in SQLCONTR,|
      * |          |          | specified in 4KB pages. Valid only when      |
      * |          |          | SQLTSTYP is set to SQL_TBS_TYP_DMS.          |
      * |----------|----------|----------------------------------------------|
      * |SQLCLEN   |SMALLINT  | Length of following SQLCONTR value.          |
      * |----------|----------|----------------------------------------------|
      * |SQLCONTR  |CHAR(256) | Container string.                            |
      * |----------|----------|----------------------------------------------|
      * 
      * pad1
      * Reserved. Used for structure alignment and should not to be populated
      * by user data.
      * 
      * pad2
      * Reserved. Used for structure alignment and should not to be populated
      * by user data.
      * 
      * Valid values for SQLCTYPE (defined in sqlenv) are:
      * - SQL_TBSC_TYP_DEV 
      * Device. Valid only when SQLTSTYP = SQL_TBS_TYP_DMS.
      * - SQL_TBSC_TYP_FILE 
      * File. Valid only when SQLTSTYP = SQL_TBS_TYP_DMS. 
      * - SQL_TBSC_TYP_PATH 
      * Path (directory). Valid only when SQLTSTYP = SQL_TBS_TYP_SMS. 
      * 
      * COBOL Structure
      * 
      * * File: sqlenv.cbl
      * 01 SQLETSCDESC.
      *     05 SQLCTYPE               PIC X.
      *     05 SQL-PAD1               PIC X(3).
      *     05 SQLCSIZE               PIC S9(9) COMP-5.
      *     05 SQLCLEN                PIC S9(4) COMP-5.
      *     05 SQLCONTR               PIC X(256).
      *     05 SQL-PAD2               PIC X(2).
      * * 
      **************************************************************************
       01 SQLETSCDESC.
      * container type
           05 SQLCTYPE               PIC X
                                     USAGE DISPLAY NATIVE.
      * reserved
           05 SQL-PAD1               PIC X(3)
                                     USAGE DISPLAY NATIVE.
      * container size (in pages)
           05 SQLCSIZE               PIC S9(9) COMP-5.
      * length of container name
           05 SQLCLEN                PIC S9(4) COMP-5.
      * container name (includes 1 byte for C NULL terminator)
           05 SQLCONTR               PIC X(256)
                                     USAGE DISPLAY NATIVE.
      * 2 bytes padding before next container
           05 SQL-PAD2               PIC X(2)
                                     USAGE DISPLAY NATIVE.


      *************************************************************************
      * sqledbdesc data structure
      * The Database Description Block (SQLEDBDESC) structure can be used
      * during a call to the sqlecrea API to specify permanent values for
      * database attributes. These attributes include database comment,
      * collating sequences, and table space definitions.
      * 
      * Table: Fields in the SQLEDBDESC Structure
      * --------------------------------------------------------------------------
      * |Field Name  | Data Type    | Description                                 |
      * |------------|--------------|---------------------------------------------|
      * |SQLDBDID    | CHAR(8)      | A structure identifier and "eye-catcher"    |
      * |            |              | for storage dumps. It is a string of eight  |
      * |            |              | bytes that must be initialized with the     |
      * |            |              | value of SQLE_DBDESC_2 (defined in sqlenv). |
      * |            |              | The contents of this field are validated for|
      * |            |              | version control.                            |
      * |------------|--------------|---------------------------------------------|
      * |SQLDBCCP    | INTEGER      | The code page of the database comment. This |
      * |            |              | value is no longer used by the database     |
      * |            |              | manager.                                    |
      * |------------|--------------|---------------------------------------------|
      * |SQLDBCSS    | INTEGER      | A value indicating the source of the        |
      * |            |              | database collating sequence. See below for  |
      * |            |              | values.                                     |
      * |            |              | Note:                                       |
      * |            |              | Specify SQL_CS_NONE to specify that the     |
      * |            |              | collating sequence for the database is      |
      * |            |              | IDENTITY (which implements a binary         |
      * |            |              | collating sequence). SQL_CS_NONE is the     |
      * |            |              | default.                                    |
      * |------------|--------------|---------------------------------------------|
      * |SQLDBUDC    | CHAR(256)    | The nth byte of this field contains the sort|
      * |            |              | weight of the code point whose underlying   |
      * |            |              | decimal representation is n in the code     |
      * |            |              | page of the database. If SQLDBCSS is not    |
      * |            |              | equal to SQL_CS_USER, this field is ignored.|
      * |------------|--------------|---------------------------------------------|
      * |SQLDBCMT    | CHAR(30)     | The comment for the database.               |
      * |------------|--------------|---------------------------------------------|
      * |SQLDBSGP    | INTEGER      | Reserved field. No longer used.             |
      * |------------|--------------|---------------------------------------------|
      * |SQLDBNSG    | SHORT        | A value that indicates the number of file   |
      * |            |              | segments to be created in the database. The |
      * |            |              | minimum value for this field is 1 and the   |
      * |            |              | maximum value for this field is 256. If a   |
      * |            |              | value of -1 is supplied, this field will    |
      * |            |              | default to 1.                               |
      * |            |              | Note:                                       |
      * |            |              | SQLDBNSG set to zero produces a default for |
      * |            |              | Version 1 compatibility.                    |
      * |------------|--------------|---------------------------------------------|
      * |SQLTSEXT    | INTEGER      | A value, in 4KB pages, which indicates the  |
      * |            |              | default extent size for each table space in |
      * |            |              | the database. The minimum value for this    |
      * |            |              | field is 2 and the maximum value for this   |
      * |            |              | field is 256. If a value of -1 is supplied, |
      * |            |              | this field will default to 32.              |
      * |------------|--------------|---------------------------------------------|
      * |SQLCATTS    | Pointer      | A pointer to a table space description      |
      * |            |              | control block, SQLETSDESC, which defines the|
      * |            |              | catalog table space. If null, a default     |
      * |            |              | catalog table space based on the values of  |
      * |            |              | SQLTSEXT and SQLDBNSG will be created.      |
      * |------------|--------------|---------------------------------------------|
      * |SQLUSRTS    | Pointer      | A pointer to a table space description      |
      * |            |              | control block, SQLETSDESC, which defines the|
      * |            |              | user table space. If null, a default user   |
      * |            |              | table space based on the values of SQLTSEXT |
      * |            |              | and SQLDBNSG will be created.               |
      * |------------|--------------|---------------------------------------------|
      * |SQLTMPTS    | Pointer      | A pointer to a table space description      |
      * |            |              | control block, SQLETSDESC, which defines the|
      * |            |              | system temporary table space. If null, a    |
      * |            |              | default system temporary table space based  |
      * |            |              | on the values of SQLTSEXT and SQLDBNSG will |
      * |            |              | be created.                                 |
      * |------------|--------------|---------------------------------------------|
      * 
      * pad1
      * Reserved. Used for structure alignment and should not be populated by
      * user data.
      * 
      * pad2
      * Reserved. Used for structure alignment and should not be populated by
      * user data.
      * 
      * Valid values for SQLDBCSS (defined in sqlenv) are:
      * 
      * - SQL_CS_SYSTEM
      * Collating sequence based on the database territory.
      * 
      * - SQL_CS_USER 
      * Collation sequence is specified by the 256-byte weight table
      * supplied by the user. Each weight in the table is one byte in
      * length.
      * 
      * - SQL_CS_NONE
      * Collation sequence is IDENTITY, that is, binary code point order.
      * 
      * - SQLE_CS_COMPATABILITY
      * Use pre-Version collating sequence.
      * 
      * - SQL_CS_SYSTEM_NLSCHAR 
      * Collating sequence from system using the NLS version of compare
      * routines for character types. This value can only be specified when
      * creating a Thai TIS620-1 database.
      * 
      * - SQL_CS_USER_NLSCHAR
      * Collation sequence is specified by the 256-byte weight table
      * supplied by the user. Each weight in the table is one byte in
      * length. This value can only be specified when creating a Thai
      * TIS620-1 database.
      * 
      * - SQL_CS_IDENTITY_16BIT
      * CESU-8 (Compatibility Encoding Scheme for UTF-16: 8-Bit) collation
      * sequence as specified by the Unicode Technical Report #26, available
      * at the Unicode Consortium web site (www.unicode.org). This value can
      * only be specified when creating a Unicode database.
      * 
      * - SQL_CS_UCA400_NO
      * UCA (Unicode Collation Algorithm) collation sequence based on the
      * Unicode Standard version 4.00 with normalization implicitly set to
      * 'on'. Details of the UCA can be found in the Unicode Technical
      * Standard #10 available at the Unicode Consortium web site
      * (www.unicode.org). This value can only be specified when creating a
      * Unicode database.
      * 
      * - SQL_CS_UCA400_LTH
      * UCA (Unicode Collation Algorithm) collation sequence based on the
      * Unicode Standard version 4.00, with sorting of all Thai characters
      * according to the Royal Thai Dictionary order. Details of the UCA can
      * be found in the Unicode Technical Standard #10 available at the
      * Unicode Consortium web site (www.unicode.org). This value can only
      * be specified when creating a Unicode database.
      * 
      * COBOL Structure
      * 
      * * File: sqlenv.cbl
      * 01 SQLEDBDESC.
      *     05 SQLDBDID               PIC X(8).
      *     05 SQLDBCCP               PIC S9(9) COMP-5.
      *     05 SQLDBCSS               PIC S9(9) COMP-5.
      *     05 SQLDBUDC               PIC X(256).
      *     05 SQLDBCMT               PIC X(30).
      *     05 FILLER                 PIC X.
      *     05 SQL-PAD                PIC X(1).
      *     05 SQLDBSGP               PIC 9(9) COMP-5.
      *     05 SQLDBNSG               PIC S9(4) COMP-5.
      *     05 SQL-PAD2               PIC X(2).
      *     05 SQLTSEXT               PIC S9(9) COMP-5.
      *     05 SQLCATTS               USAGE IS POINTER.
      *     05 SQLUSRTS               USAGE IS POINTER.
      *     05 SQLTMPTS               USAGE IS POINTER.
      * * 
      * 
      **************************************************************************
       01 SQLEDBDESC.
      * eye catcher
           05 SQLDBDID               PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * comment code page
           05 SQLDBCCP               PIC S9(9) COMP-5.
      * Source of collating seq
           05 SQLDBCSS               PIC S9(9) COMP-5.
      * user-defined collating seq
           05 SQLDBUDC               PIC X(256)
                                     USAGE DISPLAY NATIVE.
      * comment
           05 SQLDBCMT               PIC X(30)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * reserved
           05 SQL-PAD                PIC X(1)
                                     USAGE DISPLAY NATIVE.
      * obsolete: use sqltsext
           05 SQLDBSGP               PIC 9(9) COMP-5.
      * number of segments
           05 SQLDBNSG               PIC S9(4) COMP-5.
      * reserved
           05 SQL-PAD2               PIC X(2)
                                     USAGE DISPLAY NATIVE.
      * default extent size
           05 SQLTSEXT               PIC S9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
           05 SQLCATTS               USAGE IS POINTER.
           05 SQLUSRTS               USAGE IS POINTER.
           05 SQLTMPTS               USAGE IS POINTER.


      * Old Database Directory Scan data structure
      *************************************************************************
      * sqledinfo data structure
      **************************************************************************
       01 SQLEDINFO.
      * Alias name
           05 SQL-ALIAS              PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * Database name
           05 SQL-DBNAME             PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * Drive/Path
           05 SQL-DRIVE              PIC X(215)
                                     USAGE DISPLAY NATIVE.
      * Database subdirectory
           05 SQL-INTNAME            PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * Node name
           05 SQL-NODENAME           PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * Release information
           05 SQL-DBTYPE             PIC X(20)
                                     USAGE DISPLAY NATIVE.
      * Comment
           05 SQL-COMMENT            PIC X(30)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X(1)
                                     USAGE DISPLAY NATIVE.
      * Code page of comment
           05 SQL-COM-CODEPAGE       PIC S9(4) COMP-5.
      * Entry type - defines above
           05 SQL-TYPE               PIC X
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X(1)
                                     USAGE DISPLAY NATIVE.
      * Authentication type
           05 SQL-AUTHENTICATION     PIC 9(4) COMP-5.
      * Global database name
           05 SQL-GLBDBNAME          PIC X(255)
                                     USAGE DISPLAY NATIVE.
      * dce principal bin string
           05 SQL-DCEPRINCIPAL       PIC X(1024)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X(1)
                                     USAGE DISPLAY NATIVE.
      * Catalog node number
           05 SQL-CAT-NODENUM        PIC S9(4) COMP-5.
      * Node number
           05 SQL-NODENUM            PIC S9(4) COMP-5.

      * Node Directory Scan data structure
      *************************************************************************
      * sqleninfo data structure
      * This structure returns information after a call to the sqlengne API.
      * 
      * Table: Fields in the SQLENINFO Structure
      * --------------------------------------------------------------------------
      * |Field Name       |  Data Type | Description                             |
      * |-----------------|------------|-----------------------------------------|
      * |NODENAME         |  CHAR(8)   | Used for the NetBIOS protocol; the nname|
      * |                 |            | of the node where the database is       |
      * |                 |            | located (valid in system directory only)|
      * |-----------------|------------|-----------------------------------------|
      * |LOCAL_LU         |  CHAR(8)   | Used for the APPN protocol; local       |
      * |                 |            | logical unit.                           |
      * |-----------------|------------|-----------------------------------------|
      * |PARTNER_LU       |  CHAR(8)   | Used for the APPN protocol; partner     |
      * |                 |            | logical unit.                           |
      * |-----------------|------------|-----------------------------------------|
      * |MODE             |  CHAR(8)   | Used for the APPN protocol; transmission|
      * |                 |            | service mode.                           |
      * |-----------------|------------|-----------------------------------------|
      * |COMMENT          |  CHAR(30)  | The comment associated with the node.   |
      * |-----------------|------------|-----------------------------------------|
      * |COM_CODEPAGE     |  SMALLINT  | The code page of the comment. This field|
      * |                 |            | is no longer used by the database       |
      * |                 |            | manager.                                |
      * |-----------------|------------|-----------------------------------------|
      * |ADAPTER          |  SMALLINT  | Used for the NetBIOS protocol; the      |
      * |                 |            | local network adapter.                  |
      * |-----------------|------------|-----------------------------------------|
      * |NETWORKID        |  CHAR(8)   | Used for the APPN protocol; network ID. |
      * |-----------------|------------|-----------------------------------------|
      * |PROTOCOL         |  CHAR(1)   | Communications protocol.                |
      * |-----------------|------------|-----------------------------------------|
      * |SYM_DEST_NAME    |  CHAR(8)   | Used for the APPC protocol; the symbolic|
      * |                 |            | destination name.                       |
      * |-----------------|------------|-----------------------------------------|
      * |SECURITY_TYPE    |  SMALLINT  | Used for the APPC protocol; the         |
      * |                 |            | security type. See below for values.    |
      * |-----------------|------------|-----------------------------------------|
      * |HOSTNAME         |  CHAR(255) | Used for the TCP/IP protocol; the name  |
      * |                 |            | of the TCP/IP host on which the DB2     |
      * |                 |            | server instance resides.                |
      * |-----------------|------------|-----------------------------------------|
      * |SERVICE_NAME     |  CHAR(14)  | Used for the TCP/IP protocol; the TCP/IP|
      * |                 |            | service name or associated port number  |
      * |                 |            | of the DB2 server instance.             |
      * |-----------------|------------|-----------------------------------------|
      * |FILESERVER       |  CHAR(48)  | Used for the IPX/SPX protocol; the name |
      * |                 |            | of the NetWare file server where the DB2|
      * |                 |            | server instance is registered.          |
      * |-----------------|------------|-----------------------------------------|
      * |OBJECTNAME       |  CHAR(48)  | The database manager server instance is |
      * |                 |            | represented as the object, objectname,  |
      * |                 |            | on the NetWare file server. The server's|
      * |                 |            | IPX/SPX internetwork address is stored  |
      * |                 |            | and retrieved from this object.         |
      * |-----------------|------------|-----------------------------------------|
      * |INSTANCE_NAME    |  CHAR(8)   | Used for the local and NPIPE protocols; |
      * |                 |            | the name of the server instance.        |
      * |-----------------|------------|-----------------------------------------|
      * |COMPUTERNAME     |  CHAR(15)  | Used by the NPIPE protocol; the server  |
      * |                 |            | node's computer name.                   |
      * |-----------------|------------|-----------------------------------------|
      * |SYSTEM_NAME      |  CHAR(21)  | The DB2 system name of the remote       |
      * |                 |            | server.                                 |
      * |-----------------|------------|-----------------------------------------|
      * |REMOTE_INSTNAME  |  CHAR(8)   | The name of the DB2 server instance.    |
      * |-----------------|------------|-----------------------------------------|
      * |CATALOG_NODE_TYPE|  CHAR      | Catalog node type.                      |
      * |-----------------|------------|-----------------------------------------|
      * |OS_TYPE          |  UNSIGNED  | Identifies the operating system of the  |
      * |                 |  SHORT     | server.                                 |
      * |-----------------|------------|-----------------------------------------|
      * |Note:                                                                   |
      * |Each character field returned is blank filled up to the length of the   |
      * |field.                                                                  |
      * |------------------------------------------------------------------------|
      * 
      * Valid values for SECURITY_TYPE (defined in sqlenv) are:
      * - SQL_CPIC_SECURITY_NONE 
      * - SQL_CPIC_SECURITY_SAME 
      * - SQL_CPIC_SECURITY_PROGRAM 
      * 
      * COBOL Structure
      * 
      * * File: sqlenv.cbl
      * 01 SQLENINFO.
      *     05 SQL-NODE-NAME          PIC X(8).
      *     05 SQL-LOCAL-LU           PIC X(8).
      *     05 SQL-PARTNER-LU         PIC X(8).
      *     05 SQL-MODE               PIC X(8).
      *     05 SQL-COMMENT            PIC X(30).
      *     05 SQL-COM-CODEPAGE       PIC 9(4) COMP-5.
      *     05 SQL-ADAPTER            PIC 9(4) COMP-5.
      *     05 SQL-NETWORKID          PIC X(8).
      *     05 SQL-PROTOCOL           PIC X.
      *     05 SQL-SYM-DEST-NAME      PIC X(8).
      *     05 FILLER                 PIC X(1).
      *     05 SQL-SECURITY-TYPE      PIC 9(4) COMP-5.
      *     05 SQL-HOSTNAME           PIC X(255).
      *     05 SQL-SERVICE-NAME       PIC X(14).
      *     05 SQL-FILESERVER         PIC X(48).
      *     05 SQL-OBJECTNAME         PIC X(48).
      *     05 SQL-INSTANCE-NAME      PIC X(8).
      *     05 SQL-COMPUTERNAME       PIC X(15).
      *     05 SQL-SYSTEM-NAME        PIC X(21).
      *     05 SQL-REMOTE-INSTNAME    PIC X(8).
      *     05 SQL-CATALOG-NODE-TYPE  PIC X.
      *     05 SQL-OS-TYPE            PIC 9(4) COMP-5.
      * * 
      **************************************************************************
       01 SQLENINFO.
      * Node name
           05 SQL-NODE-NAME          PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * Local_lu_name
           05 SQL-LOCAL-LU           PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * Partner_lu_name
           05 SQL-PARTNER-LU         PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * Mode
           05 SQL-MODE               PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * Comment
           05 SQL-COMMENT            PIC X(30)
                                     USAGE DISPLAY NATIVE.
      * Comment code page
           05 SQL-COM-CODEPAGE       PIC 9(4) COMP-5.
      * NetBIOS Adapter #
           05 SQL-ADAPTER            PIC 9(4) COMP-5.
      * APPN Network ID
           05 SQL-NETWORKID          PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * Protocol type
           05 SQL-PROTOCOL           PIC X
                                     USAGE DISPLAY NATIVE.
      * CPIC Sym. Dest. Name
           05 SQL-SYM-DEST-NAME      PIC X(8)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X(1)
                                     USAGE DISPLAY NATIVE.
      * CPIC Security Type
           05 SQL-SECURITY-TYPE      PIC 9(4) COMP-5.
      * TCP/IP Host name
           05 SQL-HOSTNAME           PIC X(255)
                                     USAGE DISPLAY NATIVE.
      * TCP/IP Service name
           05 SQL-SERVICE-NAME       PIC X(14)
                                     USAGE DISPLAY NATIVE.
      * IPX/SPX fileserver name
           05 SQL-FILESERVER         PIC X(48)
                                     USAGE DISPLAY NATIVE.
      * IPX/SPX objectname
           05 SQL-OBJECTNAME         PIC X(48)
                                     USAGE DISPLAY NATIVE.
      * LOCAL Instance name
           05 SQL-INSTANCE-NAME      PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * Computer name
           05 SQL-COMPUTERNAME       PIC X(15)
                                     USAGE DISPLAY NATIVE.
      * System name
           05 SQL-SYSTEM-NAME        PIC X(21)
                                     USAGE DISPLAY NATIVE.
      * Remote instance name
           05 SQL-REMOTE-INSTNAME    PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * Catalog node type
           05 SQL-CATALOG-NODE-TYPE  PIC X
                                     USAGE DISPLAY NATIVE.
      * OS type
           05 SQL-OS-TYPE            PIC 9(4) COMP-5.
      * Change_password_lu_name
           05 SQL-CHGPWD-LU          PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * TRANSaction_Program_Name
           05 SQL-TRANSPN            PIC X(64)
                                     USAGE DISPLAY NATIVE.
      * LAN_Adapter_Address
           05 SQL-LANADDR            PIC X(12)
                                     USAGE DISPLAY NATIVE.

      * General Catalog Node structures and defines

      *************************************************************************
      * sqle_node_struct data structure
      * This structure is used to catalog nodes for the sqlectnd API.
      * 
      * Table: Fields in the SQLE-NODE-STRUCT Structure
      * -----------------------------------------------------------------------
      * |Field Name | Data Type | Description                                  |
      * |----------------------------------------------------------------------|
      * |STRUCT_ID  | SMALLINT  | Structure identifier.                        |
      * |----------------------------------------------------------------------|
      * |CODEPAGE   | SMALLINT  | Code page for comment.                       |
      * |----------------------------------------------------------------------|
      * |COMMENT    | CHAR(30)  | Optional description of the node.            |
      * |----------------------------------------------------------------------|
      * |NODENAME   | CHAR(8)   | Local name for the node where the database is|
      * |           |           | located.                                     |
      * |----------------------------------------------------------------------|
      * |PROTOCOL   | CHAR(1)   | Communications protocol type.                |
      * |----------------------------------------------------------------------|
      * |Note:                                                                 |
      * |The character fields passed in this structure must be null terminated |
      * |or blank filled up to the length of the field.                        |
      * |----------------------------------------------------------------------|
      * 
      * Valid values for PROTOCOL (defined in sqlenv) are:
      * - SQL_PROTOCOL_APPC
      * - SQL_PROTOCOL_APPN
      * - SQL_PROTOCOL_CPIC
      * - SQL_PROTOCOL_IPXSPX
      * - SQL_PROTOCOL_LOCAL 
      * - SQL_PROTOCOL_NETB
      * - SQL_PROTOCOL_NPIPE
      * - SQL_PROTOCOL_SOCKS
      * - SQL_PROTOCOL_TCPIP
      * 
      * COBOL Structure
      * 
      * * File: sqlenv.cbl
      * 01 SQL-NODE-STRUCT.
      *     05 STRUCT-ID              PIC 9(4) COMP-5.
      *     05 CODEPAGE               PIC 9(4) COMP-5.
      *     05 COMMENT                PIC X(30).
      *     05 FILLER                 PIC X.
      *     05 NODENAME               PIC X(8).
      *     05 FILLER                 PIC X.
      *     05 PROTOCOL               PIC X.
      *     05 FILLER                 PIC X(1).
      * * 
      **************************************************************************
       01 SQL-NODE-STRUCT.
      * Structure Identifier
           05 STRUCT-ID              PIC 9(4) COMP-5.
      * Codepage for comment
           05 CODEPAGE               PIC 9(4) COMP-5.
      * Comment
           05 COMMENT                PIC X(30)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * Node name
           05 NODENAME               PIC X(8)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * Protocol Type
           05 PROTOCOL               PIC X
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X(1)
                                     USAGE DISPLAY NATIVE.

      *************************************************************************
      * sqle_node_appc data structure
      * This structure is used to catalog APPC nodes for the sqlectnd API.
      * 
      * Table: Fields in the SQLE-NODE-APPC Structure
      * ----------------------------------------------------------------------
      * |Field Name  |Data Type | Description                                 |
      * |---------------------------------------------------------------------|
      * |LOCAL_LU    |CHAR(8)   | Local_lu name.                              |
      * |---------------------------------------------------------------------|
      * |PARTNER_LU  |CHAR(8)   | Alias Partner_lu name.                      |
      * |---------------------------------------------------------------------|
      * |MODE        |CHAR(8)   | Mode.                                       |
      * |---------------------------------------------------------------------|
      * |Note:                                                                |
      * |The character fields passed in this structure must be null terminated|
      * |or blank filled up to the length of the field.                       |
      * |---------------------------------------------------------------------|
      * 
      * COBOL Structure
      * 
      * * File: sqlenv.cbl
      * 01 SQL-NODE-APPC.
      *     05 LOCAL-LU               PIC X(8).
      *     05 FILLER                 PIC X.
      *     05 PARTNER-LU             PIC X(8).
      *     05 FILLER                 PIC X.
      *     05 TRANS-MODE             PIC X(8).
      *     05 FILLER                 PIC X.
      * * 
      **************************************************************************
      * For APPC protocol
       01 SQL-NODE-APPC.
      * Local_lu name
           05 LOCAL-LU               PIC X(8)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * Alias Partner_lu name
           05 PARTNER-LU             PIC X(8)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * Mode
           05 TRANS-MODE             PIC X(8)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.

      *************************************************************************
      * sqle_node_netb data structure
      * This structure is used to catalog NetBIOS nodes for the sqlectnd API.
      * 
      * Table: Fields in the SQLE-NODE-NETB Structure
      * ------------------------------------------------------------------------
      * |Field Name   |Data Type |Description                                   |
      * |-----------------------------------------------------------------------|
      * |ADAPTER      |SMALLINT  |Local LAN adapter.                            |
      * |-----------------------------------------------------------------------|
      * |REMOTE_NNAME |CHAR(8)   |Nname of the remote workstation that is stored|
      * |             |          |in the database manager configuration file on |
      * |             |          |the server instance.                          |
      * |-----------------------------------------------------------------------|
      * |Note:                                                                  |
      * |The character fields passed in this structure must be null terminated  |
      * |or blank filled up to the length of the field.                         |
      * |-----------------------------------------------------------------------|
      * 
      * COBOL Structure
      * 
      * * File: sqlenv.cbl
      * 01 SQL-NODE-NETB.
      *     05 ADAPTER                PIC 9(4) COMP-5.
      *     05 REMOTE-NNAME           PIC X(8).
      *     05 FILLER                 PIC X.
      *     05 FILLER                 PIC X(1).
      * * 
      **************************************************************************
      * For NetBIOS Protocol
       01 SQL-NODE-NETB.
      * Adapter Number
           05 ADAPTER                PIC 9(4) COMP-5.
      * Remote Workstation name
           05 REMOTE-NNAME           PIC X(8)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X(1)
                                     USAGE DISPLAY NATIVE.

      *************************************************************************
      * sqle_node_appn data structure
      * This structure is used to catalog APPN nodes for the sqlectnd API.
      * 
      * Table: Fields in the SQLE-NODE-APPN Structure
      * ----------------------------------------------------------------------
      * |Field Name | Data Type | Description                                 |
      * |---------------------------------------------------------------------|
      * |NETWORKID  | CHAR(8)   | Network ID.                                 |
      * |---------------------------------------------------------------------|
      * |REMOTE_LU  | CHAR(8)   | Alias Remote_lu name.                       |
      * |---------------------------------------------------------------------|
      * |LOCAL_LU   | CHAR(8)   | Alias Local_lu name.                        |
      * |---------------------------------------------------------------------|
      * |MODE       | CHAR(8)   | Mode.                                       |
      * |---------------------------------------------------------------------|
      * |Note:                                                                |
      * |The character fields passed in this structure must be null terminated|
      * |or blank filled up to the length of the field.                       |
      * |---------------------------------------------------------------------|
      * 
      * COBOL Structure
      * 
      * * File: sqlenv.cbl
      * 01 SQL-NODE-APPN.
      *     05 NETWORKID              PIC X(8).
      *     05 FILLER                 PIC X.
      *     05 REMOTE-LU              PIC X(8).
      *     05 FILLER                 PIC X.
      *     05 LOCAL-LU               PIC X(8).
      *     05 FILLER                 PIC X.
      *     05 TRANS-MODE             PIC X(8).
      *     05 FILLER                 PIC X.
      * *
      **************************************************************************
      * For APPN protocol
       01 SQL-NODE-APPN.
      * Network ID
           05 NETWORKID              PIC X(8)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * Remoter lu name
           05 REMOTE-LU              PIC X(8)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * Local_lu name
           05 LOCAL-LU               PIC X(8)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * Mode
           05 TRANS-MODE             PIC X(8)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * Change password lu name
           05 CHGPWD-LU              PIC X(8)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * Transaction Program Name
           05 TRANSPN                PIC X(64)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * LAN Adapter Address
           05 LANADDR                PIC X(12)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X(1)
                                     USAGE DISPLAY NATIVE.
      * Security Type
           05 SECURITY-TYPE          PIC 9(4) COMP-5.

      *************************************************************************
      * sqle_node_tcpip data structure
      * This structure is used to catalog TCP/IP nodes for the sqlectnd API.
      * 
      * Note:
      * To catalog a TCP/IP SOCKS node, set the PROTOCOL type in the node
      * directory structure to SQL_PROTOCOL_SOCKS in the SQLE-NODE-STRUCT
      * structure before calling the sqlectnd API.
      * 
      * Table: Fields in the SQLE-NODE-TCPIP Structure
      * -----------------------------------------------------------------------
      * |Field Name   | Data Type|Description                                  |
      * |----------------------------------------------------------------------|
      * |HOSTNAME     | CHAR(255)|The name of the TCP/IP host on which the DB2 |
      * |             |          |server instance resides.                     |
      * |----------------------------------------------------------------------|
      * |SERVICE_NAME | CHAR(14) |TCP/IP service name or associated port number|
      * |             |          |of the DB2 server instance.                  |
      * |----------------------------------------------------------------------|
      * |Note:                                                                 |
      * |The character fields passed in this structure must be null terminated |
      * |or blank filled up to the length of the field.                        |
      * |----------------------------------------------------------------------|
      * 
      * COBOL Structure
      * 
      * * File: sqlenv.cbl
      * 01 SQL-NODE-TCPIP.
      *     05 HOSTNAME               PIC X(255).
      *     05 FILLER                 PIC X.
      *     05 SERVICE-NAME           PIC X(14).
      *     05 FILLER                 PIC X.
      * *
      **************************************************************************
      * For TCP/IP protocol
       01 SQL-NODE-TCPIP.
      * Host name
           05 HOSTNAME               PIC X(255)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * Service Name
           05 SERVICE-NAME           PIC X(14)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.

      *************************************************************************
      * sqle_node_npipe data structure
      * This structure is used to catalog named pipe nodes for the sqlectnd API.
      * 
      * Table: Fields in the SQLE-NODE-NPIPE Structure
      * -----------------------------------------------------------------------
      * |Field Name   |Data Type | Description                                |
      * |---------------------------------------------------------------------|
      * |COMPUTERNAME |CHAR(15)  | Computer name.                             |
      * |---------------------------------------------------------------------|
      * |INSTANCE_NAME|CHAR(8)   | Name of an instance.                       |
      * |---------------------------------------------------------------------|
      * |Note:                                                                |
      * |The character fields passed in this structure must be null terminated|
      * |or blank filled up to the length of the field.                       |
      * |---------------------------------------------------------------------|
      * 
      * COBOL Structure
      * 
      * * File: sqlenv.cbl
      * 01 SQL-NODE-NPIPE.
      *     05 COMPUTERNAME           PIC X(15).
      *     05 FILLER                 PIC X.
      *     05 INSTANCE-NAME          PIC X(8).
      *     05 FILLER                 PIC X.
      * * 
      **************************************************************************
      * For NPIPE protocol
       01 SQL-NODE-NPIPE.
      * Computer name
           05 COMPUTERNAME           PIC X(15)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * Instance Name
           05 INSTANCE-NAME          PIC X(8)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.

      *************************************************************************
      * sqle_node_local data structure
      * This structure is used to catalog local nodes for the sqlectnd API.
      * 
      * Table: Fields in the SQLE-NODE-LOCAL Structure
      * -----------------------------------------------------------------------
      * |Field Name    | Data Type | Description                               |
      * |----------------------------------------------------------------------|
      * |INSTANCE_NAME | CHAR(8)   | Name of an instance.                      |
      * |----------------------------------------------------------------------|
      * |Note:                                                                 |
      * |The character fields passed in this structure must be null terminated |
      * |or blank filled up to the length of the field.                        |
      * |----------------------------------------------------------------------|
      * 
      * COBOL Structure
      * 
      * * File: sqlenv.cbl
      * 01 SQL-NODE-LOCAL.
      *     05 SQL-INSTANCE-NAME      PIC X(8).
      *     05 FILLER                 PIC X.
      * * 
      **************************************************************************
      * For LOCAL protocol
       01 SQL-NODE-LOCAL.
      * Instance Name
           05 SQL-INSTANCE-NAME      PIC X(8)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.

      *************************************************************************
      * sqle_node_cpic data structure
      * This structure is used to catalog CPIC nodes for the sqlectnd API.
      * 
      * Table: Fields in the SQLE-NODE-CPIC Structure
      * ----------------------------------------------------------------------
      * |Field Name    |Data Type |Description                                |
      * |---------------------------------------------------------------------|
      * |SYM_DEST_NAME |CHAR(8)   |Symbolic destination name of remote        |
      * |              |          |partner.                                   |
      * |---------------------------------------------------------------------|
      * |SECURITY_TYPE |SMALLINT  |Security type.                             |
      * |---------------------------------------------------------------------|
      * |Note:                                                                |
      * |The character fields passed in this structure must be null terminated|
      * |or blank filled up to the length of the field.                       |
      * |---------------------------------------------------------------------|
      * 
      * Valid values for SECURITY_TYPE (defined in sqlenv) are:
      * - SQL_CPIC_SECURITY_NONE 
      * - SQL_CPIC_SECURITY_SAME 
      * - SQL_CPIC_SECURITY_PROGRAM 
      * 
      * COBOL Structure
      * 
      * * File: sqlenv.cbl
      * 01 SQL-NODE-CPIC.
      *     05 SYM-DEST-NAME          PIC X(8).
      *     05 FILLER                 PIC X.
      *     05 FILLER                 PIC X(1).
      *     05 SECURITY-TYPE          PIC 9(4) COMP-5.
      * * 
      **************************************************************************
      * For APPC using CPIC protocol
       01 SQL-NODE-CPIC.
      * Sym Dest Name
           05 SYM-DEST-NAME          PIC X(8)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X(1)
                                     USAGE DISPLAY NATIVE.
      * Security Type
           05 SECURITY-TYPE          PIC 9(4) COMP-5.

      *************************************************************************
      * sqle_node_ipxspx data structure
      * This structure is used to catalog IPX/SPX nodes for the sqlectnd API.
      * 
      * Table: Fields in the SQLE-NODE-IPXSPX Structure
      * -----------------------------------------------------------------------
      * |Field Name | Data Type | Description                                  |
      * |----------------------------------------------------------------------|
      * |FILESERVER | CHAR(48)  | Name of the NetWare file server where the DB2|
      * |           |           | server instance is registered.               |
      * |----------------------------------------------------------------------|
      * |OBJECTNAME | CHAR(48)  | The database manager server instance is      |
      * |           |           | represented as the object, objectname, on the|
      * |           |           | NetWare file server. The server's IPX/SPX    |
      * |           |           | internetwork address is stored and retrieved |
      * |           |           | from this object.                            |
      * |----------------------------------------------------------------------|
      * |Note:                                                                 |
      * |The character fields passed in this structure must be null terminated |
      * |or blank filled up to the length of the field.                        |
      * |----------------------------------------------------------------------|
      * 
      * COBOL Structure
      * 
      * * File: sqlenv.cbl
      * 01 SQL-NODE-IPXSPX.
      *     05 SQL-FILESERVER         PIC X(48).
      *     05 FILLER                 PIC X.
      *     05 SQL-OBJECTNAME         PIC X(48).
      *     05 FILLER                 PIC X.
      * * 
      **************************************************************************
      * For IPX/SPX protocol
       01 SQL-NODE-IPXSPX.
      * Fileserver name
           05 SQL-FILESERVER         PIC X(48)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * Object name
           05 SQL-OBJECTNAME         PIC X(48)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.

      * Values for sqlefrce
      * Force Mode (Asynchronous)
       77  SQL-ASYNCH                PIC S9(4) COMP-5 VALUE 0.
      * Force Count (All Users)
       77  SQL-ALL-USERS             PIC S9(4) COMP-5 VALUE -1.

      * Product name
       77  SQL-PRODNAME-SZ           PIC S9(4) COMP-5 VALUE 30.
      *************************************************************************
      * sql_dir_entry data structure
      * This structure is used by the DCS directory APIs.
      * 
      * Table: Fields in the SQL-DIR-ENTRY Structure
      * ----------------------------------------------------------------------
      * |Field Name|Data Type  |Description                                   |
      * |----------|-----------|----------------------------------------------|
      * |STRUCT_ID |SMALLINT   |Structure identifier. Set to SQL_DCS_STR_ID   |
      * |          |           |(defined in sqlenv).                          |
      * |RELEASE   |SMALLINT   |Release version (assigned by the API).        |
      * |CODEPAGE  |SMALLINT   |Code page for comment.                        |
      * |COMMENT   |CHAR(30)   |Optional description of the database.         |
      * |LDB       |CHAR(8)    |Local name of the database; must match        |
      * |          |           |database alias in system database directory.  |
      * |TDB       |CHAR(18)   |Actual name of the database.                  |
      * |AR        |CHAR(32)   |Name of the application client.               |
      * |PARM      |CHAR(512)  |Contains transaction program prefix,          |
      * |          |           |transaction program name, SQLCODE mapping file|
      * |          |           |name, and disconnect and security option.     |
      * |----------|-----------|----------------------------------------------|
      * |Note:                                                                |
      * |The character fields passed in this structure must be null terminated|
      * |or blank filled up to the length of the field.                       |
      * |---------------------------------------------------------------------|
      * 
      * COBOL Structure
      * 
      * * File: sqlenv.cbl
      * 01 SQL-DIR-ENTRY.
      *     05 STRUCT-ID              PIC 9(4) COMP-5.
      *     05 RELEASE-LVL            PIC 9(4) COMP-5.
      *     05 CODEPAGE               PIC 9(4) COMP-5.
      *     05 COMMENT                PIC X(30).
      *     05 FILLER                 PIC X.
      *     05 LDB                    PIC X(8).
      *     05 FILLER                 PIC X.
      *     05 TDB                    PIC X(18).
      *     05 FILLER                 PIC X.
      *     05 AR                     PIC X(32).
      *     05 FILLER                 PIC X.
      *     05 PARM                   PIC X(512).
      *     05 FILLER                 PIC X.
      *     05 FILLER                 PIC X(1).
      * * 
      * 
      **************************************************************************
      * DDCS Directory Entry Data Structure
       01 SQL-DIR-ENTRY.
      * Structure Identifier
           05 STRUCT-ID              PIC 9(4) COMP-5.
      * Release level of entry
           05 RELEASE-LVL            PIC 9(4) COMP-5.
      * Codepage of comment
           05 CODEPAGE               PIC 9(4) COMP-5.
      * Directory entry comment
           05 COMMENT                PIC X(30)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * Local DB name
           05 LDB                    PIC X(8)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * Target (host) DB name
           05 TDB                    PIC X(18)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * AR library name
           05 AR                     PIC X(32)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * Parameter string
           05 PARM                   PIC X(512)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X(1)
                                     USAGE DISPLAY NATIVE.

      * Database Codepage and Territory code info structures

      *************************************************************************
      * sqledbcinfo data structure
      **************************************************************************
       01 SQLEDBCINFO.
      * database codeset
           05 SQLDBCP                PIC X(9)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * database territory
           05 SQLDBCC                PIC X(5)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.

      * V2 Database Codepage and Territory code info structure

      *************************************************************************
      * sqledbcountryinfo data structure
      * This structure is used to provide code set and territory options
      * to the sqlecrea API.
      * 
      * Table: Fields in the SQLEDBTERRITORYINFO Structure
      * -----------------------------------------------------------------------
      * |Field Name   | Data Type | Description                               |
      * ----------------------------------------------------------------------|
      * |SQLDBCODESET | CHAR(9)   | Database code set.                        |
      * ----------------------------------------------------------------------|
      * |SQLDBLOCALE  | CHAR(5)   | Database territory.                       |
      * |---------------------------------------------------------------------|
      * 
      * COBOL Structure
      * 
      * * File: sqlenv.cbl
      * 01 SQLEDBTERRITORYINFO.
      *     05 SQLDBCODESET           PIC X(9).
      *     05 FILLER                 PIC X.
      *     05 SQLDBLOCALE            PIC X(5).
      *     05 FILLER                 PIC X.
      * * 
      **************************************************************************
       01 SQLEDBCOUNTRYINFO.
      * database codeset
           05 SQLDBCODESET           PIC X(9)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * database territory
           05 SQLDBLOCALE            PIC X(5)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.



      * Connection setting structure for use with distributed 
      * unit of work

       01 SQLE-CONN-SETTING.
           05 SQLE-CONN-SETTING-ITEM OCCURS 7 TIMES.
             10 SQLE-CONN-TYPE       PIC S9(4) COMP-5.
             10 SQLE-CONN-VALUE      PIC S9(4) COMP-5.

      * SET CLIENT Information structure for use with sqleseti 
      * and sqleqryi

       01 SQLE-CLIENT-INFO.
           05 SQLE-CLIENT-INFO-ITEM OCCURS 4 TIMES.
             10 SQLE-CLIENT-INFO-TYPE     PIC S9(4) COMP-5.
             10 SQLE-CLIENT-INFO-LENGTH   PIC S9(4) COMP-5.
             10 SQLE-CLIENT-INFO-P-VALUE  USAGE IS POINTER.

      * Database Codepage and Territory code info structure using
      * SQL_CODESET_SIZE and SQL_LOCALE_SIZE

      *************************************************************************
      * sqle_db_territory_info data structure
      **************************************************************************
       01 SQLE-DB-TERRITORY-INFO.
      * database codeset
           05 SQLDBCODESET           PIC X(17)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * database territory
           05 SQLDBLOCALE            PIC X(33)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.



      * Register/Deregister constants and data structures

      * Defines for LOCATION TO REGISTER parameter
       77  SQL-NWBINDERY             PIC S9(4) COMP-5 VALUE 0.

      * Register/deregister info. for NW bindery data structure
      *************************************************************************
      * sqle_reg_nwbindery data structure
      **************************************************************************
       01 SQLE-REG-NWBINDERY.
           05 SQL-UID                PIC X(48)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X(1)
                                     USAGE DISPLAY NATIVE.
           05 SQL-UID-LEN            PIC 9(4) COMP-5.
           05 SQL-PSWD               PIC X(128)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X(1)
                                     USAGE DISPLAY NATIVE.
           05 SQL-PSWD-LEN           PIC 9(4) COMP-5.

      *************************************************************************
      * Start/Stop Database Manager constants and data structures
      **************************************************************************

      * V5 Start Options structure Eye Catcher value
       77  SQLE-STARTOPTID-V51       PIC X(8) value "SQLOPT01"
                                     USAGE DISPLAY NATIVE.


      * V5 Start Database Manager structure
      *************************************************************************
      * sqle_start_options data structure
      **************************************************************************
       01 SQLE-START-OPTIONS.
      * Structure Eye Catcher
           05 SQLOPTID               PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * Profile specified?
           05 SQL-ISPROFILE          PIC 9(9) COMP-5.
      * Profile
           05 SQL-PROFILE            PIC X(235)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * Node number specified?
           05 SQL-ISNODENUM          PIC 9(9) COMP-5.
      * Node number
           05 SQL-NODENUM            PIC S9(4) COMP-5.
           05 FILLER                 PIC X(2)
                                     USAGE DISPLAY NATIVE.
      * Start option
           05 SQL-OPTION             PIC 9(9) COMP-5.
      * Hostname specified?
           05 SQL-ISHOSTNAME         PIC 9(9) COMP-5.
      * Hostname
           05 SQL-HOSTNAME           PIC X(255)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * Port specified?
           05 SQL-ISPORT             PIC 9(9) COMP-5.
      * Port
           05 SQL-PORT               PIC S9(9) COMP-5.
      * Netname specified?
           05 SQL-ISNETNAME          PIC 9(9) COMP-5.
      * Netname
           05 SQL-NETNAME            PIC X(255)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * Addnode tablespace type
           05 SQL-TBLSPACE-TYPE      PIC 9(9) COMP-5.
      * Addnode tablespace node
           05 SQL-TBLSPACE-NODE      PIC S9(4) COMP-5.
           05 FILLER                 PIC X(2)
                                     USAGE DISPLAY NATIVE.
      * Computername specified?
           05 SQL-ISCOMPUTER         PIC 9(9) COMP-5.
      * Computername
           05 SQL-COMPUTER           PIC X(15)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * Logon Account user name
           05 SQL-P-USER-NAME        USAGE IS POINTER.
      * Logon Account password
           05 SQL-P-PASSWORD         USAGE IS POINTER.

      * V5 Stop Database Manager structure
      *************************************************************************
      * sqledbstopopt data structure
      **************************************************************************
       01 SQLEDBSTOPOPT.
      * Profile specified?
           05 SQL-ISPROFILE          PIC 9(9) COMP-5.
      * Profile
           05 SQL-PROFILE            PIC X(235)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * Node number specified?
           05 SQL-ISNODENUM          PIC 9(9) COMP-5.
      * Node number
           05 SQL-NODENUM            PIC S9(4) COMP-5.
           05 FILLER                 PIC X(2)
                                     USAGE DISPLAY NATIVE.
      * Option
           05 SQL-OPTION             PIC 9(9) COMP-5.
      * Caller action
           05 SQL-CALLERAC           PIC 9(9) COMP-5.

      * Add Node data structures

      * V5 Add Node Option structure Eye Catcher value
       77  SQLE-ADDOPTID-V51         PIC X(8) value "SQLADD01"
                                     USAGE DISPLAY NATIVE.


      * Add Node structure
      *************************************************************************
      * sqle_addn_options data structure
      * This structure is used to pass information to the sqleaddn API.
      * 
      * Table: Fields in the SQLE-ADDN-OPTIONS Structure
      * -------------------------------------------------------------------------
      * |Field Name   |Data Type        |Description                            |
      * |-------------|-----------------|---------------------------------------|
      * |SQLADDID     |CHAR             |An "eyecatcher" value which must be    |
      * |             |                 |set to SQLE_ADDOPTID_V51.              |
      * |-------------|-----------------|---------------------------------------|
      * |TBLSPACE_TYPE|sqluint32        |Specifies the type of system temporary |
      * |             |                 |table space definitions to be used for |
      * |             |                 |the node being added. See below for    |
      * |             |                 |values.                                |
      * |-------------|-----------------|---------------------------------------|
      * |TBLSPACE_NODE|SQL_PDB_NODE_TYPE|Specifies the node number from which   |
      * |             |                 |the system temporary table space       |
      * |             |                 |definitions should be obtained. The    |
      * |             |                 |node number must exist in the          |
      * |             |                 |db2nodes.cfg file, and is only used    |
      * |             |                 |if the tblspace_type field is set to   |
      * |             |                 |SQLE_TABLESPACES_LIKE_NODE.            |
      * |-------------|-----------------|---------------------------------------|
      * 
      * Valid values for TBLSPACE_TYPE (defined in sqlenv) are:
      * 
      * - SQLE_TABLESPACES_NONE
      * Do not create any system temporary table spaces. 
      * 
      * - SQLE_TABLESPACES_LIKE_NODE
      * The containers for the system temporary table spaces should be the
      * same as those for the specified node. 
      * 
      * - SQLE_TABLESPACES_LIKE_CATALOG
      * The containers for the system temporary table spaces should be the
      * same as those for the catalog node of each database. 
      * 
      * COBOL Structure
      * 
      * * File: sqlenv.cbl
      * 01 SQLE-ADDN-OPTIONS.
      *     05 SQLADDID               PIC X(8).
      *     05 SQL-TBLSPACE-TYPE      PIC 9(9) COMP-5.
      *     05 SQL-TBLSPACE-NODE      PIC S9(4) COMP-5.
      *     05 FILLER                 PIC X(2).
      * * 
      * 
      **************************************************************************
       01 SQLE-ADDN-OPTIONS.
      * Structure Eye Catcher
           05 SQLADDID               PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * Temporary Tablespace Type
           05 SQL-TBLSPACE-TYPE      PIC 9(9) COMP-5.
      * Temporary Tablespace Node
           05 SQL-TBLSPACE-NODE      PIC S9(4) COMP-5.
           05 FILLER                 PIC X(2)
                                     USAGE DISPLAY NATIVE.

      * GENERIC INTERFACES

      * SQL Return Codes in SQLCODE for Environment Commands

      * Request is still executing
       77  SQLE-RC-STILL-EXECUTING   PIC S9(4) COMP-5 VALUE 16.
      * Connect to other DB not allowed
       77  SQLE-RC-INLUW             PIC S9(4) COMP-5 VALUE -752.
      * Only SBCS data allowed
       77  SQLE-RC-W863              PIC S9(4) COMP-5 VALUE 863.

      * Agent heap too small
       77  SQLE-RC-E953              PIC S9(4) COMP-5 VALUE -953.
      * Requestor comm heap too small
       77  SQLE-RC-E957              PIC S9(4) COMP-5 VALUE -957.
      * Server comm heap too small
       77  SQLE-RC-E959              PIC S9(4) COMP-5 VALUE -959.
      * Rqstr remote svcs heap too small
       77  SQLE-RC-E961              PIC S9(4) COMP-5 VALUE -961.
      * Svr remote svcs heap too small
       77  SQLE-RC-E962              PIC S9(4) COMP-5 VALUE -962.
      * Application control shared memory set cannot be allocated
       77  SQLE-RC-NO-APP-CTRL-SEG   PIC S9(4) COMP-5 VALUE -987.

      * New log path is invalid
       77  SQLE-RC-INVNEWLOGP        PIC S9(4) COMP-5 VALUE 993.
      * Current log path is invalid
       77  SQLE-RC-INVLOGP           PIC S9(4) COMP-5 VALUE 995.

      * Invalid alias
       77  SQLE-RC-INVALIAS          PIC S9(4) COMP-5 VALUE -1000.
      * Invalid database name
       77  SQLE-RC-INVDBNAME         PIC S9(4) COMP-5 VALUE -1001.
      * Invalid drive
       77  SQLE-RC-INVDRIVE          PIC S9(4) COMP-5 VALUE -1002.

      * Invalid password - OS/2
       77  SQLE-RC-INVPSW-DB2OS2     PIC S9(4) COMP-5 VALUE -1003.
      * Invalid password - NT
       77  SQLE-RC-INVPSW-DB2NT      PIC S9(4) COMP-5 VALUE -1003.
      * Invalid password - DOS
       77  SQLE-RC-INVPSW-DB2DOS     PIC S9(4) COMP-5 VALUE -1003.
      * Invalid password - Windows
       77  SQLE-RC-INVPSW-DB2WIN     PIC S9(4) COMP-5 VALUE -1003.
      * Invalid password - Mac
       77  SQLE-RC-INVPSW-DB2MAC     PIC S9(4) COMP-5 VALUE -1003.
      * Invalid password - AIX
       77  SQLE-RC-INVPSW-DB2AIX     PIC S9(9) COMP-5 VALUE -10002.

       77  SQLE-RC-INVPSW            PIC S9(9) COMP-5 VALUE -10002.

      * Insuf storage on file system
       77  SQLE-RC-INSSTOR           PIC S9(4) COMP-5 VALUE -1004.
      * Duplicate alias
       77  SQLE-RC-DUPALIAS          PIC S9(4) COMP-5 VALUE -1005.
      * Appl code page does not match db
       77  SQLE-RC-WRONGCODEPG       PIC S9(4) COMP-5 VALUE -1006.
      * Invalid new password
       77  SQLE-RC-INV-NEWPSW        PIC S9(4) COMP-5 VALUE -1008.
      * Invalid remote command
       77  SQLE-RC-INVREMOTE         PIC S9(4) COMP-5 VALUE -1009.

      * Invalid type
       77  SQLE-RC-INVTYPE           PIC S9(4) COMP-5 VALUE -1010.
      * No drive for indirect entry
       77  SQLE-RC-NODRIVE           PIC S9(4) COMP-5 VALUE -1011.
      * No nodename for remote entry
       77  SQLE-RC-NONODE            PIC S9(4) COMP-5 VALUE -1012.
      * Alias or database name not found
       77  SQLE-RC-NODB              PIC S9(4) COMP-5 VALUE -1013.
      * No more entries
       77  SQLE-RC-NOMORE            PIC S9(4) COMP-5 VALUE 1014.
      * Database needs restart
       77  SQLE-RC-DB-RESTART        PIC S9(4) COMP-5 VALUE -1015.
      * Invalid local_lu alias
       77  SQLE-RC-INVLLU            PIC S9(4) COMP-5 VALUE -1016.
      * Invalid mode
       77  SQLE-RC-INVMODE           PIC S9(4) COMP-5 VALUE -1017.
      * Duplicate node name
       77  SQLE-RC-DUPNODE           PIC S9(4) COMP-5 VALUE -1018.
      * Invalid node name
       77  SQLE-RC-INVNODE           PIC S9(4) COMP-5 VALUE -1019.

      * Node could not be cataloged
       77  SQLE-RC-MAXNODE           PIC S9(4) COMP-5 VALUE -1020.
      * Nodename not found
       77  SQLE-RC-NOTNODE           PIC S9(4) COMP-5 VALUE -1021.

      * Insuf system resources - OS/2
       77  SQLE-RC-INSSYS-DB2OS2     PIC S9(4) COMP-5 VALUE -1022.
      * Insuf system resources - NT
       77  SQLE-RC-INSSYS-DB2NT      PIC S9(4) COMP-5 VALUE -1022.
      * Insuf system resources - DOS
       77  SQLE-RC-INSSYS-DB2DOS     PIC S9(4) COMP-5 VALUE -1022.
      * Insuf system resources - Windows
       77  SQLE-RC-INSSYS-DB2WIN     PIC S9(4) COMP-5 VALUE -1022.
      * Insuf system resources - Macintosh
       77  SQLE-RC-INSSYS-DB2MAC     PIC S9(4) COMP-5 VALUE -1022.
      * Insuf system resources - AIX
       77  SQLE-RC-INSSYS-DB2AIX     PIC S9(9) COMP-5 VALUE -10003.

       77  SQLE-RC-INSSYS            PIC S9(9) COMP-5 VALUE -10003.

      * Communication conversation failed
       77  SQLE-RC-NOCONV            PIC S9(4) COMP-5 VALUE -1023.
      * No database connection exists
       77  SQLE-RC-NOSUDB            PIC S9(4) COMP-5 VALUE -1024.
      * Databases are active
       77  SQLE-RC-DBACT             PIC S9(4) COMP-5 VALUE -1025.
      * Database manager already started
       77  SQLE-RC-INVSTRT           PIC S9(4) COMP-5 VALUE -1026.
      * Node directory not found
       77  SQLE-RC-NONODEDIR         PIC S9(4) COMP-5 VALUE -1027.
      * Partner lu not specified
       77  SQLE-RC-INVRLU            PIC S9(4) COMP-5 VALUE -1029.

      * Database directory is full
       77  SQLE-RC-MAXDB             PIC S9(4) COMP-5 VALUE -1030.
      * Database directory not found
       77  SQLE-RC-NODBDIR           PIC S9(4) COMP-5 VALUE -1031.
      * Database manager not started
       77  SQLE-RC-NOSTARTG          PIC S9(4) COMP-5 VALUE -1032.
      * Database directory being updated
       77  SQLE-RC-DIRBUSY           PIC S9(4) COMP-5 VALUE -1033.
      * Database is damaged
       77  SQLE-RC-DBBAD             PIC S9(4) COMP-5 VALUE -1034.
      * Database already in use
       77  SQLE-RC-DB-INUSE          PIC S9(4) COMP-5 VALUE -1035.
      * Database file error
       77  SQLE-RC-FILEDB            PIC S9(4) COMP-5 VALUE -1036.
      * No entry in Node directory
       77  SQLE-RC-NODE-DIR-EMPTY    PIC S9(4) COMP-5 VALUE 1037.
      * Node directory file error
       77  SQLE-RC-FILENODE          PIC S9(4) COMP-5 VALUE -1038.

      * Directory file error - OS/2
       77  SQLE-RC-FILEDIR-DB2OS2    PIC S9(4) COMP-5 VALUE -1039.
      * Directory file error - NT
       77  SQLE-RC-FILEDIR-DB2NT     PIC S9(4) COMP-5 VALUE -1039.
      * Directory file error - DOS
       77  SQLE-RC-FILEDIR-DB2DOS    PIC S9(4) COMP-5 VALUE -1039.
      * Directory file error - Windows
       77  SQLE-RC-FILEDIR-DB2WIN    PIC S9(4) COMP-5 VALUE -1039.
      * Directory file error - Mac
       77  SQLE-RC-FILEDIR-DB2MAC    PIC S9(4) COMP-5 VALUE -1039.
      * Directory file error - AIX
       77  SQLE-RC-FILEDIR-DB2AIX    PIC S9(9) COMP-5 VALUE -10004.

       77  SQLE-RC-FILEDIR           PIC S9(9) COMP-5 VALUE -10004.

      * Max number of applications reached
       77  SQLE-RC-MAXAPPLS          PIC S9(4) COMP-5 VALUE -1040.
      * Max number of databases started
       77  SQLE-RC-MAXDBS            PIC S9(4) COMP-5 VALUE -1041.
      * System error
       77  SQLE-RC-SYSERR            PIC S9(4) COMP-5 VALUE -1042.
      * Catalog bootstrap failure
       77  SQLE-RC-CATBOOT           PIC S9(4) COMP-5 VALUE -1043.
      * Request interrupted by ctrl+break
       77  SQLE-RC-INTRRPT           PIC S9(4) COMP-5 VALUE -1044.
      * Invalid level of indirection
       77  SQLE-RC-INVINDIR          PIC S9(4) COMP-5 VALUE -1045.
      * Invalid userid
       77  SQLE-RC-INVAUTHID         PIC S9(4) COMP-5 VALUE -1046.
      * Appl already connect to another db
       77  SQLE-RC-APCONN            PIC S9(4) COMP-5 VALUE -1047.

      * Invalid use specified - OS/2
       77  SQLE-RC-USEINVALID-DB2OS2 PIC S9(4) COMP-5 VALUE -1048.
      * Invalid use specified - NT
       77  SQLE-RC-USEINVALID-DB2NT  PIC S9(4) COMP-5 VALUE -1048.
      * Invalid use specified - DOS
       77  SQLE-RC-USEINVALID-DB2DOS PIC S9(4) COMP-5 VALUE -1048.
      * Invalid use specified - Windows
       77  SQLE-RC-USEINVALID-DB2WIN PIC S9(4) COMP-5 VALUE -1048.
      * Invalid use specified - MacOS
       77  SQLE-RC-USEINVALID-DB2MAC PIC S9(4) COMP-5 VALUE -1048.
      * Invalid use specified - AIX
       77  SQLE-RC-USEINVALID-DB2AIX PIC S9(9) COMP-5 VALUE -10005.

       77  SQLE-RC-USEINVALID        PIC S9(9) COMP-5 VALUE -10005.

      * Appl state in error
       77  SQLE-RC-APPSERR           PIC S9(4) COMP-5 VALUE -900.

      * Cannot uncatalog 'Home' database
       77  SQLE-RC-UNCHOME           PIC S9(4) COMP-5 VALUE -1050.
      * Db direct. drive does not exist
       77  SQLE-RC-NODIRDRV          PIC S9(4) COMP-5 VALUE -1051.
      * Database drive does not exist
       77  SQLE-RC-NODBDRV           PIC S9(4) COMP-5 VALUE -1052.
      * Interrupt already in progress
       77  SQLE-RC-INTBUSY           PIC S9(4) COMP-5 VALUE -1053.
      * Commit in progress - no int's
       77  SQLE-RC-COMMINP           PIC S9(4) COMP-5 VALUE -1054.
      * Rollback in progress - no int's
       77  SQLE-RC-ROLLINP           PIC S9(4) COMP-5 VALUE -1055.
      * Cannot be interrupted - no int's
       77  SQLE-RC-NOINTER           PIC S9(4) COMP-5 VALUE -1360.
      * Windows Client Execution Timeout
       77  SQLE-RC-TIMEOUT           PIC S9(4) COMP-5 VALUE 1361.
      * Maximum allowable scans exceeded
       77  SQLE-RC-MAXSCAN           PIC S9(4) COMP-5 VALUE -1056.
      * No entries in directory
       77  SQLE-RC-NODENTRY          PIC S9(4) COMP-5 VALUE 1057.
      * Invalid input handle
       77  SQLE-RC-INVHAND           PIC S9(4) COMP-5 VALUE -1058.
      * Open scan not issued
       77  SQLE-RC-NOSCAN            PIC S9(4) COMP-5 VALUE -1059.

      * User lacks connect privilege
       77  SQLE-RC-NOCONNECT         PIC S9(4) COMP-5 VALUE -1060.
      * User lacks connect privilege for Quiesced Db
       77  SQLE-RC-QSNOCONNECT       PIC S9(9) COMP-5 VALUE -20157.
      * RESTART was successful, but indoubt transactions exist
       77  SQLE-RC-RESTART-WITH-INDOUBTS PIC S9(4) COMP-5 VALUE 1061.
      * Database path not found
       77  SQLE-RC-BADPATH           PIC S9(4) COMP-5 VALUE -1062.
      * Database manager started OK
       77  SQLE-RC-START-OK          PIC S9(4) COMP-5 VALUE -1063.
      * Database manager stopped OK
       77  SQLE-RC-STOP-OK           PIC S9(4) COMP-5 VALUE -1064.
      * N utilities not bound
       77  SQLE-RC-DB-BADBINDS       PIC S9(4) COMP-5 VALUE 1065.

      * Message file not found - OS/2
       77  SQLE-RC-NOMSG-DB2OS2      PIC S9(4) COMP-5 VALUE -1068.
      * Message file not found - NT
       77  SQLE-RC-NOMSG-DB2NT       PIC S9(4) COMP-5 VALUE -1068.
      * Message file not found - DOS
       77  SQLE-RC-NOMSG-DB2DOS      PIC S9(4) COMP-5 VALUE -1068.
      * Message file not found - Windows
       77  SQLE-RC-NOMSG-DB2WIN      PIC S9(4) COMP-5 VALUE -1068.
      * Message file not found - MacOS
       77  SQLE-RC-NOMSG-DB2MAC      PIC S9(4) COMP-5 VALUE -1068.
      * Message file not found - AIX
       77  SQLE-RC-NOMSG-DB2AIX      PIC S9(9) COMP-5 VALUE -10007.

       77  SQLE-RC-NOMSG             PIC S9(9) COMP-5 VALUE -10007.

      * DB invalid type for Drop
       77  SQLE-RC-INVDROP           PIC S9(4) COMP-5 VALUE -1069.

      * Invalid Database Name pointer
       77  SQLE-RC-INVDBNAME-PTR     PIC S9(4) COMP-5 VALUE -1070.
      * Invalid Alias pointer
       77  SQLE-RC-INVALIAS-PTR      PIC S9(4) COMP-5 VALUE -1071.
      * Resources in inconsistent state
       77  SQLE-RC-RESOURCE-ERROR    PIC S9(4) COMP-5 VALUE -1072.
      * Invalid Node Directory release
       77  SQLE-RC-BAD-ND-REL        PIC S9(4) COMP-5 VALUE -1073.
      * Invalid Password pointer
       77  SQLE-RC-INVPSW-PTR        PIC S9(4) COMP-5 VALUE -1074.
      * Invalid Comment pointer
       77  SQLE-RC-INVCOMM-PTR       PIC S9(4) COMP-5 VALUE -1075.
      * Invalid Count pointer
       77  SQLE-RC-INVCNT-PTR        PIC S9(4) COMP-5 VALUE -1076.
      * Invalid Handle pointer
       77  SQLE-RC-INVHAND-PTR       PIC S9(4) COMP-5 VALUE -1077.
      * Invalid Buffer pointer
       77  SQLE-RC-INVBUFF-PTR       PIC S9(4) COMP-5 VALUE -1078.
      * Invalid Node pointer
       77  SQLE-RC-INVNODE-PTR       PIC S9(4) COMP-5 VALUE -1079.
      * Invalid Userid pointer
       77  SQLE-RC-INVUSERID-PTR     PIC S9(4) COMP-5 VALUE -1150.
      * Invalid Parms pointer
       77  SQLE-RC-INVPARM-PTR       PIC S9(4) COMP-5 VALUE -1151.

      * Invalid Local Lu pointer
       77  SQLE-RC-INVLLU-PTR        PIC S9(4) COMP-5 VALUE -1080.
      * Invalid Remote Lu pointer
       77  SQLE-RC-INVRLU-PTR        PIC S9(4) COMP-5 VALUE -1081.
      * Invalid Mode pointer
       77  SQLE-RC-INVMODE-PTR       PIC S9(4) COMP-5 VALUE -1082.
      * Bad Database Description Block
       77  SQLE-RC-BAD-DBDB          PIC S9(4) COMP-5 VALUE -1083.
      * Cannot Allocate Kernel Segments
       77  SQLE-RC-KSEGSFAIL         PIC S9(4) COMP-5 VALUE -1084.
      * Cannot Allocate Application heap
       77  SQLE-RC-APPHEAPFAIL       PIC S9(4) COMP-5 VALUE -1085.
      * Unexpected OS/2 error
       77  SQLE-RC-OS2ERROR          PIC S9(4) COMP-5 VALUE -1086.
      * Bind list could not be opened
       77  SQLE-RC-BIND-LIST         PIC S9(4) COMP-5 VALUE 1087.
      * Error occurred during bind
       77  SQLE-RC-BIND-ERROR        PIC S9(4) COMP-5 VALUE 1088.
      * Binding was interrupted
       77  SQLE-RC-BIND-INTRRPT      PIC S9(4) COMP-5 VALUE 1089.

      * Release number of appl is invalid
       77  SQLE-RC-BAD-APP-REL       PIC S9(4) COMP-5 VALUE -1090.
      * Release number of database bad
       77  SQLE-RC-BAD-DB-REL        PIC S9(4) COMP-5 VALUE -1091.

      * Authorization error
       77  SQLE-RC-INSAUTH           PIC S9(4) COMP-5 VALUE -1092.
      * User not logged on
       77  SQLE-RC-NOLOGON           PIC S9(4) COMP-5 VALUE -1093.
      * Node directory being updated
       77  SQLE-RC-NDBUSY            PIC S9(4) COMP-5 VALUE -1094.
      * Max node scans open
       77  SQLE-RC-MAX-NDSCAN        PIC S9(4) COMP-5 VALUE -1095.
      * Invalid type for requester node
       77  SQLE-RC-REQTYPE           PIC S9(4) COMP-5 VALUE -1096.
      * Node not found for remote db
       77  SQLE-RC-NODERR            PIC S9(4) COMP-5 VALUE -1097.
      * Appl is already connected to db
       77  SQLE-RC-APCONN-SAME       PIC S9(4) COMP-5 VALUE -1098.

      * Write protect error on diskette
       77  SQLE-RC-WRPROT-ERR-DB2OS2 PIC S9(4) COMP-5 VALUE -1099.
      * Write protect error on diskette
       77  SQLE-RC-WRPROT-ERR-DB2NT  PIC S9(4) COMP-5 VALUE -1099.
      * Write protect error on diskette
       77  SQLE-RC-WRPROT-ERR-DB2DOS PIC S9(4) COMP-5 VALUE -1099.
      * Write protect error on diskette
       77  SQLE-RC-WRPROT-ERR-DB2WIN PIC S9(4) COMP-5 VALUE -1099.
      * Write protect error on diskette
       77  SQLE-RC-WRPROT-ERR-DB2MAC PIC S9(4) COMP-5 VALUE -1099.
      * Write protect error on filesystem
       77  SQLE-RC-WRPROT-ERR-DB2AIX PIC S9(9) COMP-5 VALUE -10021.

       77  SQLE-RC-WRPROT-ERR        PIC S9(9) COMP-5 VALUE -10021.

      * Node not cataloged for database
       77  SQLE-RC-NODE-WARN         PIC S9(4) COMP-5 VALUE 1100.
      * Remote communications error
       77  SQLE-RC-REMCONN-ERR       PIC S9(4) COMP-5 VALUE -1101.
      * No database name provided in call
       77  SQLE-RC-MIG-NODB          PIC S9(4) COMP-5 VALUE -1102.
      * Migration was successful
       77  SQLE-RC-MIG-OK            PIC S9(4) COMP-5 VALUE 1103.
      * Invalid program name pointer
       77  SQLE-RC-INVPROG-PTR       PIC S9(4) COMP-5 VALUE -1104.

      * Invalid disconnect from database
       77  SQLE-RC-INV-SPDB-DB2OS2   PIC S9(4) COMP-5 VALUE -1105.
      * Invalid disconnect from database
       77  SQLE-RC-INV-SPDB-DB2NT    PIC S9(4) COMP-5 VALUE -1105.
      * Invalid disconnect from database
       77  SQLE-RC-INV-SPDB-DB2DOS   PIC S9(4) COMP-5 VALUE -1105.
      * Invalid disconnect from database
       77  SQLE-RC-INV-SPDB-DB2WIN   PIC S9(4) COMP-5 VALUE -1105.
      * Invalid disconnect from database
       77  SQLE-RC-INV-SPDB-DB2MAC   PIC S9(4) COMP-5 VALUE -1105.
      * Invalid disconnect from database
       77  SQLE-RC-INV-SPDB-DB2AIX   PIC S9(9) COMP-5 VALUE -10017.

       77  SQLE-RC-INV-SPDB          PIC S9(9) COMP-5 VALUE -10017.

      * Function could not be executed
       77  SQLE-RC-INVALID-PROC-DB2OS2 PIC S9(4) COMP-5 VALUE -1106.
      * Function could not be executed
       77  SQLE-RC-INVALID-PROC-DB2NT PIC S9(4) COMP-5 VALUE -1106.
      * Function could not be executed
       77  SQLE-RC-INVALID-PROC-DB2DOS PIC S9(4) COMP-5 VALUE -1106.
      * Function could not be executed
       77  SQLE-RC-INVALID-PROC-DB2WIN PIC S9(4) COMP-5 VALUE -1106.
      * Function could not be executed
       77  SQLE-RC-INVALID-PROC-DB2MAC PIC S9(4) COMP-5 VALUE -1106.
      * Function could not be executed
       77  SQLE-RC-INVALID-PROC-DB2AIX PIC S9(9) COMP-5 VALUE -10010.

       77  SQLE-RC-INVALID-PROC      PIC S9(9) COMP-5 VALUE -10010.

      * Program interrupted - OS/2
       77  SQLE-RC-INTRP-PROC-DB2OS2 PIC S9(4) COMP-5 VALUE -1107.
      * Program interrupted - NT
       77  SQLE-RC-INTRP-PROC-DB2NT  PIC S9(4) COMP-5 VALUE -1107.
      * Program interrupted - DOS
       77  SQLE-RC-INTRP-PROC-DB2DOS PIC S9(4) COMP-5 VALUE -1107.
      * Program interrupted - Windows
       77  SQLE-RC-INTRP-PROC-DB2WIN PIC S9(4) COMP-5 VALUE -1107.
      * Program interrupted - MacOS
       77  SQLE-RC-INTRP-PROC-DB2MAC PIC S9(4) COMP-5 VALUE -1107.
      * Program interrupted - AIX
       77  SQLE-RC-INTRP-PROC-DB2AIX PIC S9(9) COMP-5 VALUE -10011.

       77  SQLE-RC-INTRP-PROC        PIC S9(9) COMP-5 VALUE -10010.

      * System error on library load
       77  SQLE-RC-SYSERR-PROC-DB2OS2 PIC S9(4) COMP-5 VALUE -1108.
      * System error on library load
       77  SQLE-RC-SYSERR-PROC-DB2NT PIC S9(4) COMP-5 VALUE -1108.
      * System error on library load
       77  SQLE-RC-SYSERR-PROC-DB2DOS PIC S9(4) COMP-5 VALUE -1108.
      * System error on library load
       77  SQLE-RC-SYSERR-PROC-DB2WIN PIC S9(4) COMP-5 VALUE -1108.
      * System error on library load
       77  SQLE-RC-SYSERR-PROC-DB2MAC PIC S9(4) COMP-5 VALUE -1108.
      * System error on library load
       77  SQLE-RC-SYSERR-PROC-DB2AIX PIC S9(9) COMP-5 VALUE -10012.

       77  SQLE-RC-SYSERR-PROC       PIC S9(9) COMP-5 VALUE -10012.

      * Library could not be loaded
       77  SQLE-RC-NOFILE-PROC-DB2OS2 PIC S9(4) COMP-5 VALUE -1109.
      * Library could not be loaded
       77  SQLE-RC-NOFILE-PROC-DB2NT PIC S9(4) COMP-5 VALUE -1109.
      * Library could not be loaded
       77  SQLE-RC-NOFILE-PROC-DB2DOS PIC S9(4) COMP-5 VALUE -1109.
      * Library could not be loaded
       77  SQLE-RC-NOFILE-PROC-DB2WIN PIC S9(4) COMP-5 VALUE -1109.
      * Library could not be loaded
       77  SQLE-RC-NOFILE-PROC-DB2MAC PIC S9(4) COMP-5 VALUE -1109.
      * Library could not be loaded
       77  SQLE-RC-NOFILE-PROC-DB2AIX PIC S9(9) COMP-5 VALUE -10013.

       77  SQLE-RC-NOFILE-PROC       PIC S9(9) COMP-5 VALUE -10013.

      * Program error
       77  SQLE-RC-ERROR-PROC        PIC S9(4) COMP-5 VALUE -1110.

      * Invalid DARI prog name format
       77  SQLE-RC-BADPGN-PROC-DB2OS2 PIC S9(4) COMP-5 VALUE -1111.
      * Invalid DARI prog name format
       77  SQLE-RC-BADPGN-PROC-DB2NT PIC S9(4) COMP-5 VALUE -1111.
      * Invalid DARI prog name format
       77  SQLE-RC-BADPGN-PROC-DB2DOS PIC S9(4) COMP-5 VALUE -1111.
      * Invalid DARI prog name format
       77  SQLE-RC-BADPGN-PROC-DB2WIN PIC S9(4) COMP-5 VALUE -1111.
      * Invalid DARI prog name format
       77  SQLE-RC-BADPGN-PROC-DB2MAC PIC S9(4) COMP-5 VALUE -1111.
      * Invalid DARI prog name format
       77  SQLE-RC-BADPGN-PROC-DB2AIX PIC S9(9) COMP-5 VALUE -10014.

       77  SQLE-RC-BADPGN-PROC       PIC S9(9) COMP-5 VALUE -10014.

      * Insuf memory to load lib
       77  SQLE-RC-INSMEM-PROC-DB2OS2 PIC S9(4) COMP-5 VALUE -1112.
      * Insuf memory to load lib
       77  SQLE-RC-INSMEM-PROC-DB2NT PIC S9(4) COMP-5 VALUE -1112.
      * Insuf memory to load lib
       77  SQLE-RC-INSMEM-PROC-DB2DOS PIC S9(4) COMP-5 VALUE -1112.
      * Insuf memory to load lib
       77  SQLE-RC-INSMEM-PROC-DB2WIN PIC S9(4) COMP-5 VALUE -1112.
      * Insuf memory to load lib
       77  SQLE-RC-INSMEM-PROC-DB2MAC PIC S9(4) COMP-5 VALUE -1112.
      * Insuf memory to load lib
       77  SQLE-RC-INSMEM-PROC-DB2AIX PIC S9(9) COMP-5 VALUE -10015.

       77  SQLE-RC-INSMEM-PROC       PIC S9(9) COMP-5 VALUE -10015.

      * Data type in output SQLDA changed
       77  SQLE-RC-SQLDA-DATATYPE    PIC S9(4) COMP-5 VALUE -1113.
      * Data length in output SQLDA changed
       77  SQLE-RC-SQLDA-LENGTH      PIC S9(4) COMP-5 VALUE -1114.
      * Num of sqlvars changed in SQLDA
       77  SQLE-RC-SQLDA-VARS        PIC S9(4) COMP-5 VALUE -1115.
      * Backup pending
       77  SQLE-RC-BKP-PEND          PIC S9(4) COMP-5 VALUE -1116.
      * Roll forward pending
       77  SQLE-RC-ROLLFWD-PEND      PIC S9(4) COMP-5 VALUE -1117.
      * Need to rerun the Backup process
       77  SQLE-RC-BKP-INPROG        PIC S9(4) COMP-5 VALUE -1118.
      * Need to rerun the Restore process
       77  SQLE-RC-RST-INPROG        PIC S9(4) COMP-5 VALUE -1119.
      * Need to rerun either Backup or Restore process
       77  SQLE-RC-BR-INPROG         PIC S9(4) COMP-5 VALUE -1120.

      * Invalid Node structure pointer
       77  SQLE-RC-INVNODESTR-PTR    PIC S9(4) COMP-5 VALUE -1121.
      * Invalid Protocol structure pointer
       77  SQLE-RC-INVPROTOCOL-PTR   PIC S9(4) COMP-5 VALUE -1122.
      * Invalid protocol type
       77  SQLE-RC-INVPROTOCOL       PIC S9(4) COMP-5 VALUE -1123.
      * Invalid remote workstation name
       77  SQLE-RC-INVRNNAME         PIC S9(4) COMP-5 VALUE -1124.
      * Invalid adapter number
       77  SQLE-RC-INVADAPTER        PIC S9(4) COMP-5 VALUE -1125.
      * Invalid network id
       77  SQLE-RC-INVNETID          PIC S9(4) COMP-5 VALUE -1126.
      * Invalid real partner LU name
       77  SQLE-RC-INVPLU            PIC S9(4) COMP-5 VALUE -1127.

      * Insuf system resources for DARI
       77  SQLE-RC-DARI-INSSYS       PIC S9(4) COMP-5 VALUE -1129.
      * Max DARI process limit reached
       77  SQLE-RC-DARI-MAXDARI      PIC S9(4) COMP-5 VALUE -1130.
      * DARI process abnormally terminated
       77  SQLE-RC-DARI-ABEND        PIC S9(4) COMP-5 VALUE -1131.
      * Invalid DB2 request in DARI
       77  SQLE-RC-DARI-INV-RQST     PIC S9(4) COMP-5 VALUE -1132.
      * SQLVAR's sqldata or sqlind ptrs were altered
       77  SQLE-RC-DARI-VAR-POINTER-CHG PIC S9(4) COMP-5 VALUE -1133.
      * DB2 request is not allowed when DB auth is client
       77  SQLE-RC-DARI-RQST-AUTH-ERR PIC S9(4) COMP-5 VALUE -1134.
      * Invalid numsegs on create db
       77  SQLE-RC-BAD-NUMSEGS       PIC S9(4) COMP-5 VALUE -1135.
      * Invalid extSize on create db
       77  SQLE-RC-BAD-EXTSIZE       PIC S9(4) COMP-5 VALUE -1136.
      * Mounted Segment Directories on a drop database request
       77  SQLE-RC-MOUNTED-SEGS      PIC S9(4) COMP-5 VALUE -1137.

      * Deadlocks event monitor not created during create db
       77  SQLE-RC-WARN-DLMON        PIC S9(4) COMP-5 VALUE 1187.

      * Failed to drop db2look operation table/view
      * SYSTOOLS.DB2LOOK_INFO/SYSTOOLS.DB2LOOK_INOF_V during database
      * migration
       77  SQLE-RC-WARN-DB2LK        PIC S9(4) COMP-5 VALUE 1243.

      * API or command option has an invalid value
       77  SQLE-RC-INVALID-VALUE     PIC S9(4) COMP-5 VALUE -1197.

      * Invalid object specified
       77  SQLE-RC-INVOS-OBJ         PIC S9(4) COMP-5 VALUE -1200.
      * Invalid status specified
       77  SQLE-RC-INVOS-STAT        PIC S9(4) COMP-5 VALUE -1201.
      * Status has not been collected
       77  SQLE-RC-INVOS-NOSTAT      PIC S9(4) COMP-5 VALUE -1202.
      * No users connected to database
       77  SQLE-RC-INVOS-NOUSER      PIC S9(4) COMP-5 VALUE -1203.
      * Active codepage is not supported
       77  SQLE-RC-UNSUPP-CODEPG     PIC S9(4) COMP-5 VALUE -1204.

      * Invalid territory information
       77  SQLE-RC-INV-CNTRYINFO-DB2OS2 PIC S9(4) COMP-5 VALUE -1205.
      * Invalid territory information
       77  SQLE-RC-INV-CNTRYINFO-DB2NT PIC S9(4) COMP-5 VALUE -1205.
      * Invalid territory information
       77  SQLE-RC-INV-CNTRYINFO-DB2DOS PIC S9(4) COMP-5 VALUE -1205.
      * Invalid territory information
       77  SQLE-RC-INV-CNTRYINFO-DB2WIN PIC S9(4) COMP-5 VALUE -1205.
      * Invalid territory information
       77  SQLE-RC-INV-CNTRYINFO-DB2MAC PIC S9(4) COMP-5 VALUE -1205.
      * Invalid territory information
       77  SQLE-RC-INV-CNTRYINFO-DB2AIX PIC S9(4) COMP-5 VALUE -1205.

       77  SQLE-RC-INV-CNTRYINFO     PIC S9(4) COMP-5 VALUE -1205.

      * Invalid Computer Name
       77  SQLE-RC-INV-COMPUTERNAME  PIC S9(4) COMP-5 VALUE -1211.
      * Invalid Instance Name
       77  SQLE-RC-INV-INSTANCENAME  PIC S9(4) COMP-5 VALUE -1212.
      * Invalid Change Password LU
       77  SQLE-RC-INVCHGPWDLU       PIC S9(4) COMP-5 VALUE -1213.
      * Invalid Transaction Pgm Name
       77  SQLE-RC-INVTPNAME         PIC S9(4) COMP-5 VALUE -1214.
      * Invalid LAN Adapter Addr
       77  SQLE-RC-INVLANADDRESS     PIC S9(4) COMP-5 VALUE -1215.
      * DB2 Shared Memory Set alloc failed
       77  SQLE-RC-NO-SHRD-SEG       PIC S9(4) COMP-5 VALUE -1220.
      * ASL heap cannot be allocated
       77  SQLE-RC-NO-ASL-HEAP       PIC S9(4) COMP-5 VALUE -1221.
      * ASL heap is too small
       77  SQLE-RC-ASL-TOO-SMALL     PIC S9(4) COMP-5 VALUE -1222.
      * No more agents available
       77  SQLE-RC-NO-AGENT-AVAIL    PIC S9(4) COMP-5 VALUE -1223.
      * DB2 agent not active
       77  SQLE-RC-AGENT-GONE        PIC S9(4) COMP-5 VALUE -1224.
      * Op. Sys. couldn't spawn a process
       77  SQLE-RC-PROC-LIMIT        PIC S9(4) COMP-5 VALUE -1225.
      * Max number of coords reached
       77  SQLE-RC-MAXCOORDS         PIC S9(4) COMP-5 VALUE -1226.
      * Drop database warning
       77  SQLE-RC-DROPDB-WARN       PIC S9(4) COMP-5 VALUE 1228.

      * At least one agent not forced
       77  SQLE-RC-AGENT-NOT-FORCED  PIC S9(4) COMP-5 VALUE 1230.
      * Invalid Force Users count
       77  SQLE-RC-INVCOUNT          PIC S9(4) COMP-5 VALUE -1231.
      * Invalid Force Users mode
       77  SQLE-RC-INVFRCE-MODE      PIC S9(4) COMP-5 VALUE -1232.

      * Invalid TableSpace descriptor
       77  SQLE-RC-INV-TBS-DESC      PIC S9(4) COMP-5 VALUE -1241.

      * Cannot set connection options - existing connections
       77  SQLE-RC-NO-SETCONNOPT     PIC S9(4) COMP-5 VALUE -1246.

      * db2uexit file not found
       77  SQLE-RC-NOUEXIT           PIC S9(4) COMP-5 VALUE -1267.

       77  SQLC-RC-NPIPE-BROKEN      PIC S9(4) COMP-5 VALUE -1281.
       77  SQLC-RC-NPIPE-BUSY        PIC S9(4) COMP-5 VALUE -1282.
       77  SQLC-RC-NPIPE-PIPE-INUSE  PIC S9(4) COMP-5 VALUE -1283.
       77  SQLC-RC-NPIPE-PIPE-NOT-FOUND PIC S9(4) COMP-5 VALUE -1284.
       77  SQLC-RC-NPIPE-INVALID-NAME PIC S9(4) COMP-5 VALUE -1285.
       77  SQLC-RC-NPIPE-NO-RESOURCE PIC S9(4) COMP-5 VALUE -1286.
       77  SQLC-RC-NPIPE-INST-NOT-FOUND PIC S9(4) COMP-5 VALUE -1287.

      * Directory Services failed
       77  SQLE-RC-DS-FAILED         PIC S9(4) COMP-5 VALUE -1291.
      * Bad global name
       77  SQLE-RC-DS-BAD-GLB-NAME   PIC S9(4) COMP-5 VALUE -1292.
      * Bad global directory entry
       77  SQLE-RC-DS-BAD-GLB-DIR-ENTRY PIC S9(4) COMP-5 VALUE -1293.
      * Bad DIR_PATH_NAME
       77  SQLE-RC-DS-BAD-DIR-PATH-NAME PIC S9(4) COMP-5 VALUE -1294.
      * Bad ROUTE_OBJ_NAME
       77  SQLE-RC-DS-BAD-ROUTE-NAME PIC S9(4) COMP-5 VALUE -1295.
      * Command not supported
       77  SQLE-RC-DS-UNSUPPORTED-CMD PIC S9(4) COMP-5 VALUE -1297.

      * Invalid DCE principal name
       77  SQLE-RC-DCE-INVPN         PIC S9(4) COMP-5 VALUE -1300.
      * Error DCE keytab file
       77  SQLE-RC-DCE-ERR-KEYTAB    PIC S9(4) COMP-5 VALUE -1301.
      * DCE principal and DB2 authid mapping error
       77  SQLE-RC-DCE-ERR-MAPPING   PIC S9(4) COMP-5 VALUE -1302.
      * Security daemon could not be restarted
       77  SQLE-RC-SECD-ERR-RESTART  PIC S9(4) COMP-5 VALUE -1303.
      * Invalid security type for TCP/IP protocol
       77  SQLE-RC-INVSTCP           PIC S9(4) COMP-5 VALUE -1304.
      * DCE internal error
       77  SQLE-RC-DCE-ERR           PIC S9(4) COMP-5 VALUE -1305.
      * Invalid parameter to audit
       77  SQLE-RC-AUD-INV-PARM      PIC S9(4) COMP-5 VALUE -1306.
      * Audit error
       77  SQLE-RC-AUD-ERR           PIC S9(4) COMP-5 VALUE -1307.
      * DCE invalid server principal name
       77  SQLE-RC-DCE-INV-PRINC     PIC S9(4) COMP-5 VALUE -1309.

      * DCS Directory file access error
       77  SQLE-RC-FILEDCS           PIC S9(4) COMP-5 VALUE -1310.
      * DCS Directory not found
       77  SQLE-RC-DCSDIR-NF         PIC S9(4) COMP-5 VALUE -1311.
      * DCS Directory is empty
       77  SQLE-RC-NO-ENTRY          PIC S9(4) COMP-5 VALUE 1312.
      * DCS Directory is full
       77  SQLE-RC-MAX-ENTRY         PIC S9(4) COMP-5 VALUE -1313.
      * Entry parameter pointer invalid
       77  SQLE-RC-INVENTRY-PTR      PIC S9(4) COMP-5 VALUE -1314.
      * Local DB name has invalid chars
       77  SQLE-RC-INVLDB            PIC S9(4) COMP-5 VALUE -1315.
      * DCS Directory entry not found
       77  SQLE-RC-LDB-NF            PIC S9(4) COMP-5 VALUE -1316.
      * DCS Directory duplicate entry
       77  SQLE-RC-DUPLDB            PIC S9(4) COMP-5 VALUE -1317.
      * Invalid element length
       77  SQLE-RC-INVLENGTH         PIC S9(4) COMP-5 VALUE -1318.
      * Entries have not been collected
       77  SQLE-RC-ENTRYNOT-COL      PIC S9(4) COMP-5 VALUE -1319.

      * Cannot access DCS Dir at this time
       77  SQLE-RC-GDBUSY            PIC S9(4) COMP-5 VALUE -1320.
      * Invalid structure ID
       77  SQLE-RC-INVSTRUCT-ID      PIC S9(4) COMP-5 VALUE -1321.
      * Error writing to audit log
       77  SQLE-RC-AUD-WRITE-ERR     PIC S9(4) COMP-5 VALUE -1322.
      * Error accessing db2audit.cfg
       77  SQLE-RC-AUD-CFG-FILE-ERR  PIC S9(4) COMP-5 VALUE -1323.
      * Remote function not supported
       77  SQLE-RC-DRDANSP           PIC S9(4) COMP-5 VALUE -1325.
      * File or directory access denied
       77  SQLE-RC-ACCD              PIC S9(4) COMP-5 VALUE -1326.
      * Implicit connect - invalid dbname
       77  SQLE-RC-IMPLCONN-INVDB    PIC S9(4) COMP-5 VALUE -1327.
      * Implicit connect - alias not found
       77  SQLE-RC-IMPLCONN-NODB     PIC S9(4) COMP-5 VALUE -1328.
      * Input path too long
       77  SQLE-RC-PATH-TOO-LONG     PIC S9(4) COMP-5 VALUE -1329.

      * Invalid symbolic destination name
       77  SQLE-RC-INVSDNAME         PIC S9(4) COMP-5 VALUE -1330.
      * Invalid CPIC security type
       77  SQLE-RC-INVSTYPE          PIC S9(4) COMP-5 VALUE -1331.
      * Invalid Host Name
       77  SQLE-RC-INV-HOSTNAME      PIC S9(4) COMP-5 VALUE -1332.
      * Invalid Service Name
       77  SQLE-RC-INV-SERNAME       PIC S9(4) COMP-5 VALUE -1333.

      * Double-hops not allowed
       77  SQLE-RC-DOUBLE-REMOTE     PIC S9(4) COMP-5 VALUE -1334.
      * AR name has invalid chars
       77  SQLE-RC-INVAR             PIC S9(4) COMP-5 VALUE -1335.

      * File server is unknown
       77  SQLE-RC-UNKNOWN-FILESERVER PIC S9(4) COMP-5 VALUE -1340.
      * Invalid File Server
       77  SQLE-RC-INV-FSERVER       PIC S9(4) COMP-5 VALUE -1342.
      * Invalid Object Name
       77  SQLE-RC-INV-OBJNAME       PIC S9(4) COMP-5 VALUE -1343.

      * Backup or Restore is active
       77  SQLE-RC-BR-ACTIVE         PIC S9(4) COMP-5 VALUE -1350.

      * Quiesce is failed
       77  SQLE-RC-QUIESCE-FAILED    PIC S9(4) COMP-5 VALUE 1371.
      * Unquiesce is failed
       77  SQLE-RC-UNQUIESCE-FAILED  PIC S9(4) COMP-5 VALUE 1373.
      * Invalid Instance Name
       77  SQLE-RC-INV-INSTANCE      PIC S9(4) COMP-5 VALUE -1390.
      * Another Instance is using the DB
       77  SQLE-RC-INSTANCE-USING    PIC S9(4) COMP-5 VALUE -1391.
      * Invalid DB2 Path Name
       77  SQLE-RC-INV-DB2PATH       PIC S9(4) COMP-5 VALUE -1393.

      * Unsupported authentication type
       77  SQLE-RC-BAD-AUTH          PIC S9(4) COMP-5 VALUE -1400.
      * Authentication types do not match
       77  SQLE-RC-DIFF-AUTH         PIC S9(4) COMP-5 VALUE -1401.
      * Authentication failed due to unexpected error
       77  SQLE-RC-AUTH-ERR          PIC S9(4) COMP-5 VALUE -1402.
      * Invalid user name and/or password
       77  SQLE-RC-AUTH-FAILURE      PIC S9(4) COMP-5 VALUE -1403.
      * Password has expired
       77  SQLE-RC-PASSWORD-EXPIRED  PIC S9(4) COMP-5 VALUE -1404.
      * Password without userid
       77  SQLE-RC-PASSWD-WITHOUT-USERID PIC S9(4) COMP-5 VALUE -1425.
      * Error getting DB2INSTDFT
       77  SQLE-RC-DB2INSTDFT-ERROR  PIC S9(4) COMP-5 VALUE -1426.
      * No current attachment
       77  SQLE-RC-NOT-INSTANCE-ATTACHED PIC S9(4) COMP-5 VALUE -1427.
      * Attached to wrong instance
       77  SQLE-RC-WRONG-ATTACH      PIC S9(4) COMP-5 VALUE -1428.
      * Relative path not allowed
       77  SQLE-RC-RELPATH-NOT-ALLOWED PIC S9(4) COMP-5 VALUE -1431.
      * Connected to wrong database
       77  SQLE-RC-WRONG-CONNECT     PIC S9(4) COMP-5 VALUE -1433.

      * Ctx parm invalid
       77  SQLE-RC-CTX-INV-PARM      PIC S9(4) COMP-5 VALUE -1441.
      * App Ctx not in use
       77  SQLE-RC-CTX-NOTINUSE      PIC S9(4) COMP-5 VALUE -1442.
      * Already using Ctx
       77  SQLE-RC-CTX-USING         PIC S9(4) COMP-5 VALUE -1443.
      * App Ctx in use
       77  SQLE-RC-CTX-INUSE         PIC S9(4) COMP-5 VALUE -1444.
      * Thread does not have context
       77  SQLE-RC-CTX-NO-CTX        PIC S9(4) COMP-5 VALUE -1445.

      * Invalid registration info. ptr.
       77  SQLE-RC-INVREGINFO-PTR    PIC S9(4) COMP-5 VALUE -1450.
      * Reg. issued from invalid node
       77  SQLE-RC-REG-INVNODE       PIC S9(4) COMP-5 VALUE -1451.
      * Invalid registration location
       77  SQLE-RC-INVREGLOC         PIC S9(4) COMP-5 VALUE -1452.
      * Invalid file server in DBM cfg.
       77  SQLE-RC-INVCFG-FSNAME     PIC S9(4) COMP-5 VALUE -1453.
      * Invalid object name in DBM cfg.
       77  SQLE-RC-INVCFG-OBJNAME    PIC S9(4) COMP-5 VALUE -1454.
      * Invalid IPX socket in DBM cfg.
       77  SQLE-RC-INVCFG-IPXSOCKET  PIC S9(4) COMP-5 VALUE -1455.
      * Object name already exists
       77  SQLE-RC-DUPLICATE-OBJNAME PIC S9(4) COMP-5 VALUE -1456.
      * NWDS connection exists, cannot log into NW fileserver
       77  SQLE-RC-NWDS-CONNEXISTS   PIC S9(4) COMP-5 VALUE -1457.
      * DB2 server reg./dereg. not needed
       77  SQLE-RC-REG-NOT-NEEDED    PIC S9(4) COMP-5 VALUE -1458.
      * Invalid TCP/IP Security 
       77  SQLE-RC-INVSTYPE-TCP      PIC S9(4) COMP-5 VALUE -1461.

      * Database is started but only one bufferpool is started
       77  SQLE-RC-ONE-BUFFERPOOL    PIC S9(4) COMP-5 VALUE 1478.

      * An error occured when starting the DB2 security daemon
       77  SQLE-RC-SECD-FAILURE      PIC S9(4) COMP-5 VALUE -1525.

      * FCM startup error when using VI
       77  SQLE-RC-VI-ERROR          PIC S9(4) COMP-5 VALUE -1526.

      * Function is no longer supported
       77  SQLE-RC-UNSUPP-FUNCTION   PIC S9(4) COMP-5 VALUE -1650.

      * Invalid server level for request
       77  SQLE-RC-INV-SERVERLVL     PIC S9(4) COMP-5 VALUE -1651.
      * File I/O error
       77  SQLE-RC-FILEIO-ERR        PIC S9(4) COMP-5 VALUE -1652.
      * Invalid profile path
       77  SQLE-RC-INV-PROFILE-PATH  PIC S9(4) COMP-5 VALUE -1653.
      * Instance path error
       77  SQLE-RC-INSTPATH-ERR      PIC S9(4) COMP-5 VALUE -1654.

      * Generator failed
       77  SQLE-RC-GENERATOR-FAILED  PIC S9(4) COMP-5 VALUE -1660.

      * Discover is disabled in DBM CFG
       77  SQLE-RC-DSCVR-DISABLED    PIC S9(4) COMP-5 VALUE -1670.
      * Search discovery failed
       77  SQLE-RC-SEARCH-DSCVR-FAILED PIC S9(4) COMP-5 VALUE -1671.
      * Invalid discover address list
       77  SQLE-RC-INV-DSCVR-ADDRLST PIC S9(4) COMP-5 VALUE -1673.
      * Invalid discover address
       77  SQLE-RC-INV-DSCVR-ADDR    PIC S9(4) COMP-5 VALUE -1674.
      * Invalid admin. server
       77  SQLE-RC-INV-ADMINSERVER   PIC S9(4) COMP-5 VALUE -1675.

      * Invalid Schema name found
       77  SQLE-RC-INV-SCHEMA        PIC S9(4) COMP-5 VALUE -1700.
      * DB cannot be migrated
       77  SQLE-RC-DB-NOT-MIGR       PIC S9(4) COMP-5 VALUE -1701.
      * Fail to create db2event dir
       77  SQLE-RC-CRT-EVENT-FAIL    PIC S9(4) COMP-5 VALUE -1703.
      * DB migration failed
       77  SQLE-RC-DB-MIG-FAIL       PIC S9(4) COMP-5 VALUE -1704.
      * Fail to update directory entry
       77  SQLE-RC-UPDATE-DIR-FAIL   PIC S9(4) COMP-5 VALUE 1705.

      * Invalid Request Info pointer
       77  SQLE-RC-INV-REQINFO-PTR   PIC S9(4) COMP-5 VALUE -1800.
      * Invalid Request Type
       77  SQLE-RC-INV-REQUEST-TYPE  PIC S9(4) COMP-5 VALUE -1801.
      * No entry belongs to Request Type
       77  SQLE-RC-NO-NODE-ENTRY     PIC S9(4) COMP-5 VALUE -1802.
      * Node already exists in node directory
       77  SQLE-RC-NODE-EXIST        PIC S9(4) COMP-5 VALUE -1803.

      * DB is already activated
       77  SQLE-RC-DB-ACTIVATED      PIC S9(4) COMP-5 VALUE 1490.
      * DB is still active
       77  SQLE-RC-DB-NOT-STOPPED    PIC S9(4) COMP-5 VALUE -1491.
      * DB is not active
       77  SQLE-RC-DB-NOT-UP         PIC S9(4) COMP-5 VALUE -1492.
      * Application is connected to a database
       77  SQLE-RC-APP-IS-CONNECTED  PIC S9(4) COMP-5 VALUE -1493.
      * There is already DB connection
       77  SQLE-RC-ACT-DB-CONNECTED  PIC S9(4) COMP-5 VALUE 1494.
      * There is still DB connection
       77  SQLE-RC-DEACT-DB-CONNECTED PIC S9(4) COMP-5 VALUE 1495.
      * DB is not activated
       77  SQLE-RC-DEACT-DB-NOT-ACTIVATED PIC S9(4) COMP-5 VALUE 1496.
      * Error occurs on some nodes
       77  SQLE-RC-ACTDEACT-ERROR    PIC S9(4) COMP-5 VALUE 1497.
      * Invalid parameter
       77  SQLE-RC-INVALID-PARM      PIC S9(4) COMP-5 VALUE -2032.

      * Quiesce is pending
       77  SQLE-RC-QUIESCE-PENDING   PIC S9(4) COMP-5 VALUE -3807.
      * Unquiesce is pending
       77  SQLE-RC-UNQUIESCE-PENDING PIC S9(4) COMP-5 VALUE -3808.
      * Error not Admin Server
       77  SQLE-RC-E4411             PIC S9(4) COMP-5 VALUE -4411.
      * Admin Server not started
       77  SQLE-RC-NOADMSTART        PIC S9(4) COMP-5 VALUE -4414.

      * Communications support failed
       77  SQLE-RC-COMM-FAILED       PIC S9(4) COMP-5 VALUE 5043.

      * Vendor cfg file not found
       77  SQLE-RC-NO-VENDOR-CFG     PIC S9(4) COMP-5 VALUE -5500.
      * Vendor cfg file invalid 
       77  SQLE-RC-BAD-VENDOR-CFG    PIC S9(4) COMP-5 VALUE -5501.

      * System database directory is not shared by all PDB nodes
       77  SQLE-RC-SDIRERR           PIC S9(4) COMP-5 VALUE -6022.
      * The path specified for the database directory is not valid
       77  SQLE-RC-PATH-NOT-QUAL     PIC S9(4) COMP-5 VALUE -6027.
      * Database is not found in local database directory
       77  SQLE-RC-LOCALDB-NOT-FOUND PIC S9(4) COMP-5 VALUE -6028.
      * Invalid parameter for start/stop
       77  SQLE-RC-INV-PARM          PIC S9(4) COMP-5 VALUE -6030.
      * Error in db2nodes.cfg file
       77  SQLE-RC-ERR-DB2NODES-CFG  PIC S9(4) COMP-5 VALUE -6031.
      * Some nodes have not been started properly
       77  SQLE-RC-STARTED-PARTIALLY PIC S9(4) COMP-5 VALUE 6032.
      * Some nodes have not been stopped properly
       77  SQLE-RC-STOPPED-PARTIALLY PIC S9(4) COMP-5 VALUE 6033.
      * The node is not in used by any database
       77  SQLE-RC-NODE-NOT-INUSE    PIC S9(4) COMP-5 VALUE 6034.
      * The node is used by a database
       77  SQLE-RC-NODE-INUSE        PIC S9(4) COMP-5 VALUE 6035.
      * Start/stop command in progress
       77  SQLE-RC-START-STOP-IN-PROG PIC S9(4) COMP-5 VALUE -6036.
      * Timeout reached for start/stop
       77  SQLE-RC-NODE-TIMEOUT      PIC S9(4) COMP-5 VALUE -6037.
      * Invalid action for DROP NODE
       77  SQLE-RC-INVDROP-ACTION    PIC S9(4) COMP-5 VALUE -6046.
      * Communication error in start/stop
       77  SQLE-RC-COMM-ERR          PIC S9(4) COMP-5 VALUE -6048.
      * Need to stop the node before starting the node with the restart
      * option
       77  SQLE-RC-NODE-NEED-STOP    PIC S9(4) COMP-5 VALUE -6072.
      * Add Node failed
       77  SQLE-RC-ADD-NODE-FAIL     PIC S9(4) COMP-5 VALUE -6073.
      * Add Node failed because Create/Drop Db in progress
       77  SQLE-RC-ADD-NODE-CRDP     PIC S9(4) COMP-5 VALUE -6074.
      * Add Node operation successful
       77  SQLE-RC-ADD-NODE-OK       PIC S9(4) COMP-5 VALUE 6075.
      * Prompt for db2stop DROP NODENUM
       77  SQLE-RC-DROP-PROMPT       PIC S9(4) COMP-5 VALUE 6076.
      * Drop node OK. Files still exist
       77  SQLE-RC-DROP-OK           PIC S9(4) COMP-5 VALUE 6077.
      * Drop node failed
       77  SQLE-RC-DROP-FAILED       PIC S9(4) COMP-5 VALUE -6078.
      * Drop node cancelled successfully
       77  SQLE-RC-DROP-CANCEL       PIC S9(4) COMP-5 VALUE 6079.
      * Add Node succeeded but no databases created on the node
       77  SQLE-RC-ADD-NODE-NODB     PIC S9(4) COMP-5 VALUE 6080.
      * Timeout reached in stop FORCE
       77  SQLE-RC-FORCE-TIMEOUT-ERR PIC S9(4) COMP-5 VALUE -6081.

      * No DB2 license
       77  SQLE-RC-DB2-SERVER-LICENSE PIC S9(4) COMP-5 VALUE -8000.
      * Out of DB2 client licenses
       77  SQLE-RC-DB2-LICENSE       PIC S9(4) COMP-5 VALUE -8001.
      * Out of DDCS clients
       77  SQLE-RC-DDCS-LICENSE      PIC S9(4) COMP-5 VALUE -8002.

      * Federated cfg file not found
       77  SQLE-RC-NO-FED-CFG        PIC S9(4) COMP-5 VALUE -5180.
      * Federated cfg file invalid
       77  SQLE-RC-BAD-FED-CFG       PIC S9(4) COMP-5 VALUE -5181.

      * Invalid port number
       77  SQLE-RC-BAD-PORT          PIC S9(4) COMP-5 VALUE -1888.
      * Update Alternate Server Ignored
       77  SQLE-RC-IGNORE-UPD-ALT-SVR PIC S9(4) COMP-5 VALUE 1889.
      * Invalid host name
       77  SQLE-RC-BAD-HOSTNAME      PIC S9(4) COMP-5 VALUE -1890.
      * Invalid host name pointer
       77  SQLE-RC-HOSTNAME-PTR      PIC S9(4) COMP-5 VALUE -1891.
      * Invalid port number pointer
       77  SQLE-RC-PORT-PTR          PIC S9(4) COMP-5 VALUE -1892.

      * The following functions and symbols are obsolete and may not be
      * supportedin future releases. The obsolete functions are provided for
      * backward compatibilityand exported from DB2API.LIB. All applications
      * should be migrated to use new APIs.Note: Some of the function
      * parameters may be NO-OP.      Some structures are larger (eg.
      * SQLEDINFO) in V2.
      * Authentication Not Specified
       77  SQL-AUTHENTICATION-UNDEF  PIC S9(4) COMP-5 VALUE 255.
      * Invalid numsegs on create db
       77  SQLE-RC-BAD-SEGPAGES      PIC S9(4) COMP-5 VALUE -1136.

      * No CS/6000 license
       77  SQLE-RC-CS-LICENSE        PIC S9(4) COMP-5 VALUE -8003.
      * No SNA/6000 license
       77  SQLE-RC-SNA-LICENSE       PIC S9(4) COMP-5 VALUE -8004.

      * Authentication Undefined
       77  SQL-AUTHENTICATION-UNDEF  PIC S9(4) COMP-5 VALUE 255.

      * PE V1.2 Start Database Manager structure
      *************************************************************************
      * sqledbstrtopt data structure
      **************************************************************************
       01 SQLEDBSTRTOPT.
      * Profile specified?
           05 SQL-ISPROFILE          PIC 9(9) COMP-5.
      * Profile
           05 SQL-PROFILE            PIC X(235)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * Node number specified?
           05 SQL-ISNODENUM          PIC 9(9) COMP-5.
      * Node number
           05 SQL-NODENUM            PIC S9(4) COMP-5.
           05 FILLER                 PIC X(2)
                                     USAGE DISPLAY NATIVE.
      * Command specified?
           05 SQL-ISCOMMAND          PIC 9(9) COMP-5.
      * Command
           05 SQL-SCOMMAND           PIC X(10)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X(1)
                                     USAGE DISPLAY NATIVE.
      * Hostname specified?
           05 SQL-ISHOSTNAME         PIC 9(9) COMP-5.
      * Hostname
           05 SQL-HOSTNAME           PIC X(255)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
      * Port specified?
           05 SQL-ISPORT             PIC 9(9) COMP-5.
      * Port
           05 SQL-PORT               PIC S9(9) COMP-5.
      * Netname specified?
           05 SQL-ISNETNAME          PIC 9(9) COMP-5.
      * Netname
           05 SQL-NETNAME            PIC X(255)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.

      * End of obsolete functions and symbols
