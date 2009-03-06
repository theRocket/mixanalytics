/* begin_generated_IBM_copyright_prolog                             */
/*                                                                  */
/* This is an automatically generated copyright prolog.             */
/* After initializing,  DO NOT MODIFY OR MOVE                       */
/* ---------------------------------------------------------------- */
/* IBM Confidential                                                 */
/*                                                                  */
/* OCO Source Materials                                             */
/*                                                                  */
/* Product(s):                                                      */
/*     5722-SS1                                                     */
/*                                                                  */
/* (C)Copyright IBM Corp.  2005, 2007                               */
/*                                                                  */
/* The Source code for this program is not published  or otherwise  */
/* divested of its trade secrets,  irrespective of what has been    */
/* deposited with the U.S. Copyright Office.                        */
/*  --------------------------------------------------------------- */
/*                                                                  */
/* end_generated_IBM_copyright_prolog                               */
/******************************************************************************
*
* Source File Name = DB2UDBG.H
*
* Function = Include File defining:
*              SQL Debugger Internal APIs
*
* Operating System = Common C Include File
*
*  Change Activity:
*    DATE    DESCRIPTION                                             S&D Code
*  ============================================================================
*  dd-mmm-yy xxxxxxxxxxxxxxxxxxx                                     @dxxxxxxaha
*  03-Mar-05 Second drop of udbg code & move sdbg to psmd\           @w019913hpl
*  01-Jun-05 Re-organize macro usage                                 @w034743hpl
*  13-Jul-05 Implement SessionManager SP                             @w039928hpl
*  21-Jul-05 Update Java APIs                                        @w041025hpl
*  27-Jul-05 Lookup default port numbers for debug JVM in LUW        @w041025hpl
*  01-Aug-05 Update Java APIs part 2 & return code                   @w042043hpl
*  17-Oct-05 Add new constants                                       @w052676hpl
*  20-Oct-05 Add new constants                                       @w053250hpl
*  26-Jan-06 Add new constant -32                                    @hpl060126
*  17-Feb-06 Removed '???' from defines for data types               @bains01
*  25-Feb-06 Add some new contants                                   @hpl060225
*  26-Feb-06 Add new dbg_OpenHandle2 for Java debugger               @hpl060226
*  13-Jun-07 Add DECFLOAT 16 and 34                                  @rtm070613
*  18-Jun-07 Add dbg_RegisterLines and new variable types            @emj070618
*
*  Last Changed =    %E%  %U%
**
******************************************************************************/

#ifndef _DB2UDBG_H_
#define _DB2UDBG_H_

/* The define is placed in front of function declarations to force the */
/* procedure exported name to remain unchanged and not mangled as C++  */
/* does with names.  This is useful when other languages want to call  */
/* one of these functions in the DB2 debug support                     */
#ifndef EXTERNC
 #ifdef __cplusplus
  #define EXTERNC extern "C"
 #else
  #define EXTERNC
 #endif
#endif

///////////////////////////////////////////////////////////////////////////////
// DB2 and PSMD Includes
///////////////////////////////////////////////////////////////////////////////
#if defined(SQL400)

#include <sqlsystm.h>

#elif defined(SQLOS390)

#include <sqlca.h>
#include "db2sdbg.h"

#else

#include <sqlca.h>
#include "db2psmd.h"

#endif



///////////////////////////////////////////////////////////////////////////////
// PSMD Constants
///////////////////////////////////////////////////////////////////////////////
#if defined(SQL400)

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

#define DB2DEBUGAPI

#elif defined(SQLOS390)

#define DB2DEBUGAPI

#else

#define DB2DEBUGAPI DB2API

#endif



/******************************************************************************
** PSMD Flow Control Codes
******************************************************************************/
#if defined(SQL400)
#define PD_FLOW_CONTINUE        0
#define PD_FLOW_TERMINATE       999
#endif


/******************************************************************************
** PSMD Routine Types
******************************************************************************/
#if defined(SQL400)
#define PD_RTYPE_PROCEDURE 0
#define PD_RTYPE_FUNCTION  1
#define PD_RTYPE_TRIGGER   2
#define PD_RTYPE_STATEMENT 3
#endif



/******************************************************************************
** PSMD Routine Languages
******************************************************************************/
#define PD_RLANG_SQL            0
#define PD_RLANG_JAVA           1
#define PD_RLANG_CLR            2


/******************************************************************************
** PSMD Variable Types  ??? means not supported in current code base
******************************************************************************/
#if defined(SQL400)
#define PD_VTYPE_SMALLINT       0       //SMALLINT
#define PD_VTYPE_INT            1       //INTEGER
#define PD_VTYPE_LARGEINT       2       //BIGINT
#define PD_VTYPE_FLOAT          3       //FLOAT, REAL
#define PD_VTYPE_DOUBLE         4       //DOUBLE
#define PD_VTYPE_TCHAR          5       //CHAR
#define PD_VTYPE_BCHAR          6       //CHAR FOR BIT DATA
#define PD_VTYPE_TSQLCHAR       7       //VARCHAR
#define PD_VTYPE_BSQLCHAR       8       //VARCHAR FOR BIT DATA
#define PD_VTYPE_TSQLLOB        9       //CLOB
#define PD_VTYPE_BSQLLOB        10      //BLOB

#define PD_VTYPE_DATE           11      //DATE
#define PD_VTYPE_TIME           12      //TIME
#define PD_VTYPE_TIMESTAMP      13      //TIMESTAMP

#define PD_VTYPE_GRAPHIC        14      //GRAPHIC
#define PD_VTYPE_SQLDBCHAR      15      //VARGRAPHIC
#define PD_VTYPE_DBCLOB         16      //DBCLOB   ???

#define PD_VTYPE_DECIMAL        17      //DECIMAL, NUMERIC
#endif

#define PD_VTYPE_ZSQLCHAR       18      // Varchar with null-terminated
#define PD_VTYPE_ZGRAPHIC       19      // Vargraphic with null-terminate

#define PD_VTYPE_BINARY         20      // Binary
#define PD_VTYPE_VBINARY        21      // VarBinary

#define PD_VTYPE_ROWID          22      // RowID         ???
#define PD_VTYPE_DATALINK       23      // DataLink      ???
#define PD_VTYPE_LOCATOR        24      // LOB Locator   ???
 
#define PD_VTYPE_DECFLOAT16     25      //DECFLOAT  16 Digits
#define PD_VTYPE_DECFLOAT64     25      //DECFLOAT  64 bits (16 digits)
#define PD_VTYPE_DECFLOAT34     26      //DECFLOAT  34 Digits
#define PD_VTYPE_DECFLOAT128    26      //DECFLOAT 128 bits (34 digits)

#define PD_VTYPE_TABLE_LOCATOR  27      // Table locator       // emj070618
#define PD_VTYPE_RS_LOCATOR     28      // Result set locator  // emj070618
#define PD_VTYPE_XML            29      // XML                 // emj070618
 
/******************************************************************************
** PSMD Condition Handler Types
******************************************************************************/
#define PD_HANDLER_NA          -1
#define PD_HANDLER_CONTINUE     0
#define PD_HANDLER_EXIT         1
#define PD_HANDLER_UNDO         2


/******************************************************************************
** PSMD API Parameter Constants
******************************************************************************/
#define PD_PARM_LINE_NA        -1    /* Line is not available */
#define PD_PARM_SCOPEID_NA      0    /* scopeid is not available */
#define PD_PARM_PORT_NA        -1    /* java port is not available */
#define PD_PARM_VAR_UPDABLE     1    /* variable can be updated */
#define PD_PARM_VAR_READONLY    0    /* variable is read only */


/******************************************************************************
** PSMD Error Codes
******************************************************************************/
#define PD_OK                       0
#define PD_ERR_NA                  -1

#define PD_ERR_USER_PRIVILEGE      -10 /* user does not have debug privilege */
#define PD_ERR_MGR_COMMUNICATION   -20 /* cannot communicate with session mgr */
#define PD_ERR_MGR_INFO_CONFLICT   -21 /* Mip:port is conflict between debug
                                          handler and register */
#define PD_ERR_MGR_INIT_PATH       -22 // can't initialize memory
#define PD_ERR_MGR_NOT_FOUND       -23 // db2favit not found
#define PD_ERR_MGR_NO_RES          -24 // Not enough resources
#define PD_ERR_MGR_USER_PERMIT     -25 // User doesn't have execute access
#define PD_ERR_MGR_INTRP           -26 // Interrupt has been detected
#define PD_ERR_MGR_UNEXP           -27 // Unexpected error
#define PD_ERR_JVM_NO_FREE_PORT    -30 // no java free port
#define PD_ERR_JVM_NOT_LINKED      -31 // cli cannot link to debug jvm //@hpl060126
#define PD_ERR_JVM_LINKED_TIMEOUT  -32 // no response from cli about jvm linked
#define PD_ERR_RTN_NOT_FOUND	   -100
#define PD_ERR_RTN_NOT_SUPPORTED   -101 /* routine not supported */
#define PD_ERR_CON_NOT_FOUND	   -120
#define PD_ERR_CON_TIMEDOUT        -121 /* connection timed out */
#define PD_ERR_CLI_NOT_FOUND	   -140 /* client not found */
#define PD_ERR_REG_UNABLE_QUERY    -200 /* unable to query debug info */
#define PD_ERR_REG_INVALID_CONTENT -201 /* register content invalid format */
#define PD_ERR_DEBUGINFO_EMPTY     -300 /* debug info is empty */ //@w053250hpl 
#define PD_ERR_HANDLE_INVALID      -301 /* invalid handler */
#define PD_ERR_DEBUGBUFF_EMPTY     -302                      //@w053250hpl
#define PD_ERR_DEBUGBUFF_DSNX9I4R  -303                      //@w053250hpl
#define PD_ERR_DEBUGBUFF_INVALID   -304                      //@w053250hpl
#define PD_ERR_GET_DEBUGINFO       -305
#define PD_ERR_RTNINFO_INVALID     -306 /* invalid routine info */
#define PD_ERR_RTNINFO_NOT_INIT    -307 /* routine info is not initialized*/
#define PD_ERR_PROC_DEBUGINFO      -310
#define PD_ERR_GETHOSTNAME         -320   //@w052676hpl
#define PD_ERR_GETHOSTBYNAME       -321   //@w052676hpl
#define PD_ERR_IPLIST_EMPTY        -322   //@w052676hpl
#define PD_ERR_GETIPFORM           -323   //@w052676hpl 
#define PD_ERR_GETSERVBYNAME       -324   //@w053250hpl
#define PD_ERR_XML_INVALID         -400 /* invalid format or content */
#define PD_ERR_OTHER               -500 /* any other error */

#define PD_WARN_PORT_NOT_FOUND      1 //@w052676hpl
#define PD_WARN_GETPORT_ERROR       2 //@w052676hpl

#if 0
///////////////////////////////////////////////////////////////////////////////
// CUdbgCon Error Code
///////////////////////////////////////////////////////////////////////////////
#define UDBG_ERR_CON_CONNECT_FAILED     -1110
#define UDBG_ERR_CON_DISCONNECT_FAILED  -1111
#define UDBG_ERR_CON_SEND_FAILED        -1112
#define UDBG_ERR_CON_RECV_FAILED        -1113
#define UDBG_ERR_CON_INVALID_HEADER     -1114                      //@hpl060225
#define UDBG_ERR_CON_NOT_CONNECTED      -1115                      //@hpl060225
#endif

/******************************************************************************
** PSMD Trace level
******************************************************************************/
#define PD_TRACE_NO               0   /* don't log any trace */
#define PD_TRACE_MIN              1   /* log trace when serious problem only */
#define PD_TRACE_MAX              2   /* log all traces*/




extern char DebugInfo[];


struct SDBGDebugInfo
{
  char 	    clientId[42];
  char      connectionId[10];
  char      threadId[10];
  char      nodeId[11];
  char 	    mgrIP[31];
  sqlint32  mgrPort;
  sqlint32  traceLevel;	    /* 0=no trace; 1=log trace only with serious problem;
                               2= log all the traces */
  sqlint32  nestedCount;    /* Nested stored procedure calls */
};

struct SDBGRoutine
{
  char*	    procSchema;
  char*	    procName;
  char*     specificSchema;
  char*	    specificName;
  char*     version;        /*  The version of the routine */
  char*     timestamp;      /*  This would help the IDE whether refesh server */
  sqlint32  type;
  sqlint32  language;
};

struct SDBGDiagnostics
{
  char*     sqlstate;
  sqlint32  sqlcode;
  char*     sqlmessage;
  sqlint32  row_count;
  sqlint32  return_status;
  void*     extension;
};





/******************************************************************************
** PSMD Internal Implementation APIs
******************************************************************************/




 ///////////////////////////////////////////////////////////////////////
 // New debug APIs for V9.1
 ///////////////////////////////////////////////////////////////////////


EXTERNC  sqlint32 DB2DEBUGAPI dbg_SetDebugInfo(
    char*                     pDebugInfo);


EXTERNC  sqlint32 DB2DEBUGAPI dbg_GetDebugInfo(
    char*                     pDebugInfoBuf);


EXTERNC  sqlint32 DB2DEBUGAPI dbg_IsDebugInfoAvail();


EXTERNC  sqlint32 DB2DEBUGAPI dbg_OpenHandle(
    void**                    ppDebugHandle);

EXTERNC  sqlint32 DB2DEBUGAPI dbg_OpenHandle2(                     //hpl060226
    void**                    ppDebugHandle,
    char*                     pDebugInfoString);


EXTERNC  sqlint32 DB2DEBUGAPI dbg_CloseHandle(
    void**                    ppDebugHandle);


EXTERNC  sqlint32 DB2DEBUGAPI dbg_PreEnterRoutine(
    void*                     pDebugHandle,
    sqlint32                  routineType,
    sqlint32                  routineLanguage);


EXTERNC  sqlint32 DB2DEBUGAPI dbg_EnterRoutine(
    void*                     pDebugHandle,
    struct SDBGRoutine*	      pRoutineInfo,
    char*                     pDebugJVMIP,
    sqlint32                  debugJVMPort);


EXTERNC  sqlint32 DB2DEBUGAPI dbg_ExitRoutine(
    void*                     pDebugHandle,
    struct SDBGRoutine*       pRoutineInfo);


EXTERNC  sqlint32 DB2DEBUGAPI dbg_LogFailure(
    void*                     pDebugHandle,
    struct SDBGRoutine*       pRoutineInfo,
    sqlint32                  ReasonCode,
    char*                     pMessage);


EXTERNC  sqlint32 DB2DEBUGAPI dbg_SetPortRange(
    void*                     piDebugHandle,
    char*                     piJVMIP,
    sqlint32                  iFromPort,
    sqlint32                  iToPort);


EXTERNC  sqlint32 DB2DEBUGAPI dbg_ReservePort(
    void*                     piDebugHandle,
    char*                     piJVMIP,
    sqlint32*                 poOutPort);


EXTERNC  sqlint32 DB2DEBUGAPI dbg_ReserveAlternatePort(
    void*                     piDebugHandle,
    char*                     piJVMIP,
    sqlint32                  iBadPort,
    sqlint32*                 poOutPort);


EXTERNC  sqlint32 DB2DEBUGAPI dbg_ReleasePort(
    void*                     piDebugHandle,
    char*                     piJVMIP,
    sqlint32                  iPort);


EXTERNC  void DB2DEBUGAPI dbg_InitializeRoutine(
    void**                    ppRoutineHandle,
    sqlint32                  CCSID);


EXTERNC  void DB2DEBUGAPI dbg_TerminateRoutine(
    void**                    ppRoutineHandle,
    sqlint32                  routineRc);


EXTERNC  void DB2DEBUGAPI dbg_RegisterScopeName(
    void**                    ppRoutineHandle,
    char*                     pScopeName,
    sqlint32                  scopeID);


EXTERNC  void DB2DEBUGAPI dbg_EnterScope(
    void**                    ppRoutineHandle,
    sqlint32                  scopeID);


EXTERNC  void DB2DEBUGAPI dbg_ExitScope(
    void**                    ppRoutineHandle,
    sqlint32                  scopeID);


EXTERNC  sqlint32 DB2DEBUGAPI dbg_AtLine(
    void**                    ppRoutineHandle,
    char*                     pStatement,/*if na, use  NULL */
    sqlint32                  maxStatementLen,
    sqlint32                  line,
    sqlint32                  scopeID,/*if na, use PD_PARM_SCOPEID_NA*/
    struct SDBGDiagnostics*   pDbgDiagnosticInfo);


EXTERNC  void DB2DEBUGAPI dbg_VarRegister(
    void**                    ppRoutineHandle,
    char*                     pVarName,
    sqlint32                  scopeID,/*if na, use PD_PARM_SCOPEID_NA*/
    void*                     pVarAddr,
    sqlint16*                 pIndicator,
    sqlint32                  varType,
    sqlint32                  varSize,
    sqlint32                  varScale,
    sqlint32                  CCSID,
    sqlint32                  isUpdable);


EXTERNC  void DB2DEBUGAPI dbg_VarMayChanged(
    void**                    ppRoutineHandle,
    char*                     pVarName,
    sqlint32                  scopeID);/*if na, use PD_PARM_SCOPEID_NA*/


EXTERNC  void DB2DEBUGAPI dbg_EnterConditionHandler (
    void**                    ppRoutineHandle,
    sqlint32                  pHandlerType);/*if na, use  PD_HANDLER_NA*/


EXTERNC  void DB2DEBUGAPI dbg_ExitConditionHandler (
   void**                     ppRoutineHandle);

/* emj070618
   pLineMap is a pointer to a bitmap of valid lines for breakpoints. 
       Each line is represented by a single bit in this bitmap.
   mapLen is number of bytes in pLineMap
   lastMapLine is last valid line in pLineMap
   maxLine is last line in program (may be N/A)
   bit string may be up to 2M/8 bytes long
*/
EXTERNC void DB2DEBUGAPI dbg_RegisterLines(                     // emj070618
   void** ppRoutineHandle,                                      // emj070618
   void* pLineMap,                                              // emj070618
   sqlint32 mapLen,                                             // emj070618
   sqlint32 lastLapLine,                                        // emj070618
   sqlint32 maxLine);                                           // emj070618

#if defined(SQL400)
EXTERNC sqlint32 DB2DEBUGAPI GET_DEBUG_INFO(
   char*                      pDebugInfo);

#endif



/******************************************************************************
******************************************************************************/

#endif
