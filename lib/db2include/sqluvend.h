/******************************************************************************
**
** Source File Name: SQLUVEND
**
** (C) COPYRIGHT International Business Machines Corp. 1987, 1997
** All Rights Reserved
** Licensed Materials - Property of IBM
**
** US Government Users Restricted Rights - Use, duplication or
** disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
**
**
** This include file is to be used by backup interface vendors.
**
** Function = Include File defining:
**              - Interface to vendor devices.
**              - Structures required by vendor interfaces.
**              - Defined symbols and return codes to be
**                returned from vendor interfaces.
**
*******************************************************************************/
#ifndef _H_SQLUVEND
#define _H_SQLUVEND

#ifdef __cplusplus
extern "C" {
#endif

#include "sql.h"

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


/*** sqluv API Return Codes***/                                                  

#define SQLUV_OK               0   /* Operation is successful */
#define SQLUV_LINK_EXIST       1   /* Session activated previously */
#define SQLUV_COMM_ERROR       2   /* Communication error with device */
#define SQLUV_INV_VERSION      3   /* The DB2 and vendor products are incompatible */
#define SQLUV_INV_ACTION       4   /* Invalid action is requested */
#define SQLUV_NO_DEV_AVAIL     5   /* No device is available for use at the moment */
#define SQLUV_OBJ_NOT_FOUND    6   /* Object specified cannot be found */
#define SQLUV_OBJS_FOUND       7   /* More than 1 object matches specification is found */
#define SQLUV_INV_USERID       8   /* Invalid userid specified */
#define SQLUV_INV_PASSWORD     9   /* Invalid password provided */
#define SQLUV_INV_OPTIONS      10  /* Invalid options specified */
#define SQLUV_INIT_FAILED      11  /* Initialization failed */
#define SQLUV_INV_DEV_HANDLE   12  /* Invalid device handle */
#define SQLUV_BUFF_SIZE        13  /* Invalid buffer size specified */
#define SQLUV_END_OF_DATA      14  /* End of data reached */
#define SQLUV_END_OF_TAPE      15  /* End of tape reached. Requires attention */
#define SQLUV_DATA_RESEND      16  /* Device requested to have last buffer sent again */
#define SQLUV_COMMIT_FAILED    17  /* Commit request failed */
#define SQLUV_DEV_ERROR        18  /* Device error */
#define SQLUV_WARNING          19  /* Warning. see return code */
#define SQLUV_LINK_NOT_EXIST   20  /* Session not activated previously */
#define SQLUV_MORE_DATA        21  /* More data to come */
#define SQLUV_ENDOFMEDIA_NO_DATA   22  /* End of media encountered with no data */
#define SQLUV_ENDOFMEDIA           23  /* ENd of media encountered */
#define SQLUV_MAX_LINK_GRANT   24  /* Max no. of link established */
#define SQLUV_IO_ERROR         25  /* I/O error encountered */
#define SQLUV_DELETE_FAILED    26  /* Delete object fails */
#define SQLUV_INV_BKUP_FNAME   27  /* Invalid backup filename provided */
#define SQLUV_NOT_ENOUGH_SPACE 28  /* insufficient space for estimated database size */
#define SQLUV_ABORT_FAILED     29  /* Abort request failed */
#define SQLUV_UNEXPECTED_ERROR 30  /* A severe error was experienced */
#define SQLUV_NO_DATA          31  /* No data has been returned */
#define SQLUV_OBJ_OUT_OF_SCOPE 32  /* Object not under BackupAdapter control */

#define SQLUV_COMMIT           0
#define SQLUV_ABORT            1
#define SQLUV_TERMINATE        2    /* For use by TSM only */

#define SQLUV_COMMENT_LEN     30

/******************************************************************************
** Return_code data structure
** Contains the return code for and a short explanation of the error being
** returned to DB2 by the backup and restore vendor storage plug-in. This data
** structure is used by all the vendor storage plug-in APIs.
**
** Table: Fields in the Return_code Structure
** -----------------------------------------------------------------------
** |Field Name      | Data Type | Description                            |
** |----------------|-----------|----------------------------------------|
** |return_code     | sqlint32  | Return code from the vendor API.       |
** |(see note below)|           |                                        |
** |----------------|-----------|----------------------------------------|
** |description     | char      | A short description of the return code.|
** |----------------|-----------|----------------------------------------|  
** |reserve         | void      | Reserved for future use.               |
** |---------------------------------------------------------------------|
** |Note: This is a vendor-specific return code that is not the same as  |
** |the value returned by various DB2 APIs. See the individual API       |
** |descriptions for the return codes that are accepted from vendor      |
** |products.                                                            |
** |---------------------------------------------------------------------|
*******************************************************************************/
typedef struct Return_code
{
        sqlint32   return_code;  /* return code from the vendor function  */
        char       description[SQLUV_COMMENT_LEN];
        /* descriptive message                   */
        void       *reserve;     /* reserve for future use                */
} Return_code;


/*** Misc Definitions***/

/*** Caller actions***/

/* For sqluvint */
#define SQLUV_WRITE         'W'   /* to write images         */
#define SQLUV_READ          'R'   /* to read images          */
#define SQLUV_ARCHIVE       'A'   /* to archive (write) logs */
#define SQLUV_RETRIEVE      'T'   /* to retrieve (read) logs */
#define SQLUV_QUERY_IMAGES  'I'   /* to query images         */
#define SQLUV_QUERY_LOGS    'L'   /* to query logs           */

/* For sqluvdel */
#define SQLUV_DELETE_IMAGES 'M'   /* for images              */
#define SQLUV_DELETE_LOGS   'O'   /* for logs                */
#define SQLUV_DELETE_ALL    'B'   /* for images/logs         */

/*** Low level backup and load copy image names***/
#define SQLUV_NAME_DB         "DB"
#define SQLUV_NAME_TSP        "TSP"
#define SQLUV_NAME_INCR       "_INCR"
#define SQLUV_NAME_DELTA      "_DELTA"
#define SQLUV_NAME_SUFFIX     "_BACKUP"

#define SQLUV_NAME_LOAD_COPY  "LOAD_COPY"
#define SQLUV_NAME_DB_FULL    "FULL"                           SQLUV_NAME_SUFFIX
#define SQLUV_NAME_DB_INCR    SQLUV_NAME_DB  SQLUV_NAME_INCR   SQLUV_NAME_SUFFIX
#define SQLUV_NAME_DB_DELTA   SQLUV_NAME_DB  SQLUV_NAME_DELTA  SQLUV_NAME_SUFFIX
#define SQLUV_NAME_TSP_FULL   SQLUV_NAME_TSP                   SQLUV_NAME_SUFFIX
#define SQLUV_NAME_TSP_INCR   SQLUV_NAME_TSP SQLUV_NAME_INCR   SQLUV_NAME_SUFFIX
#define SQLUV_NAME_TSP_DELTA  SQLUV_NAME_TSP SQLUV_NAME_DELTA  SQLUV_NAME_SUFFIX

/*** Image types to help create names.***/
#define SQLUV_DB          SQLUB_DB
#define SQLUV_TBSP        SQLUB_TABLESPACE
#define SQLUV_INCREMENTAL SQLUB_INCREMENTAL
#define SQLUV_DELTA       SQLUB_DELTA
#define SQLUV_LOAD_COPY   4

/******************************************************************************
** Create the low-level backup image name used by DB2 supported storage vendors.
*******************************************************************************/
#define SQLUV_NAME_GENERATE(_type, _incr) \
( (_type == SQLUV_DB) \
   ? ( !_incr ? SQLUV_NAME_DB_FULL \
              : ( (_incr == SQLUV_INCREMENTAL) \
                   ? SQLUV_NAME_DB_INCR : SQLUV_NAME_DB_DELTA )) \
   : ( (_type == SQLUV_TBSP) \
        ? ( !_incr ? SQLUV_NAME_TSP_FULL \
                   : ( (_incr == SQLUV_INCREMENTAL) \
                        ? SQLUV_NAME_TSP_INCR : SQLUV_NAME_TSP_DELTA )) \
        : SQLUV_NAME_LOAD_COPY ))


/******************************************************************************
** list_entry data structure
*******************************************************************************/
typedef  struct list_entry
{
    int       entry_len;        /* Including NULL terminator */
    char     *pentry;
} list_entry;

/******************************************************************************
** sqlu_gen_list data structure
*******************************************************************************/
typedef   struct sqlu_gen_list
{
    int                    num_of_entries;
    struct list_entry     *entry;
} sqlu_gen_list;

/******************************************************************************
** DB2_info data structure    
** Contains information about the DB2 product and the database that is being
** backed up or restored. This structure is used to identify DB2 to the vendor
** device and to describe a particular session between DB2 and the vendor
** device. It is passed to the backup and restore vendor storage plug-in as
** part of the Init_input data structure.
**
** Table: Fields in the DB2_info Structure. All char data type fields are
** null-terminated strings.
** ---------------------------------------------------------------------------
** |Field Name       |Data Type           |Description                       |
** |-----------------|--------------------|----------------------------------|
** |DB2_id           |char                |An identifier for the DB2         |
** |                 |                    |product. Maximum length of the    |
** |                 |                    |string it points to is 8          |
** |                 |                    |characters.                       |
** |-----------------|--------------------|----------------------------------|
** |version          |char                |The current version of the DB2    |
** |                 |                    |product. Maximum length of the    |
** |                 |                    |string it points to is 8          |
** |                 |                    |characters.                       |
** |-----------------|--------------------|----------------------------------|
** |release          |char                |The current release of the DB2    |
** |                 |                    |product. Set to NULL if it is     |
** |                 |                    |insignificant. Maximum length of  |
** |                 |                    |the string it points to is 8      |
** |                 |                    |characters.                       |
** |-----------------|--------------------|----------------------------------|
** |level            |char                |The current level of the DB2      |
** |                 |                    |product. Set to NULL if it is     |
** |                 |                    |insignificant. Maximum length of  |
** |                 |                    |the string it points to is 8      |
** |                 |                    |characters.                       |
** |-----------------|--------------------|----------------------------------|
** |action           |char                |Specifies the action to be taken. |
** |                 |                    |Maximum length of the string it   |
** |                 |                    |points to is 1 character.         |
** |-----------------|--------------------|----------------------------------|
** |filename         |char                |The file name used to identify    |
** |                 |                    |the backup image. If it is NULL,  |
** |                 |                    |the server_id, db2instance,       |
** |                 |                    |dbname, and timestamp will        |
** |                 |                    |uniquely identify the backup      |
** |                 |                    |image. Maximum length of the      |
** |                 |                    |string it points to is 255        |
** |                 |                    |characters.                       |
** |-----------------|--------------------|----------------------------------|
** |server_id        |char                |A unique name identifying the     |
** |                 |                    |server where the database         |
** |                 |                    |resides. Maximum length of the    |
** |                 |                    |string it points to is 8          |
** |                 |                    |characters.                       |
** |-----------------|--------------------|----------------------------------|
** |db2instance      |char                |The db2instance ID. This is the   |
** |                 |                    |user ID invoking the command.     |
** |                 |                    |Maximum length of the string it   |
** |                 |                    |points to is 8 characters.        |
** |-----------------|--------------------|----------------------------------|
** |type             |char                |Specifies the type of backup      |
** |                 |                    |being taken or the type of        |
** |                 |                    |restore being performed. The      |
** |                 |                    |following are possible values:    |
** |                 |                    |                                  |
** |                 |                    |When action is SQLUV_WRITE:       |
** |                 |                    |                                  |
** |                 |                    |0 - full database backup          |
** |                 |                    |3 - table space level backup      |
** |                 |                    |                                  |
** |                 |                    |When action is SQLUV_READ:        |
** |                 |                    |                                  |
** |                 |                    |0 - full restore                  |
** |                 |                    |3 - online table space restore    |
** |                 |                    |4 - table space restore           |
** |                 |                    |5 - history file restore          |
** |-----------------|--------------------|----------------------------------|
** |dbname           |char                |The name of the database to be    |
** |                 |                    |backed up or restored. Maximum    |
** |                 |                    |length of the string it points    |
** |                 |                    |to is 8 characters.               |
** |-----------------|--------------------|----------------------------------|
** |alias            |char                |The alias of the database to be   |
** |                 |                    |backed up or restored. Maximum    |
** |                 |                    |length of the string it points to |
** |                 |                    |is 8 characters.                  |
** |-----------------|--------------------|----------------------------------|
** |timestamp        |char                |The time stamp used to identify   |
** |                 |                    |the backup image. Maximum length  |
** |                 |                    |of the string it points to is 26  |
** |                 |                    |characters.                       |
** |-----------------|--------------------|----------------------------------|
** |sequence         |char                |Specifies the file extension for  |
** |                 |                    |the backup image. For write       |
** |                 |                    |operations, the value for the     |
** |                 |                    |first session is 1 and each time  |
** |                 |                    |another session is initiated with |
** |                 |                    |an sqluvint call, the value is    |
** |                 |                    |incremented by 1. For read        |
** |                 |                    |operations, the value is always   |
** |                 |                    |zero. Maximum length of the       |
** |                 |                    |string it points to is 3          |
** |                 |                    |characters.                       |
** |-----------------|--------------------|----------------------------------|
** |obj_list         |struct sqlu_gen_list|Reserved for future use.          |
** |-----------------|--------------------|----------------------------------|
** |max_bytes_per_txn|sqlint32            |Specifies to the vendor in bytes, |
** |                 |                    |the transfer buffer size          |
** |                 |                    |specified by the user.            |
** |-----------------|--------------------|----------------------------------|
** |image_filename   |char                |Reserved for future use.          |
** |-----------------|--------------------|----------------------------------|
** |reserve          |void                |Reserved for future use.          |
** |-----------------|--------------------|----------------------------------|
** |nodename         |char                |Name of the node at which the     |
** |                 |                    |backup was generated.             |
** |-----------------|--------------------|----------------------------------|
** |password         |char                |Password for the node at which    |
** |                 |                    |the backup was generated.         |
** |-----------------|--------------------|----------------------------------|
** |owner            |char                |ID of the backup originator.      |
** |-----------------|--------------------|----------------------------------|
** |mcNameP          |char                |Management class.                 |
** |-----------------|--------------------|----------------------------------|
** |nodeNum          |SQL_PDB_NODE_TYPE   |Node number. Numbers greater than |
** |                 |                    |255 are supported by the vendor   |
** |                 |                    |interface.                        |
** |-----------------|--------------------|----------------------------------|
**
** The filename, or server_id, db2instance, type, dbname and timestamp 
** uniquely identifies the backup image. The sequence number, specified by
** sequence, identifies the file extension. When a backup image is to be
** restored, the same values must be specified to retrieve the backup image.
** Depending on the vendor product, if filename is used, the other parameters
** may be set to NULL, and vice versa. 
*******************************************************************************/
typedef struct DB2_info
{
  char     *DB2_id;            /* DB2_id                            */
  char     *version;           /* Current DB2 version               */
  char     *release;           /* Current DB2 release               */
  char     *level;             /* Current DB2 level                 */
  char     *action;            /* Caller action                     */
  char     *filename;          /* file to read or write.            */
  char     *server_id;         /* Unique name identifying db server */
  char     *db2instance;       /* db2insance id                     */
  char     *type;              /* When action is SQLUV_WRITE,       */
                               /*  0 - full database backup         */
                               /*  3 - datapool level backup        */
                               /*  4 - load copy image              */
                               /* When action is SQLUV_READ,        */
                               /*  0 - full restore                 */
                               /*  4 - tablespace restore           */
                               /*    - load copy restore            */
                               /*  5 - history file restore         */
  char     *dbname;            /* Database alias to be backed up or */
                               /*   recovered                       */
  char     *alias;             /* Database alias to be backed up or recovered */
  char     *timestamp;         /* Timestamp to identify the backup image */
  char     *sequence;          /* Sequence number within a backup        */

  struct sqlu_gen_list         /* List of objects in the backup     */
                  *obj_list;
  sqlint32  max_bytes_per_txn; /* Transfer buffer size want to use  */
  char     *image_filename;    /* Not used.                         */
  void     *reserve;           /* Reserved for future use           */
  char     *nodename;          /* name of node at which the backup  */
                               /* was generated                     */
  char     *password;          /* password for the node at which the */
                               /* backup was generated              */
  char     *owner;             /* backup originator ID              */
  char     *mcNameP;           /* Management Class                  */
  SQL_PDB_NODE_TYPE nodeNum;   /* Node number.                      */
} DB2_info ;


/******************************************************************************
** Vendor_info data structure
** Contains information, returned to DB2 as part of the Init_output structure, 
** identifying the vendor and the version of the vendor device.
**
** Table: Fields in the Vendor_info Structure. All char data type fields are
** NULL-terminated strings.
** ----------------------------------------------------------------------------
** |Field Name           |Data Type|Description                                |
** |---------------------|---------|-------------------------------------------|
** |vendor_id            |char     |An identifier for the vendor. Maximum      |
** |                     |         |length of the string it points to is 64    |
** |                     |         |characters.                                |
** |---------------------|---------|-------------------------------------------|
** |version              |char     |The current version of the vendor product. |
** |                     |         |Maximum length of the string it points to  |
** |                     |         |is 8 characters.                           |
** |---------------------|---------|-------------------------------------------|
** |release              |char     |The current release of the vendor product. |
** |                     |         |Set to NULL if it is insignificant.        |
** |                     |         |Maximum length of the string it points to  |
** |                     |         |is 8 characters.                           |
** |---------------------|---------|-------------------------------------------|
** |level                |char     |The current level of the vendor product.   |
** |                     |         |Set to NULL if it is insignificant. Maximum|
** |                     |         |length of the string it points to is 8     |
** |                     |         |characters.                                |
** |---------------------|---------|-------------------------------------------|
** |server_id            |char     |A unique name identifying the server where |
** |                     |         |the database resides. Maximum length of the|
** |                     |         |string it points to is 8 characters.       |
** |---------------------|---------|-------------------------------------------|
** |max_bytes_per_txn    |sqlint32 |The maximum supported transfer buffer size.|
** |                     |         |Specified by the vendor, in bytes. This is |
** |                     |         |used only if the return code from the      |
** |                     |         |vendor initialize API is                   |
** |                     |         |SQLUV_BUFF_SIZE, indicating that an        |
** |                     |         |invalid buffer size wasspecified.          |
** |---------------------|---------|-------------------------------------------|
** |num_objects_in_backup|sqlint32 |The number of sessions that were used to   |
** |                     |         |make a complete backup. This is used to    |
** |                     |         |determine when all backup images have been |
** |                     |         |processed during a restore operation.      |
** |---------------------|---------|-------------------------------------------|
** |reserve              |void     |Reserved for future use.                   |
** |                     |         |                                           |
** |---------------------|---------|-------------------------------------------|
*******************************************************************************/
typedef struct Vendor_info
{
  char     *vendor_id;         /* An identifier for the vendor      */
  char     *version;           /* Current version                   */
  char     *release;           /* Current release                   */
  char     *level;             /* Current level                     */
  char     *server_id;         /* Unique name identifying db server */
  sqlint32  max_bytes_per_txn; /* Vendor supports max bytes / transfer*/
  sqlint32  num_objects_in_backup;   /* no. of objects found in backup*/
  void     *reserve;           /* Reserve for future use.           */
} Vendor_info;


/******************************************************************************
** Init_input data structure
** Contains information provided by DB2 to set up and to establish a logical
** link with a vendor device. This data structure is used by DB2 to send
** information to the backup and restore vendor storage plug-in through the
** sqluvint and sqluvdel APIs.
**
** Table: Fields in the Init_input Structure. 
** --------------------------------------------------------------------------
** |Field Name    |Data Type      |Description                              | 
** |--------------|---------------|-----------------------------------------|
** |DB2_session   |struct DB2_info|A description of the session from the    |
** |              |               |perspective of DB2.                      |
** |--------------|---------------|-----------------------------------------|
** |size_options  |unsigned short |The length of the options field. When    |
** |              |               |using the DB2 backup or restore function,|
** |              |               |the data in this field is passed directly|
** |              |               |from the VendorOptionsSize parameter.    |
** |--------------|---------------|-----------------------------------------|
** |size_HI_order |sqluint32      |High order 32 bits of DB size estimate   |
** |              |               |in bytes; total size is 64 bits.         |
** |--------------|---------------|-----------------------------------------|
** |size_LOW_order|sqluint32      |Low order 32 bits of DB size estimate in |
** |              |               |bytes; total size is 64 bits.            |
** |--------------|---------------|-----------------------------------------|
** |options       |void           |This information is passed from the      |
** |              |               |application when the backup or the       |
** |              |               |restore function is invoked. This data   |
** |              |               |structure must be flat; in other words,  |
** |              |               |no level of indirection is supported.    |
** |              |               |Byte-reversal is not done, and the code  |
** |              |               |page for this data is not checked. When  |
** |              |               |using the DB2 backup or restore          |
** |              |               |function, the data in this field is      |
** |              |               |passed directly from the pVendorOptions  |
** |              |               |parameter.                               |
** |--------------|---------------|-----------------------------------------|
** |reserve       |void           |Reserved for future use.                 |
** |--------------|---------------|-----------------------------------------|
** |prompt_lvl    |char           |Prompting level requested by the user    |
** |              |               |when a backup or a restore operation was |
** |              |               |invoked. Maximum length of the string it |
** |              |               |points to is 1 character. This field is a|
** |              |               |NULL-terminated string.                  |
** |--------------|---------------|-----------------------------------------|
** |num_sessions  |unsigned short |Number of sessions requested by the user |
** |              |               |when a backup or a restore operation was |
** |              |               |invoked.                                 |
** |--------------|---------------|-----------------------------------------|
*******************************************************************************/
typedef struct Init_input
{
   struct DB2_info  *DB2_session;   /* DB2 Identifier for session.  */
   unsigned short   size_options;   /* size of options field.       */
   sqluint32        size_HI_order;  /* High order 32 bits of DB size*/
   sqluint32        size_LOW_order; /* Low order 32 bits of DB size */
   void             *options;       /* options passed in by user.   */
   void             *reserve;       /* reserve for future use.      */
   char             *prompt_lvl;    /* Prompt level                 */
   unsigned short   num_sessions;   /* Number of sessions           */
} Init_input;

/******************************************************************************
** Init_output data structure
** Contains a control block for the session and information returned by the
** backup and restore vendor storage plug-in to DB2. This data structure is 
** used by the sqluvint and sqluvdel APIs.
**
** Table: Fields in the Init_output Structure 
** -------------------------------------------------------------------------
** |Field Name    |Data Type         |Description                          |
** |--------------|------------------|-------------------------------------|
** |vendor_session|struct Vendor_info|Contains information to identify the |
** |              |                  |vendor to DB2.                       |
** |--------------|------------------|-------------------------------------|
** |pVendorCB     |void              |Vendor control block.                |
** |--------------|------------------|-------------------------------------|
** |reserve       |void              |Reserved for future use.             |
** |--------------|------------------|-------------------------------------|
*******************************************************************************/
typedef struct Init_output
{
   struct Vendor_info * vendor_session; /* Vendor id for the session */
   void               * pVendorCB;      /* vendor control block      */
   void               * reserve;        /* reserve for future use.   */
} Init_output ;

/******************************************************************************
** Data data structure
** Contains data transferred between DB2 and a vendor device. This structure 
** is used by the sqluvput API when data is being written to the vendor device
** and by the sqluvget API when data is being read from the vendor device.
**
** Table: Fields in the Data Structure
** ------------------------------------------------------------------------
** |Field Name     |Data Type|Description                                 |
** |---------------|---------|--------------------------------------------|
** |obj_num        |sqlint32 |The sequence number assigned by DB2 during  |
** |               |         |a backup operation.                         |
** |---------------|---------|--------------------------------------------|
** |buff_size      |sqlint32 |The size of the buffer.                     |
** |---------------|---------|--------------------------------------------|
** |actual_buf_size|sqlint32 |The actual number of bytes sent or received.|
** |               |         |This must not exceed buff_size.             |
** |---------------|---------|--------------------------------------------|
** |dataptr        |void     |Pointer to the data buffer. DB2 allocates   |
** |               |         |space for the buffer.                       |
** |---------------|---------|--------------------------------------------|
** |reserve        |void     |Reserved for future use.                    |
** |               |         |                                            |
** |---------------|---------|--------------------------------------------|
*******************************************************************************/
typedef struct Data
{
   sqlint32  obj_num;                 /* indicate which obj to be read */
                                      /* It is useful for restore.     */
   sqlint32  buff_size;               /* buffer size to be used        */
   sqlint32  actual_buff_size;        /* actual bytes read or written  */
   void      *dataptr;                /* Pointer to the data buffer    */
   void      *reserve;                /* reserve for future use        */
} Data;



/*** Vendor Storage API Prototypes***/

/******************************************************************************
** sqluvint API
** Provides information for initializing a vendor device and for establishing
** a logical link between DB2 and the vendor device.
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
** sqluvend.h
** 
** sqluvint API parameters
**
** in
** Input. Structure that contains information provided by DB2 to establish a 
** logical link with the vendor device. 
**
** out
** Output. Structure that contains the output returned by the vendor device. 
**
** return_code
** Output. Structure that contains the return code to be passed to DB2, and a
** brief text explanation. 
**
** Usage notes
**
** For each media I/O session, DB2 will call this API to obtain a device
** handle. If for any reason, the vendor storage API encounters an error during
** initialization, it will indicate it via a return code. If the return code
** indicates an error, DB2 may choose to terminate the operation by calling
** the sqluvend API. Details on possible return codes, and the DB2
** reaction to each of these, is contained in the return codes table (see 
** table below).
**
** The Init_input structure contains elements that can be used by the vendor
** product to determine if the backup or restore can proceed:
**
** - size_HI_order and size_LOW_order
** This is the estimated size of the backup. They can be used to determine
** if the vendor devices can handle the size of the backup image. They can be
** used to estimate the quantity of removable media that will be required to
** hold the backup. It might be beneficial to fail at the first sqluvint call
** if problems are anticipated.
**
** - req_sessions
** The number of user requested sessions can be used in conjunction with the
** estimated size and the prompting level to determine if the backup or
** restore operation is possible.
**
** - prompt_lvl
** The prompting level indicates to the vendor if it is possible to prompt
** for actions such as changing removable media (for example, put another
** tape in the tape drive). This might suggest that the operation cannot
** proceed since there will be no way to prompt the user.
** If the prompting level is WITHOUT PROMPTING and the quantity of 
** removable media is greater than the number of sessions requested, DB2 
** will not be able to complete the operation successfully.
**
** DB2 names the backup being written or the restore to be read via fields
** in the DB2_info structure. In the case of an action = SQLUV_READ, the
** vendor product must check for the existence of the named object. If it
** cannot be found, the return code should be set to SQLUV_OBJ_NOT_FOUND
** so that DB2 will take the appropriate action.
**
** After initialization is completed successfully, DB2 will continue by
** calling other data transfer APIs, but may terminate the session at
** any time with an sqluvend call.
**
** Return codes
** Table: Valid Return Codes for sqluvint and Resulting DB2 Action
**  ----------------------------------------------------------------------------
** |Literal in |Description            |Probable Next|Other Comments           |
** |Header File|                       |Call         |                         |
** |-----------|-----------------------|-------------|-------------------------|
** |SQLUV_OK   |Operation successful.  |sqluvput,    |If action = SQLUV_WRITE, |
** |           |                       |sqluvget (see|the next call will be to |
** |           |                       |comments)    |the sqluvput API (to     |
** |           |                       |             |BACKUP data).            |
** |           |                       |             |If action = SQLUV_READ,  |
** |           |                       |             |verify the existence of  |
** |           |                       |             |the named object prior to|
** |           |                       |             |returning SQLUV_OK; the  |
** |           |                       |             |next call will be to the |
** |           |                       |             |sqluvget API to restore  |
** |           |                       |             |data.                    |
** |-----------|-----------------------|-------------|-------------------------|
** |SQLUV_LINK_|Session activated      |No further   |Session initialization   |
** |EXIST      |previously.            |calls.       |fails. Free up memory    |
** |           |                       |             |allocated for this       |
** |           |                       |             |session and terminate. A |
** |           |                       |             |sqluvend API call will   |
** |           |                       |             |not be received, since   |
** |           |                       |             |the session was never    |
** |           |                       |             |established.             |
** |-----------|-----------------------|-------------|-------------------------|
** |SQLUV_COMM_|Communication error    |No further   |Session initialization   |
** |ERROR      |with device.           |calls.       |fails. Free up memory    |
** |           |                       |             |allocated for this       |
** |           |                       |             |session and terminate. A |
** |           |                       |             |sqluvend API call will   |
** |           |                       |             |not be received, since   |
** |           |                       |             |the session was never    |
** |           |                       |             |established.             |
** |-----------|-----------------------|-------------|-------------------------|
** |SQLUV_INV_ |The DB2 and vendor     |No further   |Session initialization   |
** |VERSION    |products are           |calls.       |fails. Free up memory    |
** |           |incompatible           |             |allocated for this       |
** |           |                       |             |session and terminate. A |
** |           |                       |             |sqluvend API call will   |
** |           |                       |             |not be received, since   |
** |           |                       |             |the session was never    |
** |           |                       |             |established.             |
** |-----------|-----------------------|-------------|-------------------------|
** |SQLUV_INV_ |Invalid action is      |No further   |Session initialization   |
** |ACTION     |requested. This could  |calls.       |fails. Free up memory    |
** |           |also be used to        |             |allocated for this       |
** |           |indicate that the      |             |session and terminate. A |
** |           |combination of         |             |sqluvend API call will   |
** |           |parameters results in  |             |not be received, since   |
** |           |an operation which is  |             |the session was never    |
** |           |not possible.          |             |established.             |
** |-----------|-----------------------|-------------|-------------------------|
** |SQLUV_NO_  |No device is available |No further   |Session initialization   |
** |DEV_AVAIL  |for use at the moment. |calls.       |fails. Free up memory    |
** |           |                       |             |allocated for this       |
** |           |                       |             |session and terminate. A |
** |           |                       |             |sqluvend API call will   |
** |           |                       |             |not be received, since   |
** |           |                       |             |the session was never    |
** |           |                       |             |established.             |
** |-----------|-----------------------|-------------|-------------------------|
** |SQLUV_OBJ_ |Object specified cannot|No further   |Session initialization   |
** |NOT_FOUND  |be found. This should  |calls.       |fails. Free up memory    |
** |           |be used when the action|             |allocated for this       |
** |           |on the sqluvint call is|             |session and terminate. A |
** |           |"R" (read) and the     |             |sqluvend API call will   |
** |           |requested object cannot|             |not be received, since   |
** |           |be found based on the  |             |the session was never    |
** |           |criteria specified in  |             |established.             |
** |           |the DB2_info structure.|             |                         |
** |-----------|-----------------------|-------------|-------------------------|
** |SQLUV_OBJS_|More than 1 object     |No further   |Session initialization   |
** |FOUND      |matches the specified  |calls.       |fails. Free up memory    |
** |           |criteria. This will    |             |allocated for this       |
** |           |result when the action |             |session and terminate. A |
** |           |on the sqluvint call is|             |sqluvend API call will   |
** |           |"R" (read) and more    |             |not be received, since   |
** |           |than one object matches|             |the session was never    |
** |           |the criteria in the    |             |established.             |
** |           |DB2_info structure.    |             |                         |
** |-----------|-----------------------|-------------|-------------------------|
** |SQLUV_INV_ |Invalid userid         |No further   |Session initialization   |
** |USERID     |specified.             |calls.       |fails. Free up memory    |
** |           |                       |             |allocated for this       |
** |           |                       |             |session and terminate. A |
** |           |                       |             |sqluvend API call will   |
** |           |                       |             |not be received, since   |
** |           |                       |             |the session was never    |
** |           |                       |             |established.             |
** |-----------|-----------------------|-------------|-------------------------|
** |SQLUV_INV_ |Invalid password       |No further   |Session initialization   |
** |PASSWORD   |provided.              |calls.       |fails. Free up memory    |
** |           |                       |             |allocated for this       |
** |           |                       |             |session and terminate. A |
** |           |                       |             |sqluvend API call will   |
** |           |                       |             |not be received, since   |
** |           |                       |             |the session was never    |
** |           |                       |             |established.             |
** |-----------|-----------------------|-------------|-------------------------|
** |SQLUV_INV_ |Invalid options        |No further   |Session initialization   |
** |OPTIONS    |encountered in the     |calls.       |fails. Free up memory    |
** |           |vendor options field.  |             |allocated for this       |
** |           |                       |             |session and terminate. A |
** |           |                       |             |sqluvend API call will   |
** |           |                       |             |not be received, since   |
** |           |                       |             |the session was never    |
** |           |                       |             |established.             |
** |-----------|-----------------------|-------------|-------------------------|
** |SQLUV_INIT_|Initialization failed  |No further   |Session initialization   |
** |FAILED     |and the session is to  |calls.       |fails. Free up memory    |
** |           |be terminated.         |             |allocated for this       |
** |           |                       |             |session and terminate. A |
** |           |                       |             |sqluvend API call will   |
** |           |                       |             |not be received, since   |
** |           |                       |             |the session was never    |
** |           |                       |             |established.             |
** |-----------|-----------------------|-------------|-------------------------|
** |SQLUV_DEV_ |Device error.          |No further   |Session initialization   |
** |ERROR      |                       |calls.       |fails. Free up memory    |
** |           |                       |             |allocated for this       |
** |           |                       |             |session and terminate. A |
** |           |                       |             |sqluvend API call will   |
** |           |                       |             |not be received, since   |
** |           |                       |             |the session was never    |
** |           |                       |             |established.             |
** |-----------|-----------------------|-------------|-------------------------|
** |SQLUV_MAX_ |Max number of links    |sqluvput,    |This is treated as a     |
** |LINK_GRANT |established.           |sqluvget (see|warning by DB2. The      |
** |           |                       |comments).   |warning tells DB2 not to |
** |           |                       |             |open additional sessions |
** |           |                       |             |with the vendor product, |
** |           |                       |             |because the maximum      |
** |           |                       |             |number of sessions it can|
** |           |                       |             |support has been reached |
** |           |                       |             |(note: this could be due |
** |           |                       |             |to device availability). |
** |           |                       |             |If action = SQLUV_WRITE  |
** |           |                       |             |(BACKUP), the next call  |
** |           |                       |             |will be to sqluvput API. |
** |           |                       |             |If action = SQLUV_READ,  |
** |           |                       |             |verify the existence of  |
** |           |                       |             |the named object prior to|
** |           |                       |             |returning SQLUV_MAX_LINK_|
** |           |                       |             |GRANT; the next call will|
** |           |                       |             |be to the sqluvget API to|
** |           |                       |             |restore data.            |
** |-----------|-----------------------|-------------|-------------------------|
** |SQLUV_IO_  |I/O error.             |No further   |Session initialization   |
** |ERROR      |                       |calls.       |fails. Free up memory    |
** |           |                       |             |allocated for this       |
** |           |                       |             |session and terminate. A |
** |           |                       |             |sqluvend API call will   |
** |           |                       |             |not be received, since   |
** |           |                       |             |the session was never    |
** |           |                       |             |established.             |
** |-----------|-----------------------|-------------|-------------------------|
** |SQLUV_NOT_ |There is not enough    |No further   |Session initialization   |
** |ENOUGH_    |space to store the     |calls.       |fails. Free up memory    |
** |SPACE      |entire backup image;   |             |allocated for this       |
** |           |the size estimate is   |             |session and terminate. A |
** |           |provided as a 64-bit   |             |sqluvend API call will   |
** |           |value in bytes.        |             |not be received, since   |
** |           |                       |             |the session was never    |
** |           |                       |             |established.             |
** |-----------|-----------------------|-------------|-------------------------|
******************************************************************************/
int sqluvint ( struct Init_input   *in,
               struct Init_output  *out,
               struct Return_code  *return_code);


/******************************************************************************
** sqluvget API
** After a vendor device has been initialized with the sqluvint API, DB2 calls
** this API to read from the device during a restore operation.
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
** sqluvend.h
**
** sqluvget API parameters
**
** hdle
** Input. Pointer to space allocated for the Data structure (including the data
** buffer) and Return_code. 
** 
** data
** Input or output. A pointer to the Data structure. 
**
** return_code
** Output. The return code from the API call.
**
** Usage notes
**
** This API is used by the restore utility.
** 
** Return codes
** Table: Valid Return Codes for sqluvget and Resulting DB2 Action
** ---------------------------------------------------------------------------
** |Literal in Header   |Description        |Probable Next Call|Other Comments|
** |File                |                   |                  |              |
** |--------------------|-------------------|------------------|--------------|
** |SQLUV_OK            |Operation          |sqluvget          |DB2 processes |
** |                    |successful.        |                  |the data      |
** |--------------------|-------------------|------------------|--------------|
** |SQLUV_COMM_ERROR    |Communication error|sqluvend, action =|The session   |
** |                    |with device.       |SQLU_ABORT (see   |will be       |
** |                    |                   |note below        |terminated.   |
** |--------------------|-------------------|------------------|--------------|
** |SQLUV_INV_ACTION    |Invalid action is  |sqluvend, action =|The session   |
** |                    |requested.         |SQLU_ABORT (see   |will be       |
** |                    |                   |note below        |terminated.   |
** |--------------------|-------------------|------------------|--------------|
** |SQLUV_INV_DEV_HANDLE|Invalid device     |sqluvend, action =|The session   |
** |                    |handle.            |SQLU_ABORT (see   |will be       |
** |                    |                   |note below        |terminated.   |
** |--------------------|-------------------|------------------|--------------|
** |SQLUV_INV_BUFF_SIZE |Invalid buffer size|sqluvend, action =|The session   |
** |                    |specified.         |SQLU_ABORT (see   |will be       |
** |                    |                   |note below        |terminated.   |
** |--------------------|-------------------|------------------|--------------|
** |SQLUV_DEV_ERROR     |Device error.      |sqluvend, action =|The session   |
** |                    |                   |SQLU_ABORT (see   |will be       |
** |                    |                   |note below        |terminated.   |
** |--------------------|-------------------|------------------|--------------|
** |SQLUV_WARNING       |Warning. This      |sqluvget, or      |              |
** |                    |should not be used |sqluvend, action= |              |
** |                    |to indicate end-of-|SQLU_ABORT        |              |
** |                    |media to DB2; use  |                  |              |
** |                    |SQLUV_ENDOFMEDIA or|                  |              |
** |                    |SQLUV_ENDOFMEDIA_NO|                  |              |
** |                    |_DATA for this     |                  |              |
** |                    |purpose.However,   |                  |              |
** |                    |device not ready   |                  |              |
** |                    |conditions can be  |                  |              |
** |                    |indicated using    |                  |              |
** |                    |this return code.  |                  |              |
** |--------------------|-------------------|------------------|--------------|
** |SQLUV_LINK_NOT_EXIST|No link currently  |sqluvend, action =|The session   |
** |                    |exists             |SQLU_ABORT (see   |will be       |
** |                    |                   |note below        |terminated.   |
** |--------------------|-------------------|------------------|--------------|
** |SQLUV_MORE_DATA     |Operation          |sqluvget          |              |
** |                    |successful; more   |                  |              |
** |                    |data available.    |                  |              |
** |--------------------|-------------------|------------------|--------------|
** |SQLUV_ENDOFMEDIA_NO_|End of media and 0 |sqluvend          |              |
** |DATA                |bytes read (for    |                  |              |
** |                    |example, end of    |                  |              |
** |                    |tape).             |                  |              |
** |--------------------|-------------------|------------------|--------------|
** |SQLUV_ENDOFMEDIA    |End of media and >0|sqluvend          |DB2 processes |
** |                    |bytes read (for    |                  |the data, and |
** |                    |example, end of    |                  |then handles  |
** |                    |tape).             |                  |the end-of-   |
** |                    |                   |                  |media         |
** |                    |                   |                  |condition.    |
** |--------------------|-------------------|------------------|--------------|
** |SQLUV_IO_ERROR      |I/O error.         |sqluvend, action =|The session   |
** |                    |                   |SQLU_ABORT (see   |will be       |
** |                    |                   |note below        |terminated.   |
** |--------------------|-------------------|------------------|--------------|
** |Note:         						              |
** |Next call: If the next call is an sqluvend, action = SQLU_ABORT, this     |
** |session and all other active sessions will be terminated.                 |
** |--------------------------------------------------------------------------|
******************************************************************************/
int sqluvget ( void *               hdle,
               struct Data         *data,
               struct Return_code  *return_code);


/******************************************************************************
** sqluvput API
** After a vendor device has been initialized with the sqluvint API, DB2 calls
** this API to write to the device during a backup operation.
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
** sqluvend.h
**
** sqluvput API parameters
**
** hdle
** Input. Pointer to space allocated for the DATA structure (including the data
** buffer) and Return_code. 
**
** data
** Output. Data buffer filled with data to be written out. 
**
** return_code
** Output. The return code from the API call.
**
** Usage notes
**
** This API is used by the backup utility.
** 
** Return codes
** Table: Valid Return Codes for sqluvput and Resulting DB2 Action
**  ----------------------------------------------------------------------------
** |Literal in Header   |Description        |Probable Next Call|Other Comments|
** |File                |                   |                  |              |
** |--------------------|-------------------|------------------|--------------|
** |SQLUV_OK            |Operation          |sqluvput or       |Inform other  |
** |                    |successful.        |sqluvend, if      |processes of  |
** |                    |                   |complete (for     |successful    |
** |                    |                   |example, DB2 has  |operation.    |
** |                    |                   |no more data)     |              |
** |--------------------|-------------------|------------------|--------------|
** |SQLUV_COMM_ERROR    |Communication error|sqluvend, action =|The session   |
** |                    |with device.       |SQLU_ABORT (see   |will be       |
** |                    |                   |note below).      |terminated.   |
** |--------------------|-------------------|------------------|--------------|
** |SQLUV_INV_ACTION    |Invalid action is  |sqluvend, action =|The session   |
** |                    |requested.         |SQLU_ABORT (see   |will be       |
** |                    |                   |note below).      |terminated.   |
** |--------------------|-------------------|------------------|--------------|
** |SQLUV_INV_DEV_HANDLE|Invalid device     |sqluvend, action =|The session   |
** |                    |handle.            |SQLU_ABORT (see   |will be       |
** |                    |                   |note below).      |terminated.   |
** |--------------------|-------------------|------------------|--------------|
** |SQLUV_INV_BUFF_SIZE |Invalid buffer size|sqluvend, action =|The session   |
** |                    |specified.         |SQLU_ABORT (see   |will be       |
** |                    |                   |note below).      |terminated.   |
** |--------------------|-------------------|------------------|--------------|
** |SQLUV_ENDOFMEDIA    |End of media       |sqluvend          |              |
** |                    |reached, for       |                  |              |
** |                    |example, end of    |                  |              |
** |                    |tape.              |                  |              |
** |--------------------|-------------------|------------------|--------------|
** |SQLUV_DATA_RESEND   |Device requested to|sqluvput          |DB2 will      |
** |                    |have buffer sent   |                  |retransmit the|
** |                    |again.             |                  |last buffer.  |
** |                    |                   |                  |This will only|
** |                    |                   |                  |be done once. |
** |--------------------|-------------------|------------------|--------------|
** |SQLUV_DEV_ERROR     |Device error.      |sqluvend, action =|The session   |
** |                    |                   |SQLU_ABORT (see   |will be       |
** |                    |                   |note below).      |terminated.   |
** |--------------------|-------------------|------------------|--------------|
** |SQLUV_WARNING       |Warning. This      |sqluvput          |              |
** |                    |should not be used |                  |              |
** |                    |to indicate end-of-|                  |              |
** |                    |media to DB2; use  |                  |              |
** |                    |SQLUV_ENDOFMEDIA   |                  |              |
** |                    |for this purpose.  |                  |              |
** |                    |However, device not|                  |              |
** |                    |ready conditions   |                  |              |
** |                    |can be indicated   |                  |              |
** |                    |using this return  |                  |              |
** |                    |code.              |                  |              |
** |--------------------|-------------------|------------------|--------------|
** |SQLUV_LINK_NOT_EXIST|No link currently  |sqluvend, action =|The session   |
** |                    |exists.            |SQLU_ABORT (see   |will be       |
** |                    |                   |note below).      |terminated.   |
** |--------------------|-------------------|------------------|--------------|
** |SQLUV_IO_ERROR      |I/O error.         |sqluvend, action =|The session   |
** |                    |                   |SQLU_ABORT (see   |will be       |
** |                    |                   |note below).      |terminated.   |
** |--------------------|-------------------|------------------|--------------|
** |Note:                                                                     |	
** |Next call: If the next call is an sqluvend, action = SQLU_ABORT, this     |
** |session and all other active sessions will be terminated. Committed       |
** |sessions are deleted with an sqluvint, sqluvdel, and sqluvend sequence of |
** |calls.                                                                    |
** |--------------------------------------------------------------------------|
******************************************************************************/

int sqluvput ( void *               hdle,
               struct Data         *data,
               struct Return_code  *return_code);


/******************************************************************************
** sqluvend API
** Unlinks a vendor device and frees all of its related resources. All unused
** resources (for example, allocated space and file handles) must be released
** before the sqluvend API call returns to DB2.
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
** sqluvend.h
**
** sqluvend API parameters
**
** action
** Input. Used to commit or abort the session:
** - SQLUV_COMMIT ( 0 = to commit )
** - SQLUV_ABORT ( 1 = to abort )
** 
** hdle
** Input. Pointer to the Init_output structure. 
**
** in_out
** Output. Space for Init_output de-allocated. The data has been committed to 
** stable storage for a backup if action is to commit. The data is purged for a
** backup if the action is to abort. 
**
** return_code
** Output. The return code from the API call. 
**
** Usage notes
**
** This API is called for each session that has been opened. There are two
** possible action codes:
** 
** - Commit
** Output of data to this session, or the reading of data from the session, is
** complete.
**
** For a write (backup) session, if the vendor returns to DB2 with a return code
** of SQLUV_OK, DB2 assumes that the output data has been appropriately saved by
** the vendor product, and can be accessed if referenced in a later sqluvint 
** call.
**
** For a read (restore) session, if the vendor returns to DB2 with a return code
** of SQLUV_OK, the data should not be deleted, because it may be needed again.
** If the vendor returns SQLUV_COMMIT_FAILED, DB2 assumes that there are
** problems with the entire backup or restore operation. All active sessions are
** terminated by sqluvend calls with action = SQLUV_ABORT. For a backup 
** operation, committed sessions receive a sqluvint, sqluvdel, and sqluvend 
** sequence of calls.
**
** - Abort
** A problem has been encountered by DB2, and there will be no more reading or
** writing of data to the session.
**
** For a write (backup) session, the vendor should delete the partial output
** dataset, and use a SQLUV_OK return code if the partial output is deleted. DB2
** assumes that there are problems with the entire backup. All active sessions
** are terminated by sqluvend calls with action = SQLUV_ABORT, and committed 
** sessions receive a sqluvint, sqluvdel, and sqluvend sequence of calls.
**
** For a read (restore) session, the vendor should not delete the data (because
** it may be needed again), but should clean up and return to DB2 with a
** SQLUV_OK return code. DB2 terminates all the restore sessions by sqluvend
** calls with action = SQLUV_ABORT. If the vendor returns SQLUV_ABORT_FAILED to
** DB2, the caller is not notified of this error, because DB2 returns the first
** fatal failure and ignores subsequent failures. In this case, for DB2 to have
** called sqluvend with action = SQLUV_ABORT, an initial fatal error must have
** occurred.
**
** Return codes
** Table: Valid Return Codes for sqluvend and Resulting DB2 Action
**  --------------------------------------------------------------------------
** |Literal in Header  |Description        |Probable Next Call|Other Comments|
** |File               |                   |                  |              |
** |-------------------|-------------------|------------------|--------------|
** |SQLUV_OK           |Operation          |No further calls  |Free all      |
** |                   |successful         |                  |memory        |
** |                   |                   |                  |allocated for |
** |                   |                   |                  |this session  |
** |                   |                   |                  |and terminate.|
** |-------------------|-------------------|------------------|--------------|
** |SQLUV_COMMIT_FAILED|Commit request     |No further calls  |Free all      |
** |                   |failed.            |                  |memory        |
** |                   |                   |                  |allocated for |
** |                   |                   |                  |this session  |
** |                   |                   |                  |and terminate.|
** |-------------------|-------------------|------------------|--------------|
** |SQLUV_ABORT_FAILED |Abort request      |No further calls  |              |
** |                   |failed.            |                  |              |
** |-------------------|-------------------|------------------|--------------|
******************************************************************************/

int sqluvend ( sqlint32             action,
               void                *hdle,
               struct Init_output  *in_out,
               struct Return_code  *return_code);


/******************************************************************************
** sqluvdel API
** Deletes committed sessions from a vendor device.
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
** sqluvend.h
**
** sqluvdel API parameters
**
** in
** Input. Space allocated for Init_input and Return_code. 
**
** vendorDevData
** Output. Structure containing the output returned by the vendor device.
**
** return_code
** Output. Return code from the API call. The object pointed to by the
** Init_input structure is deleted.
**
** Usage notes
**
** If multiple sessions are opened, and some sessions are committed, but one of
** them fails, this API is called to delete the committed sessions. No
** sequence number is specified; sqluvdel is responsible for finding all of the
** objects that were created during a particular backup operation, and deleting
** them. Information in the Init_input structure is used to identify the output
** data to be deleted. The call to sqluvdel is responsible for establishing any
** connection or session that is required to delete a backup object from the
** vendor device. If the return code from this call is SQLUV_DELETE_FAILED, DB2
** does not notify the caller, because DB2 returns the first fatal failure and
** ignores subsequent failures. In this case, for DB2 to have called the 
** sqluvdel API, an initial fatal error must have occurred.
**
** Return codes
** Table: Valid Return Codes for sqluvdel and Resulting DB2 Action
**  -------------------------------------------------------------------------
** |Literal in Header  |Description        |Probable Next Call|Other Comments|
** |File               |                   |                  |              |
** |-------------------|-------------------|------------------|--------------|
** |SQLUV_OK           |Operation          |No further calls. |              |
** |                   |successful.        |                  |              |
** |-------------------|-------------------|------------------|--------------|
** |SQLUV_DELETE_FAILED|Delete request     |No further calls. |              |
** |                   |failed.            |                  |              |
** |-------------------|-------------------|------------------|--------------|
******************************************************************************/

int sqluvdel ( struct Init_input   *in,
               struct Init_output  *vendorDevData,
               struct Return_code  *return_code);


#if defined(DB2NT)
#pragma pack()
#elif defined(DB2AIX)
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif
