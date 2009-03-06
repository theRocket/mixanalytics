/******************************************************************************
*
* Source File Name = SQLXA.H
*
* (C) COPYRIGHT International Business Machines Corp. 1993, 1995
* All Rights Reserved
* Licensed Materials - Property of IBM
*
* US Government Users Restricted Rights - Use, duplication or
* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
*
* Function = Include File defining:
*              XA Interface - Constants
*              XA Interface - Data Structures
*              XA Interface - Function Prototypes
*
* Operating System = Common C Include File
*
******************************************************************************/

#ifndef SQL_H_SQLXA
   #define SQL_H_SQLXA             /* Permit duplicate Includes */

#include "sqlsystm.h"              /* Provides _SQLOLDCHAR      */
#include "db2ApiDf.h"              /* Provides db2 api literals */

#ifdef __cplusplus
extern "C" {
#endif

#if defined(DB2NT)
#if defined _WIN64
#pragma pack(8)
#else
#pragma pack(4)
#endif
#elif (defined(DB2AIX) && defined(__64BIT__))
#pragma options align=natural
#elif (defined(DB2AIX))
#pragma options align=power
#endif

/*
* Define an alias for the XID structure defined by X/Open.
* This avoids conflicts with the XID defined by X11 (Xwindows).
*/

#define SQLXA_XIDDATASIZE   128    /* size in bytes           */

#define SQLXA_XID_FORMATID  0x53514C20      /* "SQL " */
#define SQLXA_XID_F2PC_FORMATID 0x46325043  /* "F2PC" */
#define SQLXA_XID_BQLEN     0
#define SQLXA_XID_APPLIDLEN 25
#define SQLXA_XID_SEQNUM    4
#define SQLXA_XID_GTLEN     SQL_DBNAME_SZ+1+SQLXA_XID_APPLIDLEN+SQLXA_XID_SEQNUM+1

#define SQLXA_XID_TSLEN     4
#define SQLXA_XID_LOGIDLEN  4
#define SQLXA_XID_LOGIDPOS  SQL_DBNAME_SZ+1+SQLXA_XID_TSLEN
#define SQLXA_XID_TIDPOS    SQLXA_XID_LOGIDPOS+SQLXA_XID_LOGIDLEN
#define SQLXA_XID_TIDLEN    6

#define SQLXA_XID_GTRID_LEN   17
#define SQLXA_XID_BQUAL_LEN   6

/******************************************************************************
** SQLXA_XID data structure
** This structure is used by the transaction APIs to identify XA transactions.
** sqlxhfrg, sqlxphcm, sqlxphrl, sqlcspqy and db2XaListIndTrans APIs constitute
** the transaction APIs group. These APIs are used for the management of
** indoubt transactions.
**
** Table: Fields in the SQLXA-XID Structure
** |----------------------------------------------------------------|
** |Field Name  |Data Type|Description                              |
** |------------|---------|-----------------------------------------|
** |FORMATID    |INTEGER  |XA format ID.                            |
** |GTRID_LENGTH|INTEGER  |Length of the global transaction ID.     |
** |BQUAL_LENGTH|INTEGER  |Length of the branch identifier.         |
** |DATA        |CHAR[128]|GTRID, followed by BQUAL and trailing    |
** |            |         |blanks, for a total of 128 bytes.        |
** |------------|---------|-----------------------------------------|
** |Note:                                                           |
** |The maximum size for GTRID and BQUAL is 64 bytes each.          |
** |----------------------------------------------------------------|
****************************************************************************/
struct sqlxa_xid_t {
  sqlint32 formatID;                   /* format identifier       */
  sqlint32 gtrid_length;               /* value from 1 through 64 */
  sqlint32 bqual_length;               /* value from 1 through 64 */
  char data[SQLXA_XIDDATASIZE];
  } ;

typedef struct sqlxa_xid_t SQLXA_XID;

/******************************************************************************
** the following macro can generate a NULLXID
******************************************************************************/
#define SQLXA_NULLXID( x ) \
{ (x).formatID     = -1; \
(x).gtrid_length = -1; \
(x).bqual_length = -1; \
(x).data[0] = 0; }

/* provide a test for the NULLXID */
/* note that we only test the formatID! -> a simplification */
#define SQLXA_XID_IS_NULL( x ) ( (x).formatID     == -1 )

/* provide a test for Microsoft DTC */
#define SQLXA_XID_IS_MSDTC( x ) ( (x).formatID    == 0x00445443 )

/* provide a test for Encina Server */
#define SQLXA_XID_IS_ENCINA( x ) ( (x).formatID   == 113577 )

/* provide a test for SYSTEM_NU Server */
#define SQLXA_XID_IS_SYSTEM_NU( x ) ( (x).formatID   == 33 )

/* provide a test for DB2 coordinated transaction */
#define SQLXA_XID_IS_DB2( x ) ( (x).formatID   == SQLXA_XID_FORMATID )

/* provide a test for Federated coordinated transaction */
#define SQLXA_XID_IS_F2PC( x ) ( (x).formatID == SQLXA_XID_F2PC_FORMATID )

/* provide a test for DB2 coordinated transaction coming from V7 client */
#define SQLXA_XID_SQL_V7(xid) ( SQLXA_XID_IS_DB2(xid) && ((xid)->bqual_length == 0))

/* provide a test for DB2 coordinated transaction */
#define SQLXA_XID_IS_DB2_DRDA( x ) ( (x).formatID   == 0x44524441 )

/* provide XID header size ...sum of size of  formatID,gtrid_size,bqual_size */
#define XID_HEADER_SIZE 12

/* provide true XID size */
#define XID_ACTUAL_SIZE(p_xid) ( XID_HEADER_SIZE + \
                                 (p_xid)->gtrid_length + \
                                 (p_xid)->bqual_length )

/*
* Compare xidA and xidB, for equality.
* Returns "true" if compared to NULLXID by checking the formatID
* Returns "true" (ie. non-zero) if xid's are the same.
* This macro expands to an expression and is therefore suitable for use in
* statements like "while" or "if"
*/

#define XIDEQUAL(xidA, xidB) ( (((xidA).formatID == -1) &&                    \
                                ((xidB).formatID == -1)) ? 1 :                \
                               ((xidA).formatID    ==(xidB).formatID)     &&  \
                               ((xidA).gtrid_length==(xidB).gtrid_length) &&  \
                               ((xidA).bqual_length==(xidB).bqual_length) &&  \
                               ( memcmp((xidA).data, (xidB).data,             \
                                        (int)(xidA).gtrid_length +            \
                                        (int)(xidA).bqual_length) == 0) )

/*
* Compare xidA and xidB, for LOOSE equality:
* 1. (Neither xid can be NULL) and
* 2. (formatIDs must match) and
* 3. (gtrid lengths must match) and
* 4. (gtrid contents must match) and
* 5. ((bqual lengths must differ) or (bqual contents must differ))
*/
#define XIDLSLYCPLD(xidA, xidB) (((xidA).formatID != -1) &&                       \
                                 ((xidA).formatID != SQLXA_XID_FORMATID) &&       \
                                 ((xidA).formatID == (xidB).formatID) &&          \
                                 ((xidA).gtrid_length == (xidB).gtrid_length) &&  \
                                 (memcmp((xidA).data, (xidB).data,                \
                                         (int)(xidA).gtrid_length) == 0) &&       \
                                 (((xidA).bqual_length != (xidB).bqual_length) || \
                                  (memcmp((xidA).data, (xidB).data,               \
                                          (int)(xidA).gtrid_length +              \
                                          (int)(xidA).bqual_length) != 0)))


/*
* Copy xidB into xidA
* -> a macro is not really needed here, since the C language supports
* structure assignments (and this should be efficient on any platform).
*/

#define XIDCPY( xidA, xidB )  (xidA) = (xidB);

/* define a TRUE/FALSE pair for boolean fields in XA structures */
#define SQLXA_TRUE    1
#define SQLXA_FALSE   0

/* define all possible states of transactions returned by "recover" */
#define SQLXA_TS_PREP       'P'  /* prepared                        */
#define SQLXA_TS_HCOM       'X'  /* heuristically committed         */
#define SQLXA_TS_HROL       'Y'  /* heuristically rolled back       */
#define SQLXA_TS_END        'E'  /* idle -> xa_end has been issued  */
#define SQLXA_TS_MACK       'M'  /* missing commit acknowledgement  */
#define SQLXA_TS_MRACK      'R'  /* missing rollback acknowledgement*/
#define SQLXA_TS_MFCACK     'D'  /* missing federated commit acknowledgement  */
#define SQLXA_TS_MFRACK     'B'  /* missing federated rollback acknowledgement*/

#define SQLXA_EXE_ALL_NODES  1   /* execute the request on all the nodes in MPP environment */
#define SQLXA_EXE_THIS_NODE  0   /* execute the request on the node it is issued from */

/* various transaction originators */
#define SQLXA_ORIG_PE        0   /* transaction originated by DB2 in MPP environment*/
#define SQLXA_ORIG_XA        1   /* transaction originated by XA */
#define SQLXA_ORIG_FXA       2   /* transaction originated by F2PC */

/*
* The following structure is used to describe the current state
* of an indoubt (ie "prepared") or heuristically completed transaction.
*
* We need to beef up the explanations of the structure elements,
* so that they can appear in the user doc -> CLP will be providing
* the info basically verbatim to the user.
*
* The char string areas will always be right padded with blanks.
*/

#define SQLXA_DBNAME_SZ         8
#define SQLXA_APPLID_SZ         32
#define SQLXA_SEQ_SZ            4
#define SQLXA_OLD_USERID_SZ     8
#define SQLXA_USERID_SZ         SQL_USERID_SZ
#define SQLXA_PASSWD_SZ         8

/******************************************************************************
** SQLXA_RECOVER data structure
** Used by the transaction APIs to return information about indoubt
** transactions.
**
** Table: Fields in the SQLXA-RECOVER Structure
** |----------------------------------------------------------------|
** |Field Name    |Data Type|Description                            |
** |--------------|---------|---------------------------------------|
** |TIMESTAMP     |INTEGER  |Time stamp when the transaction        |
** |              |         |entered the prepared (indoubt) state.  |
** |              |         |This is the number of seconds the      |
** |              |         |local time zone is displaced from      |
** |              |         |Coordinated Universal Time.            |
** |--------------|---------|---------------------------------------|
** |XID           |CHAR(140)|XA identifier assigned by the          |
** |              |         |transaction manager to uniquely        |
** |              |         |identify a global transaction.         |
** |--------------|---------|---------------------------------------|
** |DBALIAS       |CHAR(16) |Alias of the database where the indoubt|
** |              |         |transaction is found.                  |
** |--------------|---------|---------------------------------------|
** |APPLID        |CHAR(30) |Application identifier assigned by the |
** |              |         |database manager for this transaction. |
** |--------------|---------|---------------------------------------|
** |SEQUENCE_NO   |CHAR(4)  |The sequence number assigned by the    |
** |              |         |database manager as an extension to    |
** |              |         |the APPLID.                            |
** |--------------|---------|---------------------------------------|
** |AUTH_ID       |CHAR(8)  |ID of the user who ran the transaction.|
** |--------------|---------|---------------------------------------|
** |LOG_FULL      |CHAR(1)  |Indicates whether this transaction     |
** |              |         |caused a log full condition.           |
** |--------------|---------|---------------------------------------|
** |CONNECTED     |CHAR(1)  |Indicates whether an application is    |
** |              |         |connected.                             |
** |--------------|---------|---------------------------------------|
** |INDOUBT_STATUS|CHAR(1)  |Possible values are listed below.      |
** |--------------|---------|---------------------------------------|
** |ORIGINATOR    |CHAR(1)  |Indicates whether the transaction was  |
** |              |         |originated by XA or by DB2 in a        |
** |              |         |partitioned database environment.      |
** |--------------|---------|---------------------------------------|
** |RESERVED      |CHAR(9)  |The first byte is used to indicate the |
** |              |         |type of indoubt transaction: 0         |
** |              |         |indicates RM, and 1 indicates TM.      |
** |--------------|---------|---------------------------------------|
**
** Possible values for LOGFULL (defined in sqlxa) are:
** -SQLXA_TRUE
** True
** - SQLXA_FALSE
** False.
**
** Possible values for CONNECTED (defined in sqlxa) are:
** - SQLXA_TRUE
** True. The transaction is undergoing normal syncpoint processing, and
** is waiting for the second phase of the two-phase commit.
** - SQLXA_FALSE
** False. The transaction was left indoubt by an earlier failure, and is
** now waiting for re-sync from a transaction manager.
**
** Possible values for INDOUBT_STATUS (defined in sqlxa) are:
** - SQLXA_TS_PREP
** Prepared
** - SQLXA_TS_HCOM
** Heuristically committed
** - SQLXA_TS_HROL
** Heuristically rolled back
** - SQLXA_TS_MACK
** Missing commit acknowledgement
** - SQLXA_TS_END
** Idle.
**
** Possible values for ORIGINATOR (defined in sqlxa) are:
** - SQLXA_ORIG_PE
** Transaction originated by DB2 in MPP environment.
** - SQLXA_ORIG_XA
** Transaction originated by XA.
** - SQLXA_ORIG_FXA
** Transaction originated by F2PC.
******************************************************************************/
typedef struct sqlxa_recover_t {
   sqluint32      timestamp;
   SQLXA_XID      xid;
   _SQLOLDCHAR    dbalias[SQLXA_DBNAME_SZ];
   _SQLOLDCHAR    applid[SQLXA_APPLID_SZ];
   _SQLOLDCHAR    sequence_no[SQLXA_SEQ_SZ];
   _SQLOLDCHAR    auth_id[SQLXA_OLD_USERID_SZ];
   char           log_full;                    /* SQLXA_TRUE/FALSE */
   char           connected;                   /* SQLXA_TRUE/FALSE */
   char           indoubt_status;              /* SQLXA_TS_xxx     */
   char           originator;                  /* SQLXA_ORIG_PE/XA */
   char           reserved[8];                 /* set to zeroes    */
   } SQLXA_RECOVER;

/**** reason codes for the SQL_RC_W997 general XA warning code */
#define SQLXAER_REASON_DEADLOCK  1  /* returned when XA_END clears a deadlock */
#define SQLXAER_REASON_RDONLYCOM 35 /* trans read-only and has been committed */

/**** reason codes for the SQL_RC_E998 general XA error sqlcode */
#define SQLXAER_REASON_ASYNC    1 /* asynch operation already outstanding     */
#define SQLXAER_REASON_RMERR    2 /* an RM error occurred                     */
#define SQLXAER_REASON_NOTA     3 /* XID not recognized                       */
#define SQLXAER_REASON_INVAL    4 /* invalid parameters                       */
#define SQLXAER_REASON_PROTO    5 /* routine called in improper context       */
#define SQLXAER_REASON_RMFAIL   6 /* RM unavailable                           */
#define SQLXAER_REASON_DUPID    7 /* the XID already exists                   */
#define SQLXAER_REASON_OUTSIDE  8 /* RM doing work outside global transaction */
#define SQLXAER_REASON_AXREG    9 /* axreg failed                             */
#define SQLXAER_REASON_1LUW    10 /* trying to start new trans while suspended*/
#define SQLXAER_REASON_NOJOIN  11 /* can't joing work of existing transaction */
#define SQLXAER_REASON_AXUNREG 12 /* axunreg failed                           */
#define SQLXAER_REASON_BADAX   13 /* ax interface failure (unresolved symbol) */
#define SQLXAER_REASON_DTCXATMDOWN 14 /* Enlist TM with DTC has failed        */
#define SQLXAER_REASON_DTCNOTRANSACTION 15 /*AXREG with DTC has failed        */
#define SQLXAER_REASON_NOHEUR  35 /* heuristic operaion invalid for non-XA db */
#define SQLXAER_REASON_BADXID  36 /* XID not knowne by the RM                 */
#define SQLXAER_REASON_HEURCOM 37 /* trans already heuristically commited     */
#define SQLXAER_REASON_HEURROL 38 /* trans already heuristically rolled back  */
#define SQLXAER_REASON_NOTINDT 39 /* not an indoubt transaction               */
#define SQLXAER_REASON_RBONLY  40 /* Rollback only is allowed                 */
#define SQLXAER_REASON_HEURFAL 41 /* heuristic commit fails because of node   */
                                  /* failure                                  */
#define SQLXAER_REASON_NO_XA_SUPP 43 /* XA not support by remote server       */
#define SQLXAER_REASON_DISALLOW_LCT 225 /* disallow operations in Loosely Coupled Transaction */
#define SQLXAER_REASON_DO_ROLL 226 /* heuristic rollback is performed */
#define SQLXAER_REASON_UNKNOWN 227 /* transaction state is unknown */
#define SQLXAER_REASON_CURSORS_EXIST 228 /* cursors still existed */
#define SQLXAER_REASON_NOT_FIRST_STMT 229 /* not the first stmt */
#define SQLXAER_REASON_DO_COMMIT 230 /* heuristic commit is performed */


/**** subcodes for the SQL_RC_E998 general XA error sqlcode  reason code 4 (SQLXAER_REASON_INVAL) */
#define SQLXAER_SUBCODE_XAINFO_INVALID                 1
#define SQLXAER_SUBCODE_DBNAME_TOO_LONG                2
#define SQLXAER_SUBCODE_USERID_TOO_LONG                3
#define SQLXAER_SUBCODE_PASSWD_TOO_LONG                4
#define SQLXAER_SUBCODE_USERID_NO_PASSWD               5
#define SQLXAER_SUBCODE_PASSWD_NO_USERID               6
#define SQLXAER_SUBCODE_TOO_MANY_PARMS                 7
#define SQLXAER_SUBCODE_RMID_NOT_MATCH_DBNAME          8
#define SQLXAER_SUBCODE_DBNAME_NOT_SPECIFIED           9                         /* +SAM */
#define SQLXAER_SUBCODE_INVALID_EXE_TYPE               10
#define SQLXAER_SUBCODE_INVALID_TMFLAGS                14


/**** subcodes for the SQL_RC_E998 general XA error sqlcode reason code 9 (SQLXAER_REASON_AXREG) */
#define SQLXAER_SUBCODE_JOINING_XID_NOT_FOUND          1
#define SQLXAER_SUBCODE_AXLIB_LOAD_FAIL                2
#define SQLXAER_SUBCODE_TP_MON_NAME_AXLIB_NOT_FOUND    3

/**** subcodes for the SQL_RC_E998 general XA error sqlcode reason code 13 (SQLXAER_REASON_BADAX) */
#define SQLXAER_SUBCODE_AX_REG_NOT_FOUND               1
#define SQLXAER_SUBCODE_AX_UNREG_NOT_FOUND             2


/**** subcodes for the SQL_RC_E998 general XA error sqlcode reason code ?? */
#define SQLXAER_SUBCODE_INVALID_EXE_TYPE               10
#define SQLXAER_SUBCODE_SUSPEND_CURSOR                 11
#define SQLXAER_SUBCODE_AX_LIB                         12
#define SQLXAER_SUBCODE_TP_MON                         13

/**** reason codes for the SQL_RC_E30090 general XA error code */
#define SQLXAER_REASON_READONLY    1  /* update issued against readonly database */
#define SQLXAER_REASON_BADAPI      2  /* This API not allowed                    */
#define SQLXAER_REASON_CANTHOLD    3  /* HELD CURSOR not allowed                 */
#define SQLXAER_REASON_BADAPI_STR "2" /* This API not allowed - str version      */

/*** prototypes for the heuristic API's in sqlxapi.c *************/
/******************************************************************************
** sqlxphqr API
******************************************************************************/
extern int SQL_API_FN sqlxphqr(    /* query existing indoubt transactions  */
   int                  exe_type,
   SQLXA_RECOVER        **ppIndoubtData,
   sqlint32             *pNumIndoubts,
   struct sqlca         *pSqlca
   );

/******************************************************************************
** sqlxphcm API
** Commits an indoubt transaction (that is, a transaction that is prepared to
** be committed). If the operation succeeds, the transaction's state becomes
** heuristically committed.
**
** Scope
**
** This API only affects the node on which it is issued.
**
** Authorization
**
** None
**
** Required connection
**
** Database
**
** API include file
**
** sqlxa.h
**
** sqlxphcm API parameters
**
** exe_type
** Input. If EXE_THIS_NODE is specified, the operation is executed only at this
** node.
**
** pTransId
** Input. XA identifier of the transaction to be heuristically committed.
**
** pSqlca
** Output. A pointer to the sqlca structure.
**
** Usage notes
** Only transactions with a status of prepared can be committed. Once
** heuristically committed, the database manager remembers the state of the
** transaction until the sqlxhfrg API is called.
*******************************************************************************/
extern int SQL_API_FN sqlxphcm(    /* heuristically commit a transaction   */
   int                  exe_type,
   SQLXA_XID            *pTransId,
   struct sqlca         *pSqlca
   );

/******************************************************************************
** sqlxphrl API
** Rolls back an indoubt transaction (that is, a transaction that has been
** prepared). If the operation succeeds, the transaction's state becomes
** heuristically rolled back.
**
** Scope
**
** This API only affects the node on which it is issued.
**
** Authorization
**
** None
**
** Required connection
**
** Database
**
** API include file
**
** sqlxa.h
**
** sqlxphrl API parameters
**
** exe_type
** Input. If EXE_THIS_NODE is specified, the operation is executed only at
** this node.
**
** pTransId
** Input. XA identifier of the transaction to be heuristically rolled back.
**
** pSqlca
** Output. A pointer to the sqlca structure.
**
** Usage notes
**
** Only transactions with a status of prepared or idle can be rolled back.
** Once heuristically rolled back, the database manager remembers the state
** of the transaction until the sqlxhfrg API is called.
*******************************************************************************/
extern int SQL_API_FN sqlxphrl(    /* heuristically rollback a transaction */
   int                  exe_type,
   SQLXA_XID            *pTransId,
   struct sqlca         *pSqlca
   );

/******************************************************************************
** sqlxhfrg API
** Permits the resource manager to release resources held by a heuristically
** completed transaction (that is, one that has been committed or rolled back
** heuristically). You might call this API after heuristically committing or
** rolling back an indoubt XA transaction.
**
** Authorization
**
** None
**
** Required connection
**
** Database
**
** API include file
**
** sqlxa.h
**
** sqlxhfrg API parameters
**
** pTransId
** Input. XA identifier of the transaction to be heuristically forgotten,
** or removed from the database log.
**
** pSqlca
** Output. A pointer to the sqlca structure.
**
** Usage notes
** Only transactions with a status of heuristically committed or rolled back
** can have the FORGET operation applied to them.
*******************************************************************************/
extern int SQL_API_FN sqlxhfrg(    /* heuristically forget a transaction   */
   SQLXA_XID            *pTransId,
   struct sqlca         *pSqlca
   );

/******************************************************************************
** db2XaRecoverStruct data structure
** db2XaRecoverStruct data structure parameters
**
** timestamp
** Output. Specifies the time when the transaction entered the indoubt state.
**
** xid
** Output. Specifies the XA identifier assigned by the transaction manager to
** uniquely identify a global transaction.
**
** dbalias
** Output. Specifies the alias of the database where the indoubt transaction
** is found.
**
** applid
** Output. Specifies the application identifier assigned by the database
** manager for this transaction.
**
** sequence_no
** Output. Specifies the sequence number assigned by the database manager as
** an extension to the applid.
**
** auth_id
** Output. Specifies the authorization ID of the user who ran the transaction.
**
** log_full
** Output. Indicates whether or not this transaction caused a log full
** condition. Valid values are:
** - SQLXA_TRUE
** This indoubt transaction caused a log full condition.
** - SQLXA_FALSE
** This indoubt transaction did not cause a log full condition.
**
** connected
** Indicates whether an application is connected.
**
** Possible values for CONNECTED (defined in sqlxa) are:
** - SQLXA_TRUE
** True. The transaction is undergoing normal syncpoint processing, and
** is waiting for the second phase of the two-phase commit.
** - SQLXA_FALSE
** False. The transaction was left indoubt by an earlier failure, and is
** now waiting for re-sync from a transaction manager.
**
** indoubt_status
** Output. Indicates the status of this indoubt transaction. Valid values are:
** - SQLXA_TS_PREP
** The transaction is prepared. The connected parameter can be used to
** determine whether the transaction is waiting for the second phase of normal
** commit processing or whether an error occurred and resynchronization with
** the transaction manager is required.
** - SQLXA_TS_HCOM
** The transaction has been heuristically committed.
** - SQLXA_TS_HROL
** The transaction has been heuristically rolled back.
** - SQLXA_TS_MACK
** The transaction is missing commit acknowledgement from a node in a
** partitioned database.
** - SQLXA_TS_END
** The transaction has ended at this database. This transaction may be
** re-activated, committed, or rolled back at a later time. It is also possible
** that the transaction manager encountered an error and the transaction will
** not be completed. If this is the case, this transaction requires heuristic
** actions, because it may be holding locks and preventing other applications
** from accessing data.
**
** originator
** Indicates whether the transaction was originated by XA or by DB2 in a
** partitioned database environment.
**
** Possible values for ORIGINATOR (defined in sqlxa) are:
** - SQLXA_ORIG_PE
** Transaction originated by DB2 in MPP environment.
** - SQLXA_ORIG_XA
** Transaction originated by XA.
** - SQLXA_ORIG_FXA
** Transaction originated by F2PC.
**
** reserved
** The first byte is used to indicate the type of indoubt transaction: 0
** indicates RM, and 1 indicates TM.
*******************************************************************************/
#define SQLXA_MAX_FedRM           16           /* Maximum # of Fed. RMs in */
                                               /* an indoubt transaction   */
#define SQLXA_MAX_SERVER_NAME_LEN (128 + 1)    /* Maximum length of a Fed. RM name */
  
typedef SQL_STRUCTURE rm_entry
{
  char name[SQLXA_MAX_SERVER_NAME_LEN];
  SQLXA_XID xid;
} rm_entry;

typedef SQL_STRUCTURE db2XaRecoverStruct{
   sqluint32      timestamp;                   /* Time when indoubt state entered */
   SQLXA_XID      xid;                         /* XA Transaction Identifier */
   char           dbalias[SQLXA_DBNAME_SZ];    /* Database alias */
   char           applid[SQLM_APPLID_SZ];      /* Application Identifier */
   char           sequence_no[SQLXA_SEQ_SZ];   /* Sequence Number */
   char           auth_id[SQLXA_USERID_SZ];    /* Authorisation ID  */
   char           log_full;                    /* Log full         */
   char           connected;                   /* Is application connected ? */
   char           indoubt_status;              /* Indoubt status  */
   char           originator;                  /* XA or DB2 EEE transaction */
   char           reserved[8];                 /* Reserved         */
   sqluint32      rmn;                         /* # of Fed. RMs */
   rm_entry       rm_list[SQLXA_MAX_FedRM];    /* Name & XID of Fed. RMs */
   } db2XaRecoverStruct;

/* List Indoubt Transaction API struct                                        */
/******************************************************************************
** db2XaListIndTransStruct data structure
** db2XaListIndTransStruct data structure parameters
**
** piIndoubtData
** Input. A pointer to the application supplied buffer where indoubt data will
** be returned. The indoubt data is in db2XaRecoverStruct format. The
** application can traverse the list of indoubt transactions by using the size
** of the db2XaRecoverStruct structure, starting at the address provided by
** this parameter.
**
** If the value is NULL, DB2 will calculate the size of the buffer required
** and return this value in oReqBufferLen. oNumIndoubtsTotal will contain the
** total number of indoubt transactions. The application may allocate the
** required buffer size and issue the API again.
**
** iIndoubtDataLen
** Input. Size of the buffer pointed to by piIndoubtData parameter in bytes.
**
** oNumIndoubtsReturned
** Output. The number of indoubt transaction records returned in the buffer
** specified by pIndoubtData.
**
** oNumIndoubtsTotal
** Output. The Total number of indoubt transaction records available at the
** time of API invocation. If the piIndoubtData buffer is too small to
** contain all the records, oNumIndoubtsTotal will be greater than the total
** for oNumIndoubtsReturned. The application may reissue the API in order to
** obtain all records.
** Note:
** This number may change between API invocations as a result of automatic or
** heuristic indoubt transaction resynchronization, or as a result of other
** transactions entering the indoubt state.
**
** oReqBufferLen
** Output. Required buffer length to hold all indoubt transaction records at
** the time of API invocation. The application can use this value to determine
** the required buffer size by calling the API with pIndoubtData set to NULL.
** This value can then be used to allocate the required buffer, and the API
** can be issued with pIndoubtData set to the address of the allocated buffer.
** Note:
** The required buffer size may change between API invocations as a result of
** automatic or heuristic indoubt transaction resynchronization, or as a
** result of other transactions entering the indoubt state. The application
** may allocate a larger buffer to account for this.
*******************************************************************************/
typedef SQL_STRUCTURE db2XaListIndTransStruct
{
   db2XaRecoverStruct * piIndoubtData;         /* Indoubt Data buffer pointer */
   db2Uint32            iIndoubtDataLen;       /* Indoubt Data buffer length */
   db2Uint32            oNumIndoubtsReturned;  /* Number of indoubts returned */
   db2Uint32            oNumIndoubtsTotal;     /* Total number of indoubts  */
   db2Uint32            oReqBufferLen;         /* Required buffer length    */
} db2XaListIndTransStruct;

/******************************************************************************
** db2XaListIndTrans API
** Provides a list of all indoubt transactions for the currently connected
** database.
**
** Scope
** This API only affects the database partition on which it is issued.
**
** Authorization
**
** None
**
** Required connection
**
** Database
**
** API include file
**
** sqlxa.h
**
** db2XaListIndTrans API parameters
**
** versionNumber
** Input. Specifies the version and release level of the structure passed in as
** the second parameter, pParmStruct.
**
** pParmStruct
** Input. A pointer to the db2XaListIndTransStruct structure.
**
** pSqlca
** Output. A pointer to the sqlca structure.
**
** Usage notes
**
** A typical application will perform the following steps after setting the
** current connection to the database or to the partitioned database
** coordinator node:
**
** 1. Call db2XaListIndTrans with piIndoubtData set to NULL. This will return
** values in oReqBufferLen and oNumIndoubtsTotal.
** 2. Use the returned value in oReqBufferLen to allocate a buffer. This buffer
** may not be large enough if there are additional indoubt transactions because
** the initial invocation of this API to obtain oReqBufferLen. The application
** may provide a buffer larger than oReqBufferLen.
** 3. Determine if all indoubt transaction records have been obtained. This can
** be done by comparing oNumIndoubtsReturned to oNumIndoubtTotal. If
** oNumIndoubtsTotal is greater than oNumIndoubtsReturned, the application can
** repeat the above steps.
**
*******************************************************************************/
SQL_API_RC SQL_API_FN                  /* List indoubt transactions           */
  db2XaListIndTrans (
       db2Uint32 versionNumber,        /* Database version number             */
       void * pParmStruct,             /* Input parameters                    */
       struct sqlca * pSqlca);         /* SQLCA                               */

/******************************************************************************
** db2XaGetInfoStruct data structure
** db2XaGetInfoStruct data structure parameters
**
** iRmid
** Input. Specifies the resource manager for which information is required.
**
** oLastSqlca
** Output. Contains the sqlca for the last XA API call.
** Note:
** Only the sqlca that resulted from the last failing XA API can be retrieved.
**
*******************************************************************************/
typedef SQL_STRUCTURE db2XaGetInfoStruct
{
   db2int32             iRmid;                /* rmid to get information for   */
   struct sqlca         oLastSqlca;           /* sqlca for last XA API call    */
} db2XaGetInfoStruct;

/******************************************************************************
** db2XaGetInfo API
** Extracts information for a particular resource manager once an xa_open call
** has been made.
**
** Authorization
**
** Instance - SPM name connection
**
** Required Connection
**
** Database
**
** API include file
**
** sqlxa.h
**
** db2XaGetInfo API Parameters
**
** versionNumber
** Input. Specifies the version and release level of the structure passed in
** as the second parameter, pParmStruct.
**
** pParmStruct
** Input. A pointer to the db2XaGetInfoStruct structure.
**
** pSqlca
** Output. A pointer to the sqlca structure.
**
*******************************************************************************/
SQL_API_RC SQL_API_FN
  db2XaGetInfo(db2Uint32 versionNumber,    /* Database version number         */
               void * pParmStruct,         /* In/out parameters               */
               struct sqlca * pSqlca);     /* SQLCA                           */

/******************************************************************************
** map old api to new ones
*******************************************************************************/
#define sqlxhqry(_ppIndoubtData, _pNumIndoubts, _pSqlca) \
        sqlxphqr(SQLXA_EXE_THIS_NODE, _ppIndoubtData, _pNumIndoubts, _pSqlca)

#define sqlxhcom(_pTransId, _pSqlca) \
        sqlxphcm(SQLXA_EXE_THIS_NODE, _pTransId, _pSqlca)

#define sqlxhrol(_pTransId, _pSqlca) \
        sqlxphrl(SQLXA_EXE_THIS_NODE, _pTransId, _pSqlca)

/*
 * The following structure is used to describe the current state
 * of a DRDA indoubt transaction.
 */

#define SQLCSPQY_DBNAME_SZ       8
#define SQLCSPQY_LUWID_SZ       35
#define SQLCSPQY_LUNAME_SZ      17
#define SQLCSPQY_APPLID_SZ      32

#define SQLCSPQY_AR             'R'
#define SQLCSPQY_AS             'S'

#define SQLCSPQY_STATUS_COM     'C'
#define SQLCSPQY_STATUS_RBK     'R'
#define SQLCSPQY_STATUS_IDB     'I'
#define SQLCSPQY_STATUS_HCM     'X'
#define SQLCSPQY_STATUS_HRB     'Y'

/******************************************************************************
** db2SpmRecoverStruct
*****************************************************************************/

typedef struct db2SpmRecoverStruct {
   SQLXA_XID    xid;
   char         luwid[SQLCSPQY_LUWID_SZ+1];
   char         corrtok[SQLM_APPLID_SZ+1];
   char         partner[SQLCSPQY_LUNAME_SZ+1];
   char         dbname[SQLCSPQY_DBNAME_SZ+1];
   char         dbalias[SQLCSPQY_DBNAME_SZ+1];
   char         role;
   char         uow_status;
   char         partner_status;
} db2SpmRecoverStruct;

/******************************************************************************
** db2SpmListIndTransStruct
*******************************************************************************/
typedef SQL_STRUCTURE db2SpmListIndTransStruct
{
   db2SpmRecoverStruct * piIndoubtData;        /* Indoubt Data buffer pointer */
   db2Uint32            iIndoubtDataLen;       /* Indoubt Data buffer length */
   db2Uint32            oNumIndoubtsReturned;  /* Number of indoubts returned */
   db2Uint32            oNumIndoubtsTotal;     /* Total number of indoubts  */
   db2Uint32            oReqBufferLen;         /* Required buffer length    */
} db2SpmListIndTransStruct;


/******************************************************************************
** db2SpmListIndTrans API
** Provides a list of transactions that are indoubt between the syncpoint
** manager partner connections.
**
** Scope
** This API only affects the database partition on which it is issued.
**
** Authorization
**
** None
**
** Required connection
**
** Database
**
** API include file
**
** sqlxa.h
**
** db2SpmListIndTrans API parameters
**
** versionNumber
** Input. Specifies the version and release level of the structure passed in as
** the second parameter, pParmStruct.
**
** pParmStruct
** Input. A pointer to the db2SpmListIndTransStruct structure.
**
** pSqlca
** Output. A pointer to the sqlca structure.
**
** Usage notes
**
** DRDA indoubt transactions occur when communication is lost between
** coordinators and participants in distributed units of work.
**
** A distributed unit of work lets a user or application read and update data
** at multiple locations within a single unit of work. Such work requires a
** two-phase commit.
**
** The first phase requests all the participants to prepare for commit. The
** second phase commits or rolls back the transactions. If a coordinator or
** participant becomes unavailable after the first phase then the distributed
** transactions are indoubt.
**
** Before issuing the LIST DRDA INDOUBT TRANSACTIONS command, the application
** process must be connected to the Sync Point Manager (SPM) instance. Use the
** spm_name database manager configuration parameter as the dbalias on the
** CONNECT statement.
**
** A typical application will perform the following steps after setting the
** current connection to the database.
**
** 1. Call db2SpmListIndTrans with piIndoubtData set to NULL. This will return
** values in oReqBufferLen and oNumIndoubtsTotal.
** 2. Use the returned value in oReqBufferLen to allocate a buffer. This buffer
** may not be large enough if there are additional indoubt transactions because
** the initial invocation of this API to obtain oReqBufferLen. The application
** may provide a buffer larger than oReqBufferLen.
** 3. Determine if all indoubt transaction records have been obtained. This can
** be done by comparing oNumIndoubtsReturned to oNumIndoubtTotal. If
** oNumIndoubtsTotal is greater than oNumIndoubtsReturned, the application can
** repeat the above steps.
**
*******************************************************************************/
SQL_API_RC SQL_API_FN                  /* List drda indoubt transactions      */
  db2SpmListIndTrans (
       db2Uint32 versionNumber,        /* Database version number             */
       void * pParmStruct,             /* Input parameters                    */
       struct sqlca * pSqlca);         /* SQLCA                               */

#if defined(DB2NT)
#pragma pack()
#elif defined(DB2AIX)
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* SQL_H_SQLXA */
