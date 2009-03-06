/******************************************************************************
**
** Source File Name: db2VendorApi.h
**
** (C) COPYRIGHT International Business Machines Corp. 1987, 1997
** All Rights Reserved
** Licensed Materials - Property of IBM
**
** US Government Users Restricted Rights - Use, duplication or
** disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
**
** Function = Include File defining new additions beyond that found in
**            sqluvend.h:
**              - Interface to vendor devices.
**              - Structures required by vendor interfaces.
**              - Defined symbols
**
** Operating System: AIX
**
*******************************************************************************/
#ifndef SQL_H_DB2VENDORAPI
#define SQL_H_DB2VENDORAPI

#ifdef __cplusplus
extern "C" {
#endif

/* Required Include Files */

#include "sql.h"
#include "sqlenv.h"
#include "sqlutil.h"
#include "db2ApiDf.h"
#include "sqluvend.h"


/* API version constants */

#define  DB2VENDOR_API_VERSION1   db2Version820


/* Constants for field lengths */

#define   DB2VENDOR_MAX_FILENAME_SZ    1024
#define   DB2VENDOR_MAX_MGMTCLASS_SZ   256
#define   DB2VENDOR_MAX_OWNER_SZ       128


/* Structures */
/*******************************************************************************
** db2VendorQueryInfo data structure
** db2VendorQueryInfo data structure parameters
**
** sizeEstimate
** Specifies the estimated size of the object.
**
** type
** Specifies the image type if the object is a backup image.
**
** dbPartitionNum
** Specifies the number of the database partition that the object belongs to. 
**
** sequenceNum
** Specifies the file extension for the backup image. Valid only if the object
** is a backup. 
** 
** db2Instance
** Specifies the name of the instance that the object belongs to.
**
** dbname
** Specifes the name of the database that the object belongs to. 
**
** dbalias
** Specifies the alias of the database that the object belongs to.
**
** timestamp
** Specifies the time stamp used to identify the backup image. Valid only if the
** object is a backup image.
**
** filename
** Specifies the name of the object if the object is a load copy image or an
** archived log file.
**
** owner
** Specifies the owner of the object.
**
** mgmtClass
** Specifies the management class the object was stored under (used by TSM). 
**
** oldestLogfile
** Specifies the oldest log file stored with a backup image.
*******************************************************************************/
typedef struct db2VendorQueryInfo
{
   db2Uint64          sizeEstimate;                      /* Size estimate of obj */
   db2Uint32          type;                              /* Type of image        */
   SQL_PDB_NODE_TYPE  dbPartitionNum;                    /* Db partition number  */
   db2Uint16          sequenceNum;                       /* Seq. # of image      */

   char       db2Instance[SQL_INSTNAME_SZ + 1];          /* DB2 instance         */
   char       dbname[SQL_DBNAME_SZ + 1];                 /* Database name        */
   char       dbalias[SQL_ALIAS_SZ + 1];                 /* Database alias       */
   char       timestamp[SQLU_TIME_STAMP_LEN + 1];        /* Timestamp of image   */
   char       filename[DB2VENDOR_MAX_FILENAME_SZ + 1];   /* Specific filename    */
   char       owner[DB2VENDOR_MAX_OWNER_SZ + 1];         /* Object owner         */
   char       mgmtClass[DB2VENDOR_MAX_MGMTCLASS_SZ + 1]; /* Vendor defined       */
   char       oldestLogfile[DB2_LOGFILE_NAME_LEN + 1];   /* Oldest log file      */
                                                         /* stored with an image */
} db2VendorQueryInfo;


/* APIs */

/*******************************************************************************
** db2VendorQueryApiVersion API
** Determines which level of the vendor storage API is supported by the backup
** and restore vendor storage plug-in. If the specified vendor storage plug-in
** is not compatible with DB2, then it will not be used.
**
** If a vendor storage plug-in does not have this API implemented for 
** logs, then it cannot be used and DB2 will report an error. This will not 
** affect images that currently work with existing vendor libraries.
**
** Authorization
**
** None
**
** Required connection
**
** Database.
**
** API include file
**
** db2VendorApi.h
**
** db2VendorQueryApiVersion API parameters
**
** supportedVersion
** Output. Returns the version of the vendor storage API the vendor library 
** supports.
**
** Usage notes
**
** This API will be called before any other vendor storage APIs are invoked.
*******************************************************************************/

void db2VendorQueryApiVersion ( db2Uint32  * supportedVersion );

/*******************************************************************************
** db2VendorGetNextObj API
** This API is called after a query has been set up (using the sqluvint API) to
** get the next object (image or archived log file) that matches the search 
** criteria. Only one search for either images or log files can be set up at
** one time.
**
** Authorization
**
** None
**
** Required connection
**
** Database.
**
** API include file 
**
** db2VendorApi.h
**
** db2VendorGetNextObj API parameters
** 
** vendorCB
** Input. Pointer to space allocated by the vendor library.
**
** queryInfo 
** Output. Pointer to a db2VendorQueryInfo structure to be filled in by the
** vendor library.
** 
** returnCode 
** Output. The return code from the API call.
**
**
** Usage notes
**
** Not all parameters will pertain to each object or each vendor. The mandatory 
** parameters that need to be filled out are db2Instance, dbname, dbalias, 
** timestamp (for images), filename (for logs and load copy images), owner, 
** sequenceNum (for images) and dbPartitionNum. The remaining parameters will
** be left for the specific vendors to define. If a parameter does not pertain,
** then it should be initialized to "" for strings and 0 for numeric types.
*******************************************************************************/

int db2VendorGetNextObj ( void                        * vendorCB,
                          struct db2VendorQueryInfo   * queryInfo,
                          struct Return_code          * returnCode);

#ifdef __cplusplus
}
#endif

#endif
