      *************************************************************************
      * 
      * Source File Name: db2ApiDf
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
      * Operating System: Darwin
      * 
      **************************************************************************

      * Version, Release PTF identifier
      * Pre Version 6.1.0.0
       77  DB2VERSION6PRIOR          PIC S9(4) COMP-5 VALUE 0.
      * Version 6.1.0.0
       77  DB2VERSION610             PIC S9(9) COMP-5 VALUE 6010000.
      * Version 7.1.0.0
       77  DB2VERSION710             PIC S9(9) COMP-5 VALUE 7010000.
      * Version 8.1.0.0
       77  DB2VERSION810             PIC S9(9) COMP-5 VALUE 8010000.
      * Version 8.1.0.2
       77  DB2VERSION812             PIC S9(9) COMP-5 VALUE 8010200.
      * Version 8.1.0.4
       77  DB2VERSION814             PIC S9(9) COMP-5 VALUE 8010400.
      * Version 8.2.0.0
       77  DB2VERSION820             PIC S9(9) COMP-5 VALUE 8020000.
      * Version 8.2.0.2
       77  DB2VERSION822             PIC S9(9) COMP-5 VALUE 8020200.
      * Version 9.0.0.0
       77  DB2VERSION900             PIC S9(9) COMP-5 VALUE 9000000.
      * Version 9.5.0.0
       77  DB2VERSION950             PIC S9(9) COMP-5 VALUE 9050000.

      *************************************************************************
      * db2Char data structure
      * db2Char data structure parameters
      * 
      * pioData
      * A pointer to a character data buffer. If NULL, no data will be
      * returned.
      * 
      * iLength
      * Input. The size of the pioData buffer.
      * 
      * oLength
      * Output. The number of valid characters of data in the pioData buffer.
      * 
      **************************************************************************
       01 DB2CHAR.
      * Character data
           05 DB2-PIO-DATA           USAGE IS POINTER.
      * I:  Length of pioData
           05 DB2-I-LENGTH           PIC 9(9) COMP-5.
      * O:  Untruncated length of data
           05 DB2-O-LENGTH           PIC 9(9) COMP-5.



      * Database and Database Manager Configuration Structures, Constants,
      * and Function Prototypes

      * act on database cfg, or
       77  DB2CFG-DATABASE           PIC S9(4) COMP-5 VALUE 1.
      * act on database manager cfg
       77  DB2CFG-DATABASE-MANAGER   PIC S9(4) COMP-5 VALUE 2.
      * get/set current values, or
       77  DB2CFG-IMMEDIATE          PIC S9(4) COMP-5 VALUE 4.
      * get/set delayed values
       77  DB2CFG-DELAYED            PIC S9(4) COMP-5 VALUE 8.
      * get default values
       77  DB2CFG-GET-DEFAULTS       PIC S9(4) COMP-5 VALUE 64.
      * update on specific db partition
       77  DB2CFG-SINGLE-DBPARTITION PIC S9(4) COMP-5 VALUE 512.
      * set to default values (reset)
       77  DB2CFG-RESET              PIC S9(4) COMP-5 VALUE 64.
      * maximum number of params in db2Cfg paramArray
       77  DB2CFG-MAX-PARAM          PIC S9(4) COMP-5 VALUE 64.


      * Constants describing a single configuration parameter
      * let db2 set this value
       77  DB2CFG-PARAM-AUTOMATIC    PIC S9(4) COMP-5 VALUE 1.
      * set to computed. An automatic param calculated once.
       77  DB2CFG-PARAM-COMPUTED     PIC S9(4) COMP-5 VALUE 2.
      * unset the automatic or computed feature, leaving the value intact.
       77  DB2CFG-PARAM-MANUAL       PIC S9(4) COMP-5 VALUE 16.


      *************************************************************************
      * Constants for updating and getting self_tuning_mem.
      * The self_tuning_mem parameter can be updated to ON or OFF
      * and it can return ON, OFF, ON_ACTIVE or ON_INACTIVE.
      * Please refer to the documentation on Self-Tuning Memory.
      **************************************************************************
      * Self tuning is disabled.
       77  DB2SELF-TUNING-OFF        PIC S9(4) COMP-5 VALUE 0.
      * Self tuning is enabled.
       77  DB2SELF-TUNING-ON         PIC S9(4) COMP-5 VALUE 1.
      * Self tuning is enabled and active.
       77  DB2SELF-TUNING-ON-ACTIVE  PIC S9(4) COMP-5 VALUE 2.
      * Self tuning is enabled but inactive.
       77  DB2SELF-TUNING-ON-INACTIVE PIC S9(4) COMP-5 VALUE 3.


      * Structure for a single Configuration Parameter
      *************************************************************************
      * db2CfgParam data structure
      * db2CfgParam data structure parameters
      * 
      * token
      * Input. The configuration parameter identifier.
      * 
      * Valid entries and data types for the db2CfgParam token element are listed in
      * "Configuration parameters summary".
      * 
      * ptrvalue
      * Output. The configuration parameter value. 
      * 
      * flags
      * Input. Provides specific information for each parameter in a request. Valid
      * values (defined in db2ApiDf header file, located in the include
      * directory) are:
      * - db2CfgParamAutomatic
      * Indicates whether the retrieved parameter has a value of automatic. To
      * determine whether a given configuration parameter has been set to
      * automatic, perform a boolean AND operation against the value returned by
      * the flag and the db2CfgParamAutomatic keyword defined in db2ApiDf.h.
      **************************************************************************
       01 DB2CFG-PARAM.
      * Parameter Identifier
           05 DB2-TOKEN              PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Parameter value
           05 DB2-PTRVALUE           USAGE IS POINTER.
      * flags for this parameter
           05 DB2-FLAGS              PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.

      * Main structure for db2CfgSet() and db2CfgGet()
      *************************************************************************
      * db2Cfg data structure
      * db2Cfg data structure parameters
      * 
      * numItems
      * Input. The number of configuration parameters in the paramArray array. Set
      * this value to db2CfgMaxParam to specify the largest number of elements in
      * the paramArray.
      * 
      * paramArray
      * Input. A pointer to the db2CfgParam structure.
      * 
      * flags
      * Input. Specifies the type of action to be taken. Valid values (defined in
      * db2ApiDf header file, located in the include directory) are:
      * - db2CfgDatabase
      * Specifies to return the values in the database configuration file.
      * - db2CfgDatabaseManager
      * Specifies to return the values in the database manager configuration file.
      * - db2CfgImmediate
      * Returns the current values of the configuration parameters stored in
      * memory.
      * - db2CfgDelayed
      * Gets the values of the configuration parameters on disk. These do not
      * become the current values in memory until the next database connection
      * or instance attachment.
      * - db2CfgGetDefaults
      * Returns the default values for the configuration parameter.
      * - db2CfgReset
      * Reset to default values.
      * 
      * dbname
      * Input. The database name.
      * 
      **************************************************************************
       01 DB2CFG.
      * Number of configuration parameters in the following array
           05 DB2-NUM-ITEMS          PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Array of cfg parameters
           05 DB2-PARAM-ARRAY        USAGE IS POINTER.
      * Various properties
           05 DB2-FLAGS              PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Database Name, if needed
           05 DB2-DBNAME             USAGE IS POINTER.
      * Specific database partition number
           05 DB2-DBPARTITIONNUM     PIC S9(4) COMP-5.
           05 FILLER                 PIC X(6)
                                     USAGE DISPLAY NATIVE.

      * API for Setting/Reading the Configuration Parameters
      *************************************************************************
      * db2CfgSet API
      * Modifies individual entries in a specific database configuration file or a
      * database manager configuration file. A database configuration file resides
      * on every node on which the database has been created.
      * 
      * Scope
      * 
      * Modifications to the database configuration file affect the node on which it
      * is executed.
      * 
      * Authorization
      * 
      * For modifications to the database configuration file, one of the following:
      * - sysadm
      * - sysctrl
      * - sysmaint
      * 
      * For modifications to the database manager configuration file:
      * - sysadm
      * 
      * Required connection
      * 
      * To make an online modification of a configuration parameter for a specific
      * database, a connection to the database is required. To make an online
      * modification of a configuration parameter for the database manager,
      * or an attachment to an instance is not required.
      * 
      * API include file
      * 
      * db2ApiDf.h
      * 
      * db2CfgSet API parameters
      * 
      * versionNumber
      * Input. Specifies the version and release level of the structure passed as the
      * second parameter pParmStruct.
      * 
      * pParmStruct
      * Input. A pointer to the db2Cfg structure.
      * 
      * pSqlca
      * Output. A pointer to the sqlca structure.
      * 
      **************************************************************************
      *************************************************************************
      * db2CfgGet API
      * Returns the values of individual entries in a specific database configuration
      * file or a database manager configuration file.
      * 
      * Scope
      * 
      * Information about a specific database configuration file is returned only for
      * the database partition on which it is executed.
      * 
      * Authorization
      * 
      * None
      * 
      * Required connection
      * 
      * To obtain the current online value of a configuration parameter for a
      * specific database configuration file, a connection to the database is
      * required. To obtain the current online value of a configuration parameter
      * for the database manager, an instance attachment is required. Otherwise, a
      * connection to a database or an attachment to an instance is not required.
      * 
      * API include file
      * 
      * db2ApiDf.h
      * 
      * db2CfgGet API parameters
      * 
      * versionNumber
      * Input. Specifies the version and release level of the structure passed as the
      * second parameter pParmStruct.
      * 
      * pParmStruct
      * Input. A pointer to the db2Cfg structure.
      * 
      * pSqlca
      * Output. A pointer to the sqlca structure.
      * 
      **************************************************************************
      * Structure (generic) for a single Configuration Parameter
      *************************************************************************
      * db2gCfgParam data structure
      * db2gCfgParam data structure specific parameters
      * 
      * ptrvalue_len
      * Input. The length in bytes of ptrvalue parameter.
      * 
      **************************************************************************
       01 DB2G-CFG-PARAM.
      * Parameter Identifier
           05 DB2-TOKEN              PIC 9(9) COMP-5.
      * length of ptrvalue
           05 DB2-PTRVALUE-LEN       PIC 9(9) COMP-5.
      * Parameter value
           05 DB2-PTRVALUE           USAGE IS POINTER.
      * flags for this parameter
           05 DB2-FLAGS              PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.

      * Main (generic) structure for db2CfgSet() and db2CfgGet()
      *************************************************************************
      * db2gCfg data structure
      * db2gCfg data structure specific parameters
      * 
      * dbname_len
      * Input. The length in bytes of dbname parameter.
      * 
      **************************************************************************
       01 DB2G-CFG.
      * Number of configuration parameters in the following array
           05 DB2-NUM-ITEMS          PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Array of cfg parameters
           05 DB2-PARAM-ARRAY        USAGE IS POINTER.
      * Various properties
           05 DB2-FLAGS              PIC 9(9) COMP-5.
      * length of dbname
           05 DB2-DBNAME-LEN         PIC 9(9) COMP-5.
      * Database Name, if needed
           05 DB2-DBNAME             USAGE IS POINTER.

      * (Generic) API for Setting/Reading the Configuration Parameters
      *************************************************************************
      * db2gCfgSet API
      **************************************************************************
      *************************************************************************
      * db2gCfgGet API
      **************************************************************************



      * SYSTEM table + NLS function
       77  SQL-CS-SYSTEM-NLSCHAR     PIC S9(4) COMP-5 VALUE -8.
      * USER table + NLS function
       77  SQL-CS-USER-NLSCHAR       PIC S9(4) COMP-5 VALUE -9.
      * Node List Operations Constants
      * submit to all nodes in the node list
       77  DB2-NODE-LIST             PIC S9(4) COMP-5 VALUE 0.
      * submit to all nodes in the node configuration file
       77  DB2-ALL-NODES             PIC S9(4) COMP-5 VALUE 1.
      * submit to all nodes except the ones specified by the nodelist
      * parameter
       77  DB2-ALL-EXCEPT            PIC S9(4) COMP-5 VALUE 2.
      * submit to catalog node only
       77  DB2-CAT-NODE-ONLY         PIC S9(4) COMP-5 VALUE 3.
      * Load Query Structures and Constants

      * Possible values for "iStringType"
      * Tablename specified
       77  DB2LOADQUERY-TABLENAME    PIC S9(4) COMP-5 VALUE 0.
       77  DB2LOADQUERY-TEMPPATHNAME PIC S9(4) COMP-5 VALUE 1.

      * Possible values for "iShowLoadMessages"
      * Show ALL LOAD messages
       77  DB2LOADQUERY-SHOW-ALL-MSGS PIC S9(4) COMP-5 VALUE 0.
      * Show NO LOAD messages
       77  DB2LOADQUERY-SHOW-NO-MSGS PIC S9(4) COMP-5 VALUE 1.
      * Show only NEW LOAD messages
       77  DB2LOADQUERY-SHOW-NEW-MSGS PIC S9(4) COMP-5 VALUE 2.

      * Possible values for "oWhichPhase"
      * Load Phase
       77  DB2LOADQUERY-LOAD-PHASE   PIC S9(4) COMP-5 VALUE 1.
      * Build Phase
       77  DB2LOADQUERY-BUILD-PHASE  PIC S9(4) COMP-5 VALUE 2.
      * Delete Phase
       77  DB2LOADQUERY-DELETE-PHASE PIC S9(4) COMP-5 VALUE 3.
      * Index Copy Phase
       77  DB2LOADQUERY-INDEXCOPY-PHASE PIC S9(4) COMP-5 VALUE 4.

      * Possible values for "oTablestate"
      * Normal tablestate
       77  DB2LOADQUERY-NORMAL       PIC S9(4) COMP-5 VALUE 0.
      * Table in Set Integrity pending state
       77  DB2LOADQUERY-SI-PENDING   PIC S9(4) COMP-5 VALUE 1.
      * For backward source compatibility
       77  DB2LOADQUERY-CHECK-PENDING PIC S9(4) COMP-5 VALUE 1.
      * Load in progress on table
       77  DB2LOADQUERY-LOAD-IN-PROGRESS PIC S9(4) COMP-5 VALUE 2.
      * Table in read access only state
       77  DB2LOADQUERY-READ-ACCESS  PIC S9(4) COMP-5 VALUE 4.
      * Table in unavailable state
       77  DB2LOADQUERY-NOTAVAILABLE PIC S9(4) COMP-5 VALUE 8.
      * Table not in load restartable state
       77  DB2LOADQUERY-NO-LOAD-RESTART PIC S9(4) COMP-5 VALUE 16.
      * Table state has not changed
       77  DB2LOADQUERY-UNCHANGED    PIC S9(4) COMP-5 VALUE 32.
      * Table pending completion of load
       77  DB2LOADQUERY-LOAD-PENDING PIC S9(4) COMP-5 VALUE 64.
      * Table in no data movement state
       77  DB2LOADQUERY-NO-DATA-MOVEMENT PIC S9(4) COMP-5 VALUE 128.
      * Table in datalink reconcile pending state
       77  DB2LOADQUERY-RECONCILE-PENDING PIC S9(4) COMP-5 VALUE 256.
      * Table in datalink reconcile not possible state
       77  DB2LOADQUERY-RECONCILE-NOT-POS PIC S9(4) COMP-5 VALUE 512.
      * Table has type-1 indexes
       77  DB2LOADQUERY-TYPE1-INDEXES PIC S9(4) COMP-5 VALUE 1024.
      * Table in reorg pending state
       77  DB2LOADQUERY-REORG-PENDING PIC S9(4) COMP-5 VALUE 2048.
      * Redistribute in progress on table
       77  DB2LOADQUERY-RDST-IN-PROGRESS PIC S9(4) COMP-5 VALUE 4096.

      * Load Query Output Structure
      *************************************************************************
      * db2LoadQueryOutputStruct data structure
      * db2LoadQueryOutputStruct data structure parameters
      * 
      * oRowsRead
      * Output. Number of records read so far by the load utility.
      * 
      * oRowsSkipped
      * Output. Number of records skipped before the load operation began.
      * 
      * oRowsCommitted
      * Output. Number of rows committed to the target table so far.
      * 
      * oRowsLoaded
      * Output. Number of rows loaded into the target table so far.
      * 
      * oRowsRejected
      * Output. Number of rows rejected from the target table so far.
      * 
      * oRowsDeleted
      * Output. Number of rows deleted from the target table so far (during the
      * delete phase).
      * 
      * oCurrentIndex
      * Output. Index currently being built (during the build phase).
      * 
      * oNumTotalIndexes
      * Output. Total number of indexes to be built (during the build phase).
      * 
      * oCurrentMPPNode
      * Output. Indicates which database partition server is being queried (for
      * partitioned database environment mode only).
      * 
      * oLoadRestarted
      * Output. A flag whose value is TRUE if the load operation being queried is a
      * load restart operation.
      * 
      * oWhichPhase
      * Output. Indicates the current phase of the load operation being queried.
      * Valid values (defined in db2ApiDf header file, located in the include
      * directory) are: 
      * - DB2LOADQUERY_LOAD_PHASE 
      * Load phase. 
      * - DB2LOADQUERY_BUILD_PHASE 
      * Build phase. 
      * - DB2LOADQUERY_DELETE_PHASE 
      * Delete phase.
      * - DB2LOADQUERY_INDEXCOPY_PHASE 
      * Index copy phase. 
      * 
      * oWarningCount
      * Output. Total number of warnings returned so far.
      * 
      * oTableState
      * Output. The table states. Valid values (defined in db2ApiDf header
      * file, located in the include directory) are:
      * 
      * - DB2LOADQUERY_NORMAL
      * No table states affect the table. 
      * 
      * - DB2LOADQUERY_CHECK_PENDING 
      * The table has constraints and the constraints have yet to be verified. Use
      * the SET INTEGRITY command to take the table out of the
      * DB2LOADQUERY_CHECK_PENDING state. The load utility puts a table into the
      * DB2LOADQUERY_CHECK_PENDING state when it begins a load on a table with
      * constraints. 
      * 
      * - DB2LOADQUERY_LOAD_IN_PROGRESS
      * There is a load actively in progress on this table. 
      * 
      * - DB2LOADQUERY_LOAD_PENDING 
      * A load has been active on this table but has been aborted before the load
      * could commit. Issue a load terminate, a load restart, or a load replace
      * to bring the table out of the DB2LOADQUERY_LOAD_PENDING state. 
      * 
      * - DB2LOADQUERY_READ_ACCESS 
      * The table data is available for read access queries. Loads using the
      * DB2LOADQUERY_READ_ACCESS option put the table into Read Access Only state.
      * 
      * - DB2LOADQUERY_NOTAVAILABLE 
      * The table is unavailable. The table may only be dropped or it may be restored
      * from a backup. Rollforward through a non-recoverable load will put a table
      * into the unavailable state. 
      * 
      * - DB2LOADQUERY_NO_LOAD_RESTART 
      * The table is in a partially loaded state that will not allow a load
      * restart. The table will also be in the Load Pending state. Issue a
      * load terminate or a load replace to bring the table out of the No
      * Load Restartable state. The table can be placed in the
      * DB2LOADQUERY_NO_LOAD_RESTART state during a rollforward
      * operation. This can occur if you rollforward to a point in time that
      * is prior to the end of a load operation, or if you roll forward through
      * an aborted load operation but do not roll forward to the end of the load
      * terminate or load restart operation.
      * 
      * - DB2LOADQUERY_TYPE1_INDEXES
      * The table currently uses type-1 indexes. The indexes can be converted to
      * type-2 using the CONVERT option when using the REORG utility on the
      * indexes.
      * 
      **************************************************************************
       01 DB2LOAD-QUERY-OUTPUT-STRUCT.
      * Rows Read
           05 DB2-O-ROWS-READ        PIC 9(9) COMP-5.
      * Rows Skipped
           05 DB2-O-ROWS-SKIPPED     PIC 9(9) COMP-5.
      * Rows Committed
           05 DB2-O-ROWS-COMMITTED   PIC 9(9) COMP-5.
      * Rows Loaded
           05 DB2-O-ROWS-LOADED      PIC 9(9) COMP-5.
      * Rows Rejected
           05 DB2-O-ROWS-REJECTED    PIC 9(9) COMP-5.
      * Rows Deleted
           05 DB2-O-ROWS-DELETED     PIC 9(9) COMP-5.
      * Current Index (BUILD PHASE)
           05 DB2-O-CURRENT-INDEX    PIC 9(9) COMP-5.
      * Total # of Indexes to build (BUILD PHASE)
           05 DB2-O-NUM-TOTAL-INDEXES PIC 9(9) COMP-5.
      * Node being queried (MPP only)
           05 DB2-O-CURRENT-MPPNODE  PIC 9(9) COMP-5.
      * Load Restart indicator
           05 DB2-O-LOAD-RESTARTED   PIC 9(9) COMP-5.
      * Phase of queried Load
           05 DB2-O-WHICH-PHASE      PIC 9(9) COMP-5.
      * Warning Count
           05 DB2-O-WARNING-COUNT    PIC 9(9) COMP-5.
      * Table State
           05 DB2-O-TABLE-STATE      PIC 9(9) COMP-5.

      * Load Query Output Structure - 64 bit counters
      *************************************************************************
      * db2LoadQueryOutputStruct64 data structure
      **************************************************************************
       01 DB2LOAD-QUERY-OUTPUT-STRUCT64.
      * Rows Read
           05 DB2-O-ROWS-READ        PIC 9(18) COMP-5.
      * Rows Skipped
           05 DB2-O-ROWS-SKIPPED     PIC 9(18) COMP-5.
      * Rows Committed
           05 DB2-O-ROWS-COMMITTED   PIC 9(18) COMP-5.
      * Rows Loaded
           05 DB2-O-ROWS-LOADED      PIC 9(18) COMP-5.
      * Rows Rejected
           05 DB2-O-ROWS-REJECTED    PIC 9(18) COMP-5.
      * Rows Deleted
           05 DB2-O-ROWS-DELETED     PIC 9(18) COMP-5.
      * Current Index (BUILD PHASE)
           05 DB2-O-CURRENT-INDEX    PIC 9(9) COMP-5.
      * Total # of Indexes to build (BUILD PHASE)
           05 DB2-O-NUM-TOTAL-INDEXES PIC 9(9) COMP-5.
      * Node being queried (MPP only)
           05 DB2-O-CURRENT-MPPNODE  PIC 9(9) COMP-5.
      * Load Restart indicator
           05 DB2-O-LOAD-RESTARTED   PIC 9(9) COMP-5.
      * Phase of queried Load
           05 DB2-O-WHICH-PHASE      PIC 9(9) COMP-5.
      * Warning Count
           05 DB2-O-WARNING-COUNT    PIC 9(9) COMP-5.
      * Table State
           05 DB2-O-TABLE-STATE      PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.

      * Generic Load Query Parameter Structure
      *************************************************************************
      * db2gLoadQueryStruct data structure
      * db2gLoadQueryStruct data structure specific parameters
      * 
      * iStringLen
      * Input. Specifies the length in bytes of piString parameter.
      * 
      * iLocalMessageFileLen
      * Input. Specifies the length in bytes of piLocalMessageFile
      * parameter.
      * 
      **************************************************************************
       01 DB2G-LOAD-QUERY-STRUCT.
      * Type of piString
           05 DB2-I-STRING-TYPE      PIC 9(9) COMP-5.
      * Length in bytes of piString
           05 DB2-I-STRING-LEN       PIC 9(9) COMP-5.
      * Name to query
           05 DB2-PI-STRING          USAGE IS POINTER.
      * Level of Load message reporting
           05 DB2-I-SHOW-LOAD-MESSAGES PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Load Query Output Structure
           05 DB2-PO-OUTPUT-STRUCT   USAGE IS POINTER.
      * Length in bytes of message file variable
           05 DB2-I-LOCAL-MESSAGE-FILE-LEN PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Message File
           05 DB2-PI-LOCAL-MESSAGE-FILE USAGE IS POINTER.

      * Generic Load Query Parameter Structure - 64 bit counters
      *************************************************************************
      * db2gLoadQueryStru64 data structure
      **************************************************************************
       01 DB2G-LOAD-QUERY-STRU64.
      * Type of piString
           05 DB2-I-STRING-TYPE      PIC 9(9) COMP-5.
      * Length in bytes of piString
           05 DB2-I-STRING-LEN       PIC 9(9) COMP-5.
      * Name to query
           05 DB2-PI-STRING          USAGE IS POINTER.
      * Level of Load message reporting
           05 DB2-I-SHOW-LOAD-MESSAGES PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Load Query Output Structure
           05 DB2-PO-OUTPUT-STRUCT   USAGE IS POINTER.
      * Length in bytes of message file variable
           05 DB2-I-LOCAL-MESSAGE-FILE-LEN PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Message File
           05 DB2-PI-LOCAL-MESSAGE-FILE USAGE IS POINTER.

      *************************************************************************
      * db2gLoadQuery API
      **************************************************************************

      *************************************************************************
      * Common Structures and Constants for Data Movement Utilities
      **************************************************************************

      * Definitions for piXmlParse value
      * Preserve whitespace
       77  DB2DMU-XMLPARSE-PRESERVE-WS PIC S9(4) COMP-5 VALUE 1.
      * Strip whitespace
       77  DB2DMU-XMLPARSE-STRIP-WS  PIC S9(4) COMP-5 VALUE 2.

      * Definitions for iUsing value of db2DMUXmlValidate structure
      * Use XDS
       77  DB2DMU-XMLVAL-XDS         PIC S9(4) COMP-5 VALUE 1.
      * Use a specified schema
       77  DB2DMU-XMLVAL-SCHEMA      PIC S9(4) COMP-5 VALUE 2.
      * Use schemaLocation hints
       77  DB2DMU-XMLVAL-SCHEMALOC-HINTS PIC S9(4) COMP-5 VALUE 3.

      * MAP structure for XMLVALIDATE USING XDS
      *************************************************************************
      * db2DMUXmlMapSchema data structure
      **************************************************************************
       01 DB2DMUXML-MAP-SCHEMA.
      * Schema to map FROM
           05 DB2-I-MAP-FROM-SCHEMA.
      * Character data
               10 DB2-PIO-DATA       USAGE IS POINTER.
      * I:  Length of pioData
               10 DB2-I-LENGTH       PIC 9(9) COMP-5.
      * O:  Untruncated length of data
               10 DB2-O-LENGTH       PIC 9(9) COMP-5.
      * Schema to map TO
           05 DB2-I-MAP-TO-SCHEMA.
      * Character data
               10 DB2-PIO-DATA       USAGE IS POINTER.
      * I:  Length of pioData
               10 DB2-I-LENGTH       PIC 9(9) COMP-5.
      * O:  Untruncated length of data
               10 DB2-O-LENGTH       PIC 9(9) COMP-5.

      * XML Validate USING XDS structure
      *************************************************************************
      * db2DMUXmlValidate data structure
      **************************************************************************
       01 DB2DMUXML-VALIDATE-XDS.
      * DEFAULT schema when using XDS
           05 DB2-PI-DEFAULT-SCHEMA  USAGE IS POINTER.
      * Number of schemas to ignore when using XDS
           05 DB2-I-NUM-IGNORE-SCHEMAS PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Schemas to ignore when using XDS
           05 DB2-PI-IGNORE-SCHEMAS  USAGE IS POINTER.
      * Number of schemas to map when using XDS
           05 DB2-I-NUM-MAP-SCHEMAS  PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Schemas to map when using XDS
           05 DB2-PI-MAP-SCHEMAS     USAGE IS POINTER.

      * XML Validate USING SCHEMA structure
       01 DB2DMUXML-VALIDATE-SCHEMA.
      * Schema to use for validation
           05 DB2-PI-SCHEMA          USAGE IS POINTER.

      * XML Validate structure
       01 DB2DMUXML-VALIDATE.
      * What to use to perform validation
           05 DB2-I-USING            PIC 9(4) COMP-5.
           05 FILLER                 PIC X(6)
                                     USAGE DISPLAY NATIVE.
      * Arguments for XMLVALIDATE USING XDS
           05 DB2-PI-XDS-ARGS        USAGE IS POINTER.
      * Arguments for XMLVALIDATE USING SCHEMA
           05 DB2-PI-SCHEMA-ARGS     USAGE IS POINTER.

      * SourceUserExit structure
       01 DB2LOAD-USER-EXIT.
      * SourceUserExit Command
           05 DB2-I-SOURCE-USER-EXIT-CMD.
      * Character data
               10 DB2-PIO-DATA       USAGE IS POINTER.
      * I:  Length of pioData
               10 DB2-I-LENGTH       PIC 9(9) COMP-5.
      * O:  Untruncated length of data
               10 DB2-O-LENGTH       PIC 9(9) COMP-5.
      * Stdin redirect from buffer for iSourceUserExitCmd
           05 DB2-PI-INPUT-STREAM    USAGE IS POINTER.
      * Stdin redirect from file to iSourceUserExitCmd
           05 DB2-PI-INPUT-FILE-NAME USAGE IS POINTER.
      * Stdout/stderr redirect to file for iSourceUserExitCmd
           05 DB2-PI-OUTPUT-FILE-NAME USAGE IS POINTER.
      * Enable Parallelism for SourceUserExit cmd
           05 DB2-PI-ENABLE-PARALLELISM USAGE IS POINTER.

      * Load Structures and Constants

      * General db2Load constants
      * Max size of db2PartLoadIn - iHostName
       77  DB2LOAD-MAX-HOSTNAME-SZ   PIC S9(4) COMP-5 VALUE 255.
      * Max size of db2PartLoadIn - iFileTransferCmd
       77  DB2LOAD-MAX-FILETRANSFERCMD-SZ PIC S9(4) COMP-5 VALUE 1023.
      * Max size of db2LoadUserExit - iSourceUserExitCmd
       77  DB2LOAD-MAX-USEREXITCMD-SZ PIC S9(4) COMP-5 VALUE 1023.
      * Max size of Load path strings
       77  DB2LOAD-MAX-PATH-SZ       PIC S9(4) COMP-5 VALUE 1023.

      * Load input structure
      *************************************************************************
      * db2LoadIn data structure
      * db2LoadIn data structure parameters
      * 
      * iRowcount
      * Input. The number of physical records to be loaded. Allows a user to load
      * only the first rowcnt rows in a file.
      * 
      * iRestartcount
      * Input. Reserved for future use.
      * 
      * piUseTablespace
      * Input. If the indexes are being rebuilt, a shadow copy of the index is built
      * in tablespace iUseTablespaceName and copied over to the original
      * tablespace at the end of the load. Only system temporary table spaces
      * can be used with this option. If not specified then the shadow index will
      * be created in the same tablespace as the index object.
      * 
      * If the shadow copy is created in the same tablespace as the index
      * object, the copy of the shadow index object over the old index object is
      * instantaneous. If the shadow copy is in a different tablespace from the
      * index object a physical copy is performed. This could involve
      * considerable I/O and time. The copy happens while the table is offline at
      * the end of a load.
      * 
      * This field is ignored if iAccessLevel is SQLU_ALLOW_NO_ACCESS.
      * 
      * This option is ignored if the user does not specify INDEXING MODE
      * REBUILD or INDEXING MODE AUTOSELECT. This option will also be
      * ignored if INDEXING MODE AUTOSELECT is chosen and load chooses
      * to incrementally update the index.
      * 
      * iSavecount
      * The number of records to load before establishing a consistency point.
      * This value is converted to a page count, and rounded up to intervals of the
      * extent size. Since a message is issued at each consistency point, this
      * option should be selected if the load operation will be monitored using
      * db2LoadQuery - Load Query. If the value of savecnt is not sufficiently
      * high, the synchronization of activities performed at each consistency
      * point will impact performance.
      * 
      * The default value is 0, meaning that no consistency points will be
      * established, unless necessary.
      * 
      * iDataBufferSize
      * The number of 4KB pages (regardless of the degree of parallelism) to use
      * as buffered space for transferring data within the utility. If the value
      * specified is less than the algorithmic minimum, the required minimum is
      * used, and no warning is returned.
      * 
      * This memory is allocated directly from the utility heap, whose size can
      * be modified through the util_heap_sz database configuration parameter.
      * 
      * If a value is not specified, an intelligent default is calculated by the
      * utility at run time. The default is based on a percentage of the free
      * space available in the utility heap at the instantiation time of the
      * loader, as well as some characteristics of the table.
      * 
      * iSortBufferSize
      * Input. This option specifies a value that overrides the SORTHEAP
      * database configuration parameter during a load operation. It is relevant
      * only when loading tables with indexes and only when the iIndexingMode
      * parameter is not specified as SQLU_INX_DEFERRED. The value that is
      * specified cannot exceed the value of SORTHEAP. This parameter is
      * useful for throttling the sort memory used by LOAD without changing the
      * value of SORTHEAP, which would also affect general query processing.
      * 
      * iWarningcount
      * Input. Stops the load operation after warningcnt warnings. Set this
      * parameter if no warnings are expected, but verification that the correct file
      * and table are being used is desired. If the load file or the target table is
      * specified incorrectly, the load utility will generate a warning for each row
      * that it attempts to load, which will cause the load to fail. If warningcnt is
      * 0, or this option is not specified, the load operation will continue
      * regardless of the number of warnings issued.
      * 
      * If the load operation is stopped because the threshold of warnings was
      * exceeded, another load operation can be started in RESTART mode. The
      * load operation will automatically continue from the last consistency point.
      * Alternatively, another load operation can be initiated in REPLACE mode,
      * starting at the beginning of the input file.
      * 
      * iHoldQuiesce
      * Input. A flag whose value is set to TRUE if the utility is to leave the
      * table in quiesced exclusive state after the load, and to FALSE if it is
      * not.
      * 
      * iCpuParallelism
      * Input. The number of processes or threads that the load utility will spawn
      * for parsing, converting and formatting records when building table objects.
      * This parameter is designed to exploit intra-partition parallelism. It is
      * particularly useful when loading presorted data, because record order in
      * the source data is preserved. If the value of this parameter is zero, the
      * load utility uses an intelligent default value at run time. Note: If this
      * parameter is used with tables containing either LOB or LONG VARCHAR
      * fields, its value becomes one, regardless of the number of system CPUs,
      * or the value specified by the user.
      * 
      * iDiskParallelism
      * Input. The number of processes or threads that the load utility will spawn
      * for writing data to the table space containers. If a value is not specified,
      * the utility selects an intelligent default based on the number of table
      * space containers and the characteristics of the table.
      * 
      * iNonrecoverable
      * Input. Set to SQLU_NON_RECOVERABLE_LOAD if the load transaction
      * is to be marked as non-recoverable, and it will not be possible to recover
      * it by a subsequent roll forward action. The rollforward utility will skip the
      * transaction, and will mark the table into which data was being loaded as
      * "invalid". The utility will also ignore any subsequent transactions against
      * that table. After the roll forward is completed, such a table can only be
      * dropped. With this option, table spaces are not put in backup pending
      * state following the load operation, and a copy of the loaded data does not
      * have to be made during the load operation. Set to
      * SQLU_RECOVERABLE_LOAD if the load transaction is to be marked as
      * recoverable. 
      * 
      * iIndexingMode
      * Input. Specifies the indexing mode. Valid values (defined in sqlutil header
      * file, located in the include directory) are:
      * - SQLU_INX_AUTOSELECT
      * LOAD chooses between REBUILD and INCREMENTAL indexing
      * modes.
      * - SQLU_INX_REBUILD
      * Rebuild table indexes.
      * - SQLU_INX_INCREMENTAL
      * Extend existing indexes.
      * - SQLU_INX_DEFERRED
      * Do not update table indexes.
      * 
      * iAccessLevel
      * Input. Specifies the access level. Valid values are:
      * - SQLU_ALLOW_NO_ACCESS
      * Specifies that the load locks the table exclusively.
      * - SQLU_ALLOW_READ_ACCESS
      * Specifies that the original data in the table (the non-delta portion)
      * should still be visible to readers while the load is in progress. This
      * option is only valid for load appends, such as a load insert, and will be
      * ignored for load replace.
      * 
      * iLockWithForce
      * Input. A boolean flag. If set to TRUE load will force other applications as
      * necessary to ensure that it obtains table locks immediately. This option
      * requires the same authority as the FORCE APPLICATIONS command
      * (SYSADM or SYSCTRL).
      * 
      * SQLU_ALLOW_NO_ACCESS loads may force conflicting applications at
      * the start of the load operation. At the start of the load the utility may
      * force applications that are attempting to either query or modify the
      * table.
      * 
      * SQLU_ALLOW_READ_ACCESS loads may force conflicting applications
      * at the start or end of the load operation. At the start of the load the load
      * utility may force applications that are attempting to modify the table. At
      * the end of the load the load utility may force applications that are
      * attempting to either query or modify the table.
      * 
      * iCheckPending
      * Input. Specifies to put the table into check pending state. If
      * SQLU_CHECK_PENDING_CASCADE_IMMEDIATE is specified, check
      * pending state will be immediately cascaded to all dependent and
      * descendent tables. If SQLU_CHECK_PENDING_CASCADE_DEFERRED
      * is specified, the cascade of check pending state to dependent tables will
      * be deferred until the target table is checked for integrity violations.
      * SQLU_CHECK_PENDING_CASCADE_DEFERRED is the default if the
      * option is not specified.
      * 
      * iRestartphase
      * Input. Reserved. Valid value is a single space character ' '. 
      * 
      * iStatsOpt
      * Input. Granularity of statistics to collect. Valid values are:
      * - SQLU_STATS_NONE
      * No statistics to be gathered.
      * - SQLU_STATS_USE_PROFILE
      * Statistics are collected based on the profile defined for the current
      * table. This profile must be created using the RUNSTATS command. If
      * no profile exists for the current table, a warning is returned and no
      * statistics are collected.
      * 
      **************************************************************************
       01 DB2LOAD-IN.
      * Row count
           05 DB2-I-ROWCOUNT         PIC 9(18) COMP-5.
      * Restart count
           05 DB2-I-RESTARTCOUNT     PIC 9(18) COMP-5.
      * Alternative Tablespace to rebuild index
           05 DB2-PI-USE-TABLESPACE  USAGE IS POINTER.
      * Save count
           05 DB2-I-SAVECOUNT        PIC 9(9) COMP-5.
      * Data buffer
           05 DB2-I-DATA-BUFFER-SIZE PIC 9(9) COMP-5.
      * Sort buffer (for vendor load sort)
           05 DB2-I-SORT-BUFFER-SIZE PIC 9(9) COMP-5.
      * Warning count
           05 DB2-I-WARNINGCOUNT     PIC 9(9) COMP-5.
      * Hold quiesce between loads
           05 DB2-I-HOLD-QUIESCE     PIC 9(4) COMP-5.
      * CPU parallelism
           05 DB2-I-CPU-PARALLELISM  PIC 9(4) COMP-5.
      * Disk parallelism
           05 DB2-I-DISK-PARALLELISM PIC 9(4) COMP-5.
      * Non-recoverable load
           05 DB2-I-NONRECOVERABLE   PIC 9(4) COMP-5.
      * Indexing mode
           05 DB2-I-INDEXING-MODE    PIC 9(4) COMP-5.
      * Access Level
           05 DB2-I-ACCESS-LEVEL     PIC 9(4) COMP-5.
      * Lock With Force
           05 DB2-I-LOCK-WITH-FORCE  PIC 9(4) COMP-5.
      * Depricated Check Pending Option
           05 DB2-I-CHECK-PENDING    PIC 9(4) COMP-5.
      * Restart phase
           05 DB2-I-RESTARTPHASE     PIC X
                                     USAGE DISPLAY NATIVE.
      * Statistics option
           05 DB2-I-STATS-OPT        PIC X
                                     USAGE DISPLAY NATIVE.
      * Set Integrity Pending Option
           05 DB2-I-SET-INTEGRITY-PENDING PIC 9(4) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * SourceUserExit
           05 DB2-PI-SOURCE-USER-EXIT USAGE IS POINTER.
      * XML parsing
           05 DB2-PI-XML-PARSE       USAGE IS POINTER.
      * XML validation
           05 DB2-PI-XML-VALIDATE    USAGE IS POINTER.

      * Load output structure
      *************************************************************************
      * db2LoadOut data structure
      * db2LoadOut data structure parameters
      * 
      * oRowsRead
      * Output. Number of records read during the load operation.
      * 
      * oRowsSkipped
      * Output. Number of records skipped before the load operation begins.
      * 
      * oRowsLoaded
      * Output. Number of rows loaded into the target table.
      * 
      * oRowsRejected
      * Output. Number of records that could not be loaded.
      * 
      * oRowsDeleted
      * Output. Number of duplicate rows deleted.
      * 
      * oRowsCommitted
      * Output. The total number of processed records: the number of records loaded
      * successfully and committed to the database, plus the number of skipped and
      * rejected records.
      * 
      **************************************************************************
       01 DB2LOAD-OUT.
      * Number of rows read
           05 DB2-O-ROWS-READ        PIC 9(18) COMP-5.
      * Number of rows skipped
           05 DB2-O-ROWS-SKIPPED     PIC 9(18) COMP-5.
      * Number of rows loaded
           05 DB2-O-ROWS-LOADED      PIC 9(18) COMP-5.
      * Number of rows rejected
           05 DB2-O-ROWS-REJECTED    PIC 9(18) COMP-5.
      * Number of rows deleted
           05 DB2-O-ROWS-DELETED     PIC 9(18) COMP-5.
      * Number of rows committed
           05 DB2-O-ROWS-COMMITTED   PIC 9(18) COMP-5.

      *  
      * Partitioned Load structures and constants. These structures are only
      * needed when loading into partitioned databases
      *  

      * Load node list structure
      *************************************************************************
      * db2LoadNodeList data structure
      * db2LoadNodeList data structure parameters
      * 
      * piNodeList
      * Input. An array of node numbers.
      * 
      * iNumNodes
      * Input. The number of nodes in the piNodeList array. A 0 indicates the
      * default, which is all nodes on which the target table is defined.
      * 
      **************************************************************************
       01 DB2LOAD-NODE-LIST.
      * Array of nodes
           05 DB2-PI-NODE-LIST       USAGE IS POINTER.
      * Number of nodes
           05 DB2-I-NUM-NODES        PIC 9(4) COMP-5.
           05 FILLER                 PIC X(6)
                                     USAGE DISPLAY NATIVE.

      * Load port range structure
      *************************************************************************
      * db2LoadPortRange data structure
      * db2LoadPortRange data structure parameters
      * 
      * iPortMin
      * Input. Lower port number.
      * 
      * iPortMax
      * Input. Higher port number.
      * 
      **************************************************************************
       01 DB2LOAD-PORT-RANGE.
      * Minimum port number
           05 DB2-I-PORT-MIN         PIC 9(4) COMP-5.
      * Maximum port number
           05 DB2-I-PORT-MAX         PIC 9(4) COMP-5.

      * Possible values for db2PartLoadInfoIn - iMode
      * Partition and Load mode
       77  DB2LOAD-PARTITION-AND-LOAD PIC S9(4) COMP-5 VALUE 0.
      * Partition only mode
       77  DB2LOAD-PARTITION-ONLY    PIC S9(4) COMP-5 VALUE 1.
      * Load only mode
       77  DB2LOAD-LOAD-ONLY         PIC S9(4) COMP-5 VALUE 2.
      * Load file with no partition header
       77  DB2LOAD-LOAD-ONLY-VERIFY-PART PIC S9(4) COMP-5 VALUE 3.
      * Generate optimal partition map
       77  DB2LOAD-ANALYZE           PIC S9(4) COMP-5 VALUE 4.

      * Possible values for db2PartLoadInfoIn - iIsolatePartErrs
      * Setup errors only
       77  DB2LOAD-SETUP-ERRS-ONLY   PIC S9(4) COMP-5 VALUE 0.
      * Load errors only
       77  DB2LOAD-LOAD-ERRS-ONLY    PIC S9(4) COMP-5 VALUE 1.
      * Setup and Load errors
       77  DB2LOAD-SETUP-AND-LOAD-ERRS PIC S9(4) COMP-5 VALUE 2.
      * No partition error isolation
       77  DB2LOAD-NO-ISOLATION      PIC S9(4) COMP-5 VALUE 3.

      * Partitioned Load input structure
      *   -- assign NULL to a field to indicate default value is desired
      *************************************************************************
      * db2PartLoadIn data structure
      * db2PartLoadIn data structure parameters
      * 
      * piHostname
      * Input. The hostname for the iFileTransferCmd parameter. If NULL, the hostname
      * will default to "nohost". 
      * 
      * piFileTransferCmd
      * Input. File transfer command parameter. If not required, it must be set
      * to NULL. See the Data Movement Guide for a full description of this
      * parameter.
      * 
      * piPartFileLocation
      * Input. In PARTITION_ONLY, LOAD_ONLY, and LOAD_ONLY_VERIFY_PART
      * modes, this parameter can be used to specify the location of the partitioned
      * files. This location must exist on each database partition specified by the
      * piOutputNodes option.
      * 
      * For the SQL_CURSOR file type, this parameter cannot be NULL and the
      * location does not refer to a path, but to a fully qualified file name.
      * This will be the fully qualified base file name of the partitioned files
      * that are created on each output database partition for PARTITION_ONLY mode,
      * or the location of the files to be read from each database partition for
      * LOAD_ONLY mode. For PARTITION_ONLY mode, multiple files may be created
      * with the specified base name if there are LOB columns in the target table.
      * For file types other than SQL_CURSOR, if the value of this parameter is
      * NULL, it will default to the current directory.
      * 
      * piOutputNodes
      * Input. The list of Load output database partitions. A NULL indicates that
      * all nodes on which the target table is defined.
      * 
      * piPartitioningNodes
      * Input. The list of partitioning nodes. A NULL indicates the default. Refer to
      * the Load command in the Data Movement Guide and Reference for a
      * description of how the default is determined.
      * 
      * piMode
      * Input. Specifies the load mode for partitioned databases. Valid values
      * (defined in db2ApiDf header file, located in the include directory) are:
      * 
      * - DB2LOAD_PARTITION_AND_LOAD
      * Data is distributed (perhaps in parallel) and loaded simultaneously on
      * the corresponding database partitions.
      * 
      * - DB2LOAD_PARTITION_ONLY
      * Data is distributed (perhaps in parallel) and the output is written to files
      * in a specified location on each loading database partition. For file types
      * other than SQL_CURSOR, the name of the output file on each database
      * partition will have the form filename.xxx, where filename is the name of
      * the first input file specified by piSourceList and xxx is the database
      * partition number.For the SQL_CURSOR file type, the name of the output file
      * on each database partition will be determined by the piPartFileLocation
      * parameter. Refer to the piPartFileLocation parameter for information about
      * how to specify the location of the database partition file on each
      * database partition.
      * Note:
      * This mode cannot be used for a CLI LOAD.
      * 
      * - DB2LOAD_LOAD_ONLY
      * Data is assumed to be already distributed; the distribution process is
      * skipped, and the data is loaded simultaneously on the corresponding
      * database partitions. For file types other than SQL_CURSOR, the input
      * file name on each database partition is expected to be of the form
      * filename.xxx, where filename is the name of the first file specified
      * by piSourceList and xxx is the 13-digit database partition number.
      * For the SQL_CURSOR file type, the name of the input file on each
      * database partition will be determined by the piPartFileLocation
      * parameter. Refer to the piPartFileLocation parameter for information
      * about how to specify the location of the database partition file on
      * each database partition.
      * Note:
      * This mode cannot be used when loading a data file located on a
      * remote client, nor can it be used for a CLI LOAD.
      * 
      * - DB2LOAD_LOAD_ONLY_VERIFY_PART
      * Data is assumed to be already distributed, but the data file does not
      * contain a database partition header. The distribution process is
      * skipped, and the data is loaded simultaneously on the corresponding
      * database partitions. During the load operation, each row is checked to
      * verify that it is on the correct database partition. Rows containing
      * database partition violations are placed in a dumpfile if the dumpfile
      * file type modifier is specified. Otherwise, the rows are discarded. If
      * database partition violations exist on a particular loading database
      * partition, a single warning will be written to the load message file for
      * that database partition. The input file name on each database partition
      * is expected to be of the form filename.xxx, where filename is the name
      * of the first file specified by piSourceList and xxx is the 13-digit
      * database partition number.
      * Note:
      * This mode cannot be used when loading a data file located on a remote client,
      * nor can it be used for a CLI LOAD.
      * 
      * - DB2LOAD_ANALYZE
      * An optimal distribution map with even distribution across all database
      * partitions is generated.
      * 
      * piMaxNumPartAgents
      * Input. The maximum number of partitioning agents. A NULL value indicates the
      * default, which is 25.
      * 
      * piIsolatePartErrs
      * Input. Indicates how the load operation will react to errors that occur on
      * individual database partitions. Valid values (defined in db2ApiDf header
      * file, located in the include directory) are:
      * 
      * - DB2LOAD_SETUP_ERRS_ONLY
      * In this mode, errors that occur on a database partition during setup, such
      * as problems accessing a database partition or problems accessing a table
      * space or table on a database partition, will cause the load operation to
      * stop on the failing database partitions but to continue on the remaining
      * database partitions. Errors that occur on a database partition while data
      * is being loaded will cause the entire operation to fail and rollback to
      * the last point of consistency on each database partition.
      * 
      * - DB2LOAD_LOAD_ERRS_ONLY
      * In this mode, errors that occur on a database partition during setup
      * will cause the entire load operation to fail. When an error occurs while
      * data is being loaded, the database partitions with errors will be rolled
      * back to their last point of consistency. The load operation will
      * continue on the remaining database partitions until a failure occurs or
      * until all the data is loaded. On the database partitions where all of the
      * data was loaded, the data will not be visible following the load operation.
      * Because of the errors in the other database partitions the transaction will
      * be aborted. Data on all of the database partitions will remain invisible
      * until a load restart operation is performed. This will make the newly
      * loaded data visible on the database partitions where the load operation
      * completed and resume the load operation on database partitions that
      * experienced an error.
      * Note:
      * This mode cannot be used when iAccessLevel is set to SQLU_ALLOW_READ_ACCESS
      * and a copy target is also specified.
      * 
      * - DB2LOAD_SETUP_AND_LOAD_ERRS
      * In this mode, database partition-level errors during setup or loading data
      * cause processing to stop only on the affected database partitions. As with
      * the DB2LOAD_LOAD_ERRS_ONLY mode, when database partition errors do occur
      * while data is being loaded, the data on all database partitions will
      * remain invisible until a load restart operation is performed.
      * 
      * Note:
      * This mode cannot 1be used when iAccessLevel is set to SQLU_ALLOW_READ_ACCESS
      * and a copy target is also specified.
      * 
      * - DB2LOAD_NO_ISOLATION
      * Any error during the Load operation causes the transaction to be aborted.
      * If this parameter is NULL, it will default to DB2LOAD_LOAD_ERRS_ONLY, unless
      * iAccessLevel is set to SQLU_ALLOW_READ_ACCESS and a copy target is also
      * specified, in which case the default is DB2LOAD_NO_ISOLATION.
      * 
      * piStatusInterval
      * Input. Specifies the number of megabytes (MB) of data to load before
      * generating a progress message. Valid values are whole numbers in the
      * range of 1 to 4000. If NULL is specified, a default value of 100 will
      * be used.
      * 
      * piPortRange
      * Input. The TCP port range for internal communication. If NULL, the port range
      * used will be 6000-6063.
      * 
      * piCheckTruncation
      * Input. Causes Load to check for record truncation at Input/Output. Valid
      * values are TRUE and FALSE. If NULL, the default is FALSE.
      * 
      * piMapFileInput
      * Input. Distribution map input filename. If the mode is not ANALYZE, this
      * parameter should be set to NULL. If the mode is ANALYZE, this parameter
      * must be specified.
      * 
      * piMapFileOutput
      * Input. Distribution map output filename. The rules for piMapFileInput apply
      * here as well.
      * 
      * piTrace
      * Input. Specifies the number of records to trace when you need to review
      * a dump of all the data conversion process and the output of hashing
      * values. If NULL, the number of records defaults to 0.
      * 
      * piNewline
      * Input. Forces Load to check for newline characters at end of ASC data records
      * if RECLEN file type modifier is also specified. Possible values are TRUE and
      * FALSE. If NULL, the value defaults to FALSE.
      * 
      * piDistfile
      * Input. Name of the database partition distribution file. If a NULL is
      * specified, the value defaults to "DISTFILE". 
      * 
      * piOmitHeader
      * Input. Indicates that a distribution map header should not be included in the
      * database partition file when using DB2LOAD_PARTITION_ONLY mode. Possible
      * values are TRUE and FALSE. If NULL, the default is FALSE.
      * 
      * piRunStatDBPartNum
      * Specifies the database partition on which to collect statistics. The default
      * value is the first database partition in the output database partition list.
      * 
      **************************************************************************
       01 DB2PART-LOAD-IN.
      * Hostname for iFileTransferCmd parameter
           05 DB2-PI-HOSTNAME        USAGE IS POINTER.
      * File transfer command
           05 DB2-PI-FILE-TRANSFER-CMD USAGE IS POINTER.
      * Partition file location
           05 DB2-PI-PART-FILE-LOCATION USAGE IS POINTER.
      * Output nodes
           05 DB2-PI-OUTPUT-NODES    USAGE IS POINTER.
      * Partitioning nodes
           05 DB2-PI-PARTITIONING-NODES USAGE IS POINTER.
      * Partitioned Load mode
           05 DB2-PI-MODE            USAGE IS POINTER.
      * Max number of partitioning agents
           05 DB2-PI-MAX-NUM-PART-AGENTS USAGE IS POINTER.
      * Partition error isolation mode
           05 DB2-PI-ISOLATE-PART-ERRS USAGE IS POINTER.
      * Status report interval
           05 DB2-PI-STATUS-INTERVAL USAGE IS POINTER.
      * Port number range
           05 DB2-PI-PORT-RANGE      USAGE IS POINTER.
      * Check for record truncation
           05 DB2-PI-CHECK-TRUNCATION USAGE IS POINTER.
      * Map file input
           05 DB2-PI-MAP-FILE-INPUT  USAGE IS POINTER.
      * Map file output
           05 DB2-PI-MAP-FILE-OUTPUT USAGE IS POINTER.
      * Number of records to trace
           05 DB2-PI-TRACE           USAGE IS POINTER.
      * Check for newlines at end of ASC records
           05 DB2-PI-NEWLINE         USAGE IS POINTER.
      * Partition distribution output file
           05 DB2-PI-DISTFILE        USAGE IS POINTER.
      * Don't generate partition header in output file
           05 DB2-PI-OMIT-HEADER     USAGE IS POINTER.
      * runstat node
           05 DB2-PI-RUN-STAT-DBPART-NUM USAGE IS POINTER.

      * Possible values for db2LoadAgentInfo - oAgentType
      * Load agent (one per output node, not used for PARTITION_ONLY and
      * ANALYZE modes)
       77  DB2LOAD-LOAD-AGENT        PIC S9(4) COMP-5 VALUE 0.
      * Partitioning agent (one per partitioning node, not used for
      * LOAD_ONLY and LOAD_ONLY_VERIFY_PART modes)
       77  DB2LOAD-PARTITIONING-AGENT PIC S9(4) COMP-5 VALUE 1.
      * Pre-partitioning agent (one at coordinator node, not used for
      * LOAD_ONLY and LOAD_ONLY_VERIFY_PART modes)
       77  DB2LOAD-PRE-PARTITIONING-AGENT PIC S9(4) COMP-5 VALUE 2.
      * File transfer agent (only for FILE_TRANSFER_CMD option)
       77  DB2LOAD-FILE-TRANSFER-AGENT PIC S9(4) COMP-5 VALUE 3.
      * For PARTITION_ONLY mode (one per output node)
       77  DB2LOAD-LOAD-TO-FILE-AGENT PIC S9(4) COMP-5 VALUE 4.

      * Load agent info structure.  Load will generate an agent info
      * structure for each agent working on behalf of the Load command
      *************************************************************************
      * db2LoadAgentInfo data structure
      * db2LoadAgentInfo data structure parameters
      * 
      * oSqlcode
      * Output. The final sqlcode resulting from the agent's processing.
      * 
      * oTableState
      * Output. The purpose of this output parameter is not to report every possible
      * state of the table after the load operation. Rather, its purpose is to report
      * only a small subset of possible tablestates in order to give the caller a
      * general idea of what happened to the table during load processing. This value
      * is relevant for load agents only. The possible values are:
      * 
      * - DB2LOADQUERY_NORMAL
      * Indicates that the load completed successfully on the database partition and
      * the table was taken out of the LOAD IN PROGRESS (or LOAD PENDING) state. In
      * this case, the table still could be in CHECK PENDING state due to the need
      * for further constraints processing, but this will not reported as this is
      * normal. 
      * 
      * - DB2LOADQUERY_UNCHANGED
      * Indicates that the load job aborted processing due to an error but did
      * not yet change the state of the table on the database partition from
      * whatever state it was in prior to calling db2Load. It is not necessary to
      * perform a load restart or terminate operation on such database partitions.
      * 
      * - DB2LOADQUERY_LOADPENDING
      * Indicates that the load job aborted during processing but left the table
      * on the database partition in the LOAD PENDING state, indicating that the
      * load job on that database partition must be either terminated or restarted.
      * 
      * oNodeNum
      * Output. The number of the database partition on which the agent executed.
      * 
      * oAgentType
      * Output. The agent type. Valid values (defined in db2ApiDf header file,
      * located in the include directory) are :
      * - DB2LOAD_LOAD_AGENT
      * - DB2LOAD_PARTITIONING_AGENT
      * - DB2LOAD_PRE_PARTITIONING_AGENT
      * - DB2LOAD_FILE_TRANSFER_AGENT
      * - DB2LOAD_LOAD_TO_FILE_AGENT
      * 
      **************************************************************************
       01 DB2LOAD-AGENT-INFO.
      * Agent sqlcode
           05 DB2-O-SQLCODE          PIC S9(9) COMP-5.
      * Table state (only relevant for agents of type DB2LOAD_LOAD_AGENT)
           05 DB2-O-TABLE-STATE      PIC 9(9) COMP-5.
      * Node on which agent executed
           05 DB2-O-NODE-NUM         PIC S9(4) COMP-5.
      * Agent type (see above for possible values)
           05 DB2-O-AGENT-TYPE       PIC 9(4) COMP-5.

      * Partitioned Load output structure
      *************************************************************************
      * db2PartLoadOut data structure
      * db2PartLoadOut data structure parameters
      * 
      * oRowsRdPartAgents
      * Output. Total number of rows read by all partitioning agents.
      * 
      * oRowsRejPartAgents
      * Output. Total number of rows rejected by all partitioning agents.
      * 
      * oRowsPartitioned
      * Output. Total number of rows partitioned by all partitioning agents.
      * 
      * poAgentInfoList
      * Output. During a load operation into a partitioned database, the following
      * load processing entities may be involved: load agents, partitioning agents,
      * pre-partitioing agents, file transfer command agents and load-to-file agents
      * (these are described in the Data Movement Guide). The purpose of the
      * poAgentInfoList output parameter is to return to the caller information about
      * each load agent that participated in a load operation. Each entry in the list
      * contains the following information:
      * - oAgentType. A tag indicating what kind of load agent the entry describes.
      * - oNodeNum. The number of the database partition on which the agent executed.
      * - oSqlcode. The final sqlcode resulting from the agent's processing.
      * - oTableState. The final status of the table on the database partition on
      * which the agent executed (relevant only for load agents).
      * It is up to the caller of the API to allocate memory for this list prior to
      * calling the API. The caller should also indicate the number of entries for
      * which they allocated memory in the iMaxAgentInfoEntries parameter. If the
      * caller sets poAgentInfoList to NULL or sets iMaxAgentInfoEntries to 0,
      * then no information will be returned about the load agents. 
      * 
      * iMaxAgentInfoEntries
      * Input. The maximum number of agent information entries allocated by the user
      * for poAgentInfoList. In general, setting this parameter to 3 times the number
      * of database partitions involved in the load operation should be sufficient.
      * 
      * oNumAgentInfoEntries
      * Output. The actual number of agent information entries produced by the load
      * operation. This number of entries will be returned to the user in the
      * poAgentInfoList parameter as long as iMaxAgentInfoEntries is greater than
      * or equal to oNumAgentInfoEntries. If iMaxAgentInfoEntries is less than
      * oNumAgentInfoEntries, then the number of entries returned in poAgentInfoList
      * is equal to iMaxAgentInfoEntries.
      * 
      **************************************************************************
       01 DB2PART-LOAD-OUT.
      * Rows read by partitioning agents
           05 DB2-O-ROWS-RD-PART-AGENTS PIC 9(18) COMP-5.
      * Rows rejected by partitioning agents
           05 DB2-O-ROWS-REJ-PART-AGENTS PIC 9(18) COMP-5.
      * Rows partitioned by partitioning agents
           05 DB2-O-ROWS-PARTITIONED PIC 9(18) COMP-5.
      * Node output info list
           05 DB2-PO-AGENT-INFO-LIST USAGE IS POINTER.
      * Max number of agent info entries allocated by user for
      * poAgentInfoList. This should at least include space for the
      * partitioning agents, load agents, and one pre-partitioning agent
           05 DB2-I-MAX-AGENT-INFO-ENTRIES PIC 9(9) COMP-5.
      * Number of agent info entries produced by load.  The number of
      * entries in poAgentInfoList is min(iMaxAgentInfoEntries,
      * oNumAgentInfoEntries).
           05 DB2-O-NUM-AGENT-INFO-ENTRIES PIC 9(9) COMP-5.

      *  
      * db2Load parameter structure
      *   -- For non-partitioned database loads, set piLoadInfoIn and
      * poLoadInfoOut to NULL
      *   -- For partitioned database loads, set piLoadInfoIn to NULL to
      * request default values for all partitioned database load options
      *  
      *************************************************************************
      * db2LoadStruct data structure
      * db2LoadStruct data structure parameters
      * 
      * piSourceList
      * Input. A pointer to an sqlu_media_list structure used to provide a list of
      * source files, devices, vendors, pipes, or SQL statements.
      * 
      * The information provided in this structure depends on the value of the
      * media_type field. Valid values (defined in sqlutil header file, located
      * in the include directory) are:
      * 
      * - SQLU_SQL_STMT
      * If the media_type field is set to this value, the caller provides an SQL
      * query through the pStatement field of the target field. The pStatement
      * field is of type sqlu_statement_entry. The sessions field must be set to
      * the value of 1, since the load utility only accepts a single SQL query
      * per load.
      * 
      * - SQLU_SERVER_LOCATION
      * If the media_type field is set to this value, the caller provides
      * information through sqlu_location_entry structures. The sessions field
      * indicates the number of sqlu_location_entry structures provided. This
      * is used for files, devices, and named pipes.
      * 
      * - SQLU_CLIENT_LOCATION
      * If the media_type field is set to this value, the caller provides
      * information through sqlu_location_entry structures. The sessions field
      * indicates the number of sqlu_location_entry structures provided. This
      * is used for fully qualified files and named pipes. Note that this
      * media_type is only valid if the API is being called via a remotely
      * connected client.
      * 
      * - SQLU_TSM_MEDIA
      * If the media_type field is set to this value, the sqlu_vendor structure is
      * used, where filename is the unique identifier for the data to be loaded.
      * There should only be one sqlu_vendor entry, regardless of the value of
      * sessions. The sessions field indicates the number of TSM sessions to
      * initiate. The load utility will start the sessions with different sequence
      * numbers, but with the same data in the one sqlu_vendor entry.
      * 
      * - SQLU_OTHER_MEDIA
      * If the media_type field is set to this value, the sqlu_vendor structure is
      * used, where shr_lib is the shared library name, and filename is the
      * unique identifier for the data to be loaded. There should only be one
      * sqlu_vendor entry, regardless of the value of sessions. The sessions
      * field indicates the number of other vendor sessions to initiate. The load
      * utility will start the sessions with different sequence numbers, but with
      * the same data in the one sqlu_vendor entry.
      * 
      * piLobPathList
      * Input. A pointer to an sqlu_media_list structure. For IXF, ASC, and DEL
      * file types, a list of fully qualified paths or devices to identify the
      * location of the individual LOB files to be loaded. The file names are
      * found in the IXF, ASC, or DEL files, and are appended to the paths
      * provided.
      * 
      * The information provided in this structure depends on the value of the
      * media_type field. Valid values (defined in sqlutil header file,
      * located in the include directory) are:
      * 
      * - SQLU_LOCAL_MEDIA
      * If set to this value, the caller provides information through
      * sqlu_media_entry structures. The sessions field indicates the number
      * of sqlu_media_entry structures provided.
      * 
      * - SQLU_TSM_MEDIA
      * If set to this value, the sqlu_vendor structure is used, where filename
      * is the unique identifier for the data to be loaded. There should only be
      * one sqlu_vendor entry, regardless of the value of sessions. The
      * sessions field indicates the number of TSM sessions to initiate. The
      * load utility will start the sessions with different sequence numbers, but
      * with the same data in the one sqlu_vendor entry.
      * 
      * - SQLU_OTHER_MEDIA
      * If set to this value, the sqlu_vendor structure is used, where shr_lib
      * is the shared library name, and filename is the unique identifier for the
      * data to be loaded. There should only be one sqlu_vendor entry,
      * regardless of the value of sessions. The sessions field indicates the
      * number of other vendor sessions to initiate. The load utility will start the
      * sessions with different sequence numbers, but with the same data in
      * the one sqlu_vendor entry.
      * 
      * piDataDescriptor
      * Input. Pointer to an sqldcol structure containing information about the
      * columns being selected for loading from the external file.
      * 
      * If the pFileType parameter is set to SQL_ASC, the dcolmeth field of this
      * structure must either be set to SQL_METH_L or be set to SQL_METH_D and
      * specifies a file name with POSITIONSFILE pFileTypeMod modifier which
      * contains starting and ending pairs and null indicator positions. The user
      * specifies the start and end locations for each column to be loaded.
      * 
      * If the file type is SQL_DEL, dcolmeth can be either SQL_METH_P or
      * SQL_METH_D. If it is SQL_METH_P, the user must provide the source column
      * position. If it is SQL_METH_D, the first column in the file is loaded
      * into the first column of the table, and so on.
      * 
      * If the file type is SQL_IXF, dcolmeth can be one of SQL_METH_P, SQL_METH_D,
      * or SQL_METH_N. The rules for DEL files apply here, except that SQL_METH_N
      * indicates that file column names are to be provided in the sqldcol
      * structure.
      * 
      * piActionString
      * Input. Pointer to an sqlchar structure, followed by an array of characters
      * specifying an action that affects the table.
      * 
      * The character array is of the form:
      * "INSERT|REPLACE|RESTART|TERMINATE
      * INTO tbname [(column_list)]
      * [DATALINK SPECIFICATION datalink-spec]
      * [FOR EXCEPTION e_tbname]"
      * 
      * INSERT
      * Adds the loaded data to the table without changing the existing table
      * data.
      * 
      * REPLACE
      * Deletes all existing data from the table, and inserts the loaded data.
      * The table definition and the index definitions are not changed.
      * 
      * RESTART
      * Restarts a previously interrupted load operation. The load operation will
      * automatically continue from the last consistency point in the load,
      * build, or delete phase.
      * 
      * TERMINATE
      * Terminates a previously interrupted load operation, and rolls back the
      * operation to the point in time at which it started, even if consistency
      * points were passed. The states of any table spaces involved in the
      * operation return to normal, and all table objects are made consistent
      * (index objects may be marked as invalid, in which case index rebuild
      * will automatically take place at next access). If the table spaces in
      * which the table resides are not in load pending state, this option does
      * not affect the state of the table spaces.
      * 
      * The load terminate option will not remove a backup pending state from
      * table spaces.
      * 
      * tbname
      * The name of the table into which the data is to be loaded. The table
      * cannot be a system table or a declared temporary table. An alias, or
      * the fully qualified or unqualified table name can be specified. A qualified
      * table name is in the form schema.tablename. If an unqualified table
      * name is specified, the table will be qualified with the CURRENT
      * SCHEMA.
      * 
      * (column_list)
      * A list of table column names into which the data is to be inserted. The
      * column names must be separated by commas. If a name contains
      * spaces or lowercase characters, it must be enclosed by quotation
      * marks.
      * 
      * DATALINK SPECIFICATION datalink-spec
      * Specifies parameters pertaining to DB2 Data Links. These parameters
      * can be specified using the same syntax as in the LOAD command.
      * 
      * FOR EXCEPTION e_tbname
      * Specifies the exception table into which rows in error will be copied.
      * Any row that is in violation of a unique index or a primary key index is
      * copied. DATALINK exceptions are also captured in the exception table.
      * 
      * piFileType
      * Input. A string that indicates the format of the input data source.
      * Supported external formats (defined in sqlutil) are:
      * 
      * SQL_ASC
      * Non-delimited ASCII.
      * 
      * SQL_DEL
      * Delimited ASCII, for exchange with dBase, BASIC, and the IBM
      * Personal Decision Series programs, and many other database
      * managers and file managers.
      * 
      * SQL_IXF
      * PC version of the Integrated Exchange Format, the preferred method for
      * exporting data from a table so that it can be loaded later into the same
      * table or into another database manager table.
      * 
      * SQL_CURSOR
      * An SQL query. The sqlu_media_list structure passed in through the
      * piSourceList parameter is of type SQLU_SQL_STMT, and refers to an
      * actual SQL query and not a cursor declared against one.
      * 
      * piFileTypeMod
      * Input. A pointer to the sqlchar structure, followed by an array of
      * characters that specify one or more processing options. If this pointer is
      * NULL, or the structure pointed to has zero characters, this action is
      * interpreted as selection of a default specification.
      * 
      * Not all options can be used with all of the supported file types. See
      * related link "File type modifiers for the load utility."
      * 
      * piLocalMsgFileName
      * Input. A string containing the name of a local file to which output
      * messages are to be written.
      * 
      * piTempFilesPath
      * Input. A string containing the path name to be used on the server for
      * temporary files. Temporary files are created to store messages,
      * consistency points, and delete phase information.
      * 
      * piVendorSortWorkPaths
      * Input. A pointer to the sqlu_media_list structure which specifies the
      * Vendor Sort work directories.
      * 
      * piCopyTargetList
      * Input. A pointer to an sqlu_media_list structure used (if a copy image is
      * to be created) to provide a list of target paths, devices, or a shared
      * library to which the copy image is to be written.
      * 
      * The values provided in this structure depend on the value of the
      * media_type field. Valid values for this parameter (defined in sqlutil
      * header file, located in the include directory) are:
      * 
      * - SQLU_LOCAL_MEDIA
      * If the copy is to be written to local media, set the media_type to this
      * value and provide information about the targets in sqlu_media_entry
      * structures. The sessions field specifies the number of
      * sqlu_media_entry structures provided.
      * 
      * - SQLU_TSM_MEDIA
      * If the copy is to be written to TSM, use this value. No further
      * information is required.
      * 
      * - SQLU_OTHER_MEDIA
      * If a vendor product is to be used, use this value and provide further
      * information via an sqlu_vendor structure. Set the shr_lib field of this
      * structure to the shared library name of the vendor product. Provide only
      * one sqlu_vendor entry, regardless of the value of sessions. The
      * sessions field specifies the number of sqlu_media_entry structures
      * provided. The load utility will start the sessions with different sequence
      * numbers, but with the same data provided in the one sqlu_vendor
      * entry.
      * 
      * piNullIndicators
      * Input. For ASC files only. An array of integers that indicate whether or not
      * the column data is nullable. There is a one-to-one ordered
      * correspondence between the elements of this array and the columns
      * being loaded from the data file. That is, the number of elements must
      * equal the dcolnum field of the pDataDescriptor parameter. Each element
      * of the array contains a number identifying a location in the data file
      * that is to be used as a NULL indicator field, or a zero indicating that
      * the table column is not nullable. If the element is not zero, the
      * identified location in the data file must contain a Y or an N. A Y
      * indicates that the table column data is NULL, and N indicates that the
      * table column data is not NULL.
      * 
      * piLoadInfoIn
      * Input. A pointer to the db2LoadIn structure.
      * 
      * poLoadInfoOut
      * Input. A pointer to the db2LoadOut structure.
      * 
      * piPartLoadInfoIn
      * Input. A pointer to the db2PartLoadIn structure.
      * 
      * poPartLoadInfoOut
      * Output. A pointer to the db2PartLoadOut structure.
      * 
      * iCallerAction
      * Input. An action requested by the caller. Valid values (defined in sqlutil
      * header file, located in the include directory)
      * are:
      * 
      * - SQLU_INITIAL
      * Initial call. This value (or SQLU_NOINTERRUPT) must be used on the
      * first call to the API.
      * 
      * - SQLU_NOINTERRUPT
      * Initial call. Do not suspend processing. This value (or SQLU_INITIAL)
      * must be used on the first call to the API.
      * 
      * If the initial call or any subsequent call returns and requires the calling
      * application to perform some action prior to completing the requested load
      * operation, the caller action must be set to one of the following:
      * 
      * - SQLU_CONTINUE
      * Continue processing. This value can only be used on subsequent calls
      * to the API, after the initial call has returned with the utility requesting
      * user input (for example, to respond to an end of tape condition). It
      * specifies that the user action requested by the utility has completed,
      * and the utility can continue processing the initial request.
      * 
      * - SQLU_TERMINATE
      * Terminate processing. Causes the load utility to exit prematurely,
      * leaving the table spaces being loaded in LOAD_PENDING state. This
      * option should be specified if further processing of the data is not to be
      * done.
      * 
      * - SQLU_ABORT
      * Terminate processing. Causes the load utility to exit prematurely,
      * leaving the table spaces being loaded in LOAD_PENDING state. This
      * option should be specified if further processing of the data is not to be
      * done.
      * 
      * - SQLU_RESTART
      * Restart processing.
      * 
      * - SQLU_DEVICE_TERMINATE
      * Terminate a single device. This option should be specified if the utility
      * is to stop reading data from the device, but further processing of the
      * data is to be done.
      * 
      **************************************************************************
       01 DB2LOAD-STRUCT.
      * List of input source names (files, pipes, etc.)
           05 DB2-PI-SOURCE-LIST     USAGE IS POINTER.
      * Lob file paths
           05 DB2-PI-LOB-PATH-LIST   USAGE IS POINTER.
      * Data descriptor list
           05 DB2-PI-DATA-DESCRIPTOR USAGE IS POINTER.
      * Deprecated
           05 DB2-PI-ACTION-STRING   USAGE IS POINTER.
      * File type (ASC, DEL, IXF, WSF, etc.)
           05 DB2-PI-FILE-TYPE       USAGE IS POINTER.
      * File type modifier string
           05 DB2-PI-FILE-TYPE-MOD   USAGE IS POINTER.
      * Message filename
           05 DB2-PI-LOCAL-MSG-FILE-NAME USAGE IS POINTER.
      * Temporary files path
           05 DB2-PI-TEMP-FILES-PATH USAGE IS POINTER.
      * Vendor Sort work directories
           05 DB2-PI-VENDOR-SORT-WORK-PATHS USAGE IS POINTER.
      * List of Load copy targets
           05 DB2-PI-COPY-TARGET-LIST USAGE IS POINTER.
      * Null indicators
           05 DB2-PI-NULL-INDICATORS USAGE IS POINTER.
      * Load input structure
           05 DB2-PI-LOAD-INFO-IN    USAGE IS POINTER.
      * Load output structure
           05 DB2-PO-LOAD-INFO-OUT   USAGE IS POINTER.
      * Partitioned Load input structure
           05 DB2-PI-PART-LOAD-INFO-IN USAGE IS POINTER.
      * Partitioned Load output structure
           05 DB2-PO-PART-LOAD-INFO-OUT USAGE IS POINTER.
      * Caller action
           05 DB2-I-CALLER-ACTION    PIC S9(4) COMP-5.
           05 FILLER                 PIC X(6)
                                     USAGE DISPLAY NATIVE.
      * Long Load action string
           05 DB2-PI-LONG-ACTION-STRING USAGE IS POINTER.
      * XML file paths
           05 DB2-PI-XML-PATH-LIST   USAGE IS POINTER.

      * db2Load - API
      *  
      * db2gLoad structures
      *  

      * Generic Load input structure
      *************************************************************************
      * db2gLoadIn data structure
      * db2gLoadIn data structure specific parameters
      * 
      * iUseTablespaceLen
      * Input. The length in bytes of piUseTablespace parameter.
      * 
      **************************************************************************
       01 DB2G-LOAD-IN.
      * Row count
           05 DB2-I-ROWCOUNT         PIC 9(18) COMP-5.
      * Restart count
           05 DB2-I-RESTARTCOUNT     PIC 9(18) COMP-5.
      * Alternative Tablespace to rebuild index
           05 DB2-PI-USE-TABLESPACE  USAGE IS POINTER.
      * Save count
           05 DB2-I-SAVECOUNT        PIC 9(9) COMP-5.
      * Data buffer
           05 DB2-I-DATA-BUFFER-SIZE PIC 9(9) COMP-5.
      * Sort buffer (for vendor load sort)
           05 DB2-I-SORT-BUFFER-SIZE PIC 9(9) COMP-5.
      * Warning count
           05 DB2-I-WARNINGCOUNT     PIC 9(9) COMP-5.
      * Hold quiesce between loads
           05 DB2-I-HOLD-QUIESCE     PIC 9(4) COMP-5.
      * CPU parallelism
           05 DB2-I-CPU-PARALLELISM  PIC 9(4) COMP-5.
      * Disk parallelism
           05 DB2-I-DISK-PARALLELISM PIC 9(4) COMP-5.
      * Non-recoverable load
           05 DB2-I-NONRECOVERABLE   PIC 9(4) COMP-5.
      * Indexing mode
           05 DB2-I-INDEXING-MODE    PIC 9(4) COMP-5.
      * Access Level
           05 DB2-I-ACCESS-LEVEL     PIC 9(4) COMP-5.
      * Lock With Force
           05 DB2-I-LOCK-WITH-FORCE  PIC 9(4) COMP-5.
      * Check Pending Option
           05 DB2-I-CHECK-PENDING    PIC 9(4) COMP-5.
      * Restart phase
           05 DB2-I-RESTARTPHASE     PIC X
                                     USAGE DISPLAY NATIVE.
      * Statistics option
           05 DB2-I-STATS-OPT        PIC X
                                     USAGE DISPLAY NATIVE.
      * Length of piUseTablespace string
           05 DB2-I-USE-TABLESPACE-LEN PIC 9(4) COMP-5.
      * Set Integrity Pending Option
           05 DB2-I-SET-INTEGRITY-PENDING PIC 9(4) COMP-5.
           05 FILLER                 PIC X(2)
                                     USAGE DISPLAY NATIVE.
      * SourceUserExit
           05 DB2-PI-SOURCE-USER-EXIT USAGE IS POINTER.
      * XML parsing
           05 DB2-PI-XML-PARSE       USAGE IS POINTER.
      * XML validation
           05 DB2-PI-XML-VALIDATE    USAGE IS POINTER.

      * Generic Partitioned Load input structure
      *************************************************************************
      * db2gPartLoadIn data structure
      * db2gPartLoadIn data structure specific parameters
      * 
      * piReserved1
      * Reserved for future use.
      * 
      * iHostnameLen
      * Input. The length in bytes of piHostname parameter.
      * 
      * iFileTransferLen
      * Input. The length in bytes of piFileTransferCmd parameter.
      * 
      * iPartFileLocLen
      * Input. The length in bytes of piPartFileLocation parameter.
      * 
      * iMapFileInputLen
      * Input. The length in bytes of piMapFileInput parameter.
      * 
      * iMapFileOutputLen
      * Input. The length in bytes of piMapFileOutput parameter.
      * 
      * iDistfileLen
      * Input. The length in bytes of piDistfile parameter.
      * 
      **************************************************************************
       01 DB2G-PART-LOAD-IN.
      * Hostname for iFileTransferCmd parameter
           05 DB2-PI-HOSTNAME        USAGE IS POINTER.
      * File transfer command
           05 DB2-PI-FILE-TRANSFER-CMD USAGE IS POINTER.
      * Partition file location
           05 DB2-PI-PART-FILE-LOCATION USAGE IS POINTER.
      * Output nodes
           05 DB2-PI-OUTPUT-NODES    USAGE IS POINTER.
      * Partitioning nodes
           05 DB2-PI-PARTITIONING-NODES USAGE IS POINTER.
      * Partitioned Load mode
           05 DB2-PI-MODE            USAGE IS POINTER.
      * Max number of partitioning agents
           05 DB2-PI-MAX-NUM-PART-AGENTS USAGE IS POINTER.
      * Partition error isolation mode
           05 DB2-PI-ISOLATE-PART-ERRS USAGE IS POINTER.
      * Status report interval
           05 DB2-PI-STATUS-INTERVAL USAGE IS POINTER.
      * Port number range
           05 DB2-PI-PORT-RANGE      USAGE IS POINTER.
      * Check for record truncation
           05 DB2-PI-CHECK-TRUNCATION USAGE IS POINTER.
      * Map file input
           05 DB2-PI-MAP-FILE-INPUT  USAGE IS POINTER.
      * Map file output
           05 DB2-PI-MAP-FILE-OUTPUT USAGE IS POINTER.
      * Number of records to trace
           05 DB2-PI-TRACE           USAGE IS POINTER.
      * Check for newlines at end of ASC records
           05 DB2-PI-NEWLINE         USAGE IS POINTER.
      * Partition distribution output file
           05 DB2-PI-DISTFILE        USAGE IS POINTER.
      * Don't generate partition header in output file
           05 DB2-PI-OMIT-HEADER     USAGE IS POINTER.
      * Reserved parameter 1
           05 DB2-PI-RESERVED1       USAGE IS POINTER.
      * Length of iHostname string
           05 DB2-I-HOSTNAME-LEN     PIC 9(4) COMP-5.
      * Length of iFileTransferCmd string
           05 DB2-I-FILE-TRANSFER-LEN PIC 9(4) COMP-5.
      * Length of iPartFileLocation string
           05 DB2-I-PART-FILE-LOC-LEN PIC 9(4) COMP-5.
      * Length of iMapFileInput string
           05 DB2-I-MAP-FILE-INPUT-LEN PIC 9(4) COMP-5.
      * Length of iMapFileOutput string
           05 DB2-I-MAP-FILE-OUTPUT-LEN PIC 9(4) COMP-5.
      * Length of iDistfile string
           05 DB2-I-DISTFILE-LEN     PIC 9(4) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.

      * db2gLoad parameter structure
      *************************************************************************
      * db2gLoadStruct data structure
      * db2gLoadStruct data structure specific parameters
      * 
      * iFileTypeLen
      * Input. Specifies the length in bytes of iFileType parameter. 
      * 
      * iLocalMsgFileLen
      * Input. Specifies the length in bytes of iLocalMsgFileName
      * parameter.
      * 
      * iTempFilesPathLen
      * Input. Specifies the length in bytes of iTempFilesPath parameter.
      * 
      **************************************************************************
       01 DB2G-LOAD-STRUCT.
      * List of input source names (files, pipes, etc.)
           05 DB2-PI-SOURCE-LIST     USAGE IS POINTER.
      * Lob file paths
           05 DB2-PI-LOB-PATH-LIST   USAGE IS POINTER.
      * Data descriptor list
           05 DB2-PI-DATA-DESCRIPTOR USAGE IS POINTER.
      * Deprecated
           05 DB2-PI-ACTION-STRING   USAGE IS POINTER.
      * File type (ASC, DEL, IXF, WSF, etc.)
           05 DB2-PI-FILE-TYPE       USAGE IS POINTER.
      * File type modifier string
           05 DB2-PI-FILE-TYPE-MOD   USAGE IS POINTER.
      * Message filename
           05 DB2-PI-LOCAL-MSG-FILE-NAME USAGE IS POINTER.
      * Temporary files path
           05 DB2-PI-TEMP-FILES-PATH USAGE IS POINTER.
      * Vendor Sort work directories
           05 DB2-PI-VENDOR-SORT-WORK-PATHS USAGE IS POINTER.
      * List of Load copy targets
           05 DB2-PI-COPY-TARGET-LIST USAGE IS POINTER.
      * Null indicators
           05 DB2-PI-NULL-INDICATORS USAGE IS POINTER.
      * Load input structure
           05 DB2-PI-LOAD-INFO-IN    USAGE IS POINTER.
      * Load output structure
           05 DB2-PO-LOAD-INFO-OUT   USAGE IS POINTER.
      * Partitioned Load input structure
           05 DB2-PI-PART-LOAD-INFO-IN USAGE IS POINTER.
      * Partitioned Load output structure
           05 DB2-PO-PART-LOAD-INFO-OUT USAGE IS POINTER.
      * Caller action
           05 DB2-I-CALLER-ACTION    PIC S9(4) COMP-5.
      * Length of iFileType string
           05 DB2-I-FILE-TYPE-LEN    PIC 9(4) COMP-5.
      * Length of iLocalMsgFileName string
           05 DB2-I-LOCAL-MSG-FILE-LEN PIC 9(4) COMP-5.
      * Length of iTempFilesPath string
           05 DB2-I-TEMP-FILES-PATH-LEN PIC 9(4) COMP-5.
      * Long Load action string
           05 DB2-PI-LONG-ACTION-STRING USAGE IS POINTER.
      * XML file paths
           05 DB2-PI-XML-PATH-LIST   USAGE IS POINTER.

      * db2Load - Generic API
      *************************************************************************
      * db2gLoad API
      **************************************************************************

      * Import Structures and Constants

      * Respect db cfg LOCKTIMEOUT
       77  DB2IMPORT-LOCKTIMEOUT     PIC S9(4) COMP-5 VALUE 0.
      * Override db cfg LOCKTIMEOUT
       77  DB2IMPORT-NO-LOCKTIMEOUT  PIC S9(4) COMP-5 VALUE 1.
      * Use automatic commitcount
       77  DB2IMPORT-COMMIT-AUTO     PIC S9(4) COMP-5 VALUE -1.

      * Generic Import input structure
      *************************************************************************
      * db2gImportIn data structure
      **************************************************************************
       01 DB2G-IMPORT-IN.
      * Row count
           05 DB2-I-ROWCOUNT         PIC 9(18) COMP-5.
      * Restart count
           05 DB2-I-RESTARTCOUNT     PIC 9(18) COMP-5.
      * Skip count
           05 DB2-I-SKIPCOUNT        PIC 9(18) COMP-5.
      * Commit count
           05 DB2-PI-COMMITCOUNT     USAGE IS POINTER.
      * Warning count
           05 DB2-I-WARNINGCOUNT     PIC 9(9) COMP-5.
      * No lock timeout
           05 DB2-I-NO-TIMEOUT       PIC 9(4) COMP-5.
      * Access level
           05 DB2-I-ACCESS-LEVEL     PIC 9(4) COMP-5.
      * XML parsing
           05 DB2-PI-XML-PARSE       USAGE IS POINTER.
      * XML validation
           05 DB2-PI-XML-VALIDATE    USAGE IS POINTER.

      * Generic Import output structure
      *************************************************************************
      * db2gImportOut data structure
      **************************************************************************
       01 DB2G-IMPORT-OUT.
      * Rows read
           05 DB2-O-ROWS-READ        PIC 9(18) COMP-5.
      * Rows skipped
           05 DB2-O-ROWS-SKIPPED     PIC 9(18) COMP-5.
      * Rows inserted
           05 DB2-O-ROWS-INSERTED    PIC 9(18) COMP-5.
      * Rows updated
           05 DB2-O-ROWS-UPDATED     PIC 9(18) COMP-5.
      * Rows rejected
           05 DB2-O-ROWS-REJECTED    PIC 9(18) COMP-5.
      * Rows committed
           05 DB2-O-ROWS-COMMITTED   PIC 9(18) COMP-5.

      * db2gImport parameter structure
      *************************************************************************
      * db2gImportStruct data structure
      * db2gImportStruct data structure specific parameters
      * 
      * iDataFileNameLen
      * Input. Specifies the length in bytes of piDataFileName parameter.
      * 
      * iFileTypeLen
      * Input. Specifies the length in bytes of piFileType parameter.
      * 
      * iMsgFileNameLen
      * Input. Specifies the length in bytes of piMsgFileName parameter.
      * 
      **************************************************************************
       01 DB2G-IMPORT-STRUCT.
      * Data file name
           05 DB2-PI-DATA-FILE-NAME  USAGE IS POINTER.
      * Lob file paths
           05 DB2-PI-LOB-PATH-LIST   USAGE IS POINTER.
      * Data descriptor list
           05 DB2-PI-DATA-DESCRIPTOR USAGE IS POINTER.
      * Deprecated
           05 DB2-PI-ACTION-STRING   USAGE IS POINTER.
      * File type (ASC, DEL, IXF, WSF, etc.)
           05 DB2-PI-FILE-TYPE       USAGE IS POINTER.
      * File type modifier string
           05 DB2-PI-FILE-TYPE-MOD   USAGE IS POINTER.
      * Message filename
           05 DB2-PI-MSG-FILE-NAME   USAGE IS POINTER.
      * Caller action
           05 DB2-I-CALLER-ACTION    PIC S9(4) COMP-5.
           05 FILLER                 PIC X(2)
                                     USAGE DISPLAY NATIVE.
      * Import input structure
           05 DB2-PI-IMPORT-INFO-IN  USAGE IS POINTER.
      * Import output structure
           05 DB2-PO-IMPORT-INFO-OUT USAGE IS POINTER.
      * Null indicators
           05 DB2-PI-NULL-INDICATORS USAGE IS POINTER.
      * Length of iDataFileName string
           05 DB2-I-DATA-FILE-NAME-LEN PIC 9(4) COMP-5.
      * Length of iFileType string
           05 DB2-I-FILE-TYPE-LEN    PIC 9(4) COMP-5.
      * Length of iMsgFileName string
           05 DB2-I-MSG-FILE-NAME-LEN PIC 9(4) COMP-5.
           05 FILLER                 PIC X(2)
                                     USAGE DISPLAY NATIVE.
      * XML file paths
           05 DB2-PI-XML-PATH-LIST   USAGE IS POINTER.
      * Long Import action string
           05 DB2-PI-LONG-ACTION-STRING USAGE IS POINTER.
      * db2gImport - Generic API
      *************************************************************************
      * db2gImport API
      **************************************************************************

      * Export Structures and Constants

      * Export input structure
      *************************************************************************
      * db2ExportIn data structure
      **************************************************************************
       01 DB2EXPORT-IN.
      * Save XML schemas used to validate XML documents
           05 DB2-PI-XML-SAVE-SCHEMA USAGE IS POINTER.

      * Export output structure
      *************************************************************************
      * db2ExportOut data structure
      * db2ExportOut data structure parameters
      * 
      * oRowsExported
      * Output. Returns the number of records exported to the target file.
      * 
      **************************************************************************
       01 DB2EXPORT-OUT.
      * Rows Exported
           05 DB2-O-ROWS-EXPORTED    PIC 9(18) COMP-5.

      * db2gExport parameter structure
      *************************************************************************
      * db2gExportStruct data structure
      * db2gExportStruct data structure specific parameters
      * 
      * iDataFileNameLen
      * Input. A 2-byte unsigned integer representing the length in bytes of the
      * data file name.
      * 
      * iFileTypeLen
      * Input. A 2-byte unsigned integer representing the length in bytes of the
      * file type.
      * 
      * iMsgFileNameLen
      * Input. A 2-byte unsigned integer representing the length in bytes of the
      * message file name.
      * 
      **************************************************************************
       01 DB2G-EXPORT-STRUCT.
      * Data file name
           05 DB2-PI-DATA-FILE-NAME  USAGE IS POINTER.
      * Lob file paths
           05 DB2-PI-LOB-PATH-LIST   USAGE IS POINTER.
      * Lob file files
           05 DB2-PI-LOB-FILE-LIST   USAGE IS POINTER.
      * Data descriptor list
           05 DB2-PI-DATA-DESCRIPTOR USAGE IS POINTER.
      * Export action string
           05 DB2-PI-ACTION-STRING   USAGE IS POINTER.
      * File type (ASC, DEL, IXF, WSF, etc.)
           05 DB2-PI-FILE-TYPE       USAGE IS POINTER.
      * File type modifier string
           05 DB2-PI-FILE-TYPE-MOD   USAGE IS POINTER.
      * Message filename
           05 DB2-PI-MSG-FILE-NAME   USAGE IS POINTER.
      * Caller action
           05 DB2-I-CALLER-ACTION    PIC S9(4) COMP-5.
           05 FILLER                 PIC X(2)
                                     USAGE DISPLAY NATIVE.
      * Export output structure
           05 DB2-PO-EXPORT-INFO-OUT USAGE IS POINTER.
      * Length of piDataFileName string
           05 DB2-I-DATA-FILE-NAME-LEN PIC 9(4) COMP-5.
      * Length of piFileType string
           05 DB2-I-FILE-TYPE-LEN    PIC 9(4) COMP-5.
      * Length of piMsgFileName string
           05 DB2-I-MSG-FILE-NAME-LEN PIC 9(4) COMP-5.
           05 FILLER                 PIC X(2)
                                     USAGE DISPLAY NATIVE.
      * Export input structure
           05 DB2-PI-EXPORT-INFO-IN  USAGE IS POINTER.
      * XML file paths
           05 DB2-PI-XML-PATH-LIST   USAGE IS POINTER.
      * XML file lists
           05 DB2-PI-XML-FILE-LIST   USAGE IS POINTER.

      * db2gExport - Generic API
      *************************************************************************
      * db2gExport API
      **************************************************************************

      * Open History Scan Definitions

      * Values for db2HistoryOpen - iCallerAction
       77  DB2HISTORY-LIST-HISTORY   PIC S9(4) COMP-5 VALUE 0.
       77  DB2HISTORY-LIST-BACKUP    PIC S9(4) COMP-5 VALUE 1.
       77  DB2HISTORY-LIST-ROLLFORWARD PIC S9(4) COMP-5 VALUE 2.
       77  DB2HISTORY-LIST-REORG     PIC S9(4) COMP-5 VALUE 4.
       77  DB2HISTORY-LIST-ALT-TABLESPACE PIC S9(4) COMP-5 VALUE 5.
       77  DB2HISTORY-LIST-DROPPED-TABLE PIC S9(4) COMP-5 VALUE 6.
       77  DB2HISTORY-LIST-LOAD      PIC S9(4) COMP-5 VALUE 7.
       77  DB2HISTORY-LIST-REN-TABLESPACE PIC S9(4) COMP-5 VALUE 8.
       77  DB2HISTORY-LIST-CRT-TABLESPACE PIC S9(4) COMP-5 VALUE 9.
       77  DB2HISTORY-LIST-ARCHIVE-LOG PIC S9(4) COMP-5 VALUE 10.

      * db2gHistoryOpen input struct
      *************************************************************************
      * db2gHistoryOpenStruct data structure
      * db2gHistoryOpenStruct data structure specific parameters
      * 
      * iAliasLen
      * Input. Specifies the length in bytes of the database alias string.
      * 
      * iTimestampLen
      * Input. Specifies the length in bytes of the timestamp string.
      * 
      * iObjectNameLen
      * Input. Specifies the length in bytes of the object name string.
      * 
      **************************************************************************
       01 DB2G-HISTORY-OPEN-STRUCT.
      * DB to fetch history from
           05 DB2-PI-DATABASE-ALIAS  USAGE IS POINTER.
      * Since this timestamp
           05 DB2-PI-TIMESTAMP       USAGE IS POINTER.
      * Entries containing this object
           05 DB2-PI-OBJECT-NAME     USAGE IS POINTER.
      * Length of database alias string
           05 DB2-I-ALIAS-LEN        PIC 9(9) COMP-5 VALUE 0.
      * Length of timestamp string
           05 DB2-I-TIMESTAMP-LEN    PIC 9(9) COMP-5 VALUE 0.
      * Length of object name string
           05 DB2-I-OBJECT-NAME-LEN  PIC 9(9) COMP-5 VALUE 0.
      * # of entries matching search
           05 DB2-O-NUM-ROWS         PIC 9(9) COMP-5.
      * Max. # of tablespace names stored with ANY history entry
           05 DB2-O-MAX-TBSPACES     PIC 9(9) COMP-5.
      * Caller action
           05 DB2-I-CALLER-ACTION    PIC 9(4) COMP-5.
      * Handle for this scan
           05 DB2-O-HANDLE           PIC 9(4) COMP-5.

      * db2gHistoryOpenScan - Generic API
      *************************************************************************
      * db2gHistoryOpenScan API
      **************************************************************************

      * Fetch Next History Entry Definitions

      * Structure db2HistoryEID
      *************************************************************************
      * db2HistoryEID data structure
      * db2HistoryEID data structure parameters
      * 
      * ioNode
      * This parameter can be used as either an input or output parameter.
      * Indicates the node number.
      * 
      * ioHID
      * This parameter can be used as either an input or output parameter.
      * Indicates the local history file entry ID.
      * 
      **************************************************************************
       01 DB2HISTORY-EID.
      * Node number
           05 DB2-IO-NODE            PIC S9(4) COMP-5.
           05 FILLER                 PIC X(2)
                                     USAGE DISPLAY NATIVE.
      * Local history file entry ID
           05 DB2-IO-HID             PIC 9(9) COMP-5.

      * Max Sizes of db2HistoryDataStruct db2Char fields
      * NOTE:  These lengths do not include NULL terminators
       77  DB2HISTORY-TIMESTAMP-SZ   PIC S9(4) COMP-5 VALUE 14.
       77  DB2HISTORY-SEQNUM-SZ      PIC S9(4) COMP-5 VALUE 3.
       77  DB2HISTORY-OBJPART-SZ     PIC S9(4) COMP-5 VALUE 17.
       77  DB2HISTORY-LOGFILE-SZ     PIC S9(4) COMP-5 VALUE 12.
       77  DB2HISTORY-ID-SZ          PIC S9(4) COMP-5 VALUE 24.
       77  DB2HISTORY-TABLE-QUAL-SZ  PIC S9(4) COMP-5 VALUE 128.
       77  DB2HISTORY-TABLE-NAME-SZ  PIC S9(4) COMP-5 VALUE 128.
       77  DB2HISTORY-LOCATION-SZ    PIC S9(4) COMP-5 VALUE 255.
       77  DB2HISTORY-COMMENT-SZ     PIC S9(4) COMP-5 VALUE 30.
       77  DB2HISTORY-COMMAND-SZ     PIC S9(9) COMP-5 VALUE 2097152.

      * Structure db2HistoryData
      * 
      * Description:
      *      ioHistDataID      -- Eye catcher, must be set to "SQLUHINF"
      * 
      *      oObjectPart       -- Start time + sequence number
      *                        -- DB2HISTORY_OBJPART_SZ
      * 
      *      oEndTime          -- Completion timestamp
      *                        -- DB2HISTORY_TIMESTAMP_SZ
      * 
      *      oFirstLog         -- First log file referrenced by event
      *                        -- DB2HISTORY_LOGFILE_SZ
      * 
      *      oLastLog          -- Last log file referrenced by event
      *                        -- DB2HISTORY_LOGFILE_SZ
      * 
      *      oID               -- Backup ID (timestamp), or unique table ID
      *                        -- DB2HISTORY_ID_SZ
      * 
      *      oTableQualifier   -- Table qualifier
      *                        -- DB2HISTORY_TABLE_QUAL_SZ
      * 
      *      oTableName        -- Table name
      *                        -- DB2HISTORY_TABLE_NAME_SZ
      * 
      *      oLocation         -- Location of object used or produced by
      * event
      *                        -- DB2HISTORY_LOCATION_SZ
      * 
      *      oComment          -- Text comment
      *                        -- DB2HISTORY_COMMENT_SZ
      * 
      *      oCommandText      -- Command text, or DDL
      *                        -- DB2HISTORY_COMMAND_SZ
      * 
      *      oLastLSN          -- Last Log Sequence Number
      *      poEventSQLCA      -- SQLCA returned at event completion
      *      poTablespace      -- LIST of tablespace names
      *      iNumTablespaces   -- # of available entries in the poTablespace
      * list
      *      oNumTablespaces   -- # of used entries in the poTablespace list
      *      oEID              -- Unique history entry ID
      *      oOperation        -- Event type:        DB2HISTORY_TYPE_*
      *      oObject           -- Event granularity: DB2HISTORY_GRAN_*
      *      oOptype           -- Event details:     DB2HISTORY_OPTYPE_*
      *      oStatus           -- Entry status:      DB2HISTORY_STATUS_*
      *      oDeviceType       -- Type of oLocation: DB2_MEDIA_*

      * db2HistoryData structure.
       01 DB2HISTORY-DATA.
           05 DB2-IO-HIST-DATA-ID    PIC X(8)
                                     USAGE DISPLAY NATIVE.
           05 DB2-O-OBJECT-PART.
               10 DB2-PIO-DATA       USAGE IS POINTER.
               10 DB2-I-LENGTH       PIC 9(9) COMP-5 VALUE 0.
               10 DB2-O-LENGTH       PIC 9(9) COMP-5 VALUE 0.
           05 DB2-O-END-TIME.
               10 DB2-PIO-DATA       USAGE IS POINTER.
               10 DB2-I-LENGTH       PIC 9(9) COMP-5 VALUE 0.
               10 DB2-O-LENGTH       PIC 9(9) COMP-5 VALUE 0.
           05 DB2-O-FIRST-LOG.
               10 DB2-PIO-DATA       USAGE IS POINTER.
               10 DB2-I-LENGTH       PIC 9(9) COMP-5 VALUE 0.
               10 DB2-O-LENGTH       PIC 9(9) COMP-5 VALUE 0.
           05 DB2-O-LAST-LOG.
               10 DB2-PIO-DATA       USAGE IS POINTER.
               10 DB2-I-LENGTH       PIC 9(9) COMP-5 VALUE 0.
               10 DB2-O-LENGTH       PIC 9(9) COMP-5 VALUE 0.
           05 DB2-O-ID.
               10 DB2-PIO-DATA       USAGE IS POINTER.
               10 DB2-I-LENGTH       PIC 9(9) COMP-5 VALUE 0.
               10 DB2-O-LENGTH       PIC 9(9) COMP-5 VALUE 0.
           05 DB2-O-TABLE-QUALIFIER.
               10 DB2-PIO-DATA       USAGE IS POINTER.
               10 DB2-I-LENGTH       PIC 9(9) COMP-5 VALUE 0.
               10 DB2-O-LENGTH       PIC 9(9) COMP-5 VALUE 0.
           05 DB2-O-TABLE-NAME.
               10 DB2-PIO-DATA       USAGE IS POINTER.
               10 DB2-I-LENGTH       PIC 9(9) COMP-5 VALUE 0.
               10 DB2-O-LENGTH       PIC 9(9) COMP-5 VALUE 0.
           05 DB2-O-LOCATION.
               10 DB2-PIO-DATA       USAGE IS POINTER.
               10 DB2-I-LENGTH       PIC 9(9) COMP-5 VALUE 0.
               10 DB2-O-LENGTH       PIC 9(9) COMP-5 VALUE 0.
           05 DB2-O-COMMENT.
               10 DB2-PIO-DATA       USAGE IS POINTER.
               10 DB2-I-LENGTH       PIC 9(9) COMP-5 VALUE 0.
               10 DB2-O-LENGTH       PIC 9(9) COMP-5 VALUE 0.
           05 DB2-O-COMMAND-TEXT.
               10 DB2-PIO-DATA       USAGE IS POINTER.
               10 DB2-I-LENGTH       PIC 9(9) COMP-5 VALUE 0.
               10 DB2-O-LENGTH       PIC 9(9) COMP-5 VALUE 0.
      * Structure SQLU_LSN
           05 DB2-O-LAST-LSN.
               10 SQL-LSN-CHAR       PIC X(6)
                                     USAGE DISPLAY NATIVE.
               10 SQL-LSN-WORD       REDEFINES SQL-LSN-CHAR
                                     PIC 9(4) COMP-5 OCCURS 3 TIMES.
               10 FILLER             REDEFINES SQL-LSN-CHAR
                                     PIC X(6)
                                     USAGE DISPLAY NATIVE.
               10 FILLER             PIC X(2)
                                     USAGE DISPLAY NATIVE.
      * Structure db2HistoryEID
           05 DB2-O-EID.
               10 DB2-IO-NODE        PIC S9(4) COMP-5 VALUE 0.
               10 FILLER             PIC X(2)
                                     USAGE DISPLAY NATIVE.
               10 DB2-IO-HID         PIC 9(9) COMP-5 VALUE 0.
      * Result SQLCA from event
           05 DB2-PO-EVENT-SQLCA     USAGE IS POINTER.
           05 DB2-PO-TABLESPACE      USAGE IS POINTER.
           05 DB2-I-NUM-TABLESPACES  PIC 9(9) COMP-5 VALUE 0.
           05 DB2-O-NUM-TABLESPACES  PIC 9(9) COMP-5 VALUE 0.
           05 DB2-O-OPERATION        PIC X
                                     USAGE DISPLAY NATIVE.
           05 DB2-O-OBJECT           PIC X
                                     USAGE DISPLAY NATIVE.
           05 DB2-O-OPTYPE           PIC X
                                     USAGE DISPLAY NATIVE.
           05 DB2-O-STATUS           PIC X
                                     USAGE DISPLAY NATIVE.
           05 DB2-O-DEVICE-TYPE      PIC X
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X(3)
                                     USAGE DISPLAY NATIVE.

      * Values for db2HistoryGetEntry - iCallerAction
      * Next entry, without command data
       77  DB2HISTORY-GET-ENTRY      PIC S9(4) COMP-5 VALUE 0.
      * ONLY command data from previous fetch
       77  DB2HISTORY-GET-DDL        PIC S9(4) COMP-5 VALUE 1.
      * Next entry, with all data
       77  DB2HISTORY-GET-ALL        PIC S9(4) COMP-5 VALUE 2.

      * db2HistoryGetEntry input struct
      *************************************************************************
      * db2HistoryGetEntryStruct data structure
      * db2HistoryGetEntryStruct data structure parameters
      * 
      * pioHistData
      * Input. A pointer to the db2HistData structure.
      * 
      * iHandle
      * Input. Contains the handle for scan access that was returned by the
      * db2HistoryOpenScan API.
      * 
      * iCallerAction
      * Input. Specifies the type of action to be taken. Valid values (defined in
      * db2ApiDf header file, located in the include directory) are:
      * - DB2HISTORY_GET_ENTRY
      * Get the next entry, but without any command data.
      * - DB2HISTORY_GET_DDL
      * Get only the command data from the previous fetch.
      * - DB2HISTORY_GET_ALL
      * Get the next entry, including all data.
      * 
      **************************************************************************
       01 DB2HISTORY-GET-ENTRY-STRUCT.
      * History entry data area
           05 DB2-PIO-HIST-DATA      USAGE IS POINTER.
      * History scan handle
           05 DB2-I-HANDLE           PIC 9(4) COMP-5.
      * Caller action
           05 DB2-I-CALLER-ACTION    PIC 9(4) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.

      * db2gHistoryGetEntry - Generic API
      *************************************************************************
      * db2gHistoryGetEntry API
      **************************************************************************

      * History Operations
       77  DB2HIST-OP-CRT-TABLESPACE PIC X(1) value "A"
                                     USAGE DISPLAY NATIVE.
       77  DB2HIST-OP-BACKUP         PIC X(1) value "B"
                                     USAGE DISPLAY NATIVE.
       77  DB2HIST-OP-LOAD-COPY      PIC X(1) value "C"
                                     USAGE DISPLAY NATIVE.
       77  DB2HIST-OP-DROPPED-TABLE  PIC X(1) value "D"
                                     USAGE DISPLAY NATIVE.
       77  DB2HIST-OP-ROLLFWD        PIC X(1) value "F"
                                     USAGE DISPLAY NATIVE.
       77  DB2HIST-OP-REORG          PIC X(1) value "G"
                                     USAGE DISPLAY NATIVE.
       77  DB2HIST-OP-LOAD           PIC X(1) value "L"
                                     USAGE DISPLAY NATIVE.
       77  DB2HIST-OP-REN-TABLESPACE PIC X(1) value "N"
                                     USAGE DISPLAY NATIVE.
       77  DB2HIST-OP-DROP-TABLESPACE PIC X(1) value "O"
                                     USAGE DISPLAY NATIVE.
       77  DB2HIST-OP-QUIESCE        PIC X(1) value "Q"
                                     USAGE DISPLAY NATIVE.
       77  DB2HIST-OP-RESTORE        PIC X(1) value "R"
                                     USAGE DISPLAY NATIVE.
       77  DB2HIST-OP-ALT-TBS        PIC X(1) value "T"
                                     USAGE DISPLAY NATIVE.
       77  DB2HIST-OP-UNLOAD         PIC X(1) value "U"
                                     USAGE DISPLAY NATIVE.
       77  DB2HIST-OP-ARCHIVE-LOG    PIC X(1) value "X"
                                     USAGE DISPLAY NATIVE.

      * History Objects
       77  DB2HISTORY-GRAN-DB        PIC X(1) value "D"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-GRAN-TBS       PIC X(1) value "P"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-GRAN-TABLE     PIC X(1) value "T"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-GRAN-RPTABLE   PIC X(1) value "R"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-GRAN-INDEX     PIC X(1) value "I"
                                     USAGE DISPLAY NATIVE.

      * Backup/Restore Optypes
       77  DB2HISTORY-OPTYPE-OFFLINE PIC X(1) value "F"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-OPTYPE-ONLINE  PIC X(1) value "N"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-OPTYPE-INCR-OFFLINE PIC X(1) value "I"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-OPTYPE-INCR-ONLINE PIC X(1) value "O"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-OPTYPE-DELT-OFFLINE PIC X(1) value "D"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-OPTYPE-DELT-ONLINE PIC X(1) value "E"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-OPTYPE-REBUILD PIC X(1) value "R"
                                     USAGE DISPLAY NATIVE.

      * Quiesce Optypes
       77  DB2HISTORY-OPTYPE-SHARE   PIC X(1) value "S"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-OPTYPE-UPDATE  PIC X(1) value "U"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-OPTYPE-EXCL    PIC X(1) value "X"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-OPTYPE-RESET   PIC X(1) value "Z"
                                     USAGE DISPLAY NATIVE.

      * Rollforward Optypes
       77  DB2HISTORY-OPTYPE-EOL     PIC X(1) value "E"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-OPTYPE-PIT     PIC X(1) value "P"
                                     USAGE DISPLAY NATIVE.

      * Load Optypes
       77  DB2HISTORY-OPTYPE-INSERT  PIC X(1) value "I"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-OPTYPE-REPLACE PIC X(1) value "R"
                                     USAGE DISPLAY NATIVE.

      * Alter Tablespace Optypes
       77  DB2HISTORY-OPTYPE-ADD-CONT PIC X(1) value "C"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-OPTYPE-REB     PIC X(1) value "R"
                                     USAGE DISPLAY NATIVE.

      * Archive Log Optypes
       77  DB2HISTORY-OPTYPE-ARCHIVE-CMD PIC X(1) value "N"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-OPTYPE-PRIMARY PIC X(1) value "P"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-OPTYPE-MIRROR  PIC X(1) value "M"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-OPTYPE-ARCHFAIL PIC X(1) value "F"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-OPTYPE-ARCH1   PIC X(1) value "1"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-OPTYPE-ARCH2   PIC X(1) value "2"
                                     USAGE DISPLAY NATIVE.

      * History Entry Status Flags
       77  DB2HISTORY-STATUS-ACTIVE  PIC X(1) value "A"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-STATUS-INACTIVE PIC X(1) value "I"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-STATUS-EXPIRED PIC X(1) value "E"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-STATUS-DELETED PIC X(1) value "D"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-STATUS-NC      PIC X(1) value "N"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-STATUS-INCMP-ACTV PIC X(1) value "a"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-STATUS-INCMP-INACTV PIC X(1) value "i"
                                     USAGE DISPLAY NATIVE.
       77  DB2HISTORY-STATUS-DO-NOT-DEL PIC X(1) value "X"
                                     USAGE DISPLAY NATIVE.


      * db2gHistoryCloseScan - Generic API
      *************************************************************************
      * db2gHistoryCloseScan API
      **************************************************************************

      * Update History Entry Definitions

      * Update history API input struct
      *************************************************************************
      * db2gHistoryUpdateStruct data structure
      * db2gHistoryUpdateStruct data structure specific parameters
      * 
      * iNewLocationLen
      * Input. Specifies the length in bytes of the piNewLocation parameter.
      * 
      * iNewDeviceLen
      * Input. Specifies the length in bytes of the piNewDeviceType parameter.
      * 
      * iNewCommentLen
      * Input. Specifies the length in bytes of the piNewComment parameter.
      * 
      * iNewStatusLen
      * Input. Specifies the length in bytes of the piNewStatus paramter.
      * 
      **************************************************************************
       01 DB2G-HISTORY-UPDATE-STRUCT.
           05 DB2-PI-NEW-LOCATION    USAGE IS POINTER.
           05 DB2-PI-NEW-DEVICE-TYPE USAGE IS POINTER.
           05 DB2-PI-NEW-COMMENT     USAGE IS POINTER.
           05 DB2-PI-NEW-STATUS      USAGE IS POINTER.
           05 DB2-I-NEW-LOCATION-LEN PIC 9(9) COMP-5 VALUE 0.
           05 DB2-I-NEW-DEVICE-LEN   PIC 9(9) COMP-5 VALUE 0.
           05 DB2-I-NEW-COMMENT-LEN  PIC 9(9) COMP-5 VALUE 0.
           05 DB2-I-NEW-STATUS-LEN   PIC 9(9) COMP-5 VALUE 0.
      * ID of the entry to be updated
           05 DB2-I-EID.
      * Node number
               10 DB2-IO-NODE        PIC S9(4) COMP-5.
               10 FILLER             PIC X(2)
                                     USAGE DISPLAY NATIVE.
      * Local history file entry ID
               10 DB2-IO-HID         PIC 9(9) COMP-5.

      * db2gHistoryUpdate - Generic API
      *************************************************************************
      * db2gHistoryUpdate API
      **************************************************************************

      *************************************************************************
      * Precompiler API Related Definitions
      **************************************************************************

      * Generic Compile SQL Parmeter Structure
      *************************************************************************
      * db2gCompileSqlStruct data structure
      **************************************************************************
       01 DB2G-COMPILE-SQL-STRUCT.
      * SQL statement text length
           05 DB2-PI-SQL-STMT-LEN    USAGE IS POINTER.
      * SQL statement text
           05 DB2-PI-SQL-STMT        USAGE IS POINTER.
      * Source Line Number
           05 DB2-PI-LINE-NUM        USAGE IS POINTER.
      * SQL Flagger information
           05 DB2-PIO-FLAG-INFO      USAGE IS POINTER.
      * Token ID Array
           05 DB2-PIO-TOKEN-ID-ARRAY USAGE IS POINTER.
      * Task Array
           05 DB2-PO-TASK-ARRAY      USAGE IS POINTER.
      * Section Number
           05 DB2-PO-SECTION-NUM     USAGE IS POINTER.
      * Type of SQL statement
           05 DB2-PO-SQL-STMT-TYPE   USAGE IS POINTER.
      * 256 byte string buffer 1
           05 DB2-PO-BUFFER1         USAGE IS POINTER.
      * 256 byte string buffer 2
           05 DB2-PO-BUFFER2         USAGE IS POINTER.
      * 256 byte string buffer 3
           05 DB2-PO-BUFFER3         USAGE IS POINTER.
      * Reserved
           05 DB2-PIO-RESERVED       USAGE IS POINTER.

      * Generic Initialization Parmeter Structure
      *************************************************************************
      * db2gInitStruct data structure
      **************************************************************************
       01 DB2G-INIT-STRUCT.
      * Program name length
           05 DB2-PI-PROGRAM-NAME-LENGTH USAGE IS POINTER.
      * Program name
           05 DB2-PI-PROGRAM-NAME    USAGE IS POINTER.
      * Database name length
           05 DB2-PI-DB-NAME-LENGTH  USAGE IS POINTER.
      * Database name
           05 DB2-PI-DB-NAME         USAGE IS POINTER.
      * Password length
           05 DB2-PI-DB-PASSWORD-LENGTH USAGE IS POINTER.
      * Password
           05 DB2-PI-DB-PASSWORD     USAGE IS POINTER.
      * Bindfile name length
           05 DB2-PI-BIND-NAME-LENGTH USAGE IS POINTER.
      * Bindfile name
           05 DB2-PI-BIND-NAME       USAGE IS POINTER.
      * Precompiler options array
           05 DB2-PI-OPTIONS-ARRAY   USAGE IS POINTER.
      * Precompiler program ID buffer length
           05 DB2-PI-PID-LENGTH      USAGE IS POINTER.
      * Precompiler program ID
           05 DB2-PO-PRECOMPILER-PID USAGE IS POINTER.

      * Reorg Definitions

      * Reorg type defines
      * Define for reorg table offline
       77  DB2REORG-OBJ-TABLE-OFFLINE PIC S9(4) COMP-5 VALUE 1.
      * Define for reorg table inplace
       77  DB2REORG-OBJ-TABLE-INPLACE PIC S9(4) COMP-5 VALUE 2.
      * Define for reorg indexes all
       77  DB2REORG-OBJ-INDEXESALL   PIC S9(4) COMP-5 VALUE 4.
      * Define for reorg index
       77  DB2REORG-OBJ-INDEX        PIC S9(4) COMP-5 VALUE 8.

      * Defines for reorg flags parameter
      * Take default action
       77  DB2REORG-OPTION-NONE      PIC S9(4) COMP-5 VALUE 0.

      * Offline Reorg Options
      * Reorg long fields and lobs
       77  DB2REORG-LONGLOB          PIC S9(4) COMP-5 VALUE 1.
      * System to choose temp tablespace for reorg work
       77  DB2REORG-CHOOSE-TEMP      PIC S9(4) COMP-5 VALUE 2.
      * Recluster utilizing index scan
       77  DB2REORG-INDEXSCAN        PIC S9(4) COMP-5 VALUE 4.
      * No read or write access to table
       77  DB2REORG-ALLOW-NONE       PIC S9(4) COMP-5 VALUE 8.
      * Rebuild dictionary
       77  DB2REORG-RESET-DICTIONARY PIC S9(4) COMP-5 VALUE 16.
      * Keep original dictionary
       77  DB2REORG-KEEP-DICTIONARY  PIC S9(4) COMP-5 VALUE 32.

      * Online Reorg Options
      * Start online reorg
       77  DB2REORG-START-ONLINE     PIC S9(9) COMP-5 VALUE 65536.
      * Pause an existing online reorg
       77  DB2REORG-PAUSE-ONLINE     PIC S9(9) COMP-5 VALUE 131072.
      * Stop an existing online reorg
       77  DB2REORG-STOP-ONLINE      PIC S9(9) COMP-5 VALUE 262144.
      * Resume a paused online reorg
       77  DB2REORG-RESUME-ONLINE    PIC S9(9) COMP-5 VALUE 524288.
      * Do not perform table truncation
       77  DB2REORG-NOTRUNCATE-ONLINE PIC S9(9) COMP-5 VALUE 1048576.
      * Read and write access to table
       77  DB2REORG-ALLOW-WRITE      PIC S9(9) COMP-5 VALUE 268435456.
      * Allow only read access to table
       77  DB2REORG-ALLOW-READ       PIC S9(9) COMP-5 VALUE 536870912.

      * Online Reorg Indexes All Options
      * Reorg type1 index only
       77  DB2REORG-REORG-TYPE1      PIC S9(9) COMP-5 VALUE 2097152.
      * No cleanup is required
       77  DB2REORG-CLEANUP-NONE     PIC S9(9) COMP-5 VALUE 4194304.
      * Cleanup pages and keys
       77  DB2REORG-CLEANUP-ALL      PIC S9(9) COMP-5 VALUE 8388608.
      * Cleanup pages only
       77  DB2REORG-CLEANUP-PAGES    PIC S9(9) COMP-5 VALUE 16777216.
      * No convert is required
       77  DB2REORG-CONVERT-NONE     PIC S9(9) COMP-5 VALUE 33554432.
      * Convert to type2
       77  DB2REORG-CONVERT          PIC S9(9) COMP-5 VALUE 67108864.
      * Convert to type1
       77  DB2REORG-CONVERT-TYPE1    PIC S9(9) COMP-5 VALUE 134217728.

      * MPP allNodeFlag values
       77  DB2REORG-NODE-LIST        PIC S9(4) COMP-5 VALUE 0.
       77  DB2REORG-ALL-NODES        PIC S9(4) COMP-5 VALUE 1.
       77  DB2REORG-ALL-EXCEPT       PIC S9(4) COMP-5 VALUE 2.

      * Generic Reorg Table API input struct
      *************************************************************************
      * db2gReorgTable data structure
      * db2gReorgTable data structure specific parameters
      * 
      * tableNameLen
      * Input. Specifies the length in bytes of pTableName.
      * 
      * orderByIndexLen
      * Input. Specifies the length in byte of pOrderByIndex. 
      * 
      * sysTempSpaceLen
      * Input. Specifies the length in bytes of pSysTempSpace. 
      * 
      **************************************************************************
       01 DB2G-REORG-TABLE.
      * length in bytes of pTableName
           05 DB2-TABLE-NAME-LEN     PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Name of table to reorganize
           05 DB2-P-TABLE-NAME       USAGE IS POINTER.
      * length in bytes of pOrderByIndex
           05 DB2-ORDER-BY-INDEX-LEN PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Index to order table by
           05 DB2-P-ORDER-BY-INDEX   USAGE IS POINTER.
      * length in bytes of pSysTempSpace
           05 DB2-SYS-TEMP-SPACE-LEN PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Tablespace to create temp objects in
           05 DB2-P-SYS-TEMP-SPACE   USAGE IS POINTER.
      * length in bytes of pLongTempSpace
           05 DB2-LONG-TEMP-SPACE-LEN PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Tablespace to create temp long objects in
           05 DB2-P-LONG-TEMP-SPACE  USAGE IS POINTER.


      * Reorg Indexes all input struct
      *************************************************************************
      * db2gReorgIndexesAll data structure
      * db2gReorgIndexesAll data structure specific parameters
      * 
      * tableNameLen
      * Input. Specifies the length in bytes of pTableName. 
      * 
      **************************************************************************
       01 DB2G-REORG-INDEXES-ALL.
      * length in bytes of pTableName
           05 DB2-TABLE-NAME-LEN     PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Name of table to reorganize indexes on
           05 DB2-P-TABLE-NAME       USAGE IS POINTER.
      * length in bytes of pIndexName
           05 DB2-INDEX-NAME-LEN     PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Name of index to reorganize
           05 DB2-P-INDEX-NAME       USAGE IS POINTER.


      *************************************************************************
      * db2gReorgnodes data structure
      **************************************************************************
       01 DB2G-REORG-NODES.
      * Node number
           05 DB2-NODE-NUM           PIC S9(4) COMP-5 OCCURS 1000 TIMES.


      *************************************************************************
      * db2gReorgStruct data structure
      **************************************************************************
       01 DB2G-REORG-STRUCT.
      * Type - Table or Indexes
           05 DB2-REORG-TYPE         PIC 9(9) COMP-5.
      * Reorg options - DB2REORG_xxxx
           05 DB2-REORG-FLAGS        PIC 9(9) COMP-5.
      * Which nodes reorg applies to
           05 DB2-NODE-LIST-FLAG     PIC S9(9) COMP-5.
      * Number of nodes in nodelist array
           05 DB2-NUM-NODES          PIC 9(9) COMP-5.
      * Pointer to array of node numbers
           05 DB2-P-NODE-LIST        USAGE IS POINTER.
      * Table or Index struct
           05 DB2-REORG-OBJECT.
      * Table struct
               10 DB2-TABLE-STRUCT.
      * length in bytes of pTableName
                   15 DB2-TABLE-NAME-LEN PIC 9(9) COMP-5.
                   15 FILLER         PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Name of table to reorganize
                   15 DB2-P-TABLE-NAME USAGE IS POINTER.
      * length in bytes of pOrderByIndex
                   15 DB2-ORDER-BY-INDEX-LEN PIC 9(9) COMP-5.
                   15 FILLER         PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Index to order table by
                   15 DB2-P-ORDER-BY-INDEX USAGE IS POINTER.
      * length in bytes of pSysTempSpace
                   15 DB2-SYS-TEMP-SPACE-LEN PIC 9(9) COMP-5.
                   15 FILLER         PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Tablespace to create temp objects in
                   15 DB2-P-SYS-TEMP-SPACE USAGE IS POINTER.
      * length in bytes of pLongTempSpace
                   15 DB2-LONG-TEMP-SPACE-LEN PIC 9(9) COMP-5.
                   15 FILLER         PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Tablespace to create temp long objects in
                   15 DB2-P-LONG-TEMP-SPACE USAGE IS POINTER.
      * Indexes struct
               10 DB2-INDEXES-ALL-STRUCT REDEFINES DB2-TABLE-STRUCT.
      * length in bytes of pTableName
                   15 DB2-TABLE-NAME-LEN PIC 9(9) COMP-5.
                   15 FILLER         PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Name of table to reorganize indexes on
                   15 DB2-P-TABLE-NAME USAGE IS POINTER.
      * length in bytes of pIndexName
                   15 DB2-INDEX-NAME-LEN PIC 9(9) COMP-5.
                   15 FILLER         PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Name of index to reorganize
                   15 DB2-P-INDEX-NAME USAGE IS POINTER.

      *************************************************************************
      * db2gReorg API
      **************************************************************************
      * Generic Reorg Table API


      * db2Runstats Definitions


      * Options for iRunstatsFlags
      * Gather stats on all columns
       77  DB2RUNSTATS-ALL-COLUMNS   PIC S9(4) COMP-5 VALUE 1.
      * Gather stats on key columns
       77  DB2RUNSTATS-KEY-COLUMNS   PIC S9(4) COMP-5 VALUE 2.
      * Gather stats on all indexes
       77  DB2RUNSTATS-ALL-INDEXES   PIC S9(4) COMP-5 VALUE 4.
      * Gather distribution stats on either all columns or key columns
       77  DB2RUNSTATS-DISTRIBUTION  PIC S9(4) COMP-5 VALUE 8.
      * Gather extended index stats
       77  DB2RUNSTATS-EXT-INDEX     PIC S9(4) COMP-5 VALUE 16.
      * Gather sampled extended index stats
       77  DB2RUNSTATS-EXT-INDEX-SAMPLED PIC S9(4) COMP-5 VALUE 32.
      * Gather stats using profile
       77  DB2RUNSTATS-USE-PROFILE   PIC S9(4) COMP-5 VALUE 64.
      * Gather stats and set the profile
       77  DB2RUNSTATS-SET-PROFILE   PIC S9(4) COMP-5 VALUE 128.
      * Set the stats profile only
       77  DB2RUNSTATS-SET-PROFILE-ONLY PIC S9(4) COMP-5 VALUE 256.
      * Allow others to only read table while Runstats is in progress
       77  DB2RUNSTATS-ALLOW-READ    PIC S9(4) COMP-5 VALUE 512.
      * Gather stats on all DB partitions
       77  DB2RUNSTATS-ALL-DBPARTITIONS PIC S9(4) COMP-5 VALUE 1024.
      * Gather statistics and update statistics profile
       77  DB2RUNSTATS-UPDATE-PROFILE PIC S9(4) COMP-5 VALUE 2048.
      * Update statistics profile without gathering statistics
       77  DB2RUNSTATS-UPDA-PROFILE-ONLY PIC S9(4) COMP-5 VALUE 4096.
      * Page Level Sampling
       77  DB2RUNSTATS-SAMPLING-SYSTEM PIC S9(4) COMP-5 VALUE 8192.
      * Generate Repeatable Sample
       77  DB2RUNSTATS-SAMPLING-REPEAT PIC S9(9) COMP-5 VALUE 16384.
      * Excluding XML columns
       77  DB2RUNSTATS-EXCLUDING-XML PIC S9(9) COMP-5 VALUE 32768.
      * Unset the profile
       77  DB2RUNSTATS-UNSET-PROFILE PIC S9(9) COMP-5 VALUE 65536.

      * Options for iColumnFlags
      * Gather stats for LIKE predicates
       77  DB2RUNSTATS-COLUMN-LIKE-STATS PIC S9(4) COMP-5 VALUE 1.

      * Default options
      * Default level of parallelism
       77  DB2RUNSTATS-PARALLELISM-DFLT PIC S9(4) COMP-5 VALUE 0.
      * Default percentage of pages sampled (100%)
       77  DB2RUNSTATS-SAMPLING-DFLT USAGE COMP-2 VALUE 1.000000e+02.


      *  Structures for db2gRunstats API

      * Columns to Collect Stats on
      *************************************************************************
      * db2gColumnData data structure
      * db2gColumnData data structure specific parameters
      * 
      * iColumnNameLen
      * Input. A value representing the length in bytes of the column name.
      * 
      **************************************************************************
       01 DB2G-COLUMN-DATA.
           05 DB2-PI-COLUMN-NAME     USAGE IS POINTER.
           05 DB2-I-COLUMN-NAME-LEN  PIC 9(4) COMP-5.
           05 DB2-I-COLUMN-FLAGS     PIC S9(4) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.

      * Columns to Collect Distribution Stats on
      *************************************************************************
      * db2gColumnDistData data structure
      * db2gColumnDistData data structure specific parameters
      * 
      * iColumnNameLen
      * Input. A value representing the length in bytes of the column name.
      * 
      **************************************************************************
       01 DB2G-COLUMN-DIST-DATA.
           05 DB2-PI-COLUMN-NAME     USAGE IS POINTER.
           05 DB2-I-COLUMN-NAME-LEN  PIC 9(4) COMP-5.
           05 DB2-I-NUM-FREQ-VALUES  PIC S9(4) COMP-5.
           05 DB2-I-NUM-QUANTILES    PIC S9(4) COMP-5.
           05 FILLER                 PIC X(2)
                                     USAGE DISPLAY NATIVE.

      * Columns Groups to Collect Stats on
      *************************************************************************
      * db2gColumnGrpData data structure
      * db2gColumnGrpData data structure specific parameters
      * 
      * piGroupColumnNamesLen
      * Input. An array of values representing the length in bytes of each
      * of the column names in the column names list. 
      * 
      **************************************************************************
       01 DB2G-COLUMN-GRP-DATA.
           05 DB2-PI-GROUP-COLUMN-NAMES USAGE IS POINTER.
           05 DB2-PI-GROUP-COL-NAMES-LEN USAGE IS POINTER.
           05 DB2-I-GROUP-SIZE       PIC S9(4) COMP-5.
           05 DB2-I-NUM-FREQ-VALUES  PIC S9(4) COMP-5.
           05 DB2-I-NUM-QUANTILES    PIC S9(4) COMP-5.
           05 FILLER                 PIC X(2)
                                     USAGE DISPLAY NATIVE.

      * Struct containing db2gRunstats options
      *************************************************************************
      * db2gRunstatsData data structure
      * db2gRunstatsData data structure specific parameters
      * 
      * piIndexNamesLen
      * Input. An array of values representing the length in bytes of each of the
      * index names in the index list. If NumIndexes is zero then piIndexNamesLen
      * is ignored.
      * 
      * iTablenameLen
      * Input. A value representing the length in bytes of the table name.
      * 
      **************************************************************************
       01 DB2G-RUNSTATS-DATA.
           05 DB2-I-SAMPLING-OPTION  USAGE COMP-2.
           05 DB2-PI-TABLENAME       USAGE IS POINTER.
           05 DB2-PI-COLUMN-LIST     USAGE IS POINTER.
           05 DB2-PI-COLUMN-DIST-LIST USAGE IS POINTER.
           05 DB2-PI-COLUMN-GROUP-LIST USAGE IS POINTER.
           05 DB2-PI-INDEX-LIST      USAGE IS POINTER.
           05 DB2-PI-INDEX-NAMES-LEN USAGE IS POINTER.
           05 DB2-I-RUNSTATS-FLAGS   PIC 9(9) COMP-5.
           05 DB2-I-TABLENAME-LEN    PIC 9(4) COMP-5.
           05 DB2-I-NUM-COLUMNS      PIC S9(4) COMP-5.
           05 DB2-I-NUM-COLDIST      PIC S9(4) COMP-5.
           05 DB2-I-NUM-COL-GROUPS   PIC S9(4) COMP-5.
           05 DB2-I-NUM-INDEXES      PIC S9(4) COMP-5.
           05 DB2-I-PARALLELISM-OPTION PIC S9(4) COMP-5.
           05 DB2-I-TABLE-DEF-FREQ-VALUES PIC S9(4) COMP-5.
           05 DB2-I-TABLE-DEF-QUANTILES PIC S9(4) COMP-5.
           05 DB2-I-SAMPLING-REPEATABLE PIC 9(9) COMP-5.
           05 DB2-I-UTIL-IMPACT-PRIORITY PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.



      * Prune Database History Definitions

      * Values for db2Prune - iCallerAction
      * Remove history file entries
       77  DB2PRUNE-ACTION-HISTORY   PIC S9(4) COMP-5 VALUE 1.
      * Remove log files from active log path
       77  DB2PRUNE-ACTION-LOG       PIC S9(4) COMP-5 VALUE 2.

      * Values for db2Prune - iOptions
      * Force removal of last backup
       77  DB2PRUNE-OPTION-NONE      PIC S9(4) COMP-5 VALUE 0.
      * Force removal of last backup
       77  DB2PRUNE-OPTION-FORCE     PIC S9(4) COMP-5 VALUE 1.
      * piString is an LSN-string, used by DB2PRUNE_ACTION_LOG
       77  DB2PRUNE-OPTION-LSNSTRING PIC S9(4) COMP-5 VALUE 2.
      * Delete pruned files
       77  DB2PRUNE-OPTION-DELETE    PIC S9(4) COMP-5 VALUE 4.

      * Generic Prune API input struct
      *************************************************************************
      * db2gPruneStruct data structure
      * db2gPruneStruct data structure specific parameters
      * 
      * iStringLen
      * Input. Specifies the length in bytes of piString.
      * 
      **************************************************************************
       01 DB2G-PRUNE-STRUCT.
      * length in bytes of piString
           05 DB2-I-STRING-LEN       PIC 9(9) COMP-5 VALUE 0.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Timestamp, or lastLSN
           05 DB2-PI-STRING          USAGE IS POINTER.
      * Prune history since this EID
           05 DB2-I-EID.
      * Node number
               10 DB2-IO-NODE        PIC S9(4) COMP-5.
               10 FILLER             PIC X(2)
                                     USAGE DISPLAY NATIVE.
      * Local history file entry ID
               10 DB2-IO-HID         PIC 9(9) COMP-5.
      * What to prune
           05 DB2-I-ACTION           PIC 9(9) COMP-5.
      * Options relevent to particular iAction
           05 DB2-I-OPTIONS          PIC 9(9) COMP-5.

      *************************************************************************
      * db2gPrune API
      **************************************************************************


      * Backup Options
       77  DB2BACKUP-DB              PIC S9(4) COMP-5 VALUE 0.
       77  DB2BACKUP-TABLESPACE      PIC S9(4) COMP-5 VALUE 3.
       77  DB2BACKUP-INCREMENTAL     PIC S9(4) COMP-5 VALUE 16.
       77  DB2BACKUP-DELTA           PIC S9(4) COMP-5 VALUE 48.
       77  DB2BACKUP-OFFLINE         PIC S9(4) COMP-5 VALUE 0.
       77  DB2BACKUP-ONLINE          PIC S9(4) COMP-5 VALUE 256.
      * Compress backup image
       77  DB2BACKUP-COMPRESS        PIC S9(4) COMP-5 VALUE 1024.
      * Include compression lib in backup image
       77  DB2BACKUP-INCLUDE-COMPR-LIB PIC S9(4) COMP-5 VALUE 0.
      * Do not include compression lib in backup image
       77  DB2BACKUP-EXCLUDE-COMPR-LIB PIC S9(4) COMP-5 VALUE 2048.
      * Include log files in online backup image
       77  DB2BACKUP-INCLUDE-LOGS    PIC S9(4) COMP-5 VALUE 4096.
      * Exclude log files from backup image
       77  DB2BACKUP-EXCLUDE-LOGS    PIC S9(4) COMP-5 VALUE 8192.
      * Perform multi-partition backup
       77  DB2BACKUP-MPP             PIC S9(9) COMP-5 VALUE 16384.

      * Backup Caller Actions
       77  DB2BACKUP-BACKUP          PIC S9(4) COMP-5 VALUE 0.
       77  DB2BACKUP-CONTINUE        PIC S9(4) COMP-5 VALUE 1.
       77  DB2BACKUP-TERMINATE       PIC S9(4) COMP-5 VALUE 2.
       77  DB2BACKUP-NOINTERRUPT     PIC S9(4) COMP-5 VALUE 3.
       77  DB2BACKUP-DEVICE-TERMINATE PIC S9(4) COMP-5 VALUE 9.
       77  DB2BACKUP-PARM-CHK        PIC S9(4) COMP-5 VALUE 10.
       77  DB2BACKUP-PARM-CHK-INIT-WAIT PIC S9(4) COMP-5 VALUE 10.
       77  DB2BACKUP-PARM-CHK-ONLY   PIC S9(4) COMP-5 VALUE 11.

      * iAllNodeFlag values
      * Submit to all nodes in the node list
       77  DB2BACKUP-NODE-LIST       PIC S9(4) COMP-5 VALUE 0.
      * Submit to all nodes in the node configuration file
       77  DB2BACKUP-ALL-NODES       PIC S9(4) COMP-5 VALUE 1.
      * Submit to all nodes except the ones specified by the nodelist
      * parameter
       77  DB2BACKUP-ALL-EXCEPT      PIC S9(4) COMP-5 VALUE 2.

      * Restore Options
       77  DB2RESTORE-DB             PIC S9(4) COMP-5 VALUE 0.
       77  DB2RESTORE-TABLESPACE     PIC S9(4) COMP-5 VALUE 4.
       77  DB2RESTORE-HISTORY        PIC S9(4) COMP-5 VALUE 5.
      * Restore only compression library
       77  DB2RESTORE-COMPR-LIB      PIC S9(4) COMP-5 VALUE 6.
       77  DB2RESTORE-LOGS           PIC S9(4) COMP-5 VALUE 7.
       77  DB2RESTORE-INCREMENTAL    PIC S9(4) COMP-5 VALUE 16.
       77  DB2RESTORE-OFFLINE        PIC S9(4) COMP-5 VALUE 0.
       77  DB2RESTORE-ONLINE         PIC S9(4) COMP-5 VALUE 64.
       77  DB2RESTORE-DATALINK       PIC S9(4) COMP-5 VALUE 0.
       77  DB2RESTORE-NODATALINK     PIC S9(4) COMP-5 VALUE 128.
       77  DB2RESTORE-AUTOMATIC      PIC S9(4) COMP-5 VALUE 256.
       77  DB2RESTORE-ROLLFWD        PIC S9(4) COMP-5 VALUE 0.
       77  DB2RESTORE-NOROLLFWD      PIC S9(4) COMP-5 VALUE 512.
       77  DB2RESTORE-NOREPLACE-HISTORY PIC S9(4) COMP-5 VALUE 0.
       77  DB2RESTORE-REPLACE-HISTORY PIC S9(4) COMP-5 VALUE 1024.
      * Generate redirect restore script
       77  DB2RESTORE-GENERATE-SCRIPT PIC S9(9) COMP-5 VALUE 32768.

      * Restore Rebuild Types
      * No rebuild
       77  DB2RESTORE-NO-REBUILD     PIC S9(4) COMP-5 VALUE 0.
      * Rebuild with all tablespaces in database
       77  DB2RESTORE-ALL-TBSP-IN-DB PIC S9(4) COMP-5 VALUE 4096.
      * Rebuild with all tablespaces in image
       77  DB2RESTORE-ALL-TBSP-IN-IMG PIC S9(4) COMP-5 VALUE 8192.
      * Rebuild with all tablespaces in list
       77  DB2RESTORE-ALL-TBSP-IN-LIST PIC S9(9) COMP-5 VALUE 12288.
      * Rebuild with all tablespaces in database except
       77  DB2RESTORE-ALL-TBSP-IN-DB-EXC PIC S9(9) COMP-5 VALUE 20480.
      * Rebuild with all tablespaces in image except
       77  DB2RESTORE-ALL-TBSP-IN-IMG-EXC PIC S9(9) COMP-5 VALUE 24576.

      * Restore Caller Actions
       77  DB2RESTORE-RESTORE        PIC S9(4) COMP-5 VALUE 0.
       77  DB2RESTORE-CONTINUE       PIC S9(4) COMP-5 VALUE 1.
       77  DB2RESTORE-TERMINATE      PIC S9(4) COMP-5 VALUE 2.
       77  DB2RESTORE-NOINTERRUPT    PIC S9(4) COMP-5 VALUE 3.
       77  DB2RESTORE-DEVICE-TERMINATE PIC S9(4) COMP-5 VALUE 9.
       77  DB2RESTORE-PARM-CHK       PIC S9(4) COMP-5 VALUE 10.
       77  DB2RESTORE-PARM-CHK-INIT-WAIT PIC S9(4) COMP-5 VALUE 10.
       77  DB2RESTORE-PARM-CHK-ONLY  PIC S9(4) COMP-5 VALUE 11.
       77  DB2RESTORE-TERMINATE-INCRE PIC S9(4) COMP-5 VALUE 13.
       77  DB2RESTORE-RESTORE-STORDEF PIC S9(4) COMP-5 VALUE 100.
       77  DB2RESTORE-STORDEF-NOINTERRUPT PIC S9(4) COMP-5 VALUE 101.

      * piLogTarget values for Snapshot restore
       77  DB2RESTORE-LOGTARGET-INCLUDE PIC X(7) value "INCLUDE"
                                     USAGE DISPLAY NATIVE.
       77  DB2RESTORE-LOGTARGET-EXCLUDE PIC X(7) value "EXCLUDE"
                                     USAGE DISPLAY NATIVE.
       77  DB2RESTORE-LOGTARGET-INCFORCE PIC X(13) value "INCLUDE FORCE"
                                     USAGE DISPLAY NATIVE.
       77  DB2RESTORE-LOGTARGET-EXCFORCE PIC X(13) value "EXCLUDE FORCE"
                                     USAGE DISPLAY NATIVE.

      * Generic Backup Definitions

      * Generic Tablespace List Structure
      *************************************************************************
      * db2gTablespaceStruct data structure
      **************************************************************************
       01 DB2G-TABLESPACE-STRUCT.
           05 DB2-TABLESPACES        USAGE IS POINTER.
           05 DB2-NUM-TABLESPACES    PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.

      * Generic Media List Structure
      *************************************************************************
      * db2gMediaListStruct data structure
      **************************************************************************
       01 DB2G-MEDIA-LIST-STRUCT.
           05 DB2-LOCATIONS          USAGE IS POINTER.
           05 DB2-NUM-LOCATIONS      PIC 9(9) COMP-5.
           05 DB2-LOCATION-TYPE      PIC X
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X(3)
                                     USAGE DISPLAY NATIVE.

      * Generic Backup Structure
      *************************************************************************
      * db2gBackupStruct data structure
      * db2gBackupStruct data structure specific parameters
      * 
      * iDBAliasLen
      * Input. A 4-byte unsigned integer representing the length in bytes of the
      * database alias.
      * 
      * iApplicationIdLen
      * Input. A 4-byte unsigned integer representing the length in bytes of the
      * poApplicationId buffer. Should be equal to SQLU_APPLID_LEN+1 (defined in
      * sqlutil.h).
      * 
      * iTimestampLen
      * Input. A 4-byte unsigned integer representing the length in bytes of the
      * poTimestamp buffer. Should be equal to SQLU_TIME_STAMP_LEN+1
      * (defined in sqlutil.h).
      * 
      * iUsernameLen
      * Input. A 4-byte unsigned integer representing the length in bytes of the user
      * name. Set to zero if no user name is provided.
      * 
      * iPasswordLen
      * Input. A 4-byte unsigned integer representing the length in bytes of the
      * password. Set to zero if no password is provided.
      * 
      * iComprLibraryLen
      * Input. A four-byte unsigned integer representing the length in bytes of the
      * name of the library specified in piComprLibrary. Set to zero if no
      * library name is given.
      * 
      **************************************************************************
       01 DB2G-BACKUP-STRUCT.
           05 DB2-PI-DBALIAS         USAGE IS POINTER.
           05 DB2-I-DBALIAS-LEN      PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
           05 DB2-PO-APPLICATION-ID  USAGE IS POINTER.
           05 DB2-I-APPLICATION-ID-LEN PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
           05 DB2-PO-TIMESTAMP       USAGE IS POINTER.
           05 DB2-I-TIMESTAMP-LEN    PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
           05 DB2-PI-TABLESPACE-LIST USAGE IS POINTER.
           05 DB2-PI-MEDIA-LIST      USAGE IS POINTER.
           05 DB2-PI-USERNAME        USAGE IS POINTER.
           05 DB2-I-USERNAME-LEN     PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
           05 DB2-PI-PASSWORD        USAGE IS POINTER.
           05 DB2-I-PASSWORD-LEN     PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
           05 DB2-PI-VENDOR-OPTIONS  USAGE IS POINTER.
           05 DB2-I-VENDOR-OPTIONS-SIZE PIC 9(9) COMP-5.
           05 DB2-O-BACKUP-SIZE      PIC 9(9) COMP-5.
           05 DB2-I-CALLER-ACTION    PIC 9(9) COMP-5.
           05 DB2-I-BUFFER-SIZE      PIC 9(9) COMP-5.
           05 DB2-I-NUM-BUFFERS      PIC 9(9) COMP-5.
           05 DB2-I-PARALLELISM      PIC 9(9) COMP-5.
           05 DB2-I-OPTIONS          PIC 9(9) COMP-5.
      * Throttle Parameter
           05 DB2-I-UTIL-IMPACT-PRIORITY PIC 9(9) COMP-5.
      * Name of compression library
           05 DB2-PI-COMPR-LIBRARY   USAGE IS POINTER.
      * Length of compression library name
           05 DB2-I-COMPR-LIBRARY-LEN PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Vendor-specific options for compression plug-in
           05 DB2-PI-COMPR-OPTIONS   USAGE IS POINTER.
      * Size of piComprOptions block
           05 DB2-I-COMPR-OPTIONS-SIZE PIC 9(9) COMP-5.
      * Flag indicating how piNodeList should be used
           05 DB2-I-ALL-NODE-FLAG    PIC 9(9) COMP-5.
      * Number of partitions in piNodeList
           05 DB2-I-NUM-NODES        PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Partition list
           05 DB2-PI-NODE-LIST       USAGE IS POINTER.
      * Number of elements in piMPPOutputStruct array
           05 DB2-I-NUM-MPPOUTPUT-STRUCTS PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Per-partition backup output
           05 DB2-PO-MPPOUTPUT-STRUCT USAGE IS POINTER.

      * Generic Backup API
      *************************************************************************
      * db2gBackup API
      **************************************************************************

      * Generic Restore Definitions

      *************************************************************************
      * db2gStoragePathsStruct data structure
      **************************************************************************
       01 DB2G-STORAGE-PATHS-STRUCT.
           05 DB2-STORAGE-PATHS      USAGE IS POINTER.
           05 DB2-NUM-STORAGE-PATHS  PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.

      * Generic Restore Structure
      *************************************************************************
      * db2gRestoreStruct data structure
      * db2gRestoreStruct data structure specific parameters
      * 
      * iSourceDBAliasLen
      * Input. Specifies the length in bytes of the piSourceDBAlias parameter.
      * 
      * iTargetDBAliasLen
      * Input. Specifies the length in bytes of the piTargetDBAlias parameter.
      * 
      * iApplicationIdLen
      * Input. Specifies the length in bytes of the poApplicatoinId parameter.
      * Should be equal to SQLU_APPLID_LEN + 1. The constant SQLU_APPLID_LEN is
      * defined in sqlutil header file that is located in the include directory.
      * 
      * iTimestampLen
      * Input. Specifies the length in bytes of the piTimestamp parameter.
      * 
      * iTargetDBPathLen
      * Input. Specifies the length in bytes of the piTargetDBPath parameter.
      * 
      * iReportFileLen
      * Input. Specifies the length in bytes of the piReportFile parameter.
      * 
      * iUsernameLen
      * Input. Specifies the length in bytes of the piUsername parameter. Set
      * to zero if no user name is provided.
      * 
      * iPasswordLen
      * Input. Specifies the length in bytes of the piPassword parameter. Set
      * to zero if no password is provided.
      * 
      * iNewLogPathLen 
      * Input. Specifies the length in bytes of the piNewLogPath parameter.
      * 
      * iLogTargetLen
      * Input. Specifies the length in bytes of the piLogTarget parameter.
      * 
      **************************************************************************
       01 DB2G-RESTORE-STRUCT.
           05 DB2-PI-SOURCE-DBALIAS  USAGE IS POINTER.
           05 DB2-I-SOURCE-DBALIAS-LEN PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
           05 DB2-PI-TARGET-DBALIAS  USAGE IS POINTER.
           05 DB2-I-TARGET-DBALIAS-LEN PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
           05 DB2-PO-APPLICATION-ID  USAGE IS POINTER.
           05 DB2-I-APPLICATION-ID-LEN PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
           05 DB2-PI-TIMESTAMP       USAGE IS POINTER.
           05 DB2-I-TIMESTAMP-LEN    PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
           05 DB2-PI-TARGET-DBPATH   USAGE IS POINTER.
           05 DB2-I-TARGET-DBPATH-LEN PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
           05 DB2-PI-REPORT-FILE     USAGE IS POINTER.
           05 DB2-I-REPORT-FILE-LEN  PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
           05 DB2-PI-TABLESPACE-LIST USAGE IS POINTER.
           05 DB2-PI-MEDIA-LIST      USAGE IS POINTER.
           05 DB2-PI-USERNAME        USAGE IS POINTER.
           05 DB2-I-USERNAME-LEN     PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
           05 DB2-PI-PASSWORD        USAGE IS POINTER.
           05 DB2-I-PASSWORD-LEN     PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
           05 DB2-PI-NEW-LOG-PATH    USAGE IS POINTER.
           05 DB2-I-NEW-LOG-PATH-LEN PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
           05 DB2-PI-VENDOR-OPTIONS  USAGE IS POINTER.
           05 DB2-I-VENDOR-OPTIONS-SIZE PIC 9(9) COMP-5.
           05 DB2-I-PARALLELISM      PIC 9(9) COMP-5.
           05 DB2-I-BUFFER-SIZE      PIC 9(9) COMP-5.
           05 DB2-I-NUM-BUFFERS      PIC 9(9) COMP-5.
           05 DB2-I-CALLER-ACTION    PIC 9(9) COMP-5.
           05 DB2-I-OPTIONS          PIC 9(9) COMP-5.
      * Name of compression library
           05 DB2-PI-COMPR-LIBRARY   USAGE IS POINTER.
      * Length of compression library name
           05 DB2-I-COMPR-LIBRARY-LEN PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Vendor-specific options for compression plug-in
           05 DB2-PI-COMPR-OPTIONS   USAGE IS POINTER.
      * Size of piComprOptions block
           05 DB2-I-COMPR-OPTIONS-SIZE PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
           05 DB2-PI-LOG-TARGET      USAGE IS POINTER.
           05 DB2-I-LOG-TARGET-LEN   PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
           05 DB2-PI-STORAGE-PATHS   USAGE IS POINTER.
      * Redirect restore script file name
           05 DB2-PI-REDIRECT-SCRIPT USAGE IS POINTER.
      * Length of piRedirectScript
           05 DB2-I-REDIRECT-SCRIPT-LEN PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.

      * Generic Restore API

      * Values for db2Recover - iRecoverCallerAction
       77  DB2RECOVER                PIC S9(4) COMP-5 VALUE 3.
       77  DB2RECOVER-RESTART        PIC S9(4) COMP-5 VALUE 4.
       77  DB2RECOVER-DEVICE-TERMINATE PIC S9(4) COMP-5 VALUE 9.
       77  DB2RECOVER-PARM-CHK-ONLY  PIC S9(4) COMP-5 VALUE 10.
       77  DB2RECOVER-CONTINUE       PIC S9(4) COMP-5 VALUE 11.
       77  DB2RECOVER-LOADREC-TERM   PIC S9(4) COMP-5 VALUE 12.
       77  DB2RECOVER-DEVICE-TERM    PIC S9(4) COMP-5 VALUE 13.

      * Values for db2Recover - iOptions
      * No flags specified
       77  DB2RECOVER-EMPTY-FLAG     PIC S9(4) COMP-5 VALUE 0.
      * Interpret stop time as local time
       77  DB2RECOVER-LOCAL-TIME     PIC S9(4) COMP-5 VALUE 1.
      * Interpret stop time as GMT time
       77  DB2RECOVER-GMT-TIME       PIC S9(4) COMP-5 VALUE 2.

      *************************************************************************
      * db2gRecover API
      **************************************************************************

      * Rollforward Definitions

      * Values for db2Rollforward - CallerAction
      * Rollforward to requested point
       77  DB2ROLLFORWARD-RFWD       PIC S9(4) COMP-5 VALUE 1.
      * End rollforward recovery
       77  DB2ROLLFORWARD-STOP       PIC S9(4) COMP-5 VALUE 2.
      * End rollforward recovery
       77  DB2ROLLFORWARD-COMPLETE   PIC S9(4) COMP-5 VALUE 2.
      * Rollforward  to requested point and end rollforward recovery
       77  DB2ROLLFORWARD-RFWD-STOP  PIC S9(4) COMP-5 VALUE 3.
      * Rollforward  to requested point and end rollforward recovery
       77  DB2ROLLFORWARD-RFWD-COMPLETE PIC S9(4) COMP-5 VALUE 3.
      * Query nextarclog, firstarcdel, lastarcdel, lastcommit
       77  DB2ROLLFORWARD-QUERY      PIC S9(4) COMP-5 VALUE 4.
      * Cancel current rollforward
       77  DB2ROLLFORWARD-CANCEL     PIC S9(4) COMP-5 VALUE 8.
      * Parameter check
       77  DB2ROLLFORWARD-PARM-CHECK PIC S9(4) COMP-5 VALUE 10.
      * Continue load recovery
       77  DB2ROLLFORWARD-LOADREC-CONT PIC S9(4) COMP-5 VALUE 11.
      * Terminate load recovery
       77  DB2ROLLFORWARD-LOADREC-TERM PIC S9(4) COMP-5 VALUE 12.
      * Terminate device
       77  DB2ROLLFORWARD-DEVICE-TERM PIC S9(4) COMP-5 VALUE 13.

      * Values for db2Rollforward - ConnectMode
      * Offline rollforward mode
       77  DB2ROLLFORWARD-OFFLINE    PIC S9(4) COMP-5 VALUE 0.
      * Online rollforward mode
       77  DB2ROLLFORWARD-ONLINE     PIC S9(4) COMP-5 VALUE 1.

      * Values for db2Rollforward - iRollforwardFlags
      * No flags specified
       77  DB2ROLLFORWARD-EMPTY-FLAG PIC S9(4) COMP-5 VALUE 0.
      * Interpret stop time as local time, not UTC
       77  DB2ROLLFORWARD-LOCAL-TIME PIC S9(4) COMP-5 VALUE 1.
      * Do not attempt to retrieve log files via userexit
       77  DB2ROLLFORWARD-NO-RETRIEVE PIC S9(4) COMP-5 VALUE 2.
      * Rollforward to the end of the most recently restored backup image
       77  DB2ROLLFORWARD-END-OF-BACKUP PIC S9(4) COMP-5 VALUE 4.

      * Values for db2Rollforward - oRollforwardFlags
      * Indicates stop time is returned as server's local time, not UTC
       77  DB2ROLLFORWARD-OUT-LOCAL-TIME PIC S9(4) COMP-5 VALUE 1.

      * Length of arrays used by db2Rollforward
      * Length of ISO format timestamp
       77  DB2-ISO-TIMESTAMP-LEN     PIC S9(4) COMP-5 VALUE 26.
      * Length of logfile name
       77  DB2-LOGFILE-NAME-LEN      PIC S9(4) COMP-5 VALUE 12.
      * Maximum length of a logfile path
       77  DB2-LOGPATH-LEN           PIC S9(4) COMP-5 VALUE 242.

      * Generic Rollforward Input Structure
      *************************************************************************
      * db2gRfwdInputStruct data structure
      * db2gRfwdInputStruct data structure specific parameters
      * 
      * iDbAliasLen
      * Input. Specifies the length in bytes of the database alias.
      * 
      * iStopTimeLen 
      * Input. Specifies the length in bytes of the stop time parameter. Set to zero
      * if no stop time is provided. 
      * 
      * iUserNameLen 
      * Input. Specifies the length in bytes of the user name. Set to zero if no
      * user name is provided. 
      * 
      * iPasswordLen 
      * Input. Specifies the length in bytes of the password. Set to zero if no
      * password is provided. 
      * 
      * iOverflowLogPathLen 
      * Input. Specifies the length in bytes of the overflow log path. Set to zero
      * if no overflow log path is provided. 
      * 
      * iDroppedTblIDLen
      * Input. Specifies the length in bytes of the dropped table ID (piDroppedTblID
      * parameter). Set to zero if no dropped table ID is provided.
      * 
      * iExportDirLen
      * Input. Specifies the length in bytes of the dropped table export
      * directory (piExportDir parameter). Set to zero if no dropped table export
      * directory is provided.
      * 
      **************************************************************************
       01 DB2G-RFWD-INPUT-STRUCT.
      * Length in bytes of piDbAlias
           05 SQL-DBALIASLEN         PIC 9(9) COMP-5.
      * Length in bytes of piStopTime
           05 SQL-STOPTIMELEN        PIC 9(9) COMP-5.
      * Length in bytes of piUserName
           05 SQL-USERNAMELEN        PIC 9(9) COMP-5.
      * Length in bytes of piPassword
           05 SQL-PASSWORDLEN        PIC 9(9) COMP-5.
      * Length in bytes of piOverflowLogPath
           05 SQL-OVRLOGPATHLEN      PIC 9(9) COMP-5.
      * Length in bytes of piDroppedTblID
           05 SQL-DROPPEDTBLIDLEN    PIC 9(9) COMP-5.
      * Length in bytes of piExportDir
           05 SQL-EXPORTDIRLEN       PIC 9(9) COMP-5.
      * Rollforward version
           05 SQL-VERSION            PIC 9(9) COMP-5.
      * Database alias
           05 SQL-DBALIAS            USAGE IS POINTER.
      * Rollforward action
           05 SQL-CALLERACTION       PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Stop time
           05 SQL-STOPTIME           USAGE IS POINTER.
      * User name to execute under
           05 SQL-USERNAME           USAGE IS POINTER.
      * Password
           05 SQL-PASSWORD           USAGE IS POINTER.
      * Overflow log path
           05 SQL-OVERFLOWLOGPATH    USAGE IS POINTER.
      * Number of changed overflow log paths
           05 SQL-NUMCHANGE          PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Changed overflow log paths
           05 DB2-PI-CHNG-LOG-OVRFLW USAGE IS POINTER.
      * Connect mode
           05 SQL-CONNECTMODE        PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * List of tablespaces to rollforward
           05 DB2-PI-TABLESPACE-LIST USAGE IS POINTER.
      * Flag indicating how piNodeist should be used
           05 SQL-ALLNODEFLAG        PIC S9(9) COMP-5.
      * Number of nodes in piNodeList
           05 SQL-NUMNODES           PIC S9(9) COMP-5.
      * Node list
           05 SQL-NODELIST           USAGE IS POINTER.
      * Size of piNodeInfo in db2RfwdOutput
           05 SQL-NUMNODEINFO        PIC S9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Dropped table id
           05 SQL-DROPPEDTBLID       USAGE IS POINTER.
      * Dropped table export directory
           05 SQL-EXPORTDIR          USAGE IS POINTER.
      * Rollforward input flags
           05 SQL-ROLLFORWARDFLAGS   PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.

      * Rollforward Output Structure
      *************************************************************************
      * db2RfwdOutputStruct data structure
      * db2RfwdOutputStruct data structure parameters
      * 
      * poApplicationId
      * Output. The application ID. 
      * 
      * poNumReplies 
      * Output. The number of replies received. 
      * 
      * poNodeInfo 
      * Output. Database partition reply information.
      * 
      * oRollforwardFlags 
      * Output. Rollforward output flags. Valid values (defined in 
      * db2ApiDf header file, located in the include directory) are: 
      * - DB2ROLLFORWARD_OUT_LOCAL_TIMEIndicates to caller that the last committed transaction timestamp is 
      * returned in local time rather than UTC.  Local time is based on the 
      * server's local time, not on the client's.  In a partitioned database 
      * environment, local time is based on the catalog partition's local time.
      * 
      **************************************************************************
       01 DB2RFWD-OUTPUT-STRUCT.
      * application id
           05 SQL-APPLID             USAGE IS POINTER.
      * number of replies received
           05 SQL-NUMREPLIES         USAGE IS POINTER.
      * node reply info
           05 DB2-PO-NODE-INFO       USAGE IS POINTER.
      * Rollforward output flags
           05 SQL-OROLLFORWARDFLAGS  PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.

      * Generic Rollforward API Structure
      *************************************************************************
      * db2gRollforwardStruct data structure
      **************************************************************************
       01 DB2G-ROLLFORWARD-STRUCT.
      * generic rollforward input structure
           05 DB2-PI-RFWD-INPUT      USAGE IS POINTER.
      * rollforward output structure
           05 DB2-PO-RFWD-OUTPUT     USAGE IS POINTER.

      *************************************************************************
      * db2gRollforward API
      **************************************************************************

      * High Availability Disaster Recovery (HADR) Definitions

      * Values for iByForce
      * Do not perform START or TAKEOVER HADR operation by force
       77  DB2HADR-NO-FORCE          PIC S9(4) COMP-5 VALUE 0.
      * Do perform START or TAKEOVER HADR operation by force
       77  DB2HADR-FORCE             PIC S9(4) COMP-5 VALUE 1.
      * Perform TAKEOVER HADR BY FORCE PEER WINDOW ONLY
       77  DB2HADR-FORCE-PEERWINDOW  PIC S9(4) COMP-5 VALUE 2.

      * Values for iDbRole
      * An HADR Primary database
       77  DB2HADR-DB-ROLE-PRIMARY   PIC S9(4) COMP-5 VALUE 1.
      * An HADR Standby database
       77  DB2HADR-DB-ROLE-STANDBY   PIC S9(4) COMP-5 VALUE 2.

      * High Availability Disaster Recovery (HADR) API Definitions

      * Generic Start HADR API Input Struct
      *************************************************************************
      * db2gHADRStartStruct data structure
      * db2gHADRStartStruct data structure specific parameters
      * 
      * iAliasLen
      * Input. Specifies the length in bytes of the database alias.
      * 
      * iUserNameLen
      * Input. Specifies the length in bytes of the user name.
      * 
      * iPasswordLen
      * Input. Specifies the length in bytes of the password.
      * 
      **************************************************************************
       01 DB2G-HADRSTART-STRUCT.
      * Database alias
           05 DB2-PI-DB-ALIAS        USAGE IS POINTER.
      * Length of database alias string
           05 DB2-I-ALIAS-LEN        PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * User name to execute command under
           05 DB2-PI-USER-NAME       USAGE IS POINTER.
      * Length of username field
           05 DB2-I-USER-NAME-LEN    PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Password for username
           05 DB2-PI-PASSWORD        USAGE IS POINTER.
      * Length of password field
           05 DB2-I-PASSWORD-LEN     PIC 9(9) COMP-5.
      * Primary db or standby
           05 DB2-I-DB-ROLE          PIC 9(9) COMP-5.
      * Start HADR by force
           05 DB2-I-BY-FORCE         PIC 9(4) COMP-5.
           05 FILLER                 PIC X(6)
                                     USAGE DISPLAY NATIVE.

      *************************************************************************
      * db2gHADRStart API
      **************************************************************************


      * Generic Stop HADR API Input Struct
      *************************************************************************
      * db2gHADRStopStruct data structure
      * db2gHADRStopStruct data structure specific parameters
      * 
      * iAliasLen
      * Input. Specifies the length in bytes of the database alias.
      * 
      * iUserNameLen
      * Input. Specifies the length in bytes of the user name.
      * 
      * iPasswordLen
      * Input. Specifies the length in bytes of the password.
      * 
      **************************************************************************
       01 DB2G-HADRSTOP-STRUCT.
      * Database alias
           05 DB2-PI-DB-ALIAS        USAGE IS POINTER.
      * Length of database alias string
           05 DB2-I-ALIAS-LEN        PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * User name to execute command under
           05 DB2-PI-USER-NAME       USAGE IS POINTER.
      * Length of username field
           05 DB2-I-USER-NAME-LEN    PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Password for username
           05 DB2-PI-PASSWORD        USAGE IS POINTER.
      * Length of password field
           05 DB2-I-PASSWORD-LEN     PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.

      *************************************************************************
      * db2gHADRStop API
      **************************************************************************


      * Generic Takeover HADR API Input Struct
      *************************************************************************
      * db2gHADRTakeoverStruct data structure
      * db2gHADRTakeoverStruct data structure specific parameters
      * 
      * iAliasLen
      * Input. Specifies the length in bytes of the database alias.
      * 
      * iUserNameLen
      * Input. Specifies the length in bytes of the user name.
      * 
      * iPasswordLen
      * Input. Specifies the length in bytes of the password.
      * 
      **************************************************************************
       01 DB2G-HADRTAKEOVER-STRUCT.
      * Database alias
           05 DB2-PI-DB-ALIAS        USAGE IS POINTER.
      * Length of database alias string
           05 DB2-I-ALIAS-LEN        PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * User name to execute command under
           05 DB2-PI-USER-NAME       USAGE IS POINTER.
      * Length of username field
           05 DB2-I-USER-NAME-LEN    PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Password for username
           05 DB2-PI-PASSWORD        USAGE IS POINTER.
      * Length of password field
           05 DB2-I-PASSWORD-LEN     PIC 9(9) COMP-5.
      * Takeover HADR by force
           05 DB2-I-BY-FORCE         PIC 9(4) COMP-5.
           05 FILLER                 PIC X(2)
                                     USAGE DISPLAY NATIVE.

      *************************************************************************
      * db2gHADRTakeover API
      **************************************************************************

      * Archive Active Log Definitions

      * Values for db2ArchiveLog - iAllNodeFlag
       77  DB2ARCHIVELOG-NODE-LIST   PIC S9(4) COMP-5 VALUE 0.
       77  DB2ARCHIVELOG-ALL-NODES   PIC S9(4) COMP-5 VALUE 1.
       77  DB2ARCHIVELOG-ALL-EXCEPT  PIC S9(4) COMP-5 VALUE 2.

      * Generic Archive Active Log API Input Struct
      *************************************************************************
      * db2gArchiveLogStruct data structure
      * db2gArchiveLogStruct data structure specific parameters
      * 
      * iAliasLen
      * Input. A 4-byte unsigned integer representing the length in bytes of the
      * database alias.
      * 
      * iUserNameLen
      * Input. A 4-byte unsigned integer representing the length in bytes of the user
      * name. Set to zero if no user name is used.
      * 
      * iPasswordLen
      * Input. A 4-byte unsigned integer representing the length in bytes of the
      * password. Set to zero if no password is used.
      * 
      **************************************************************************
       01 DB2G-ARCHIVE-LOG-STRUCT.
      * Length of database alias field
           05 DB2-I-ALIAS-LEN        PIC 9(9) COMP-5.
      * Length of username field
           05 DB2-I-USER-NAME-LEN    PIC 9(9) COMP-5.
      * Length of password field
           05 DB2-I-PASSWORD-LEN     PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Alias of database to archive log for
           05 DB2-PI-DATABASE-ALIAS  USAGE IS POINTER.
      * User name to execute command under
           05 DB2-PI-USER-NAME       USAGE IS POINTER.
      * Password for username
           05 DB2-PI-PASSWORD        USAGE IS POINTER.
      * Flag indicating how the iNodeList should be used
           05 DB2-I-ALL-NODE-FLAG    PIC 9(4) COMP-5.
      * Number of nodes in piNodeList array
           05 DB2-I-NUM-NODES        PIC 9(4) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Node list
           05 DB2-PI-NODE-LIST       USAGE IS POINTER.
      * Future use
           05 DB2-I-OPTIONS          PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.

      *************************************************************************
      * db2gArchiveLog API
      **************************************************************************

      * Asynchronous Read Log Definitions

      * Values for db2ReadLog - iCallerAction
      * Read the database log
       77  DB2READLOG-READ           PIC S9(4) COMP-5 VALUE 1.
      * Read a single log record
       77  DB2READLOG-READ-SINGLE    PIC S9(4) COMP-5 VALUE 2.
      * Query the database log
       77  DB2READLOG-QUERY          PIC S9(4) COMP-5 VALUE 3.

      * Values for db2ReadLog - iFilterOption
      * Read all log records
       77  DB2READLOG-FILTER-OFF     PIC S9(4) COMP-5 VALUE 0.
      * Read only propagatable records
       77  DB2READLOG-FILTER-ON      PIC S9(4) COMP-5 VALUE 1.

      * Generic Ping Database Parameter Structure 
      *************************************************************************
      * db2gDatabasePingStruct data structure
      * db2gDatabasePingStruct data structure specific parameters
      * 
      * iDbAliasLength
      * Input. Length of the database alias name. Reserved for future use.
      * 
      **************************************************************************
       01 DB2G-DATABASE-PING-STRUCT.
      * Input: Db alias name length - reserved
           05 DB2-I-DB-ALIAS-LENGTH  PIC 9(4) COMP-5.
      * Input: Database alias - reserved
           05 DB2-I-DB-ALIAS         PIC X(8)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X(1)
                                     USAGE DISPLAY NATIVE.
      * Input: size of request packet
           05 DB2-REQUEST-PACKET-SZ  PIC S9(9) COMP-5.
      * Input: size of response packet
           05 DB2-RESPONSE-PACKET-SZ PIC S9(9) COMP-5.
      * Input: Number of iterations
           05 DB2-I-NUM-ITERATIONS   PIC 9(4) COMP-5.
           05 FILLER                 PIC X(2)
                                     USAGE DISPLAY NATIVE.
      * Output: Array of elapsed times (microsec), contains iNumIterations
      * elements
           05 DB2-PO-ELAPSED-TIME    USAGE IS POINTER.

      *************************************************************************
      * db2gDatabasePing API
      **************************************************************************

      * Convert Monitor Data Interface Structure
      *************************************************************************
      * db2ConvMonStreamData data structure
      * db2ConvMonStreamData data structure parameters
      * 
      * poTarget
      * Output. A pointer to the target monitor output structure (for example,
      * sqlm_db2). A list of output types, and their corresponding input types, is
      * given below.
      * 
      * piSource
      * Input. A pointer to the logical data element being converted (for example,
      * SQLM_ELM_DB2). A list of output types, and their corresponding input
      * types, is given below.
      * 
      * iTargetType
      * Input. The type of conversion being performed. Specify the value for the v5
      * type in sqlmon.h for instance SQLM_DB2_SS.
      * 
      * iTargetSize
      * Input. This parameter can usually be set to the size of the structure pointed
      * to by poTarget; however, for elements that have usually been referenced by
      * an offset value from the end of the structure (for example, statement text in
      * sqlm_stmt), specify a buffer that is large enough to contain the sqlm_stmt
      * statically-sized elements, as well as a statement of the largest size to be
      * extracted; that is, SQL_MAX_STMT_SIZ plus sizeof(sqlm_stmt).
      * 
      * iSourceType
      * Input. The type of source stream. Valid values are SQLM_STREAM_SNAPSHOT
      * (snapshot stream), or SQLM_STREAM_EVMON (event monitor stream).
      * 
      **************************************************************************
       01 DB2CONV-MON-STREAM-DATA.
      * Pointer to target structure
           05 DB2-PO-TARGET          USAGE IS POINTER.
      * Pointer to V6 stream
           05 DB2-PI-SOURCE          USAGE IS POINTER.
      * Target structure type
           05 DB2-I-TARGET-TYPE      PIC 9(9) COMP-5.
      * Space allocated for target
           05 DB2-I-TARGET-SIZE      PIC 9(9) COMP-5.
      * Type of source stream
           05 DB2-I-SOURCE-TYPE      PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Get Snapshot Data Interface Structure
      *************************************************************************
      * db2gGetSnapshotData data structure
      **************************************************************************
       01 DB2G-GET-SNAPSHOT-DATA.
      * Pointer to monitor area
           05 DB2-PI-SQLMA-DATA      USAGE IS POINTER.
      * Pointer to collected data
           05 DB2-PO-COLLECTED-DATA  USAGE IS POINTER.
      * Pointer to output buffer
           05 DB2-PO-BUFFER          USAGE IS POINTER.
      * Snapshot version
           05 DB2-I-VERSION          PIC 9(9) COMP-5.
      * Size of output buffer
           05 DB2-I-BUFFER-SIZE      PIC 9(9) COMP-5.
      * Write to file flag
           05 DB2-I-STORE-RESULT     PIC 9(9) COMP-5.
      * Target node
           05 DB2-I-NODE-NUMBER      PIC S9(9) COMP-5.
      * Pointer to output format indicator
           05 DB2-PO-OUTPUT-FORMAT   USAGE IS POINTER.
      * Class qualifier for snapshot
           05 DB2-I-SNAPSHOT-CLASS   PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.

      * Get Snapshot Size Data Interface Structure
      *************************************************************************
      * db2gGetSnapshotSizeData data structure
      **************************************************************************
       01 DB2G-GET-SNAPSHOT-SIZE-DATA.
      * Pointer to monitor area
           05 DB2-PI-SQLMA-DATA      USAGE IS POINTER.
      * Pointer to output buffer
           05 DB2-PO-BUFFER-SIZE     USAGE IS POINTER.
      * Snapshot version
           05 DB2-I-VERSION          PIC 9(9) COMP-5.
      * Target node
           05 DB2-I-NODE-NUMBER      PIC S9(9) COMP-5.
      * Class qualifier for snapshot
           05 DB2-I-SNAPSHOT-CLASS   PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.

      * Monitor Snapshot v9+ Request Stream Interface Structure
       01 DB2ADD-SNAPSHOT-RQST-DATA.
      * Pointer to snapshot request stream, NULL on first call.
           05 DB2-PIO-REQUEST-DATA   USAGE IS POINTER.
      * Snapshot request type e.g. SQLMA_DB2
           05 DB2-I-REQUEST-TYPE     PIC 9(9) COMP-5.
      * Stream construction flags
           05 DB2-I-REQUEST-FLAGS    PIC S9(9) COMP-5.
      * Type of the qualifier. e.g. SQLMA_QUAL_TYPE_DBNAME
           05 DB2-I-QUAL-TYPE        PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Ptr to qualifier data. e.g dbname
           05 DB2-PI-QUAL-DATA       USAGE IS POINTER.

       01 DB2G-ADD-SNAPSHOT-RQST-DATA.
      * Pointer to snapshot request stream, NULL on first call.
           05 DB2-PIO-REQUEST-DATA   USAGE IS POINTER.
      * Snapshot request type e.g. SQLMA_DB2
           05 DB2-I-REQUEST-TYPE     PIC 9(9) COMP-5.
      * Stream construction flags
           05 DB2-I-REQUEST-FLAGS    PIC S9(9) COMP-5.
      * Type of the qualifier. e.g. SQLMA_QUAL_TYPE_DBNAME
           05 DB2-I-QUAL-TYPE        PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Ptr to qualifier data. e.g dbname
           05 DB2-PI-QUAL-DATA       USAGE IS POINTER.
      * Length of the qualifier.
           05 DB2-I-QUAL-DATA-LEN    PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.

      * Monitor Switches Data Interface Structure
      *************************************************************************
      * db2gMonitorSwitchesData data structure
      **************************************************************************
       01 DB2G-MONITOR-SWITCHES-DATA.
      * Pointer to group states
           05 DB2-PI-GROUP-STATES    USAGE IS POINTER.
      * Pointer to output buffer
           05 DB2-PO-BUFFER          USAGE IS POINTER.
      * Size of output buffer
           05 DB2-I-BUFFER-SIZE      PIC 9(9) COMP-5.
      * Return data flag
           05 DB2-I-RETURN-DATA      PIC 9(9) COMP-5.
      * Snapshot version
           05 DB2-I-VERSION          PIC 9(9) COMP-5.
      * Target node
           05 DB2-I-NODE-NUMBER      PIC S9(9) COMP-5.
      * Pointer to output format indicator
           05 DB2-PO-OUTPUT-FORMAT   USAGE IS POINTER.

      * Monitor Reset Data Interface Structure
      * Monitor Reset Data General Interface Structure
      *************************************************************************
      * db2gResetMonitorData data structure
      * db2gResetMonitorData data structure specific parameters
      * 
      * iDbAliasLength 
      * Input. Specifies the length in bytes of the piDbAlias
      * parameter.
      * 
      **************************************************************************
       01 DB2G-RESET-MONITOR-DATA.
      * Reset value flag
           05 DB2-I-RESET-ALL        PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Database alias
           05 DB2-PI-DB-ALIAS        USAGE IS POINTER.
      * Length of DB alias
           05 DB2-I-DB-ALIAS-LENGTH  PIC 9(9) COMP-5.
      * Snapshot version
           05 DB2-I-VERSION          PIC 9(9) COMP-5.
      * Target node
           05 DB2-I-NODE-NUMBER      PIC S9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.

      *************************************************************************
      * db2gRestartDbStruct data structure
      * db2gRestartDbStruct data structure specific parameters
      * 
      * iDatabaseNameLen
      * Input. Length in bytes of piDatabaseName parameter.
      * 
      * iUserIdLen
      * Input. Length in bytes of piUserId parameter.
      * 
      * iPasswordLen
      * Input. Length in bytes of piPassword parameter.
      * 
      * iTablespaceNamesLen
      * Input. Length in bytes of piTablespaceNames parameter.
      * 
      **************************************************************************
       01 DB2G-RESTART-DB-STRUCT.
      * Length in bytes of piDatabaseName
           05 DB2-I-DATABASE-NAME-LEN PIC 9(9) COMP-5.
      * Length in bytes of piUserId
           05 DB2-I-USER-ID-LEN      PIC 9(9) COMP-5.
      * Length in bytes of piPassword
           05 DB2-I-PASSWORD-LEN     PIC 9(9) COMP-5.
      * Length in bytes of piTablespaceNames
           05 DB2-I-TABLESPACE-NAMES-LEN PIC 9(9) COMP-5.
      * Database name or alias
           05 DB2-PI-DATABASE-NAME   USAGE IS POINTER.
      * User Id
           05 DB2-PI-USER-ID         USAGE IS POINTER.
      * Password
           05 DB2-PI-PASSWORD        USAGE IS POINTER.
      * Tablespace name list
           05 DB2-PI-TABLESPACE-NAMES USAGE IS POINTER.


      * Inspect Database Definitions

      * Inspect API structure
      *************************************************************************
      * db2InspectStruct data structure
      * db2InspectStruct data structure parameters
      * 
      * piTablespaceName
      * Input. A string containing the table space name. The table space must be
      * identified for operations on a table space. If the pointer is NULL, the table
      * space ID value is used as input.
      * 
      * piTableName
      * Input. A string containing the table name. The table must be identified for
      * operations on a table or a table object. If the pointer is NULL, the table
      * space ID and table object ID values are used as input.
      * 
      * piSchemaName
      * Input. A string containing the schema name.
      * 
      * piResultsName
      * Input. A string containing the name for results output file. This input must
      * be provided. The file will be written out to the diagnostic data directory
      * path.
      * 
      * piDataFileName
      * Input. Reserved for future use. Must be set to NULL.
      * 
      * piNodeList
      * Input. A pointer to an array of database partition numbers on which to
      * perform the operation.
      * 
      * iAction
      * Input. Specifies the inspect action. Valid values are:
      * - DB2INSPECT_ACT_CHECK_DB
      * Inspect the entire database.
      * - DB2INSPECT_ACT_CHECK_TABSPACE
      * Inspect a table space.
      * - DB2INSPECT_ACT_CHECK_TABLE
      * Inspect a table.
      * 
      * iTablespaceID
      * Input. Specifies the table space ID. If the table space must be identified,
      * the table space ID value is used as input if the pointer to table space
      * name is NULL.
      * 
      * iObjectID
      * Input. Specifies the object ID. If the table must be identified, the
      * object ID value is used as input if the pointer to table name is NULL.
      * 
      * iBeginCheckOption
      * Input. Option for check database or check table space operation to
      * indicate where operation should begin. It must be set to zero to begin
      * from the normal start. Values are:
      * 
      * - DB2INSPECT_BEGIN_TSPID
      * Use this value for check database to begin with the table space
      * specified by the table space ID field, the table space ID must be set.
      * 
      * - DB2INSPECT_BEGIN_TSPID_OBJID
      * Use this value for check database to begin with the table specified by
      * the table space ID and object ID field. To use this option, the table
      * space ID and object ID must be set.
      * 
      * - DB2INSPECT_BEGIN_OBJID
      * Use this value for check table space to begin with the table specified
      * by the object ID field, the object ID must be set.
      * 
      * iLimitErrorReported
      * Input. Specifies the reporting limit of the number of pages in error for an
      * object. Specify the number you want to use as the limit value or specify
      * one the following values:
      * - DB2INSPECT_LIMIT_ERROR_DEFAULT
      * Use this value to specify that the maximum number of pages in error to
      * be reported is the extent size of the object.
      * - DB2INSPECT_LIMIT_ERROR_ALL
      * Use this value to report all pages in error.
      * 
      * iObjectErrorState
      * Input. Specifies whether to scan objects in error state. Valid values are:
      * - DB2INSPECT_ERROR_STATE_NORMAL
      * Process object only in normal state.
      * - DB2INSPECT_ERROR_STATE_ALL
      * Process all objects, including objects in error state.
      * 
      * iKeepResultfile
      * Input. Specifies result file retention. Valid values are:
      * - DB2INSPECT_RESFILE_CLEANUP
      * If errors are reported, the result output file will be retained. Otherwise,
      * the result file will be removed at the end of the operation.
      * - DB2INSPECT_RESFILE_KEEP_ALWAYS
      * The result output file will be retained.
      * 
      * iAllNodeFlag
      * Input. Indicates whether the operation is to be applied to all nodes defined
      * in db2nodes.cfg. Valid values are:
      * - DB2_NODE_LIST
      * Apply to all nodes in a node list that is passed in pNodeList.
      * - DB2_ALL_NODES
      * Apply to all nodes. pNodeList should be NULL. This is the default value.
      * - DB2_ALL_EXCEPT
      * Apply to all nodes except those in a node list that is passed in
      * pNodeList.
      * 
      * iNumNodes
      * Input. Specifies the number of nodes in the pNodeList array.
      * 
      * iLevelObjectData
      * Input. Specifies processing level for data object. Valid values are:
      * - DB2INSPECT_LEVEL_NORMAL
      * Level is normal.
      * - DB2INSPECT_LEVEL_LOW
      * Level is low.
      * - DB2INSPECT_LEVEL_NONE
      * Level is none.
      * 
      * iLevelObjectIndex
      * Input. Specifies processing level for index object. Valid values are:
      * - DB2INSPECT_LEVEL_NORMAL
      * Level is normal.
      * - DB2INSPECT_LEVEL_LOW
      * Level is low.
      * - DB2INSPECT_LEVEL_NONE
      * Level is none.
      * 
      * iLevelObjectLong
      * Input. Specifies processing level for long object. Valid values are:
      * - DB2INSPECT_LEVEL_NORMAL
      * Level is normal.
      * - DB2INSPECT_LEVEL_LOW
      * Level is low.
      * - DB2INSPECT_LEVEL_NONE
      * Level is none.
      * 
      * iLevelObjectLOB
      * Input. Specifies processing level for LOB object. Valid values are:
      * - DB2INSPECT_LEVEL_NORMAL
      * Level is normal.
      * - DB2INSPECT_LEVEL_LOW
      * Level is low.
      * - DB2INSPECT_LEVEL_NONE
      * Level is none.
      * 
      * iLevelObjectBlkMap
      * Input. Specifies processing level for block map object. Valid values are:
      * - DB2INSPECT_LEVEL_NORMAL
      * Level is normal.
      * - DB2INSPECT_LEVEL_LOW
      * Level is low.
      * - DB2INSPECT_LEVEL_NONE
      * Level is none.
      * 
      * iLevelExtentMap
      * Input. Specifies processing level for extent map. Valid values are:
      * - DB2INSPECT_LEVEL_NORMAL
      * Level is normal.
      * - DB2INSPECT_LEVEL_LOW
      * Level is low.
      * - DB2INSPECT_LEVEL_NONE
      * Level is none.
      * 
      **************************************************************************
       01 DB2INSPECT-STRUCT.
      * Tablespace name; null terminated
           05 DB2-PI-TABLESPACE-NAME USAGE IS POINTER.
      * Table name; null terminated
           05 DB2-PI-TABLE-NAME      USAGE IS POINTER.
      * Schema name; null terminated
           05 DB2-PI-SCHEMA-NAME     USAGE IS POINTER.
      * Results Output file name; null terminated
           05 DB2-PI-RESULTS-NAME    USAGE IS POINTER.
      * Data file name; null terminated
           05 DB2-PI-DATA-FILE-NAME  USAGE IS POINTER.
      * Array of nodes
           05 DB2-PI-NODE-LIST       USAGE IS POINTER.
      * Action
           05 DB2-I-ACTION           PIC 9(9) COMP-5.
      * Tablespace ID
           05 DB2-I-TABLESPACE-ID    PIC S9(9) COMP-5.
      * Object ID
           05 DB2-I-OBJECT-ID        PIC S9(9) COMP-5.
      * Page number of first page
           05 DB2-I-FIRST-PAGE       PIC 9(9) COMP-5.
      * Number of pages
           05 DB2-I-NUMBER-OF-PAGES  PIC 9(9) COMP-5.
      * Format type
           05 DB2-I-FORMAT-TYPE      PIC 9(9) COMP-5.
      * Options
           05 DB2-I-OPTIONS          PIC 9(9) COMP-5.
      * Begin checking option
           05 DB2-I-BEGIN-CHECK-OPTION PIC 9(9) COMP-5.
      * Number of pages in error in object to limit reporting of
           05 DB2-I-LIMIT-ERROR-REPORTED PIC S9(9) COMP-5.
      * Object error state option
           05 DB2-I-OBJECT-ERROR-STATE PIC 9(4) COMP-5.
      * Catalog to tablespace consistency option
           05 DB2-I-CATALOG-TO-TABLESPACE PIC 9(4) COMP-5.
      * Keep result file
           05 DB2-I-KEEP-RESULTFILE  PIC 9(4) COMP-5.
      * all node flag
           05 DB2-I-ALL-NODE-FLAG    PIC 9(4) COMP-5.
      * Number of nodes
           05 DB2-I-NUM-NODES        PIC 9(4) COMP-5.
      * Processing level for Data object
           05 DB2-I-LEVEL-OBJECT-DATA PIC 9(4) COMP-5.
      * Processing level for Index object
           05 DB2-I-LEVEL-OBJECT-INDEX PIC 9(4) COMP-5.
      * Processing level for Long object
           05 DB2-I-LEVEL-OBJECT-LONG PIC 9(4) COMP-5.
      * Processing level for LOB object
           05 DB2-I-LEVEL-OBJECT-LOB PIC 9(4) COMP-5.
      * Processing level for Block map object
           05 DB2-I-LEVEL-OBJECT-BLK-MAP PIC 9(4) COMP-5.
      * Processing level for Extent map
           05 DB2-I-LEVEL-EXTENT-MAP PIC 9(4) COMP-5.
      * Processing level for XML column data
           05 DB2-I-LEVEL-OBJECT-XML PIC 9(4) COMP-5.
      * Processing level for cross object checking
           05 DB2-I-LEVEL-CROSS-OBJECT PIC 9(9) COMP-5.


      * Generic Inspect API structure
      *************************************************************************
      * db2gInspectStruct data structure
      * db2gInspectStruct data structure specific parameters
      * 
      * iResultsNameLength
      * Input. The string length of the results file name.
      * 
      * iDataFileNameLength
      * Input. The string length of the data output file name.
      * 
      * iTablespaceNameLength
      * Input. The string length of the table space name.
      * 
      * iTableNameLength
      * Input. The string length of the table name.
      * 
      * iSchemaNameLength
      * Input. The string length of the schema name.
      * 
      **************************************************************************
       01 DB2G-INSPECT-STRUCT.
      * Tablespace name
           05 DB2-PI-TABLESPACE-NAME USAGE IS POINTER.
      * Table name
           05 DB2-PI-TABLE-NAME      USAGE IS POINTER.
      * Schema name
           05 DB2-PI-SCHEMA-NAME     USAGE IS POINTER.
      * Results Output file name
           05 DB2-PI-RESULTS-NAME    USAGE IS POINTER.
      * Data file name
           05 DB2-PI-DATA-FILE-NAME  USAGE IS POINTER.
      * Array of nodes
           05 DB2-PI-NODE-LIST       USAGE IS POINTER.
      * Results Output file name length
           05 DB2-I-RESULTS-NAME-LENGTH PIC 9(9) COMP-5.
      * Data file name length
           05 DB2-I-DATA-FILE-NAME-LENGTH PIC 9(9) COMP-5.
      * Tablespace name length
           05 DB2-I-TABLESPACE-NAME-LENGTH PIC 9(9) COMP-5.
      * Table name length
           05 DB2-I-TABLE-NAME-LENGTH PIC 9(9) COMP-5.
      * Schema name length
           05 DB2-I-SCHEMA-NAME-LENGTH PIC 9(9) COMP-5.
      * Action
           05 DB2-I-ACTION           PIC 9(9) COMP-5.
      * Tablespace ID
           05 DB2-I-TABLESPACE-ID    PIC S9(9) COMP-5.
      * Object ID
           05 DB2-I-OBJECT-ID        PIC S9(9) COMP-5.
      * Page number of first page
           05 DB2-I-FIRST-PAGE       PIC 9(9) COMP-5.
      * Number of pages
           05 DB2-I-NUMBER-OF-PAGES  PIC 9(9) COMP-5.
      * Format type
           05 DB2-I-FORMAT-TYPE      PIC 9(9) COMP-5.
      * Options
           05 DB2-I-OPTIONS          PIC 9(9) COMP-5.
      * Begin checking option
           05 DB2-I-BEGIN-CHECK-OPTION PIC 9(9) COMP-5.
      * Number of pages in error in object to limit reporting of
           05 DB2-I-LIMIT-ERROR-REPORTED PIC S9(9) COMP-5.
      * Object error state option
           05 DB2-I-OBJECT-ERROR-STATE PIC 9(4) COMP-5.
      * Catalog to tablespace consistency option
           05 DB2-I-CATALOG-TO-TABLESPACE PIC 9(4) COMP-5.
      * Keep result file
           05 DB2-I-KEEP-RESULTFILE  PIC 9(4) COMP-5.
      * all node flag
           05 DB2-I-ALL-NODE-FLAG    PIC 9(4) COMP-5.
      * Number of nodes
           05 DB2-I-NUM-NODES        PIC 9(4) COMP-5.
      * Processing level for Data object
           05 DB2-I-LEVEL-OBJECT-DATA PIC 9(4) COMP-5.
      * Processing level for Index object
           05 DB2-I-LEVEL-OBJECT-INDEX PIC 9(4) COMP-5.
      * Processing level for Long object
           05 DB2-I-LEVEL-OBJECT-LONG PIC 9(4) COMP-5.
      * Processing level for LOB object
           05 DB2-I-LEVEL-OBJECT-LOB PIC 9(4) COMP-5.
      * Processing level for Block map object
           05 DB2-I-LEVEL-OBJECT-BLK-MAP PIC 9(4) COMP-5.
      * Processing level for Extent map
           05 DB2-I-LEVEL-EXTENT-MAP PIC 9(4) COMP-5.
      * Processing level for XML column data
           05 DB2-I-LEVEL-OBJECT-XML PIC 9(4) COMP-5.
      * Processing level for cross object checking
           05 DB2-I-LEVEL-CROSS-OBJECT PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.


      * Values for db2Inspect - Action constants
       77  DB2INSPECT-ACTION-CHECK   PIC S9(4) COMP-5 VALUE 1.
       77  DB2INSPECT-ACTION-FORMAT  PIC S9(9) COMP-5 VALUE 65536.
       77  DB2INSPECT-ACTION-ROWCMPEST PIC S9(9) COMP-5 VALUE 131072.

      * Values for db2Inspect - iAction
      * DB2INSPECT_ACT_CHECK_RESTART   - Inspect check restart    
      * DB2INSPECT_ACT_CHECK_DB        - Inspect DB               
      * DB2INSPECT_ACT_CHECK_TABSPACE  - Inspect tablespace       
      * DB2INSPECT_ACT_CHECK_TABLE     - Inspect table            
      * DB2INSPECT_ACT_CHECK_DATA      - Inspect data object      
      * DB2INSPECT_ACT_CHECK_INDEX     - Inspect index object     
      * DB2INSPECT_ACT_CHECK_BLOCKMAP  - Inspect block map object 
      * DB2INSPECT_ACT_CHECK_XML       - Inspect XML object       
      * DB2INSPECT_ACT_CHECK_XOBJ      - Inspect cross object      
      * DB2INSPECT_ACT_FORMAT_PAGE     - Format page in tablespace
      * DB2INSPECT_ACT_FORMAT_EXT_MAP  - Format extent map        
      * DB2INSPECT_ACT_FORMAT_DATA     - Format data page         
      * DB2INSPECT_ACT_FORMAT_INDEX    - Format index page        
      * DB2INSPECT_ACT_FORMAT_BLOCKMAP - Format block map page    
      * DB2INSPECT_ACT_FORMAT_XML      - Format XML object        
      * Inspect check restart
       77  DB2INSPECT-ACT-CHECK-RESTART PIC S9(4) COMP-5 VALUE 2.
      * Inspect DB
       77  DB2INSPECT-ACT-CHECK-DB   PIC S9(4) COMP-5 VALUE 3.
      * Inspect tablespace
       77  DB2INSPECT-ACT-CHECK-TABSPACE PIC S9(4) COMP-5 VALUE 4.
      * Inspect table
       77  DB2INSPECT-ACT-CHECK-TABLE PIC S9(4) COMP-5 VALUE 5.
      * Inspect data object
       77  DB2INSPECT-ACT-CHECK-DATA PIC S9(4) COMP-5 VALUE 6.
      * Inspect index object
       77  DB2INSPECT-ACT-CHECK-INDEX PIC S9(4) COMP-5 VALUE 7.
      * Inspect block map object
       77  DB2INSPECT-ACT-CHECK-BLOCKMAP PIC S9(4) COMP-5 VALUE 8.
      * Inspect XML object
       77  DB2INSPECT-ACT-CHECK-XML  PIC S9(4) COMP-5 VALUE 9.
      * Inspect cross object checking
       77  DB2INSPECT-ACT-CHECK-XOBJ PIC S9(4) COMP-5 VALUE 10.
      * Reserved
       77  DB2INSPECT-ACT-CHECK-10   PIC S9(4) COMP-5 VALUE 11.
      * Format page in tablespace
       77  DB2INSPECT-ACT-FORMAT-PAGE PIC S9(9) COMP-5 VALUE 65537.
      * Format extent map
       77  DB2INSPECT-ACT-FORMAT-EXT-MAP PIC S9(9) COMP-5 VALUE 65538.
      * Format data page
       77  DB2INSPECT-ACT-FORMAT-DATA PIC S9(9) COMP-5 VALUE 65539.
      * Format index page
       77  DB2INSPECT-ACT-FORMAT-INDEX PIC S9(9) COMP-5 VALUE 65540.
      * Format block map page
       77  DB2INSPECT-ACT-FORMAT-BLOCKMAP PIC S9(9) COMP-5 VALUE 65541.
      * Format XML object
       77  DB2INSPECT-ACT-FORMAT-XML PIC S9(9) COMP-5 VALUE 65542.
      * Reserved
       77  DB2INSPECT-ACT-FORMAT-07  PIC S9(9) COMP-5 VALUE 65543.
      * Reserved
       77  DB2INSPECT-ACT-FORMAT-08  PIC S9(9) COMP-5 VALUE 65544.
      * Reserved
       77  DB2INSPECT-ACT-FORMAT-09  PIC S9(9) COMP-5 VALUE 65545.
      * Reserved
       77  DB2INSPECT-ACT-FORMAT-10  PIC S9(9) COMP-5 VALUE 65546.
      * Reserved
       77  DB2INSPECT-ACT-ROWCMPEST-TBL PIC S9(9) COMP-5 VALUE 131073.

      * Values for db2Inspect - iFormatType
       77  DB2INSPECT-FORMAT-TYPE-HEX PIC S9(4) COMP-5 VALUE 1.
       77  DB2INSPECT-FORMAT-TYPE-BRIEF PIC S9(4) COMP-5 VALUE 2.
       77  DB2INSPECT-FORMAT-TYPE-DETAIL PIC S9(4) COMP-5 VALUE 3.
       77  DB2INSPECT-FORMAT-TYPE-DEL PIC S9(4) COMP-5 VALUE 4.

      * Values for db2Inspect - iOptions
      * Format - 1st page number logical
       77  DB2INSPECT-OPTS-PAGE-LOGICAL PIC S9(4) COMP-5 VALUE 0.
      * Format - 1st page number physical
       77  DB2INSPECT-OPTS-PAGE-PHYSICAL PIC S9(4) COMP-5 VALUE 1.

      * Values for db2Inspect - iBeginCheckOption
      * Begin from the start.
       77  DB2INSPECT-BEGIN-FROM-START PIC S9(4) COMP-5 VALUE 0.
      * Begin check on tablespace ID.
       77  DB2INSPECT-BEGIN-TSPID    PIC S9(4) COMP-5 VALUE 1.
      * Begin check on object ID.
       77  DB2INSPECT-BEGIN-OBJID    PIC S9(4) COMP-5 VALUE 2.
       77  DB2INSPECT-BEGIN-TSPID-OBJID PIC S9(4) COMP-5 VALUE 3.

      * Values for db2Inspect - iLimitErrorReported
      * limit errors reported to default number
       77  DB2INSPECT-LIMIT-ERROR-DEFAULT PIC S9(4) COMP-5 VALUE 0.
      * no limit to errors reported
       77  DB2INSPECT-LIMIT-ERROR-ALL PIC S9(4) COMP-5 VALUE -1.

      * Values for db2Inspect - iObjectErrorState
      * process object only in normal state
       77  DB2INSPECT-ERROR-STATE-NORMAL PIC S9(4) COMP-5 VALUE 0.
      * process object in any state
       77  DB2INSPECT-ERROR-STATE-ALL PIC S9(4) COMP-5 VALUE 1.

      * Values for db2Inspect - iCatalogToTablespace
      * Catalog to tablespace consistency not requested
       77  DB2INSPECT-CAT-TO-TABSP-NONE PIC S9(4) COMP-5 VALUE 0.
      * Catalog to tablespace consistency requested
       77  DB2INSPECT-CAT-TO-TABSP-YES PIC S9(4) COMP-5 VALUE 1.

      * Values for db2Inspect - iKeepResultfile
      * Clean up result file when no error
       77  DB2INSPECT-RESFILE-CLEANUP PIC S9(4) COMP-5 VALUE 0.
      * Always keep result file
       77  DB2INSPECT-RESFILE-KEEP-ALWAYS PIC S9(4) COMP-5 VALUE 1.

      * Values for db2Inspect - Level constants
       77  DB2INSPECT-LEVEL-DEFAULT  PIC S9(4) COMP-5 VALUE 0.
       77  DB2INSPECT-LEVEL-NONE     PIC S9(4) COMP-5 VALUE 1.
       77  DB2INSPECT-LEVEL-NORMAL   PIC S9(4) COMP-5 VALUE 0.
       77  DB2INSPECT-LEVEL-LOW      PIC S9(9) COMP-5 VALUE 16384.
       77  DB2INSPECT-LEVEL-HIGH     PIC S9(9) COMP-5 VALUE 49152.

      * Values for db2Inspect - Cross Object Level constants
       77  DB2INSPECT-LVL-XOBJ-DEFAULT PIC S9(4) COMP-5 VALUE 0.
       77  DB2INSPECT-LVL-XOBJ-NONE  PIC S9(4) COMP-5 VALUE 0.
      * Index to data checking for rid index
       77  DB2INSPECT-LVL-XOBJ-INXDAT-RID PIC S9(4) COMP-5 VALUE 1.
      * Block data validation through composite block index
       77  DB2INSPECT-LVL-XOBJ-BLKDAT PIC S9(4) COMP-5 VALUE 2.
      * Data to index checking for XML index
       77  DB2INSPECT-LVL-XOBJ-DATINX-XML PIC S9(9) COMP-5 VALUE 65536.

      * Values for db2Inspect - iNumberOfPages
      * To the last page
       77  DB2INSPECT-NUMPAGES-TO-THE-END PIC S9(4) COMP-5 VALUE 0.

      * Inspect API
      *************************************************************************
      * db2Inspect API
      * Inspects the database for architectural integrity and checks the pages of the
      * database for page consistency.
      * 
      * Scope
      * 
      * In a single partition database environment, the scope is the single database
      * partition only. In a partitioned database environment, it is the collection
      * of all logical database partitions defined in db2nodes.cfg.
      * 
      * Authorization
      * 
      * One of the following:
      * - sysadm
      * - sysctrl
      * - sysmaint
      * - dbadm
      * - CONTROL privilege on the table
      * 
      * Required connection
      * 
      * Database
      * 
      * API include file
      * 
      * db2ApiDf.h
      * 
      * db2Inspect API parameters
      * 
      * versionNumber
      * Input. Specifies the version and release level of the structure passed as the
      * second parameter pParmStruct.
      * 
      * pParmStruct
      * Input. A pointer to the db2InspectStruct structure.
      * 
      * pSqlca
      * Output. A pointer to the sqlca structure.
      * 
      * Usage notes
      * 
      * The online inspect processing will access database objects using
      * isolation level uncommitted read. Commit processing will be done
      * during the inspect processing. It is advisable to end the unit of
      * work by committing or rolling back changes, by executing a COMMIT
      * or ROLLBACK statement respectively, before starting the inspect
      * operation.
      * 
      * The inspect check processing will write out unformatted inspection
      * data results to the result file. The file will be written out to the
      * diagnostic data directory path. If there are no errors found by the
      * check processing, the result output file will be erased at the end
      * of the inspect operation. If there are errors found by the check
      * processing, the result output file will not be erased at the end of
      * the inspect operation. To see the inspection details, format the
      * inspection result output file with the db2inspf utility.
      * 
      * In a partitioned database environment, the extension of the result
      * output file will correspond to the database partition number. The
      * file is located in the database manager diagnostic data directory path.
      * 
      * A unique results output file name must be specified. If the result
      * output file already exists, the operation will not be processed.
      * 
      * The processing of table spaces will process only the objects that
      * reside in that table space.
      * 
      **************************************************************************

      * Generic Inspect API
      *************************************************************************
      * db2gInspect API
      **************************************************************************



      * Utility Control API

      * Utility Throttling Constants
      * Default throttling priority
       77  SQL-UTIL-IMPACT-PRIORITY-DFLT PIC S9(4) COMP-5 VALUE 50.

      * Utility Control Structure
      *************************************************************************
      * db2UtilityControlStruct data structure
      * db2UtilityControlStruct data structure parameters
      * 
      * iId
      * Input. Specifies the ID of the utility to modify.
      * 
      * iAttribute
      * Input. Specifies the attribute to modify. Valid values (defined in
      * db2ApiDf header file, located in the include directory) are:
      * - DB2UTILCTRL_PRIORITY_ATTRIB
      * Modify the throttling priority of the utility.
      * 
      * pioValue
      * Input. Specifies the new attribute value associated with the iAttribute
      * parameter.
      * Note:
      * If the iAttribute parameter is set to DB2UTILCTRL_PRIORITY_ATTRIB, then the
      * pioValue parameter must point to a db2Uint32 containing the priority.
      * 
      **************************************************************************
       01 DB2UTILITY-CONTROL-STRUCT.
      * Utility id
           05 DB2-I-ID               PIC 9(9) COMP-5.
      * Attribute to modify
           05 DB2-I-ATTRIBUTE        PIC 9(9) COMP-5.
      * Attribute data
           05 DB2-PIO-VALUE          USAGE IS POINTER.

      * Valid utility attributes
      * Modify utility priority
       77  DB2UTILCTRL-PRIORITY-ATTRIB PIC S9(4) COMP-5 VALUE 1.

      * Utility Control API
      *************************************************************************
      * db2UtilityControl API
      * Controls the priority level of running utilities. Can be used to
      * throttle and unthrottle utility invocations.
      * 
      * Authorization
      * 
      * sysadm
      * 
      * Required connection
      * 
      * Instance
      * 
      * API include file
      * 
      * db2ApiDf.h
      * 
      * db2UtilityControl API parameters
      * 
      * version
      * Input. Specifies the version and release level of the structure passed
      * in as the second parameter, pUtilitlyControlStruct.
      * 
      * pUtilityControlStruct
      * Input. A pointer to the db2UtilityControlStruct structure.
      * 
      * pSqlca
      * Output. A pointer to the sqlca structure.
      * 
      * Usage notes
      * 
      * SQL1153N will be returned if there is no existing utility with the
      * specified iId. This may indicate that the function was invoked with
      * invalid arguments or that the utility has completed.
      * 
      * 7SQL1154N will be returned if the utility does not support throttling.
      * 
      **************************************************************************

      * Generic Utility Control Structure
      *************************************************************************
      * db2gUtilityControlStruct data structure
      **************************************************************************
       01 DB2G-UTILITY-CONTROL-STRUCT.
      * Utility id
           05 DB2-I-ID               PIC 9(9) COMP-5.
      * Attribute to modify
           05 DB2-I-ATTRIBUTE        PIC 9(9) COMP-5.
      * Attribute data
           05 DB2-PIO-VALUE          USAGE IS POINTER.


      * Generic Utility Control API
      *************************************************************************
      * db2gUtilityControl API
      **************************************************************************

      * Quiesce Definitions



































      * Update Alternate Server Parameter Structure 
      * Update Alternate Server API 
      * Generic Update Alternate Server Structure 
      *************************************************************************
      * db2gUpdateAltServerStruct data structure
      * db2gUpdateAltServerStruct data structure specific parameters
      * 
      * iDbAlias_len
      * Input. The length in bytes of piDbAlias.
      * 
      * iHostName_len
      * Input. The length in bytes of piHostName.
      * 
      * iPort_len
      * Input. The length in bytes of piPort.
      * 
      **************************************************************************
       01 DB2G-UPDATE-ALT-SERVER-STRUCT.
      * Input: database alias length
           05 DB2-I-DB-ALIAS-LEN     PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Input: database alias
           05 DB2-PI-DB-ALIAS        USAGE IS POINTER.
      * Input: host name length
           05 DB2-I-HOST-NAME-LEN    PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Input: host name
           05 DB2-PI-HOST-NAME       USAGE IS POINTER.
      * Input: port number length
           05 DB2-I-PORT-LEN         PIC 9(9) COMP-5.
           05 FILLER                 PIC X(4)
                                     USAGE DISPLAY NATIVE.
      * Input: port number
           05 DB2-PI-PORT            USAGE IS POINTER.

      * Generic Update Alternate Server API 
      *************************************************************************
      * db2gUpdateAlternateServerForDB API
      **************************************************************************

      * Open Database Directory Scan Parameter Structure 
      * Open Database Directory Scan API 
      * Generic Open Database Directory Scan Parameter Structure 
      *************************************************************************
      * db2gDbDirOpenScanStruct data structure
      * db2gDbDirOpenScanStruct data structure specific parameters
      * 
      * iPath_len
      * Input. The length in bytes of the piPath parameter.
      * 
      **************************************************************************
       01 DB2G-DB-DIR-OPEN-SCAN-STRUCT.
      * Input: drive/path length
           05 DB2-I-PATH-LEN         PIC 9(9) COMP-5.
      * Input: drive/path
           05 DB2-PI-PATH            USAGE IS POINTER.
      * Output: handle
           05 DB2-O-HANDLE           PIC 9(4) COMP-5.
      * Output: count
           05 DB2-O-NUM-ENTRIES      PIC 9(4) COMP-5.

      * Generic Open Database Directory Scan API 
      *************************************************************************
      * db2gDbDirOpenScan API
      **************************************************************************

      * Get Next Database Directory Entry Data Structure 
      *************************************************************************
      * db2DbDirInfoV9 data structure
      * db2DbDirInfoV9 data structure parameters
      * 
      * alias
      * An alternate database name.
      * 
      * dbname
      * The name of the database.
      * 
      * drive
      * The local database directory path name where the database resides. This
      * field is returned only if the system database directory is opened for scan.
      * 
      * intname
      * A token identifying the database subdirectory. This field is returned only if
      * the local database directory is opened for scan.
      * 
      * nodename
      * The name of the node where the database is located. This field is
      * returned only if the cataloged database is a remote database.
      * 
      * dbtype
      * Database manager release information.
      * 
      * comment
      * The comment associated with the database.
      * 
      * com_codepage
      * The code page of the comment. Not used.
      * 
      * type
      * Entry type. Valid values are:
      * - SQL_INDIRECT
      * Database created by the current instance (as defined by the
      * value of the DB2INSTANCE environment variable).
      * - SQL_REMOTE
      * Database resides at a different instance.
      * - SQL_HOME
      * Database resides on this volume (always HOME in local
      * database directory).
      * - SQL_DCE
      * Database resides in DCE directories.
      * 
      * authentication
      * Authentication type. Valid values are:
      * - SQL_AUTHENTICATION_SERVER
      * Authentication of the user name and password takes place at the
      * server.
      * - SQL_AUTHENTICATION_CLIENT
      * Authentication of the user name and password takes place at the
      * client.
      * - SQL_AUTHENTICATION_DCS
      * Used for DB2 Connect.
      * - SQL_AUTHENTICATION_DCE
      * Authentication takes place using DCE Security Services.
      * - SQL_AUTHENTICATION_KERBEROS
      * Authentication takes place using Kerberos Security Mechanism.
      * - SQL_AUTHENTICATION_NOT_SPECIFIED
      * DB2 no longer requires authentication to be kept in the database
      * directory. Specify this value when connecting to anything other
      * than a down-level (DB2 V2 or less) server.
      * - SQL_AUTHENTICATION_SVR_ENCRYPT
      * Specifies that authentication takes place on the node containing
      * the target database, and that the authentication password is to
      * be encrypted.
      * - SQL_AUTHENTICATION_DATAENC
      * Specifies that authentication takes place on the node containing
      * the target database, and that connections must use data
      * encryption.
      * - SQL_AUTHENTICATION_GSSPLUGIN
      * Specifies that authentication takes place using an external GSS
      * API-based plug-in security mechanism.
      * 
      * glbdbname
      * The global name of the target database in the global (DCE) directory, if
      * the entry is of type SQL_DCE.
      * 
      * dceprincipal
      * The principal name if the authentication is of type DCE or KERBEROS.
      * 
      * cat_nodenum
      * Catalog node number.
      * 
      * nodenum
      * Node number.
      * 
      * althostname
      * The hostname or IP address of the alternate server where the database is
      * reconnected at failover time.
      * 
      * altportnumber
      * The port number of the alternate server where the database is
      * reconnected at failover time.
      * 
      **************************************************************************
       01 DB2DB-DIR-INFO-V9.
      * Alias name
           05 SQL-ALIAS-V9           PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * Database name
           05 SQL-DBNAME-V9          PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * Drive/Path
           05 SQL-DRIVE-V9           PIC X(215)
                                     USAGE DISPLAY NATIVE.
      * Database subdirectory
           05 SQL-INTNAME-V9         PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * Node name
           05 SQL-NODENAME-V9        PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * Release information
           05 SQL-DBTYPE-V9          PIC X(20)
                                     USAGE DISPLAY NATIVE.
      * Comment
           05 SQL-COMMENT-V9         PIC X(30)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X(1)
                                     USAGE DISPLAY NATIVE.
      * Code page of comment
           05 SQL-COM-CODEPAGE-V9    PIC S9(4) COMP-5.
      * Entry type - defines above
           05 SQL-TYPE-V9            PIC X
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X(1)
                                     USAGE DISPLAY NATIVE.
      * Authentication type
           05 SQL-AUTHENTICATION-V9  PIC 9(4) COMP-5.
      * Global database name
           05 SQL-GLBDBNAME-V9       PIC X(255)
                                     USAGE DISPLAY NATIVE.
      * dce principal bin string
           05 SQL-DCEPRINCIPAL-V9    PIC X(1024)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X(1)
                                     USAGE DISPLAY NATIVE.
      * Catalog node number
           05 SQL-CAT-NODENUM-V9     PIC S9(4) COMP-5.
      * Node number
           05 SQL-NODENUM-V9         PIC S9(4) COMP-5.
      * Alternate hostname
           05 SQL-ALTHOSTNAME-V9     PIC X(255)
                                     USAGE DISPLAY NATIVE.
      * Port number
           05 SQL-ALTPORTNUMBER-V9   PIC X(14)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X(1)
                                     USAGE DISPLAY NATIVE.

      *************************************************************************
      * db2DbDirInfo data structure
      * 
      * db2DbDirInfo has been deprecated but is kept to preserve compatibility for
      * applications that invoke the db2DbDirGetNextEntry/db2gDbDirGetNextEntry API
      * with a downlevel version number of less than SQL_REL9000.  db2DbDirInfo will
      * be removed in a future release.  New applications should invoke the
      * db2DbDirGetNextEntry/db2gDbDirGetNextEntry API with a version number of no
      * less than SQL_REL9000 and its required pParmStruct value.
      * 
      **************************************************************************
       01 DB2DB-DIR-INFO.
      * Alias name
           05 SQL-ALIAS-N            PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * Database name
           05 SQL-DBNAME-N           PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * Drive/Path
           05 SQL-DRIVE-N            PIC X(215)
                                     USAGE DISPLAY NATIVE.
      * Database subdirectory
           05 SQL-INTNAME-N          PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * Node name
           05 SQL-NODENAME-N         PIC X(8)
                                     USAGE DISPLAY NATIVE.
      * Release information
           05 SQL-DBTYPE-N           PIC X(20)
                                     USAGE DISPLAY NATIVE.
      * Comment
           05 SQL-COMMENT-N          PIC X(30)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X(1)
                                     USAGE DISPLAY NATIVE.
      * Code page of comment
           05 SQL-COM-CODEPAGE-N     PIC S9(4) COMP-5.
      * Entry type - defines above
           05 SQL-TYPE-N             PIC X
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X(1)
                                     USAGE DISPLAY NATIVE.
      * Authentication type
           05 SQL-AUTHENTICATION-N   PIC 9(4) COMP-5.
      * Global database name
           05 SQL-GLBDBNAME-N        PIC X(255)
                                     USAGE DISPLAY NATIVE.
      * dce principal bin string
           05 SQL-DCEPRINCIPAL-N     PIC X(1024)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X(1)
                                     USAGE DISPLAY NATIVE.
      * Catalog node number
           05 SQL-CAT-NODENUM-N      PIC S9(4) COMP-5.
      * Node number
           05 SQL-NODENUM-N          PIC S9(4) COMP-5.
      * Alternate hostname
           05 SQL-ALTHOSTNAME-N      PIC X(255)
                                     USAGE DISPLAY NATIVE.
      * Port number
           05 SQL-ALTPORTNUMBER-N    PIC X(14)
                                     USAGE DISPLAY NATIVE.
           05 FILLER                 PIC X(1)
                                     USAGE DISPLAY NATIVE.

      * Get Next Database Directory Entry Parameter Structure 
      * Get Next Database Directory Entry API 
      * Generic Get Next Database Directory Entry Parameter Structure 
      *************************************************************************
      * db2gDbDirNextEntryStrV9 data structure
      **************************************************************************
       01 DB2G-DB-DIR-NEXT-ENTRY-STR-V9.
      * Input: handle
           05 DB2-I-HANDLE-V9        PIC 9(4) COMP-5.
           05 FILLER                 PIC X(2)
                                     USAGE DISPLAY NATIVE.
      * Output: buffer
           05 DB2-PO-DB-DIR-ENTRY-V9 USAGE IS POINTER.

      *************************************************************************
      * db2gDbDirNextEntryStruct data structure
      * 
      * db2gDbDirNextEntryStruct has been deprecated but is kept to preserve
      * compatibility for applications that invoke the db2gDbDirGetNextEntry API
      * with a downlevel version number of less than SQL_REL9000.
      * db2gDbDirNextEntryStruct will be removed in a future release.  New
      * applications should invoke the db2gDbDirGetNextEntry API with a version
      * number of no less than SQL_REL9000 and its required pParmStruct value.
      * 
      **************************************************************************
       01 DB2G-DB-DIR-NEXT-ENTRY-STRUCT.
      * Input: handle
           05 DB2-I-HANDLE           PIC 9(4) COMP-5.
           05 FILLER                 PIC X(2)
                                     USAGE DISPLAY NATIVE.
      * Output: buffer
           05 DB2-PO-DB-DIR-ENTRY    USAGE IS POINTER.

      * Generic Get Next Database Directory Entry API 
      *************************************************************************
      * db2gDbDirGetNextEntry API
      **************************************************************************

      * Close Database Directory Scan Parameter Structure 
      * Close Database Directory Scan API 
      * Generic Close Database Directory Scan Parameter Structure 
      *************************************************************************
      * db2gDbDirCloseScanStruct data structure
      **************************************************************************
       01 DB2G-DB-DIR-CLOSE-SCAN-STRUCT.
      * Input: handle
           05 DB2-I-HANDLE           PIC 9(4) COMP-5.

      * Generic Close Database Directory Scan API 
      *************************************************************************
      * db2gDbDirCloseScan API
      **************************************************************************

      * db2QpGetUserInformation



