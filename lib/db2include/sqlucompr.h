/******************************************************************************
**
** Source File Name: SQLUCOMPR
**
** (C) COPYRIGHT International Business Machines Corp. 1995, 2002
** All Rights Reserved
** Licensed Materials - Property of IBM
**
** US Government Users Restricted Rights - Use, duplication or
** disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
**
** Function = Include File defining:
**              Compression plug-in - Constants
**              Compression plug-in - Data Structures
**              Compression plug-in - Function Prototypes
**
*******************************************************************************/
#ifndef SQL_H_SQLUCOMPR
#define SQL_H_SQLUCOMPR

#include "db2ApiDf.h"
#include "sqlenv.h"

#ifdef __cplusplus
extern "C" {
#endif

#define SQLUV_OK                        0
#define SQLUV_INIT_FAILED               11
#define SQLUV_UNEXPECTED_ERROR          30
#define SQLUV_BUFFER_TOO_SMALL          100
#define SQLUV_PARTIAL_BUFFER            101
#define SQLUV_NO_MEMORY                 102
#define SQLUV_EXCEPTION                 103
#define SQLUV_INTERNAL_ERROR            104

/******************************************************************************
** COMPR_DB2INFO data structure
** Describes the DB2 environment. DB2 allocates and defines this structure
** and passes it in as a parameter to the InitCompression and 
** InitDecompression APIs. This structure describes the database being backed
** up or restored and gives details about the DB2 environment where the
** operation is occurring. The dbalias, instance, node, catnode, and 
** timestamp parameters are used to name the backup image.
**
** COMPR_DB2INFO data structure parameters
**
** tag
** Used as an eye catcher for the structure. This is always set to the string
** "COMPR_DB2INFO  \0".
**
** version
** Indicates which version of the structure is being used so APIs can 
** indicate the presence of additional fields. Currently, the version is 1.
** In the future there may be more parameters added to this structure.
**
** size
** Specifies the size of the COMPR_DB2INFO structure in bytes.
**
** dbalias
** Database alias. For restore operations, dbalias refers to the alias of
** the source database.
**
** instance
** Instance name.
**
** node
** Node number.
**
** catnode
** Catalog node number.
**
** timestamp
** The timestamp of the image being backed up or restored.
**
** bufferSize
** Specifies the size of a transfer buffer (in 4K pages).
**
** options
** The iOptions parameter specified in the db2Backup API or the
** db2Restore API.
**
** bkOptions
** For restore operations, specifies the iOptions parameter that was used in
** the db2Backup API when the backup was created. For backup operations,
** it is set to zero.
**
** db2Version
** Specifies the version of the DB2 engine.
**
** platform
** Specifies the platform on which the DB2 engine is running. The value will
** be one of the ones listed in sqlmon.h (located in the include directory).
**
** comprOptionsByteOrder
** Specifies the byte-order used on the client where the API is being run.
** DB2 will do no interpretation or conversion of the data passed through as
** comprOptions, so this field should be used to determine whether the data
** needs to be byte reversed before being used. Any conversion must be done
** by the plug-in library itself.
**
** comprOptionsSize
** Specifies the value of the piComprOptionsSize parameter in the db2Backup
** and db2Restore APIs.
**
** comprOptions
** Specifies the value of the piComprOptions parameter in the db2Backup and
** db2Restore APIs.
**
** savedBlockSize
** Size in bytes of savedBlock.
**
** savedBlock
** DB2 allows the plug-in library to save an arbitrary block of data in the
** backup image. If such a block of data was saved with a particular backup,
** it will be returned in these fields on the restore operation. For backup
** operations, these fields are set to zero.
******************************************************************************/
struct COMPR_DB2INFO {
#define COMPR_DB2INFOTAG                 "COMPR_DB2INFO  "
   char                  tag[16];       /* "COMPR_DB2INFO  \0"                */
   db2Uint32             version;       /* version number of the structure    */
   db2Uint32             size;          /* sizeof(COMPR_DB2INFO)              */
   char                  dbalias[SQLU_ALIAS_SZ+1];
   char                  instance[SQL_INSTNAME_SZ+1];
   SQL_PDB_NODE_TYPE     node;
   SQL_PDB_NODE_TYPE     catnode;
   char                  timestamp[SQLU_TIME_STAMP_LEN+1];
   db2Uint32             bufferSize;
   db2Uint32             options;       /* iOptions passed on API             */
   db2Uint32             bkOptions;     /* iOptions used on backup (for       */
                                        /* restore only)                      */
   db2Uint32             db2Version;    /* Currently db2Version810            */
   db2Uint32             platform;      /* from sqlmon.h                      */
   db2int32              comprOptionsByteOrder;  /* from sqlmon.h             */
   db2Uint32             comprOptionsSize;
   void                 *comprOptions;
   db2Uint32             savedBlockSize; /* size of savedBlock                */
   void                 *savedBlock;    /* block of data saved with backup    */
                                        /* (restore only; NULL for backup)    */
};

/******************************************************************************
** COMPR_PIINFO data structure
** This structure is used by the plug-in library to describe itself to DB2.
** This structure is allocated and initialized by DB2, and the key fields are
** filled in by the plug-in library on the InitCompression API call.
**
** COMPR_PIINFO data structure parameters
** 
** tag
** Used as an eye catcher for the structure. (It is set by DB2.) This is
** always set to the string "COMPR_PIINFO   \0".
** 
** version
** Indicates which version of the structure is being used so APIs can
** indicate the presence of additional fields. Currently, the version is 1.
** (It is set by DB2.) In the future there may be more fields added to this
** structure.
** 
** size
** Indicates the size of the COMPR_PIINFO structure (in bytes). (It is set
** by DB2.)
** 
** useCRC
** DB2 allows compression plug-ins to use a 32-bit CRC or checksum value
** to validate the integrity of the data being compressed and decompressed.
** If the library uses such a check, it will set this field to 1. Otherwise,
** it will set the field to 0.
** 
** useGran
** If the compression routine is able to compress data in arbitrarily-sized
** increments, the library will set this field to 1. If the compression
** routine compresses data only in byte-sized increments, the library will
** set this field to 0. See the description of the srcGran parameter of
** Compress API for details of the implications of setting this indicator.
** For restore operations, this parameter is ignored.
** 
** useAllBlocks
** Specifies whether DB2 should back up a compressed block of data that is
** larger than the original uncompressed block. By default, DB2 will store
** data uncompressed if the compressed version is larger, but under some
** circumstances the plug-in library will wish to have the compressed data
** backed up anyway. If DB2 is to save the compressed version of the data
** for all blocks, the library will set this value to 1. If DB2 is to save
** the compressed version of the data only when it is smaller than the 
** original data, the library will set this value to 0. For restore
** operations, this field is ignored.
** 
** savedBlockSize
** DB2 allows the plug-in library to save an arbitrary block of data in the
** backup image. If such a block of data is to be saved with a particular
** backup, the library will set this parameter to the size of the block to be
** allocated for this data. (The actual data will be passed to DB2 on a
** subsequent API call.) If no data is to be saved, the plug-in library will
** set this parameter to zero. For restore operations, this parameter is
** ignored. 
*******************************************************************************/
struct COMPR_PIINFO {
#define COMPR_PIINFOTAG                 "COMPR_PIINFO   "
   char                  tag[16];       /* "COMPR_PIINFO   \0"                */
   db2Uint32             version;       /* version number of the structure    */
   db2Uint32             size;          /* sizeof(COMPR_PIINFO)               */
   db2Uint32             useCRC;        /* library will calculate CRC (0/1)   */
   db2Uint32             useGran;       /* library will respect srcGran (0/1) */
   db2Uint32             useAllBlocks;  /* always store compressed data       */
   db2Uint32             savedBlockSize; /* size of data block stored in bkp  */
};

/******************************************************************************
** COMPR_CB data structure
** This structure is used internally by the plug-in library as the control
** block. It contains data used internally by compression and decompression
** APIs. DB2 passes this structure to each call it makes to the plug-in
** library, but all aspects of the structure are left up to the library, 
** including the definition of the structure's parameters and memory
** management of the structure.
*******************************************************************************/
struct COMPR_CB;

/******************************************************************************
** InitCompression API
** Initializes the compression library. DB2 will pass the db2Info and piInfo
** structures. The library will fill in the appropriate parameters of piInfo,
** and will allocate pCB and return a pointer to the allocated memory.
**
** Authorization
**
** None
**
** Required connection
**
** None
**
** API include file
**
** sqlucompr.h
**
** InitCompression API parameters
**
** db2Info
** Input. Describes the database being backed up and gives details about the
** DB2 environment where the operation is occuring.
**
** piInfo
** Output. This structure is used by the plug-in library to describe itself
** to DB2. It is allocated and initialized by DB2 and the key parameters are
** filled in by the plug-in library.
**
** pCB
** Output. This is the control block used by the compression library. The
** plug-in library is responsible for memory management of the structure.
*******************************************************************************/
int InitCompression(                    /* Initialise for compression         */
      const struct COMPR_DB2INFO
                        *db2Info,       /* (in)  DB2 info                     */
      struct COMPR_PIINFO
                        *piInfo,        /* (out) Info about plugin            */
      struct COMPR_CB  **pCB);          /* (out) Control block                */
      
/******************************************************************************
** GetSavedBlock API
** Gets the vendor-specific block of data to be saved with the backup image.
** If the library returned a non-zero value for piInfo->savedBlockSize, DB2
** will call GetSavedBlock using that value as blockSize. The plug-in library
** writes data of the given size to the memory referenced by data. This
** API will be called during initial data processing by the first db2bm 
** process for backup only. Even if parallelism > 1 is specified in the
** db2Backup API, this API will be called only once per backup.
**
** Authorization
**
** None
**
** Required connection
**
** None
**
** API include file
**
** sqlucompr.h
**
** GetSavedBlock API parameters
**
** pCB
** Input. This is the control block that was returned by the InitCompression
** API call.
**
** blocksize
** Input. This is the size of the block that was returned in
** piInfo->savedBlockSize by the InitCompression API call.
**
** data
** Output. This is the vendor-specific block of data to be saved with the
** backup image.
*******************************************************************************/
int GetSavedBlock(                      /* Get data to save in backup         */
      struct COMPR_CB   *pCB,           /* (in)  Control block                */
      db2Uint32          blockSize,     /* (in)  size of block from Init call */
      void              *data);         /* (out) data                         */
/******************************************************************************
** Compress API
** Compress a block of data. The src parameter points to a block of data that
** is srcLen bytes in size. The tgt parameter points to a buffer that is
** tgtSize bytes in size. The plug-in library compresses the data at address
** src and writes the compressed data to the buffer at address tgt. The
** actual amount of uncompressed data that was compressed is stored in
** srcAct. The actual size of the compressed data is returned as tgtAct.
**
** Authorization
**
** None
**
** Required connection
**
** None
**
** API include file
**
** sqlucompr.h
**
** Compress API parameters
** 
** pCB
** Input. This is the control block that was returned by the InitCompression
** API call.
** 
** src
** Input. Pointer to the block of data to be compressed.
**
** srcLen
** Input. Size in bytes of the block of data to be compressed.
**
** srcGran
** Input. If the library returned a value of 1 for piInfo->useGran, srcGran
** specifies the log2 of the page size of the data. (For example, if the
** page size of the data is 4096 bytes, srcGran is 12.) The library ensures
** that the amount of data actually compressed (srcAct) is an exact multiple
** of this page size. If the library sets the useGran flag, DB2 is able to
** use a more efficient algorithm for fitting the compressed data into the
** backup image. This means that both the performance of the plug-in will be
** better and that the compressed backup image will be smaller. If the
** library returned a value of 0 for piInfo->srcGran, the granularity
** is 1 byte.
**
** tgt
** Input and output. Target buffer for compressed data. DB2 will supply this
** target buffer and the plug-in will compress the data at src and write
** compressed data here.
**
** tgtSize
** Input. Size in bytes of the target buffer.
**
** srcAct
** Output. Actual amount in bytes of uncompressed data from src that was
** compressed.
**
** tgtAct
** Output. Actual amount in bytes of compressed data stored in tgt.
**
** tgtCRC
** Output. If the library returned a value of 1 for piInfo->useCRC, the CRC 
** value of the uncompressed block is returned as tgtCRC. If the library
** returned a value of 0 for piInfo->useCRC, tgtCRC will be a null pointer.
*******************************************************************************/
int Compress(                           /* Compress a block of data           */
      struct COMPR_CB   *pCB,           /* (in)  Control block                */
      const char        *src,           /* (in)  text to compress             */
      db2int32           srcSize,       /* (in)  length of data block         */
      db2Uint32          srcGran,
      char              *tgt,           /* (i/o) buffer to compress into      */
      db2int32           tgtSize,       /* (in)  size of buffer               */
      db2int32          *srcAct,        /* (out) actual size of input         */
      db2int32          *tgtAct,        /* (out) actual size of output        */
      db2Uint32         *tgtCRC);       /* (out) crc of input data (or 0)     */
/******************************************************************************
** GetMaxCompressedSize API
** Estimates the size of the largest possible buffer required to compress a
** block of data. srcLen indicates the size of a block of data about to be
** compressed. The library returns the theoretical maximum size of the buffer
** after compression as tgtLen.
**
** DB2 will use the value returned as tgtLen to optimize its use of memory
** internally. The penalty for not calculating a value or for calculating an
** incorrect value is that DB2 will have to call the Compress API more than
** once for a single block of data, or that it may waste memory from the
** utility heap. DB2 will still create the backup correctly, regardless of
** the values returned.
** 
** Authorization
** 
** None
** 
** Required connection
** 
** None
** 
** API include file
** 
** sqlucompr.h
**
** GetMaxCompressedSize API parameters
**
** pCB
** Input. This is the control block that was returned by the InitCompression
** API call.
** 
** srcLen
** Input. Size in bytes of a block of data about to be compressed.
*******************************************************************************/
int GetMaxCompressedSize(               /* Estimate size of compressed data   */
      struct COMPR_CB   *pCB,           /* (in)  Control block                */
      db2Uint32          srcLen);       /* (in)  length of data block         */
/******************************************************************************
** TermCompression API
** Terminates the compression library. The library will free the memory used
** for pCB.
**
** Authorization
**
** None
**
** Required connection
**
** None
**
** API include file
** 
** sqlucompr.h
**
** TermCompression API parameters
**
** pCB
** Input. This is the control block that was returned by the InitCompression
** API call.
*******************************************************************************/
int TermCompression(                    /* Terminate compression.             */
      struct COMPR_CB   *pCB);          /* (in)  Control block                */
/******************************************************************************
** InitDecompression API
** Initializes the decompression library. DB2 will pass the db2Info structure.
** The library will allocate pCB and return a pointer to the allocated memory.
**
** Authorization
**
** None
**
** Required connection
**
** None
**
** API include file
**
** sqlucompr.h
** 
** InitDecompression API parameters
**
** db2Info
** Input. Describes the database being backed up and gives details about the
** DB2 environment where the operation is occuring.
**
** pCB
** Output. This is the control block used by the decompression library. The
** plug-in library is responsible for memory management of the structure.
*******************************************************************************/
int InitDecompression(                  /* Initialise for decompression       */
      const struct COMPR_DB2INFO
                        *db2Info,       /* (in)  DB2 info                     */
      struct COMPR_CB  **pCB);          /* (out) Control block                */
/******************************************************************************
** Decompress API
** Decompresses a block of data. The src parameter points to a block of data
** that is srcLen bytes in size. The tgt parameter points to a buffer that
** is tgtSize bytes in size. The plug-in library decompresses the data at
** address src and writes the uncompressed data to the buffer at address tgt.
** The actual size of the uncompressed data is returned as tgtLen. If the
** library returned a value of 1 for piInfo->useCRC, the CRC of the
** uncompressed block is returned as tgtCRC. If the library returned a value
** of 0 for piInfo->useCRC, tgtLen will be a null pointer.
**
** Authorization
**
** None
**
** Required connection
**
** None
**
** API include file
** 
** sqlucompr.h
**
** Decompress API parameters
**
** pCB
** Input. This is the control block that was returned by the
** InitDecompression API call.
** 
** src
** Input. Pointer to the block of data to be decompressed.
** 
** srcLen
** Input. Size in bytes of the block of data to be decompressed.
** 
** tgt
** Input and output. Target buffer for decompressed data. DB2 will supply
** this target buffer and the plug-in will decompress the data at src 
** and write decompressed data here.
** 
** tgtSize
** Input. Size in bytes of the target buffer.
** 
** tgtLen
** Output. Actual amount in bytes of decompressed data stored in tgt.
** 
** tgtCRC
** Output. If the library returned a value of 1 for piInfo->useCRC, the CRC
** value of the uncompressed block is returned as tgtCRC. If the library
** returned a value of 0 for piInfo->useCRC, tgtCRC will be a null pointer.
*******************************************************************************/
int Decompress(                         /* Decompress a block of data         */
      struct COMPR_CB   *pCB,           /* (in)  Control block                */
      const char        *src,           /* (in)  text to decompress           */
      db2int32           srcSize,       /* (in)  length of data block         */
      char              *tgt,           /* (i/o) buffer to decompress into    */
      db2int32           tgtSize,       /* (in)  size of buffer               */
      db2int32          *tgtLen,        /* (out) actual size of output        */
      db2Uint32         *tgtCRC);       /* (out) CRC of output data (or 0)    */
/******************************************************************************
** TermDecompression API
** Terminates the decompression library. The library will free the memory
** used for pCB. All the memory used internally by the compression APIs will
** be managed by the library. The plug-in library will also manage memory
** used by the COMPR_CB structure. DB2 will manage the memory used for the
** data buffers (the src and tgt parameters in the compression APIs).
**
** Authorization
** 
** None
** 
** Required connection
** 
** None
** 
** API include file
** 
** sqlucompr.h
**
** TermDecompression API parameters
**
** pCB
** Input. This is the control block that was returned by the
** InitDecompression API call.
*******************************************************************************/ 
int TermDecompression(                  /* Terminate decompression.           */
      struct COMPR_CB   *pCB);          /* (in)  Control block                */


#ifdef __cplusplus
}
#endif

#endif
