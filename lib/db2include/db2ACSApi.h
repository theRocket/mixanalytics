/******************************************************************************
**
** Source File Name: db2ACSApi.h
**
** (C) COPYRIGHT International Business Machines Corp. 2006
** All Rights Reserved
** Licensed Materials - Property of IBM
**
** US Government Users Restricted Rights - Use, duplication or
** disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
**
** Function = Definitions for integrated Backup Adapters.
**
*******************************************************************************/
#ifndef SQL_H_DB2BACKUPADAPTERAPI
#define SQL_H_DB2BACKUPADAPTERAPI

#ifdef __cplusplus
extern "C" {
#endif

#include "sql.h"
#include "sqlenv.h"
#include "sqlutil.h"
#include "db2ApiDf.h"


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



/* ==========================================================================
 * Return Codes
 * ========================================================================== */
typedef db2int32 db2ACS_RC;
#define DB2ACS_RC_OK                    0 /* Operation is successful */
#define DB2ACS_RC_LINK_EXIST            1 /* Session activated previously */
#define DB2ACS_RC_COMM_ERROR            2 /* Communication error with device */
#define DB2ACS_RC_INV_VERSION           3 /* The DB2 and vendor products are incompatible */
#define DB2ACS_RC_INV_ACTION            4 /* Invalid action is requested */
#define DB2ACS_RC_NO_DEV_AVAIL          5 /* No device is available for use at the moment */
#define DB2ACS_RC_OBJ_NOT_FOUND         6 /* Object specified cannot be found */
#define DB2ACS_RC_OBJS_FOUND            7 /* More than 1 object matches specification is found */
#define DB2ACS_RC_INV_USERID            8 /* Invalid userid specified */
#define DB2ACS_RC_INV_PASSWORD          9 /* Invalid password provided */
#define DB2ACS_RC_INV_OPTIONS          10 /* Invalid options specified */
#define DB2ACS_RC_INIT_FAILED          11 /* Initialization failed */
#define DB2ACS_RC_INV_DEV_HANDLE       12 /* Invalid device handle */
#define DB2ACS_RC_BUFF_SIZE            13 /* Invalid buffer size specified */
#define DB2ACS_RC_END_OF_DATA          14 /* End of data reached */
#define DB2ACS_RC_END_OF_TAPE          15 /* End of tape reached. Requires attention */
#define DB2ACS_RC_DATA_RESEND          16 /* Device requested to have last buffer sent again */
#define DB2ACS_RC_COMMIT_FAILED        17 /* Commit request failed */
#define DB2ACS_RC_DEV_ERROR            18 /* Device error */
#define DB2ACS_RC_WARNING              19 /* Warning. see return code */
#define DB2ACS_RC_LINK_NOT_EXIST       20 /* Session not activated previously */
#define DB2ACS_RC_MORE_DATA            21 /* More data to come */
#define DB2ACS_RC_ENDOFMEDIA_NO_DATA   22 /* End of media encountered with no data */
#define DB2ACS_RC_ENDOFMEDIA           23 /* ENd of media encountered */
#define DB2ACS_RC_MAX_LINK_GRANT       24 /* Max no. of link established */
#define DB2ACS_RC_IO_ERROR             25 /* I/O error encountered */
#define DB2ACS_RC_DELETE_FAILED        26 /* Delete object fails */
#define DB2ACS_RC_INV_BKUP_FNAME       27 /* Invalid backup filename provided */
#define DB2ACS_RC_NOT_ENOUGH_SPACE     28 /* insufficient space for estimated database size */
#define DB2ACS_RC_ABORT_FAILED         29 /* Abort request failed */
#define DB2ACS_RC_UNEXPECTED_ERROR     30 /* A severe error was experienced */
#define DB2ACS_RC_NO_DATA              31 /* No data has been returned */
#define DB2ACS_RC_OBJ_OUT_OF_SCOPE     32 /* Object not under BackupAdapter control */
#define DB2ACS_RC_INV_CALL_SEQUENCE    33 /* Sequence of ACS API calls not allowed */
#define DB2ACS_RC_SHARED_STORAGE_GROUP 34 /* Another database or application is using the same storage groups */



/* ==========================================================================
 * Constants for field lengths
 * ========================================================================== */
#define DB2ACS_SIGNATURE_SZ             8
#define DB2ACS_MAX_VENDORID_SZ         64
#define DB2ACS_MAX_PATH_SZ           1024
#define DB2ACS_MAX_OWNER_SZ           128
#define DB2ACS_MAX_PASSWORD_SZ         64
#define DB2ACS_MAX_COMMENT_SZ        1024
#define DB2ACS_MAX_MGMTCLASS_SZ       256



/* ==========================================================================
 * API Version.
 *
 * db2ACSQueryApiVersion returns the version of the API specification which is
 * supported by the backup adapter module.  Valid return output values include
 * any of the DB2ACS_API_VERSION constants defined below.  A return of
 * DB2ACS_API_VERSION_UNKNOWN, or any unrecognized version will cause the
 * execution of this operation to be terminated with an error.
 * ========================================================================== */
typedef db2Uint32 db2ACS_Version;

#define DB2ACS_API_VERSION_UNKNOWN     0
#define DB2ACS_API_VERSION1            1

db2ACS_Version db2ACSQueryApiVersion(void);



/* ==========================================================================
 * DB2 Data Server Identifier
 * ========================================================================== */
typedef struct db2ACS_DB2ID
{
   db2Uint32                  version;
   db2Uint32                  release;
   db2Uint32                  level;
   char                       signature[DB2ACS_SIGNATURE_SZ + 1];
} db2ACS_DB2ID;



/* ==========================================================================
 * Storage Vendor Identifier
 * ========================================================================== */
typedef struct db2ACS_VendorInfo
{
   void                     * vendorCB;              /* Vendor control block  */
   db2Uint32                  version;               /* Current version       */
   db2Uint32                  release;               /* Current release       */
   db2Uint32                  level;                 /* Current level         */
   char                       signature[DB2ACS_MAX_VENDORID_SZ + 1];
} db2ACS_VendorInfo;



/* ==========================================================================
 * Session Info
 * ========================================================================== */
typedef struct db2ACS_SessionInfo
{
   db2ACS_DB2ID               db2ID;

   /* Fields identifying the backup session originator.
    * ----------------------------------------------------------------------- */
   SQL_PDB_NODE_TYPE          dbPartitionNum;
   char                       db[SQL_DBNAME_SZ + 1];
   char                       instance[DB2ACS_MAX_OWNER_SZ + 1];
   char                       host[SQL_HOSTNAME_SZ + 1];
   char                       user[DB2ACS_MAX_OWNER_SZ + 1];
   char                       password[DB2ACS_MAX_PASSWORD_SZ + 1];

   /* The fully qualified ACS vendor library name to be used.
    * ----------------------------------------------------------------------- */
   char                       libraryName[DB2ACS_MAX_PATH_SZ + 1];
} db2ACS_SessionInfo;



/* ==========================================================================
 * Partition List
 *
 * The partition list will contain an array of <numPartsInDB> partition
 * entries, one for each data partition in the database, where the first
 * <numPartsInOperation> partition entries are participating in the
 * operation, and the remaining entries are not.
 *
 * For example, a traditional (db2_all) backup of a DPF system with 5
 * partitions will have a numPartsInDB of 5 and a numPartsInOperation of 1.
 * A SSV backup (BACKUP DB <alias> ... ON ALL DBPARTITIONUMS) will have
 * numPartsInDB == numPartsInOperation.
 *
 * In single-partition, or non-DPF environments, the partition list will
 * consist of a single partition entry for the partition being backed up.
 * ========================================================================== */
typedef struct db2ACS_PartitionEntry
{
   SQL_PDB_NODE_TYPE          num;
   char                       host[SQL_HOSTNAME_SZ + 1];
} db2ACS_PartitionEntry;


typedef struct db2ACS_PartitionList
{
   db2Uint64                  numPartsInDB;
   db2Uint64                  numPartsInOperation;

   db2ACS_PartitionEntry    * partition;
} db2ACS_PartitionList;



/* ==========================================================================
 * Multi-partition Synchronization Modes
 *
 * SYNC_NONE      - No synchronization between related operations on multiple
 *                  database partitions.  Used during operations which do not
 *                  make use of any DPF synchronization.
 *
 * SYNC_SERIAL    - Performing a DPF operation on multiple partitions
 *                  concurrently, where each partition will have its IO
 *                  suspended, the Snapshot() call issued, and IO resumed
 *                  serially, not concurrently.  Those events must complete
 *                  on each partition before they will take place on any other
 *                  partition.
 *
 * SYNC_PARALLEL  - Performing a DPF operation on multiple partitions
 *                  concurrently.  Once all partitions involved in the
 *                  operation have completed their Prepare() calls, IO will
 *                  be suspended on all partitions, and then the remaining
 *                  operation steps will take place concurrently on all
 *                  involved partitions.
 * ========================================================================== */
typedef db2int32 db2ACS_SyncMode;
#define DB2ACS_SYNC_NONE      0
#define DB2ACS_SYNC_SERIAL    1
#define DB2ACS_SYNC_PARALLEL  2



/* ==========================================================================
 * Operation Info
 *
 * The information contained within this structure is only valid within the
 * context of a particular operation.  It will be valid at the time
 * BeginOperation() is called, and will remain unchanged until EndOperation()
 * returns, but must not be referenced outside the scope of an operation.
 * ========================================================================== */
typedef struct db2ACS_OperationInfo
{
   db2ACS_SyncMode            syncMode;

   /* List of database and backup operation partitions.
    *
    * For details, refer to the db2ACS_PartitionList definition.
    * ----------------------------------------------------------------------- */
   db2ACS_PartitionList     * dbPartitionList;
} db2ACS_OperationInfo;



/* ==========================================================================
 * DB2 Backup Adapter User Options
 * ========================================================================== */
typedef struct db2ACS_Options
{
   db2Uint32                  size;
   void                     * data;
} db2ACS_Options;



/* ==========================================================================
 * Object Types
 *
 * DB2ACS_OBJTYPE_ALL can only be used as a filter for queries.  There are no
 * objects of type 0.
 * ========================================================================== */
typedef db2Uint32 db2ACS_ObjectType;
#define DB2ACS_OBJTYPE_ALL       0x00000000
#define DB2ACS_OBJTYPE_BACKUP    0x00000001
#define DB2ACS_OBJTYPE_LOG       0x00000002
#define DB2ACS_OBJTYPE_LOADCOPY  0x00000004
#define DB2ACS_OBJTYPE_SNAPSHOT  0x00000008


/* -------------------------------------------------------------------------- */
typedef struct db2ACS_LogDetails
{
   db2Uint32                  fileID;
   db2Uint32                  chainID;
} db2ACS_LogDetails;


/* -------------------------------------------------------------------------- */
typedef struct db2ACS_BackupDetails
{
   /* A traditional DB2 backup can consist of multiple objects (logical tapes),
    * where each object is uniquely numbered with a non-zero natural number.
    * ----------------------------------------------------------------------- */
   db2Uint32                  sequenceNum;

   char                       imageTimestamp[SQLU_TIME_STAMP_LEN + 1];
} db2ACS_BackupDetails;


/* -------------------------------------------------------------------------- */
typedef struct db2ACS_LoadcopyDetails
{
   /* Just like the BackupDetails, a DB2 load copy can consist of multiple
    * objects (logical tapes), where each object is uniquely numbered with a
    * non-zero natural number.
    * ----------------------------------------------------------------------- */
   db2Uint32                  sequenceNum;

   char                       imageTimestamp[SQLU_TIME_STAMP_LEN + 1];
} db2ACS_LoadcopyDetails;


/* -------------------------------------------------------------------------- */
typedef struct db2ACS_SnapshotDetails
{
   char                       imageTimestamp[SQLU_TIME_STAMP_LEN + 1];
} db2ACS_SnapshotDetails;



/* ==========================================================================
 * Object Description and Associated Information.
 *
 * This structure is used for both input and output, and its contents define
 * the minimum information that must be recorded about any object created
 * through this interface.
 * ========================================================================== */
typedef struct db2ACS_ObjectInfo
{
   db2ACS_ObjectType          type;
   SQL_PDB_NODE_TYPE          dbPartitionNum;

   char                       db[SQL_DBNAME_SZ + 1];
   char                       instance[DB2ACS_MAX_OWNER_SZ + 1];
   char                       host[SQL_HOSTNAME_SZ + 1];
   char                       owner[DB2ACS_MAX_OWNER_SZ + 1];

   union
   {
      db2ACS_BackupDetails    backup;
      db2ACS_LogDetails       log;
      db2ACS_LoadcopyDetails  loadcopy;
      db2ACS_SnapshotDetails  snapshot;
   } details;
} db2ACS_ObjectInfo;



/* ==========================================================================
 * Object Creation Parameters.
 * ========================================================================== */
typedef struct db2ACS_CreateObjectInfo
{
   db2ACS_ObjectInfo          object;
   db2ACS_DB2ID               db2ID;

   /* -----------------------------------------------------------------------
    * The following fields are optional information for the backup adapter to
    * use as it sees fit.
    * ----------------------------------------------------------------------- */

   /* Historically both the size estimate and management
    * class parameters have been used by the TSM client API for traditional
    * backup objects, log archives, and load copies, but not for snapshot
    * backups.
    * ----------------------------------------------------------------------- */
   db2Uint64                  sizeEstimate;
   char                       mgmtClass[DB2ACS_MAX_MGMTCLASS_SZ + 1];

   /* The appOptions is a copy of the iOptions field of flags passed to DB2's
    * db2Backup() API when this execution was initiated.  This field will
    * only contain valid data when creating a backup or snapshot object.
    * ----------------------------------------------------------------------- */
   db2Uint32                  appOptions;
} db2ACS_CreateObjectInfo;



/* ==========================================================================
 * DB2 Backup Adapter Control Block
 * ========================================================================== */
typedef struct db2ACS_CB
{
   /* Output:  Handle value for this session.
    * ----------------------------------------------------------------------- */
   db2Uint32                  handle;
   db2ACS_VendorInfo          vendorInfo;

   /* Input fields and parameters.
    * ----------------------------------------------------------------------- */
   db2ACS_SessionInfo         session;
   db2ACS_Options             options;

   /* Operation info is optional, possibly NULL, and is only ever valid
    * within the context of an operation (from call to BeginOperation() until
    * the EndOperation() call returns).
    *
    * The operation info will be present during creation or read operations
    * of snapshot and backup objects.
    * ----------------------------------------------------------------------- */
   db2ACS_OperationInfo     * operation;
} db2ACS_CB;



/* ==========================================================================
 * Storage Adapter Return Code and Diagnostic Data.
 *
 * These will be recorded in the DB2 diagnostic logs, but are intended to be
 * internal return and reason codes from the storage layers which can be used
 * in conjunction with the DB2ACS_RC to provide more detailed diagnostic info.
 * ========================================================================== */
typedef struct db2ACS_ReturnCode
{
   int                        returnCode;
   int                        reasonCode;
   char                       description[DB2ACS_MAX_COMMENT_SZ + 1];
} db2ACS_ReturnCode;



/* ==========================================================================
 * Session Initialization and Termination APIs.
 * ========================================================================== */
db2ACS_RC db2ACSInitialize(
               db2ACS_CB               * ,
               db2ACS_ReturnCode       *  );


db2ACS_RC db2ACSTerminate(
               db2ACS_CB               * ,
               db2ACS_ReturnCode       *  );



/* ==========================================================================
 * Operation Begin and End Operation APIs.
 *
 * A valid ACS operation is specified by passing an ObjectType OR'd with one of
 * the following Operations, such as:
 *
 *    (DB2ACS_OP_CREATE | DB2ACS_OBJTYPE_SNAPSHOT)
 * ========================================================================== */
typedef db2Uint32 db2ACS_Operation;
#define DB2ACS_OP_CREATE      0x10000000
#define DB2ACS_OP_READ        0x20000000
#define DB2ACS_OP_DELETE      0x40000000

db2ACS_RC db2ACSBeginOperation(
               db2ACS_Operation          ,
               db2ACS_CB               * ,
               db2ACS_ReturnCode       *  );


typedef db2Uint32 db2ACS_EndAction;
#define  DB2ACS_END_COMMIT    0
#define  DB2ACS_END_ABORT     1
/* #define  DB2ACS_END_ABNORMAL  2 */

db2ACS_RC db2ACSEndOperation(
               db2ACS_EndAction          ,
               db2ACS_CB               * ,
               db2ACS_ReturnCode       *  );



/* ==========================================================================
 * The PostObjectInfo is a set of data that can not be known at object
 * creation time, but which must be maintained in the object respository.  This
 * is an optional field on the Verify() call, which may be NULL if there are
 * no post-operation updates to be made.
 * ========================================================================== */
typedef struct db2ACS_PostObjectInfo
{
   /* The first active log will only be valid when creating a backup or
    * snapshot object.  It will indicate the file number and chain id of the first log
    * required for recovery using this object.
    * ----------------------------------------------------------------------- */
   db2ACS_LogDetails          firstActiveLog;
} db2ACS_PostObjectInfo;



/* ==========================================================================
 * An object ID is a unique identifier for each stored object, which is
 * returned by a query to the storage repository.  These object IDs are
 * guaranteed to be unique and persistent only within the the timeframe of a
 * single backup adapter session.
 * ========================================================================== */
typedef db2Uint64 db2ACS_ObjectID;



/* ==========================================================================
 * Object status, progress, and usability.
 * ========================================================================== */
typedef db2int32 db2ACS_ProgressState;
#define DB2ACS_PSTATE_UNKNOWN       0
#define DB2ACS_PSTATE_IN_PROGRESS   1
#define DB2ACS_PSTATE_SUCCESSFUL    2
#define DB2ACS_PSTATE_FAILED        3


typedef db2Uint32 db2ACS_UsabilityState;
#define DB2ACS_USTATE_UNKNOWN                      0x00000000
#define DB2ACS_USTATE_LOCALLY_MOUNTABLE            0x00000001
#define DB2ACS_USTATE_REMOTELY_MOUNTABLE           0x00000002
#define DB2ACS_USTATE_REPETITIVELY_RESTORABLE      0x00000004
#define DB2ACS_USTATE_DESTRUCTIVELY_RESTORABLE     0x00000008
#define DB2ACS_USTATE_SWAP_RESTORABLE              0x00000010
#define DB2ACS_USTATE_PHYSICAL_PROTECTION          0x00000020
#define DB2ACS_USTATE_FULL_COPY                    0x00000040
#define DB2ACS_USTATE_DELETED                      0x00000080
#define DB2ACS_USTATE_FORCED_MOUNT                 0x00000100
#define DB2ACS_USTATE_BACKGROUND_MONITOR_PENDING   0x00000200
#define DB2ACS_USTATE_TAPE_BACKUP_PENDING          0x00000400
#define DB2ACS_USTATE_TAPE_BACKUP_IN_PROGRESS      0x00000800
#define DB2ACS_USTATE_TAPE_BACKUP_COMPLETE         0x00001000
#define DB2ACS_USTATE_INCOMPLETE                   0x00002000


typedef struct db2ACS_ObjectStatus
{
   /* The total and completed bytes refer only to the ACS snapshot backup
    * itself, not to the progress of any offloaded tape backup.
    *
    * A bytesTotal of 0 indicates that the progress could not be determined.
    * ----------------------------------------------------------------------- */
   db2Uint64                  bytesCompleted;
   db2Uint64                  bytesTotal;
   db2ACS_ProgressState       progressState;
   db2ACS_UsabilityState      usabilityState;
} db2ACS_ObjectStatus;



/* ==========================================================================
 * Unique Querying.
 *
 * When using this structure as query input, to indicate the
 * intention to supply a 'wildcard' search criteria, DB2 will supply:
 *
 *    -- character strings as "*".
 *    -- numeric values as (-1), cast as the appropriate signed or unsigned
 *       type.
 * ========================================================================== */
#define DB2ACS_WILDCARD          "*"
#define DB2ACS_ANY_PARTITIONNUM  ((SQL_PDB_NODE_TYPE)(-1))
#define DB2ACS_ANY_UINT32        ((db2Uint32)(-1))

typedef struct db2ACS_ObjectInfo db2ACS_QueryInput;


typedef struct db2ACS_QueryOutput
{
   db2ACS_ObjectID            objectID;
   db2ACS_ObjectInfo          object;
   db2ACS_PostObjectInfo      postInfo;
   db2ACS_DB2ID               db2ID;
   db2ACS_ObjectStatus        status;

   /* Size of the object in bytes.
    * ----------------------------------------------------------------------  */
   db2Uint64                  objectSize;

   /* Size of the metadata associated with the object, if any, in bytes.
    * ----------------------------------------------------------------------  */
   db2Uint64                  metaDataSize;

   /* The creation time of the object is a 64bit value with a definition
    * equivalent to an ANSI C time_t value (seconds since the epoch, GMT).
    *
    * This field is equivalent to the file creation or modification time in
    * a traditional filesystem.  This should be created and stored
    * automatically by the BA subsystem, and a valid time value should be
    * returned with object query results, for all object types.
    * ----------------------------------------------------------------------  */
   db2Uint64                  createTime;
} db2ACS_QueryOutput;



/* ==========================================================================
 * Query APIs.
 * ========================================================================== */
db2ACS_RC db2ACSBeginQuery(
               db2ACS_QueryInput       * ,
               db2ACS_CB               * ,
               db2ACS_ReturnCode       *  );

db2ACS_RC db2ACSGetNextObject(
               db2ACS_QueryOutput      * ,
               db2ACS_CB               * ,
               db2ACS_ReturnCode       *  );

db2ACS_RC db2ACSEndQuery(
               db2ACS_CB               * ,
               db2ACS_ReturnCode       *  );



/* ==========================================================================
 * Snapshot Group List
 *
 * This is an array of size 'numGroupIDs', indicating the set of groups that
 * are to be included in the snapshot operation.
 * ========================================================================== */
typedef struct db2ACS_GroupList
{
   db2Uint32                  numGroupIDs;
   db2Uint32                * id;
} db2ACS_GroupList;



/* ==========================================================================
 * Snapshot File List
 *
 * This is an array of 'numEntries' db2ACS_PathEntry's, where each path entry is
 * a path to some storage on the DB2 server which is in use by the current
 * database.
 * ========================================================================== */
typedef db2Uint32 db2ACS_PathType;
#define DB2ACS_PATH_TYPE_UNKNOWN             0
#define DB2ACS_PATH_TYPE_LOCAL_DB_DIRECTORY  1
#define DB2ACS_PATH_TYPE_DBPATH              2
#define DB2ACS_PATH_TYPE_DB_STORAGE_PATH     3
#define DB2ACS_PATH_TYPE_TBSP_CONTAINER      4
#define DB2ACS_PATH_TYPE_TBSP_DIRECTORY      5
#define DB2ACS_PATH_TYPE_TBSP_DEVICE         6
#define DB2ACS_PATH_TYPE_LOGPATH             7
#define DB2ACS_PATH_TYPE_MIRRORLOGPATH       8


typedef struct db2ACS_PathEntry
{
   /* INPUT: The path and type will be provided by the DB2 server, as well as a
    *        flag indicating if the path is to be excluded from the backup.
    * ----------------------------------------------------------------------- */
   char                       path[DB2ACS_MAX_PATH_SZ + 1];
   db2ACS_PathType            type;
   db2Uint32                  toBeExcluded;

   /* OUTPUT: The group ID is to be provided by the backup adapter for use by
    *         the DB2 server.  The group ID will be used during with snapshot
    *         operations as an indication of which paths are dependent and must
    *         be included together in any snapshot operation.  Unique group IDs
    *         indicate that the paths in those groups are independent for the
    *         purposes of snapshot operations.
    * ----------------------------------------------------------------------- */
   db2Uint32                  groupID;
} db2ACS_PathEntry;


typedef struct db2ACS_PathList
{
   db2Uint32                  numEntries;
   db2ACS_PathEntry         * entry;
} db2ACS_PathList;



/* ==========================================================================
 * Partition
 * ========================================================================== */
db2ACS_RC db2ACSPartition(
               db2ACS_PathList         * ,
               db2ACS_CreateObjectInfo * ,
               db2ACS_CB               * ,
               db2ACS_ReturnCode       *  );



/* ==========================================================================
 * Prepare
 * ========================================================================== */
db2ACS_RC db2ACSPrepare(
               db2ACS_GroupList        * ,
               db2ACS_CB               * ,
               db2ACS_ReturnCode       *  );



/* ==========================================================================
 * Snapshot
 * ========================================================================== */

/* The following actions are supported for snapshot operations.
 * -------------------------------------------------------------------------- */
typedef db2Uint32 db2ACS_Action;
#define DB2ACS_ACTION_WRITE           0x00000000
#define DB2ACS_ACTION_READ_BY_OBJECT  0x00000000
#define DB2ACS_ACTION_READ_BY_GROUP   0x00000001
/* #define DB2ACS_ACTION_READ_BY_PATH     0x00000002 */


/* The ReadList will only be used for snapshots where the action is READ, and
 * where one of the granularity modifiers other than BY_OBJ has been specified.
 * In the typical usage scenario of ( READ | BY_OBJ ) the ReadList parameter
 * should be ignored.
 *
 * When the action is DB2ACS_ACTION_BY_GROUP the union is to be interpreted
 * as a group list.
 *
 * When the action is DB2ACS_ACTION_BY_PATH then it is to be interpreted as a
 * path list, which is not yet defined.
 * -------------------------------------------------------------------------- */
typedef union db2ACS_ReadList
{
   db2ACS_GroupList           group;
} db2ACS_ReadList;


db2ACS_RC db2ACSSnapshot(
               db2ACS_Action             ,
               db2ACS_ObjectID           ,
               db2ACS_ReadList         * ,
               db2ACS_CB               * ,
               db2ACS_ReturnCode       *  );



/* ==========================================================================
 * Verify
 * ========================================================================== */
db2ACS_RC db2ACSVerify(
               db2ACS_PostObjectInfo   * ,
               db2ACS_CB               * ,
               db2ACS_ReturnCode       *  );



/* ==========================================================================
 * Delete
 * ========================================================================== */
db2ACS_RC db2ACSDelete(
               db2ACS_ObjectID           ,
               db2ACS_CB               * ,
               db2ACS_ReturnCode       *  );



/* ==========================================================================
 * Store / Retrieve MetaData APIs
 *
 * The metadata structure itself is internal to DB2 and is to be treated by
 * the storage interface as an unstructured block of data of the given size.
 * ========================================================================== */
typedef struct db2ACS_MetaData
{
   db2Uint64                  size;
   void                     * data;
} db2ACS_MetaData;


db2ACS_RC db2ACSStoreMetaData(
               db2ACS_MetaData         * ,
               db2ACS_CB               * ,
               db2ACS_ReturnCode       *  );


db2ACS_RC db2ACSRetrieveMetaData(
               db2ACS_MetaData         * ,
               db2ACS_ObjectID           ,
               db2ACS_CB               * ,
               db2ACS_ReturnCode       *  );



/* ==========================================================================
 * Read / Write APIs for traditional DB2 backups.
 * ========================================================================== */
/*
typedef struct db2ACS_Data
{
  db2Uint64                   requested;
  db2Uint64                   actual;
  char                      * data;
} db2ACS_Data;


db2ACS_RC db2ACSRead(
               db2ACS_Data             * ,
               db2ACS_CB               * ,
               db2ACS_ReturnCode       *  );


db2ACS_RC db2ACSWrite(
               db2ACS_Data             * ,
               db2ACS_CB               * ,
               db2ACS_ReturnCode       *  );
*/


#if defined(DB2NT)
#pragma pack()
#elif defined(DB2AIX)
#pragma options align=reset
#endif


#ifdef __cplusplus
}
#endif


#endif
