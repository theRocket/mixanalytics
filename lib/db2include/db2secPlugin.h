/**********************************************************************
**
**  Source File Name = db2secPlugin.h
**
**  (C) COPYRIGHT International Business Machines Corp. 1991, 2005
**  All Rights Reserved
**  Licensed Materials - Property of IBM
**
**  US Government Users Restricted Rights - Use, duplication or
**  disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
**
**  Function = This files includes:
**             1. define for all the API return codes
**             2. maximum size used in the API parameter
**             3. defines used for some of the API parameter
**             4. structures and function used in the API parameter
**             5. initialization API for group, client and server plugins
**             6. structures that returns the API function pointers
**
**             Please consult the ADG client volumne for more details.
**
**  Operating System = All platforms that DB2 supported
**
***********************************************************************/

#ifndef _DB2SECPLUGIN_H
#define _DB2SECPLUGIN_H


#include "db2ApiDf.h"
#include "gssapiDB2.h" 

#ifdef __cplusplus
extern "C" {
#endif

#define DB2SEC_API_VERSION_1 1
/* DB2SEC_API_VERSION will always point to the latest version of */
/* the plugin API */
#define DB2SEC_API_VERSION DB2SEC_API_VERSION_1 

/**********************************************************************
**
** Error Code To be Returned by the plugin API
**
***********************************************************************/

#define DB2SEC_PLUGIN_OK 0
#define DB2SEC_PLUGIN_UNKNOWNERROR -1

#define DB2SEC_PLUGIN_BADUSER -2

/* Other than DB2SEC_PLUGIN_OK, */
/* the following three error return codes are for */
/* db2secDoesAuthIDExist and db2secDoesGroupExist API */
#define DB2SEC_PLUGIN_INVALIDUSERORGROUP -3
#define DB2SEC_PLUGIN_USERSTATUSNOTKNOWN -4
#define DB2SEC_PLUGIN_GROUPSTATUSNOTKNOWN -5

#define DB2SEC_PLUGIN_UID_EXPIRED  -6
#define DB2SEC_PLUGIN_PWD_EXPIRED -7
#define DB2SEC_PLUGIN_USER_REVOKED -8
#define DB2SEC_PLUGIN_USER_SUSPENDED -9

#define DB2SEC_PLUGIN_BADPWD -10
#define DB2SEC_PLUGIN_BAD_NEWPASSWORD -11
#define DB2SEC_PLUGIN_CHANGEPASSWORD_NOTSUPPORTED -12

#define DB2SEC_PLUGIN_NOMEM -13
#define DB2SEC_PLUGIN_DISKERROR -14
#define DB2SEC_PLUGIN_NOPERM -15
#define DB2SEC_PLUGIN_NETWORKERROR -16
#define DB2SEC_PLUGIN_CANTLOADLIBRARY -17
#define DB2SEC_PLUGIN_CANT_OPEN_FILE -18
#define DB2SEC_PLUGIN_FILENOTFOUND -19

#define DB2SEC_PLUGIN_CONNECTION_DISALLOWED -20

#define DB2SEC_PLUGIN_NO_CRED -21
#define DB2SEC_PLUGIN_CRED_EXPIRED -22
#define DB2SEC_PLUGIN_BAD_PRINCIPAL_NAME -23

/* DB2SEC_PLUGIN_NO_CON_DETAILS can be returned by the plugin callback */
/* to DB2 for connecting details i.e. db2secGetConDetails */
#define DB2SEC_PLUGIN_NO_CON_DETAILS -24

#define DB2SEC_PLUGIN_BAD_INPUT_PARAMETERS -25
#define DB2SEC_PLUGIN_INCOMPATIBLE_VER -26

#define DB2SEC_PLUGIN_PROCESS_LIMIT -27
#define DB2SEC_PLUGIN_NO_LICENSES -28

#define DB2SEC_PLUGIN_ROOT_NEEDED -29

#define DB2SEC_PLUGIN_UNEXPECTED_SYSTEM_ERROR -30

/**********************************************************************
**
** Parameter limit -
** The maximum size of authid, userid, namespace, password, principal name,
**                     and database name to be used for plugin.
** Internally DB2 supports a smaller size for some of them. Refer to
** SQL reference for the SQL limits.
**
***********************************************************************/

#define DB2SEC_MAX_AUTHID_LENGTH 255
#define DB2SEC_MAX_USERID_LENGTH 255
#define DB2SEC_MAX_USERNAMESPACE_LENGTH 255
#define DB2SEC_MAX_PASSWORD_LENGTH 255
#define DB2SEC_MAX_PRINCIPAL_NAME_LENGTH 255

#define DB2SEC_MAX_DBNAME_LENGTH 128

/**********************************************************************
**
** Userid type - Used as input by DB2 to the client side plugin
**               on db2secGetDefaultLoginContext API call.
** Real User or Effective User
**
***********************************************************************/
 
#define DB2SEC_PLUGIN_REAL_USER_NAME 0
#define DB2SEC_PLUGIN_EFFECTIVE_USER_NAME 1

/**********************************************************************
**
** Connection details bitmap -
** Used in db2secGetConDetails (pConDetails = db2sec_con_details_1)
** and db2secValidatePassword (connection_details)
** indicates whether the userid is get from default login context
** indicates whether the connection is local to the server
** indicates the validate password is currently called on the server
**
***********************************************************************/

#define DB2SEC_USERID_FROM_OS 0x00000001
#define DB2SEC_CONNECTION_ISLOCAL 0x00000002
#define DB2SEC_VALIDATING_ON_SERVER_SIDE 0x0000004

/**********************************************************************
**
** Plugin Type
**
***********************************************************************/

#define DB2SEC_PLUGIN_TYPE_USERID_PASSWORD 0
#define DB2SEC_PLUGIN_TYPE_GSSAPI 1
#define DB2SEC_PLUGIN_TYPE_KERBEROS 2
#define DB2SEC_PLUGIN_TYPE_GROUP 3

/**********************************************************************
**
** Namespace Type -
** DB2SEC_NAMESPACE_SAM_COMPATIBLE is of format torolab\username
** DB2SEC_NAMESPACE_USER_PRINCIPAL is of format username@torolab.ibm.com
** where torolab is the domain name
**
************************************************************************/

#define DB2SEC_USER_NAMESPACE_UNDEFINED 0
#define DB2SEC_NAMESPACE_SAM_COMPATIBLE 1
#define DB2SEC_NAMESPACE_USER_PRINCIPAL 2

/**********************************************************************
**
** Token Type -
** Indicate the type of token whether is a token from userid/password
** plugin or GSS-API (including kerberos) plugin.
** Used in the tokentype parameter for db2secGetGroupsForUser API (group
** plugin)
**
***********************************************************************/

#define DB2SEC_GENERIC 0
#define DB2SEC_GSSAPI_CTX_HANDLE 1

/**********************************************************************
**
** Location -
** Indicate the location where the API is called (either on the client
** or on the server)
** Used in the location parameter for db2secGetGroupsForUser API (group
** plugin)
**
***********************************************************************/

#define DB2SEC_SERVER_SIDE 0
#define DB2SEC_CLIENT_SIDE 1

/**********************************************************************
**
** Initial Session Authid Type
**
***********************************************************************/

#define DB2SEC_ID_TYPE_AUTHID 0
#define DB2SEC_ID_TYPE_ROLE   1

/**********************************************************************
**
** Log Message Level
** Used in level parameter for db2secLogMessage API
** This indicates the severity of the message to be logged
**
***********************************************************************/
 
#define DB2SEC_LOG_NONE     0
#define DB2SEC_LOG_CRITICAL 1
#define DB2SEC_LOG_ERROR    2
#define DB2SEC_LOG_WARNING  3
#define DB2SEC_LOG_INFO     4

/* Connection details structure version used in conDetailsVersion parameter */
/* for db2secGetConDetails callback API */
#define DB2SEC_CON_DETAILS_VERSION_1    1
#define DB2SEC_CON_DETAILS_VERSION_2    2
#define DB2SEC_CON_DETAILS_VERSION_3    3
   
/* Connection details structure used in pConDetails parameter for */
/* db2secGetConDetails callback API - version 1*/
typedef struct db2sec_con_details_1
{
  db2int32  clientProtocol;     /* See SQL_PROTOCOL_ in sqlenv.h */
  db2Uint32 clientIPAddress;    /* Set if protocol is TCPIP4     */
  db2Uint32 connect_info_bitmap;
  db2int32  dbnameLen;
  char dbname[DB2SEC_MAX_DBNAME_LENGTH + 1];
} db2sec_con_details_1;

/* Connection details structure used in pConDetails parameter for */
/* db2secGetConDetails callback API - version 2*/
typedef struct db2sec_con_details_2
{
  db2int32  clientProtocol;     /* See SQL_PROTOCOL_ in sqlenv.h */
  db2Uint32 clientIPAddress;    /* Set if protocol is TCPIP4     */
  db2Uint32 connect_info_bitmap;
  db2int32  dbnameLen;
  char dbname[DB2SEC_MAX_DBNAME_LENGTH + 1];
  db2Uint32 clientIP6Address[4];/* Set if protocol is TCPIP6     */  
} db2sec_con_details_2;

/* Connection details structure used in pConDetails parameter for */
/* db2secGetConDetails callback API - version 3                   */
typedef struct db2sec_con_details_3
{
  db2int32  clientProtocol;     /* See SQL_PROTOCOL_ in sqlenv.h */
  db2Uint32 clientIPAddress;    /* Set if protocol is TCPIP4     */
  db2Uint32 connect_info_bitmap;
  db2int32  dbnameLen;
  char dbname[DB2SEC_MAX_DBNAME_LENGTH + 1];
  db2Uint32 clientIP6Address[4];/* Set if protocol is TCPIP6     */  
  db2Uint32 clientPlatform;     /* SQLM_PLATFORM_* from sqlmon.h */
  db2Uint32 _reserved[16];
} db2sec_con_details_3;


/* The following two callback APIs are provided by DB2 to the plugin */
typedef SQL_API_RC (SQL_API_FN db2secGetConDetails)
                              ( db2int32 conDetailsVersion, 
                                void * pConDetails );

typedef SQL_API_RC (SQL_API_FN db2secLogMessage)
                              ( db2int32 level,
                                void * data,
                                db2int32 length);

/* Client side plugin initialization API */
/**********************************************************************
** db2secClientAuthPluginInit API
** Initialization API, for the client authentication plug-in, that DB2
** calls immediately after loading the plug-in. 
**
** db2secClientAuthPluginInit API parameters
** 
** version
** Input. 
** The highest version number of the API that DB2 currently supports.
** The DB2SEC_API_VERSION value (in db2secPlugin.h) contains the
** latest version number of the API that DB2 currently 
** supports.
** 
** client_fns
** Output. 
** A pointer to memory provided by DB2 for a 
** db2secGssapiClientAuthFunctions_<version_number> structure (also
** known as gssapi_client_auth_functions_<version_number>), if GSS-API
** authentication is used, or a 
** db2secUseridPasswordClientAuthFunctions_<version_number> structure
** (also known as
** userid_password_client_auth_functions_<version_number>), if
** userid/password authentication is used. The
** db2secGssapiClientAuthFunctions_<version_number> structure and
** db2secUseridPasswordClientAuthFunctions_<version_number> structure
** respectively contain pointers to the APIs implemented for the
** GSS-API authentication plug-in and userid/password authentication
** plug-in. In future versions of DB2, there might be different
** versions of the APIs, so the client_fns parameter is cast as a
** pointer to the gssapi_client_auth_functions_<version_number>
** structure corresponding to the version the plug-in has implemented.
** The first parameter of the 
** gssapi_client_auth_functions_<version_number> structure or the 
** userid_password_client_auth_functions_<version_number> structure 
** tells DB2 the version of the APIs that the plug-in has implemented.  
** Note: The casting is done only if the DB2 version is higher or equal
** to the version of the APIs that the plug-in has implemented.
**
** Inside the gssapi_server_auth_functions_<version_number> or 
** userid_password_server_auth_functions_<version_number> structure,
** the plugintype parameter should be set to one of 
** DB2SEC_PLUGIN_TYPE_USERID_PASSWORD, DB2SEC_PLUGIN_TYPE_GSSAPI, or
** DB2SEC_PLUGIN_TYPE_KERBEROS. Other values can be defined in future
** versions of the API. 
**
** logMessage_fn
** Input. 
** A pointer to the db2secLogMessage API, which is implemented
** by DB2. The db2secClientAuthPluginInit API can call the
** db2secLogMessage API to log messages to db2diag.log for debugging or
** informational purposes. The first parameter (level) of 
** db2secLogMessage API specifies the type of diagnostic errors that 
** will be recorded in the db2diag.log file and the last two parameters
** respectively are the message string and its length. The valid values
** for the first parameter of dbesecLogMessage API (defined in
** db2secPlugin.h) are: 
**
** - DB2SEC_LOG_NONE (0)     
** No logging
** - DB2SEC_LOG_CRITICAL (1) 
** Severe Error encountered
** - DB2SEC_LOG_ERROR (2)
** Error encountered
** - DB2SEC_LOG_WARNING (3)
** Warning
** - DB2SEC_LOG_INFO (4)
** Informational 
**
** The message text will show up in the diag.log only if the value of
** the 'level' parameter of the db2secLogMessage API is less than or
** equal to the diaglevel database manager configuration parameter.
** So for example, if you use the DB2SEC_LOG_INFO value, the message 
** text will only show up in the db2diag.log if the diaglevel database
** manager configuration parameter is set to 4. 
**
** errormsg
** Output. 
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the 
** db2secClientAuthPluginInit API call is not successful.
**
** errormsglen
** Output. 
** A pointer to an integer that indicates the length in bytes
** of the error message string in errormsg parameter. 
***********************************************************************/
SQL_API_RC SQL_API_FN db2secClientAuthPluginInit 
                              ( db2int32  version,
                                void     *client_fns,
                                db2secLogMessage *logMessage_fn,
                                char    **errormsg,
                                db2int32 *errormsglen );

/* Server side plugin initialization API */
/**********************************************************************
** db2secServerAuthPluginInit API
** Initialization API, for the server authentication plug-in, that DB2
** calls immediately after loading the plug-in. 
** In the case of GSS-API, the plug-in is responsible for filling in
** the server's principal name in the serverPrincipalName parameter
** inside the gssapi_server_auth_functions structure at initialization
** time and providing the server's credential handle in the 
** serverCredHandle parameter inside the gssapi_server_auth_functions 
** structure. The freeing of the memory allocated to hold the principal
** name and the credential handle must be done by the 
** db2secServerAuthPluginTerm API by calling the gss_release_name and
** gss_release_cred APIs. 
** 
** db2secServerAuthPluginInit API parameters
**
** version
** Input. 
** The highest version number of the API that DB2 currently
** supports. The DB2SEC_API_VERSION value (in db2secPlugin.h) 
** contains the latest version number of the API that DB2 currently 
** supports.
**
** server_fns
** Output. 
** A pointer to memory provided by DB2 for a 
** db2secGssapiServerAuthFunctions_<version_number> structure (also
** known as gssapi_server_auth_functions_<version_number>), if GSS-API
** authentication is used, or a
** db2secUseridPasswordServerAuthFunctions_<version_number> structure
** (also known as 
** userid_password_server_auth_functions_<version_number>), if
** userid/password authentication is used. The
** db2secGssapiServerAuthFunctions_<version_number> structure and 
** db2secUseridPasswordServerAuthFunctions_<version_number> structure
** respectively contain pointers to the APIs implemented for the
** GSS-API authentication plug-in and userid/password authentication
** plug-in. 
** In future versions of DB2, there might be different versions of the
** APIs, so the server_fns parameter is cast as a pointer to the 
** gssapi_server_auth_functions_<version_number> structure
** corresponding to the version the plug-in has implemented. The first
** parameter of the gssapi_server_auth_functions_<version_number>
** structure or the 
** userid_password_server_auth_functions_<version_number> structure
** tells DB2 the version of the APIs that the plug-in has implemented. 
** Note: The casting is done only if the DB2 version is higher or equal
** to the version of the APIs that the plug-in has implemented.
**
** Inside the gssapi_server_auth_functions_<version_number> or 
** userid_password_server_auth_functions_<version_number> structure,
** the plugintype parameter should be set to one of 
** DB2SEC_PLUGIN_TYPE_USERID_PASSWORD, DB2SEC_PLUGIN_TYPE_GSSAPI, or
** DB2SEC_PLUGIN_TYPE_KERBEROS. Other values can be defined in future
** versions of the API. 
**
** getConDetails_fn
** Input. 
** Pointer to the db2secGetConDetails API, which is implemented
** by DB2. The db2secServerAuthPluginInit API can call the 
** db2secGetConDetails API in any one of the other authentication APIs 
** to obtain details related to the database connection. These details
** include information about the communication mechanism associated
** with the connection (such as the IP address, in the case of TCP/IP),
** which the plug-in writer might need to reference when making
** authentication decisions. For example, the plug-in could disallow a
** connection for a particular user, unless that user is connecting
** from a particular IP address. The use of the db2secGetConDetails API
** is optional. 
** 
** If the db2secGetConDetails API is called in a situation not 
** involving a database connection, it returns the value 
** DB2SEC_PLUGIN_NO_CON_DETAILS, otherwise, it returns 0 on success. 
**
** The db2secGetConDetails API takes two input parameters; pConDetails,
** which is a pointer to the db2sec_con_details structure, and 
** conDetailsVersion, which is a version number indicating which
** db2sec_con_details structure to use. The current version number is
** 1. Upon a successful return, the db2sec_con_details structure will
** contain the following information: 
** 
** - The protocol used for the connection to the server. The listing 
** of protocol definitions can be found in the file sqlenv.h (located
** in the include directory)
** (SQL_PROTOCOL_*). This information is filled out in the 
** clientProtocol parameter.
**
** - The TCP/IP address of the inbound connect to the server if the
** protocol is TCP/IP. This information is filled out in the 
** clientIPAddress parameter.
**
** - The database name the client is attempting to connect to. This 
** will not be set for instance attachments. This information is filled
** out in the dbname and dbnamelen parameters.
**
** - A connection information bit-map that contains the same details
** as documented in the connection_details parameter of the 
** db2secValidatePassword API. This information is filled out in the 
** connect_info_bitmap parameter.
**
** logMessage_fn
** Input. 
** A pointer to the db2secLogMessage API, which is implemented
** by DB2. The db2secClientAuthPluginInit API can call the
** db2secLogMessage API to log messages to db2diag.log for debugging or
** informational purposes. The first parameter (level) of 
** db2secLogMessage API specifies the type of diagnostic errors that 
** will be recorded in the db2diag.log file and the last two parameters
** respectively are the message string and its length. The valid values
** for the first parameter of dbesecLogMessage API (defined in
** db2secPlugin.h) are: 
**
** - DB2SEC_LOG_NONE (0)     
** No logging
** - DB2SEC_LOG_CRITICAL (1) 
** Severe Error encountered
** - DB2SEC_LOG_ERROR (2)
** Error encountered
** - DB2SEC_LOG_WARNING (3)
** Warning
** - DB2SEC_LOG_INFO (4)
** Informational 
**
** The message text will show up in the diag.log only if the value of
** the 'level' parameter of the db2secLogMessage API is less than or
** equal to the diaglevel database manager configuration parameter.
** So for example, if you use the DB2SEC_LOG_INFO value, the message 
** text will only show up in the db2diag.log if the diaglevel database
** manager configuration parameter is set to 4. 
**
** errormsg
** Output. 
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the 
** db2secServerAuthPluginInit API execution is not successful.
**
** errormsglen
** Output. 
** A pointer to an integer that indicates the length in bytes
** of the error message string in errormsg parameter. 
***********************************************************************/
SQL_API_RC SQL_API_FN db2secServerAuthPluginInit
                              ( db2int32              version,
                                void                 *server_fns,
                                db2secGetConDetails  *getConDetails_fn,
                                db2secLogMessage     *logMessage_fn,
                                char                **errormsg,
                                db2int32             *errormsglen );

/* Group side plugin initialization API */
/**********************************************************************
** db2secGroupPluginInit API
** Initialization API, for the group-retrieval plug-in, that DB2 
** calls immediately after loading the plug-in.   
**
** db2secGroupPluginInit API parameters
**
** version 
** Input. 
** The highest version number of the API that DB2 currently
** supports. The value DB2SEC_API_VERSION (in db2secPlugin.h) 
** contains the latest version number of the API that DB2 currently 
** supports.
**
** group_fns
** Output. 
** A pointer to the db2secGroupFunctions_<version_number> (also known
** as group_functions_<version_number>) structure. The
** db2secGroupFunctions_<version_number> structure contains pointers
** to the APIs implemented for the group-retrieval plug-in. In future,
** there might be different versions of the APIs (for example,
** db2secGroupFunctions_<version_number>), so the group_fns parameter
** is cast as a pointer to the db2secGroupFunctions_<version_number>
** structure corresponding to the version the plug-in has implemented.
** The first parameter of the group_functions_<version_number>
** structure tells DB2 the version of the APIs that the plug-in has
** implemented. 
** Note: The casting is done only if the DB2 version is higher or equal
** to the version of the APIs that the plug-in has implemented.
**
** logMessage_fn
** Input. 
** A pointer to the db2secLogMessage API, which is implemented
** by DB2. The db2secGroupPluginInit API can call the db2secLogMessage
** API to log messages to db2diag.log for debugging or informational
** purposes. The first parameter (level) of db2secLogMessage API 
** specifies the type of diagnostic errors that will be recorded in the
** db2diag.log file and the last two parameters respectively are the
** message string and its length. The valid values for the first 
** parameter of dbesecLogMessage API (defined in db2secPlugin.h) are: 
**
** - DB2SEC_LOG_NONE (0)  
** No logging
** - DB2SEC_LOG_CRITICAL (1) 
** Severe Error encountered
** - DB2SEC_LOG_ERROR (2)
** Error encountered
** - DB2SEC_LOG_WARNING (3)
** Warning
** - DB2SEC_LOG_INFO (4)
** Informational 
**
** The message text will show up in the diag.log only if the value of
** the 'level' parameter of the db2secLogMessage API is less than or
** equal to the diaglevel database manager configuration parameter.
** So for example, if you use the DB2SEC_LOG_INFO value, the message 
** text will only show up in the db2diag.log if the diaglevel database
** manager configuration parameter is set to 4. 
**
** errormsg
** Output.
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if
** the db2secGroupPluginInit API execution is not successful. 
** 
** errormsglen
** Output. 
** A pointer to an integer that indicates the length in bytes 
** of the error message string in errormsg parameter.
***********************************************************************/
SQL_API_RC SQL_API_FN db2secGroupPluginInit
                              ( db2int32   version,
                                void      *group_fns,
                                db2secLogMessage *logMessage_fn,
                                char     **errormsg,
                                db2int32  *errormsglen );

/**********************************************************************
** Group plugin function pointer structure to be returned during init 
***********************************************************************/
typedef struct group_functions_1
{
     db2int32 version;
     db2int32 plugintype;
/**********************************************************************
** db2secGetGroupsForUser API
** Returns the list of groups to which a user belongs. 
**
** db2secGetGroupsForUser API parameters
**
** authid
** Input. 
** This parameter value is an SQL authid, which means that DB2 converts
** it to an uppercase character string with no trailing blanks. DB2 
** will always provide a non-null value for the authid parameter. The
** API must be able to return a list of groups to which the authid
** belongs without depending on the other input parameters. It is
** permissible to return a shortened or empty list if this cannot be
** determined. 
**
** If a user does not exist, the API must return the return code
** DB2SEC_PLUGIN_BADUSER. DB2 does not treat the case of a user not 
** existing as an error, since it is permissible for an authid to not
** have any groups associated with it. For example, the 
** db2secGetAuthids API can return an authid that does not exist on
** the operating system. The authid is not associated with any groups,
** however, it can still be assigned privileges directly. 
**
** If the API cannot return a complete list of groups using only 
** the authid, then there will be some restrictions on certain SQL 
** functions related to group support. For a list of possible problem 
** scenarios, refer to the Usage notes section in this topic.  
**
** authidlen
** Input. 
** Length in bytes of the authid parameter value. DB2 will 
** always provide a non-zero value for the authidlen parameter.
**
** userid
** Input. 
** This is the user ID corresponding to the authid. When this
** API is called on the server in a non-connect scenario, this 
** parameter will not be filled by DB2.
**
** useridlen
** Input. 
** Length in bytes of the userid parameter value. 
**
** usernamespace
** Input. 
** The namespace from which the user ID was obtained. When the
** user ID is not available, this parameter will not be filled by DB2. 
** 
** usernamespacelen
** Input. 
** Length in bytes of the usernamespace parameter value.
**
** usernamespacetype
** Input. 
** The type of namespace. Valid values for the usernamespacetype
** parameter (defined in db2secPlugin.h) are: 
** - DB2SEC_NAMESPACE_SAM_COMPATIBLE
** Corresponds to a username style like domain\myname
** - DB2SEC_NAMESPACE_USER_PRINCIPAL 
** Corresponds to a username style like myname@domain.ibm.com
** Currently DB2 only supports the value
** DB2SEC_NAMESPACE_SAM_COMPATIBLE. When the user ID is not available,
** the usernamespacetype parameter is set to the value 
** DB2SEC_USER_NAMESPACE_UNDEFINED (defined in db2secPlugin.h).
**
** dbname
** Input.
** Name of the database being connected to. This parameter can 
** be NULL in a non-connect scenario.
** 
** dbnamelen
** Input. 
** Length in bytes of the dbname parameter value. This parameter
** is set to 0 if dbname parameter is NULL in a non-connect scenario.
**
** token
** Input. 
** A pointer to data provided by the authentication plug-in. It
** is not used by DB2. It provides the plug-in writer with the ability
** to coordinate user and group information. This parameter might
** not be provided in all cases (for example, in a non-connect
** scenario), in which case it will be NULL. If the authentication
** plug-in used is GSS-API based, the token will be set to the GSS-API
** context handle (gss_ctx_id_t).
**
** tokentype
** Input. 
** Indicates the type of data provided by the authentication
** plug-in. If the authentication plug-in used is GSS-API based, the
** token will be set to the GSS-API context handle (gss_ctx_id_t).
** If the authentication plug-in used is user ID/password based, it
** will be a generic type. Valid values for the tokentype parameter
** (defined in db2secPlugin.h) are:
** - DB2SEC_GENERIC 
** Indicates that the token is from a user ID/password based plug-in.  
** - DB2SEC_GSSAPI_CTX_HANDLE
** Indicates that the token is from a GSS-API (including Kerberos)
** based plug-in. 
**
** location
** Input. 
** Indicates whether DB2 is calling this API on the client
** side or server side. Valid values for the location parameter
** (defined in db2secPlugin.h) are:
** - DB2SEC_SERVER_SIDE 
** The API is to be called on the database server.
** - DB2SEC_CLIENT_SIDE
** The API is to be called on a client. 
**
** authpluginname
** Input. 
** Name of the authentication plug-in that provided the data in
** the token. The  db2secGetGroupsForUser API might use this 
** information in determining the correct group memberships. This
** parameter might not be filled by DB2 if the authid is not 
** authenticated (for example, if the authid does not match the current
** connected user). 
**
** authpluginnamelen
** Input. 
** Length in bytes of the authpluginname parameter value. 
**
** grouplist
** Output. 
** List of groups to which the user belongs. The list of groups
** must be returned as a pointer to a section of memory allocated by
** the plug-in containing concatenated varchars (a varchar is a
** character array in which the first byte indicates the number of
** bytes following it). The length is an unsigned char (1 byte) and 
** that limits the maximum length of a groupname to 255 characters. For
** example, "\006GROUP1\007MYGROUP\008MYGROUP3".
** Each group name should be a valid DB2 authid. The memory for this
** array must be allocated by the plug-in. The plug-in must therefore
** provide an API, such as the db2secFreeGroupListMemory API
** that DB2 will call to free the memory.
**
** numgroups
** Output. 
** The number of groups contained in the grouplist parameter.
**
** errormsg
** Output. 
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the 
** db2secGetGroupsForUser API execution is not successful. 
** 
** errormsglen
** Output. 
** A pointer to an integer that indicates the length in bytes 
** of the error message string in errormsg parameter. 
**
** Usage notes
**
** The following is a list of scenarios when problems can occur if an
** incomplete group list is returned by this API to DB2:
**
** - Embedded SQL application with DYNAMICRULES BIND (or DEFINEDBIND
** or INVOKEDBIND if the packages are running as a standalone
** application). DB2 checks for SYSADM membership and the application 
** will fail if it is dependent on the implicit DBADM authority granted
** by being a member of the SYSADM group. 
** 
** - Alternate authorization is provided in CREATE SCHEMA statement.
** Group lookup will be performed against the AUTHORIZATION NAME 
** parameter if there are nested CREATE statements in the CREATE 
** SCHEMA statement.
**
** - Embedded SQL applications with DYNAMICRULES DEFINERUN/DEFINEBIND
** and the packages are running in a routine context. DB2 checks for 
** SYSADM membership of the routine definer and the application will
** fail if it is dependent on the implicit DBADM authority granted by 
** being a member of the SYSADM group.
** 
** - Processing a jar file in an MPP environment. In an MPP
** environment, the jar processing request is sent from the coordinator
** node with the session authid. The catalog node received the requests
** and process the jar files based on the privilege of the session
** authid (the user executing the jar processing requests). 
** 
** -- Install jar file. The session authid needs to have one of the
** following rights: SYSADM, DBADM, or CREATEIN (implicit or explicit
** on the jar schema). The operation will fail if the above rights are
** granted to group containing the session authid, but not explicitly
** to the session authid or if only SYSADM is held, since SYSADM
** membership is determined by membership in the group defined by a
** database configuration parameter.
** 
** -- Remove jar file. The session authid needs to have one of the
** following rights rights: SYSADM, DBADM, or DROPIN (implicit or
** explicit on the jar schema), or is the definer of the jar file. The
** operation will fail if the above rights are granted to group
** containing the session authid, but not explicitly to the session
** authid, and if the session authid is not the definer of the jar file
** or if only SYSADM is held since SYSADM membership is determined by
** membership in the group defined by a database configuration
** parameter.
** 
** -- Replace jar file. This is same as removing the jar file, followed
** by installing the jar file. Both of the above apply. 
**
** - Regenerate views. This is triggered by the ALTER TABLE, ALTER
** COLUMN, SET DATA TYPE VARCHAR/VARGRAPHIC statements, or during
** migration. DB2 checks for SYSADM membership of the view definer. The
** application will fail if it is dependent on the implicit DBADM
** authority granted by being a member of the SYSADM group.
**
** - When SET SESSION_USER statement is issued. Subsequent DB2
** operations are run under the context of the authid specified by this
** statement. These operations will fail if the privileges required are
** owned by one of the SESSION_USER's group is not explicitly granted
** to the SESSION_USER authid. 
***********************************************************************/
     SQL_API_RC ( SQL_API_FN *db2secGetGroupsForUser) 
                           ( const char *authid,
                             db2int32    authidlen,
                             const char *userid,
                             db2int32    useridlen,
                             const char *usernamespace,
                             db2int32    usernamespacelen,
                             db2int32    usernamespacetype,
                             const char *dbname,
                             db2int32    dbnamelen,
                             void       *token,
                             db2int32    tokentype,
                             db2int32    location,
                             const char *authpluginname,
                             db2int32    authpluginnamelen,
                             void      **grouplist,
                             db2int32   *numgroups,
                             char      **errormsg,
                             db2int32   *errormsglen );
/**********************************************************************
** db2secDoesGroupExist API
** Determines if an authid represents a group. If the groupname exists,
** the API must be able to return the value DB2SEC_PLUGIN_OK, to
** indicate success. It must also be able to return the value
** DB2SEC_PLUGIN_INVALIDUSERORGROUP if the group name is not valid. It
** is permissible for the API to return the value 
** DB2SEC_PLUGIN_GROUPSTATUSNOTKNOWN if it is impossible to determine
** if the input is a valid group. If an invalid group 
** (DB2SEC_PLUGIN_INVALIDUSERORGROUP) or group not known 
** (DB2SEC_PLUGIN_GROUPSTATUSNOTKNOWN) value is returned, DB2 might not
** be able to determine whether the authid is a group or user when 
** issuing the GRANT statement without the keywords USER and GROUP,
** which would result in the error SQLCODE -569, SQLSTATE 56092 being
** returned to the user. 
** 
** db2secDoesGroupExist API parameters
**
** groupname
** Input. 
** An authid, upper-cased, with no trailing blanks. 
** 
** groupnamelen
** Input. 
** Length in bytes of the groupname parameter value.
**
** errormsg
** Output. 
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the 
** db2secDoesGroupExist API execution is not successful.
**
** errormsglen
** Output. 
** A pointer to an integer that indicates the length in bytes 
** of the error message string in errormsg parameter.
***********************************************************************/
     SQL_API_RC ( SQL_API_FN *db2secDoesGroupExist) 
                           ( const char *groupname,
                             db2int32    groupnamelen,
                             char      **errormsg,
                             db2int32   *errormsglen );

/**********************************************************************
** db2secFreeGroupListMemory API
** Frees the memory used to hold the list of groups from a previous
** call to db2secGetGroupsForUser API.
**
** db2secFreeGroupListMemory API parameters
** 
** ptr
** Input. 
** Pointer to the memory to be freed. 
**
** errormsg
** Output. 
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the 
** db2secFreeGroupListMemory API execution is not successful.
**
** errormsglen
** Output. 
** A pointer to an integer that indicates the length in bytes 
** of the error message string in errormsg parameter. 
***********************************************************************/
     SQL_API_RC ( SQL_API_FN *db2secFreeGroupListMemory) 
                           ( void       *ptr,
                             char      **errormsg,
                             db2int32   *errormsglen );
/**********************************************************************
** db2secFreeErrormsg API
** Frees the memory used to hold an error message from a previous API
** call. This is the only API that does not return an error message. 
** If this API returns an error, DB2 will log it and continue. 
**
** db2secFreeErrormsg API parameters
**
** msgtofree
** Input. 
** A pointer to the error message allocated from a previous API
** call. 
***********************************************************************/
     SQL_API_RC ( SQL_API_FN *db2secFreeErrormsg) 
                           ( char *msgtofree );
/**********************************************************************
** db2secPluginTerm API
** Frees resources used by the group-retrieval plug-in. This API is
** called by DB2 just before it unloads the group-retrieval plug-in.
** It should be implemented in a manner that it does a proper cleanup
** of any resources the plug-in library holds, for instance, free any
** memory allocated by the plug-in, close files that are still open,
** and close network connections. The plug-in is responsible for 
** keeping track of these resources in order to free them. This API is
** not called on any Windows platform. For further information, please
** refer to the topic "Restrictions on security plug-ins".
**
** db2secPluginTerm API parameters
**
** errormsg
** Output. 
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the 
** db2secPluginTerm API execution is not successful. 
**
** errormsglen
** Output. 
** A pointer to an integer that indicates the length in bytes
** of the error message string in errormsg parameter.
***********************************************************************/
     SQL_API_RC ( SQL_API_FN *db2secPluginTerm)
                           ( char      **errormsg,
                             db2int32   *errormsglen );
} db2secGroupFunction_1;

/**********************************************************************
** Client userid-password plugin function pointer structure to be 
** returned during init 
***********************************************************************/
typedef struct userid_password_client_auth_functions_1
{
     db2int32 version;
     db2int32 plugintype;

     /* db2secRemapUserid is an optional API */
/**********************************************************************
** db2secRemapUserid API
** This API is called by DB2 on the client side to provide the 
** ability to remap a given user ID and password (and possibly new 
** password and usernamespace) to values different from those given at
** connect time. DB2 will only call this API if a user ID and a
** password are supplied at connect time. This prevents a plug-in
** from remapping a user ID by itself to a user ID/password pair. This
** API is optional and will not be called if it is not provided or 
** implemented by the security plug-in. 
**
** db2secRemapUserid API parameters
**
** userid
** Input or output. 
** The user ID to be remapped. If there is an input
** user ID value, then the API must provide an output user ID value 
** that can be the same or different from the input user ID value. If
** there is no input user ID value, then the API should not return an
** output user ID value.
**
** useridlen
** Input or output. 
** Length in bytes of the userid parameter value.
**
** usernamespace
** Input or output. 
** The namespace the user ID. This value can
** optionally be remapped. If no input parameter value is specified,
** but an output value is returned, then the usernamespace will only
** be used by DB2 for CLIENT type authentication and will be 
** disregarded for other authentication types.
**
** usernamespacelen
** Input or output. 
** Length in bytes of the usernamespace parameter 
** value. Under the limitation that the usernamespacetype parameter 
** must be set to the value DB2SEC_NAMESPACE_SAM_COMPATIBLE (defined
** in db2secPlugin.h), the maximum length currently supported is 15
** bytes.
** 
** usernamespacetype
** Input or output. 
** Old and new namespacetype value. In the current
** version of DB2, the only supported namespace type value is 
** DB2SEC_NAMESPACE_SAM_COMPATIBLE (corresponds to a username style
** like domain\myname).
**
** password
** Input or output. 
** As an input, it is the password that is to be
** remapped. As an output it is the remapped password. If an input 
** value is specified for this parameter, the API must be able to 
** return an output value that differs from the input value. If
** no input value is specified, the API must not return an output
** password value.
**
** passwordlen
** Input or output. 
** Length in bytes of the password parameter value. 
**
** newpasswd
** Input or output. 
** As an input, it is the new password that is to be
** set. As an output it is the confirmed new password.
** Note: 
** This is the new password that will be passed by DB2 into the
** newpassword parameter of the db2secValidatePassword API on the
** client or the server (depending on the value of the authentication
** database manager configuration parameter). If a new password was
** passed as input, then the API must be able to return an output value
** and it can be a different new password. If there is no new password 
** passed in as input, then the API should not return an output new
** password. 
**
** newpasswdlen
** Input or output. 
** Length in bytes of the newpasswd parameter value. 
** 
** dbname
** Input.
** Name of the database to which the client is connecting.
** 
** dbnamelen
** Input.
** Length in bytes of the dbname parameter value.
**
** errormsg
** Output. 
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the
** db2secRemapUserid API execution is not successful. 
**
** errormsglen
** Output.
** A pointer to an integer that indicates the length in bytes 
** of the error message string in errormsg parameter.
***********************************************************************/
     SQL_API_RC ( SQL_API_FN *db2secRemapUserid)
                           ( char        userid[DB2SEC_MAX_USERID_LENGTH], 
                             db2int32   *useridlen,
                             char        usernamespace[DB2SEC_MAX_USERNAMESPACE_LENGTH],
                             db2int32   *usernamespacelen,
                             db2int32   *usernamespacetype,
                             char        password[DB2SEC_MAX_PASSWORD_LENGTH],
                             db2int32   *passwordlen,
                             char        newpasswd[DB2SEC_MAX_PASSWORD_LENGTH],
                             db2int32   *newpasswdlen,
                             const char *dbname,
                             db2int32    dbnamelen,
                             char      **errormsg,
                             db2int32   *errormsglen);
/**********************************************************************
** db2secGetDefaultLoginContext API
** Determines the user associated with the default login context, in
** other words, determines the DB2 authid of the user invoking a DB2
** command without explicitly specifying a user ID (either an implicit
** authentication to a database, or a local authorization). This API 
** must return both an authid and a user ID. 
**
** db2secGetDefaultLoginContext API parameters
**
** authid
** Output. 
** The parameter in which the authid should be returned. The returned
** value must conform to DB2 authid naming rules, or the user will not
** be authorized to perform the requested action. 
** 
** authidlen
** Output. 
** Length in bytes of the authid parameter value. 
**
** userid
** Output.
** The parameter in which the user ID associated with the default login
** context should be returned.
**
** useridlen
** Output. 
** Length in bytes of the userid parameter value. 
**
** useridtype
** Input. 
** Specifies if DB2 wants the real or effective user ID of the
** process. On Windows, only real user ID exists. On Linux and UNIX,
** real user ID and effective user ID maybe different. When a user 
** called UserA issues the 'su' command to UserB on a UNIX machine,
** then the real user ID is UserA and the effective user ID is UserB.
** Valid values for the userid parameter (defined in db2secPlugin.h) 
** are:
** - DB2SEC_PLUGIN_REAL_USER_NAME
** Indicates that DB2 wants the real user ID
** - DB2SEC_PLUGIN_EFFECTIVE_USER_NAME
** Indicates that DB2 wants the effective user ID.
** 
** usernamespace
** Output. 
** The namespace of the user ID. 
**
** usernamespacelen
** Output. 
** Length in bytes of the usernamespace parameter value. Under
** the limitation that the usernamespacetype parameter must be set to
** the value DB2SEC_NAMESPACE_SAM_COMPATIBLE (defined in 
** db2secPlugin.h), the maximum length currently supported is 15 bytes.
**
** usernamespacetype
** Output.
** Namespacetype value. In the current version of DB2, the only
** supported namespace type is DB2SEC_NAMESPACE_SAM_COMPATIBLE
** (corresponds to a username style like domain\myname). 
**
** dbname
** Input. 
** Contains the name of the database being connected to, if this
** call is being used in the context of a database connection. For
** local authorization actions or instance attachments, this parameter
** is set to NULL.
** 
** dbnamelen
** Input.
** Length in bytes of the dbname parameter value. 
**
** token
** Output.
** This is a pointer to data allocated by the plug-in that it
** might pass to subsequent authentication calls in the plug-in,
** or possibly to the group retrieval plug-in. The structure of this
** data is determined by the plug-in writer. 
** 
** errormsg
** Output.
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the 
** db2secGetDefaultLoginContext API execution is not successful. 
**
** errormsglen
** Output.
** A pointer to an integer that indicates the length in bytes 
** of the error message string in errormsg parameter. 
***********************************************************************/
     SQL_API_RC ( SQL_API_FN *db2secGetDefaultLoginContext)
                           ( char       authid[DB2SEC_MAX_AUTHID_LENGTH],
                             db2int32  *authidlen,
                             char       userid[DB2SEC_MAX_USERID_LENGTH],
                             db2int32  *useridlen,
                             db2int32   useridtype,
                             char       usernamespace[DB2SEC_MAX_USERNAMESPACE_LENGTH],
                             db2int32  *usernamespacelen,
                             db2int32  *usernamespacetype,
                             const char *dbname,
                             db2int32   dbnamelen,
                             void     **token,
                             char     **errormsg,
                             db2int32  *errormsglen );
/**********************************************************************
** db2secValidatePassword API
** Provides a method for performing user ID and password style 
** authentication during a database connect operation.
**
** Note: 
** When the API is run on the client side, the API code is run with the
** privileges of the user executing the CONNECT statement. This API 
** will only be called on the client side if the authentication
** configuration parameter is set to CLIENT.
** 
** When the API is run on the server side, the API code is run with the
** privileges of the instance owner.
** 
** The plug-in writer should take the above into consideration if
** authentication requires special privileges (such as root level 
** system access on UNIX). 
**
** This API must be able to return the value DB2SEC_PLUGIN_OK (success)
** if the password is valid, or an error code such as 
** DB2SEC_PLUGIN_BADPWD if the password is invalid. 
**
** 
**
** db2secValidatePassword API parameters
** 
** userid
** Input.
** The user ID whose password is to be verified.
**
** useridlen
** Input.
** Length in bytes of the userid parameter value. 
** 
** usernamespace
** Input.
** The namespace from which the user ID was obtained.
**
** usernamespacelen
** Input.
** Length in bytes of the usernamespace parameter value. 
**
** usernamespacetype
** Input.
** The type of namespace. Valid values for the usernamespacetype
** parameter (defined in db2secPlugin.h) are: 
** - DB2SEC_NAMESPACE_SAM_COMPATIBLE
** Corresponds to a username style like domain\myname
** - DB2SEC_NAMESPACE_USER_PRINCIPAL 
** Corresponds to a username style like myname@domain.ibm.com
** Currently DB2 only supports the value
** DB2SEC_NAMESPACE_SAM_COMPATIBLE. When the user ID is not available,
** the usernamespacetype parameter is set to the value 
** DB2SEC_USER_NAMESPACE_UNDEFINED (defined in db2secPlugin.h).
**
** password
** Input.
** The password to be verified. This is decrypted by DB2
** before being passed in. 
** 
** passwordlen
** Input.
** Length in bytes of the password parameter value. 
**
** newpasswd
** Input.
** A new password, if the password is to be changed. If no
** change is requested, this parameter is set to NULL. If this 
** parameter is not NULL, the API should validate the old password 
** before changing it to the new password. The API does not have to 
** fulfill a request to change the password, but if it does not, it
** should immediately return with the return value 
** DB2SEC_PLUGIN_CHANGEPASSWORD_NOTSUPPORTED without validating the old
** password.
** 
** newpasswdlen
** Input.
** Length in bytes of the newpasswd parameter value.
** 
** dbname
** Input.
** The name of the database being connected to. The API is
** free to ignore the dbname parameter, or it can return the value
** DB2SEC_PLUGIN_CONNECTIONREFUSED if it has a policy of restricting
** access to certain databases to users who otherwise have valid
** passwords.
** 
** dbnamelen
** Input.
** Length in bytes of the dbname parameter value.
**
** connection_details 
** Input.
** A 32-bit parameter of which 3 bits are currently used to
** store the following information: 
**
** - The right-most bit indicates whether the source of the user ID is
** the default from the db2secGetDefaultLoginContext API, or was 
** explicitly provided during the connect. 
**
** - The second-from-right bit indicates whether the connection is
** local (using Inter Process Communication (IPC) or a connect from one
** of the nodes in the db2nodes.cfg in the partitioned database 
** environment), or remote (through a network or loopback). This gives
** the API the ability to decide whether clients on the same machine
** can connect to the DB2 server without a password. Currently, DB2 
** always allows local connections without a password from clients on
** the same machine (assuming the client has connect privileges). 
** 
** - The third-from-right bit indicates whether DB2 is calling the 
** API from the server side or client side.
**
** The bit values are defined in db2secPlugin.h:
** - DB2SEC_USERID_FROM_OS (0x00000001)
** Indicates that the user ID is obtained from OS and not explicitly 
** given on the connect statement.
** - DB2SEC_CONNECTION_ISLOCAL (0x00000002) 
** Indicates a local connection.
** - DB2SEC_VALIDATING_ON_SERVER_SIDE (0x0000004)
** Indicates whether DB2 is calling from the server side or client side
** to validate password. If this bit value is set, then DB2 is calling
** from server side, otherwise it is calling from the client side.
**
** DB2's default behavior for an implicit authentication is to allow
** the connection without any password validation. However, plug-in
** developers have the option to disallow implicit authentication
** by returning a DB2SEC_PLUGIN_BADPASSWORD error. 
**
** token
** Input.
** A pointer to data which can be passed as a parameter to 
** subsequent API calls during the current connection. Possible APIs 
** that might be called include db2secGetAuthIDs API and 
** db2secGetGroupsForUser API.
**
** errormsg
** Output.
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the 
** db2secValidatePassword API execution is not successful.
**
** errormsglen
** Output.
** A pointer to an integer that indicates the length in bytes
** of the error message string in errormsg parameter. 
***********************************************************************/
     SQL_API_RC ( SQL_API_FN *db2secValidatePassword) 
                           ( const char *userid,
                             db2int32    useridlen,
                             const char *usernamespace,
                             db2int32    usernamespacelen,
                             db2int32    usernamespacetype,
                             const char *password,
                             db2int32    passwordlen,
                             const char *newpasswd,
                             db2int32    newpasswdlen,
                             const char *dbname,
                             db2int32    dbnamelen,
                             db2Uint32   connection_details,
                             void      **token,
                             char      **errormsg,
                             db2int32   *errormsglen);
/**********************************************************************
** db2secFreeToken API
** Frees the memory held by token. This API is called by DB2 when it no
** longer needs the memory held by the token parameter.  
** 
** db2secFreeToken API parameters
** 
** token
** Input.
** Pointer to the memory to be freed.
**
** errormsg
** Output.
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the 
** db2secFreeToken API execution is not successful.
**
** errormsglen
** Output.
** A pointer to an integer that indicates the length in bytes 
** of the error message string in errormsg parameter.
***********************************************************************/
     SQL_API_RC ( SQL_API_FN *db2secFreeToken) 
                           ( void       *token,
                             char      **errormsg,
                             db2int32   *errormsglen );
/**********************************************************************
** db2secFreeErrormsg API
** Frees the memory used to hold an error message from a previous API
** call. This is the only API that does not return an error message. 
** If this API returns an error, DB2 will log it and continue. 
**
** db2secFreeErrormsg API parameters
**
** msgtofree
** Input.
** A pointer to the error message allocated from a previous API
** call.  
***********************************************************************/
     SQL_API_RC ( SQL_API_FN *db2secFreeErrormsg) 
                           ( char *errormsg );

/**********************************************************************
** db2secClientAuthPluginTerm API
** Frees resources used by the client authentication plug-in. This API
** is called by DB2 just before it unloads the client authentication
** plug-in. It should be implemented in a manner that it does a proper
** cleanup of any resources the plug-in library holds, for instance, 
** free any memory allocated by the plug-in, close files that are still
** open, and close network connections. The plug-in is responsible for 
** keeping track of these resources in order to free them. This API is
** not called on any Windows platform. For further information, please
** refer to the topic "Restrictions on security plug-ins".
**
** db2secClientAuthPluginTerm API parameters
**
** errormsg
** Output.
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the 
** db2secClientAuthPluginTerm API execution is not successful.
** 
** errormsglen
** Output.
** A pointer to an integer that indicates the length in bytes 
** of the error message string in errormsg parameter.
***********************************************************************/
     SQL_API_RC ( SQL_API_FN *db2secClientAuthPluginTerm) 
                           ( char     **errormsg,
                             db2int32  *errormsglen );

} db2secUseridPasswordClientAuthFunctions_1;

/**********************************************************************
** Client GSSAPI plugin function pointer structure to be
** returned during init
***********************************************************************/
typedef struct gssapi_client_auth_functions_1
{
     db2int32 version;
     db2int32 plugintype;
/**********************************************************************
** db2secGetDefaultLoginContext API
** Determines the user associated with the default login context, in
** other words, determines the DB2 authid of the user invoking a DB2
** command without explicitly specifying a user ID (either an implicit
** authentication to a database, or a local authorization). This API 
** must return both an authid and a user ID. 
**
** db2secGetDefaultLoginContext API parameters
**
** authid
** Output.
** The parameter in which the authid should be returned. The returned
** value must conform to DB2 authid naming rules, or the user will not
** be authorized to perform the requested action. 
** 
** authidlen
** Output.
** Length in bytes of the authid parameter value. 
**
** userid
** Output.
** The parameter in which the user ID associated with the 
** default login context should be returned.
**
** useridlen
** Output.
** Length in bytes of the userid parameter value. 
**
** useridtype
** Input.
** Specifies if DB2 wants the real or effective user ID of the
** process. On Windows, only real user ID exists. On Linux and UNIX,
** real user ID and effective user ID maybe different. When a user 
** called UserA issues the 'su' command to UserB on a UNIX machine,
** then the real user ID is UserA and the effective user ID is UserB.
** Valid values for the userid parameter (defined in db2secPlugin.h) 
** are:
** - DB2SEC_PLUGIN_REAL_USER_NAME
** Indicates that DB2 wants the real user ID
** - DB2SEC_PLUGIN_EFFECTIVE_USER_NAME
** Indicates that DB2 wants the effective user ID.
** 
** usernamespace
** Output.
** The namespace of the user ID. 
**
** usernamespacelen
** Output.
** Length in bytes of the usernamespace parameter value. Under
** the limitation that the usernamespacetype parameter must be set to
** the value DB2SEC_NAMESPACE_SAM_COMPATIBLE (defined in 
** db2secPlugin.h), the maximum length currently supported is 15 bytes.
**
** usernamespacetype
** Output.
** Namespacetype value. In the current version of DB2, the only
** supported namespace type is DB2SEC_NAMESPACE_SAM_COMPATIBLE
** (corresponds to a username style like domain\myname). 
**
** dbname
** Input.
** Contains the name of the database being connected to, if this
** call is being used in the context of a database connection. For
** local authorization actions or instance attachments, this parameter
** is set to NULL.
** 
** dbnamelen
** Input.
** Length in bytes of the dbname parameter value. 
**
** token
** Output.
** This is a pointer to data allocated by the plug-in that it
** might pass to subsequent authentication calls in the plug-in,
** or possibly to the group retrieval plug-in. The structure of this
** data is determined by the plug-in writer. 
** 
** errormsg
** Output.
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the 
** db2secGetDefaultLoginContext API execution is not successful. 
**
** errormsglen
** Output.
** A pointer to an integer that indicates the length in bytes 
** of the error message string in errormsg parameter. 
***********************************************************************/
     SQL_API_RC ( SQL_API_FN *db2secGetDefaultLoginContext) 
                           ( char        authid[DB2SEC_MAX_AUTHID_LENGTH],
                             db2int32   *authidlen,
                             char        userid[DB2SEC_MAX_USERID_LENGTH],
                             db2int32   *useridlen,
                             db2int32    useridtype,
                             char        usernamespace[DB2SEC_MAX_USERNAMESPACE_LENGTH],
                             db2int32   *usernamespacelen,
                             db2int32   *usernamespacetype,
                             const char *dbname,
                             db2int32    dbnamelen,
                             void      **token,
                             char      **errormsg,
                             db2int32   *errormsglen );

/**********************************************************************
** db2secGenerateInitialCred API
** Obtains the initial GSS-API credentials based on the user ID and 
** password that are passed in. For Kerberos, this will be the 
** ticket-granting ticket (TGT). The credential handle that is returned
** in pGSSCredHandle parameter is the handle that is used with the
** gss_init_sec_context API and must be either an INITIATE or BOTH 
** credential. The db2secGenerateInitialCred API is only called
** when a user ID, and possibly a password are supplied. Otherwise, DB2
** will specify the value GSS_C_NO_CREDENTIAL when calling the
** gss_init_sec_context API to signify that the default credential
** obtained from the current login context is to be used. 
**
** db2secGenerateInitialCred API parameters
**
** userid
** Input.
** The user ID whose password is to be verified.
** 
** useridlen
** Input.
** Length in bytes of the userid parameter value. 
**
** usernamespace
** Input.
** The namespace from which the user ID was obtained. 
** 
** usernamespacelen
** Input.
** Length in bytes of the usernamespace parameter value. 
**
** usernamespacetype
** Input.
** The type of namespace. 
**
** password
** Input.
** The password to be verified. This is decrypted by DB2 before
** being passed to the API.
** 
** passwordlen
** Input.
** Length in bytes of the password parameter value.
**
** newpassword
** Input.
** A new password if the password is to be changed. If no change
** is requested, the newpassword parameter is set to NULL. If it is not
** NULL, the API should validate the old password before setting the
** password to its new value. The API does not have to honour a request
** to change the password, but if it does not, it should immediately 
** return with the return value 
** DB2SEC_PLUGIN_CHANGEPASSWORD_NOTSUPPORTED without validating the old
** password.
**
** newpasswordlen
** Input.
** Length in bytes of the newpassword parameter value.
**
** dbname
** Input.
** The name of the database being connected to. The API is
** free to ignore this parameter, or the API can return the value
** DB2SEC_PLUGIN_CONNECTION_DISALLOWED if it has a policy of
** restricting access to certain databases to users who otherwise have
** valid passwords.
** 
** dbnamelen
** Input.
** Length in bytes of the dbname parameter value. 
**
** pGSSCredHandle
** Output.
** Pointer to the GSS-API credential handle.
**
** InitInfo
** Output.
** A pointer to data that is not known to DB2. The plug-in can
** use this memory to maintain a list of resources that are allocated
** in the process of generating the credential handle. DB2 will call
** the db2secFreeInitInfo API at the end of the authentication process,
** at which point these resources are freed. If the
** db2secGenerateInitialCred API does not need to maintain such a list,
** then it should return NULL.
**
** errormsg
** Output.
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the 
** db2secGenerateInitialCred API execution is not successful. 
** Note:
** For this API, error messages should not be created if the return
** value indicates a bad user ID or password. An error message should
** only be returned if there is an internal error in the API that
** prevented it from completing properly. 
**
** errormsglen
** Output.
** A pointer to an integer that indicates the length in bytes 
** of the error message string in errormsg parameter. 
***********************************************************************/
     SQL_API_RC ( SQL_API_FN *db2secGenerateInitialCred)
                           ( const char     *userid,
                             db2int32        useridlen,
                             const char     *usernamespace,
                             db2int32        usernamespacelen,
                             db2int32        usernamespacetype,
                             const char     *password,
                             db2int32        passwordlen,
                             const char     *newpassword,
                             db2int32        newpasswordlen,
                             const char     *dbname,
                             db2int32        dbnamelen,
                             gss_cred_id_t  *pGSSCredHandle,
                             void          **InitInfo,
                             char          **errormsg,
                             db2int32       *errormsglen );
/**********************************************************************
** db2secProcessServerPrincipalName API
** Processes the service principal name returned from the server and
** returns the principal name in the gss_name_t internal format to be
** used with the gss_init_sec_context API. The 
** db2secProcessServerPrincipalName API also processes the service 
** principal name cataloged with the database directory when Kerberos
** authentication is used. Ordinarily, this conversion uses the 
** gss_import_name API. After the context is established, the 
** gss_name_t object is freed through the call to gss_release_name API.
** The db2secProcessServerPrincipalName API returns the value
** DB2SEC_PLUGIN_OK if gssName parameter points to a valid GSS name; a
** DB2SEC_PLUGIN_BAD_PRINCIPAL_NAME error code is returned if the
** principal name is invalid. 
** 
** db2secProcessServerPrincipalName API parameters
**
** name
** Input.
** Text name of the service principal in GSS_C_NT_USER_NAME
** format, e.g., service/host@REALM. 
** 
** namelen
** Input.
** Length in bytes of the name parameter value.
**
** gssName
** Output.
** Pointer to the output service principal name in the GSS-API
** internal format.
**
** errormsg
** Output.
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the 
** db2secProcessServerPrincipalName API execution is not successful. 
** 
** errormsglen
** Output.
** A pointer to an integer that indicates the length in bytes 
** of the error message string in errormsg parameter.
***********************************************************************/
     SQL_API_RC ( SQL_API_FN *db2secProcessServerPrincipalName)
                           ( const char  *name,
                             db2int32     namelen,
                             gss_name_t  *gssName,
                             char       **errormsg,
                             db2int32    *errormsglen );
/**********************************************************************
** db2secFreeToken API
** Frees the memory held by token. This API is called by DB2 when it no
** longer needs the memory held by the token parameter.  
** 
** db2secFreeToken API parameters
** 
** token
** Input.
** Pointer to the memory to be freed.
**
** errormsg
** Output.
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the 
** db2secFreeToken API execution is not successful.
**
** errormsglen
** Output.
** A pointer to an integer that indicates the length in bytes 
** of the error message string in errormsg parameter.
***********************************************************************/
     SQL_API_RC ( SQL_API_FN *db2secFreeToken) 
                           ( void        *token,
                             char       **errormsg,
                             db2int32    *errormsglen );
/**********************************************************************
** db2secFreeErrormsg API
** Frees the memory used to hold an error message from a previous API
** call. This is the only API that does not return an error message. 
** If this API returns an error, DB2 will log it and continue. 
**
** db2secFreeErrormsg API parameters
**
** msgtofree
** Input.
** A pointer to the error message allocated from a previous API
** call. 
***********************************************************************/
     SQL_API_RC ( SQL_API_FN *db2secFreeErrormsg)
                           ( char *errormsg );

/**********************************************************************
** db2secFreeInitInfo API
** Frees any resources allocated by the db2secGenerateInitialCred API. 
** This can include, for example, handles to underlying mechanism 
** contexts or a credential cache created for the GSS-API credential
** cache. 
**
** db2secFreeInitInfo API parameters
**
** initinfo
** Input.
** A pointer to data that is not known to DB2. The plug-in can
** use this memory to maintain a list of resources that are allocated
** in the process of generating the credential handle. These resources
** are freed by calling this API.
** 
** errormsg
** Output.
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the 
** db2secFreeInitInfo API execution is not successful. 
**
** errormsglen
** Output.
** A pointer to an integer that indicates the length of the
** error message string in errormsg parameter. 
***********************************************************************/
     SQL_API_RC ( SQL_API_FN *db2secFreeInitInfo)
                           ( void      *initinfo,
                             char     **errormsg,
                             db2int32  *errormsglen);
/**********************************************************************
** db2secClientAuthPluginTerm API
** Frees resources used by the client authentication plug-in. This API
** is called by DB2 just before it unloads the client authentication
** plug-in. It should be implemented in a manner that it does a proper
** cleanup of any resources the plug-in library holds, for instance, 
** free any memory allocated by the plug-in, close files that are still
** open, and close network connections. The plug-in is responsible for 
** keeping track of these resources in order to free them. This API is
** not called on any Windows platform. For further information, please
** refer to the topic "Restrictions on security plug-ins".
**
** db2secClientAuthPluginTerm API parameters
**
** errormsg
** Output.
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the 
** db2secClientAuthPluginTerm API execution is not successful.
** 
** errormsglen
** Output.
** A pointer to an integer that indicates the length in bytes 
** of the error message string in errormsg parameter. 
***********************************************************************/
     SQL_API_RC ( SQL_API_FN *db2secClientAuthPluginTerm) 
                           ( char     **errormsg,
                             db2int32  *errormsglen);

/**********************************************************************
** GSS-API plugin functions
***********************************************************************/
     OM_uint32 (SQL_API_FN *gss_init_sec_context)
                           ( OM_uint32 * minor_status,
                             const gss_cred_id_t cred_handle,
                             gss_ctx_id_t * context_handle,
                             const gss_name_t target_name,
                             const gss_OID mech_type,
                             OM_uint32 req_flags,
                             OM_uint32 time_req,
                             const gss_channel_bindings_t input_chan_bindings,
                             const gss_buffer_t input_token,
                             gss_OID * actual_mech_type,
                             gss_buffer_t output_token,
                             OM_uint32 * ret_flags,
                             OM_uint32 * time_rec );

     OM_uint32 (SQL_API_FN *gss_delete_sec_context)
                           ( OM_uint32 * minor_status,
                             gss_ctx_id_t * context_handle,
                             gss_buffer_t output_token );

     OM_uint32 (SQL_API_FN *gss_display_status)
                            ( OM_uint32 * minor_status,
                              OM_uint32 status_value,
                              int status_type,
                              const gss_OID mech_type,
                              OM_uint32 * message_context,
                              gss_buffer_t status_string );

     OM_uint32 (SQL_API_FN *gss_release_buffer)
                            ( OM_uint32 * minor_status,
                              gss_buffer_t buffer );

     OM_uint32 (SQL_API_FN *gss_release_cred)
                            ( OM_uint32 * minor_status,
                              gss_cred_id_t * cred_handle );

     OM_uint32 (SQL_API_FN *gss_release_name)
                            ( OM_uint32 * minor_status,
                              gss_name_t * name );
  
} db2secGssapiClientAuthFunctions_1;

/* Server userid-password plugin function pointer structure to be */
/* returned during init */
typedef struct userid_password_server_auth_functions_1
{
     db2int32 version;
     db2int32 plugintype;
     
/**********************************************************************
** db2secValidatePassword API
** Provides a method for performing user ID and password style 
** authentication during a database connect operation.
**
** Note: 
** When the API is run on the client side, the API code is run with the
** privileges of the user executing the CONNECT statement. This API 
** will only be called on the client side if the authentication
** configuration parameter is set to CLIENT.
** 
** When the API is run on the server side, the API code is run with the
** privileges of the instance owner.
** 
** The plug-in writer should take the above into consideration if
** authentication requires special privileges (such as root level 
** system access on UNIX). 
**
** This API must be able to return the value DB2SEC_PLUGIN_OK (success)
** if the password is valid, or an error code such as 
** DB2SEC_PLUGIN_BADPWD if the password is invalid. 
** 
** db2secValidatePassword API parameters
** 
** userid
** Input.
** The user ID whose password is to be verified.
**
** useridlen
** Input.
** Length in bytes of the userid parameter value. 
** 
** usernamespace
** Input.
** The namespace from which the user ID was obtained.
**
** usernamespacelen
** Input.
** Length in bytes of the usernamespace parameter value. 
**
** usernamespacetype
** Input.
** The type of namespace. Valid values for the usernamespacetype
** parameter (defined in db2secPlugin.h) are: 
** - DB2SEC_NAMESPACE_SAM_COMPATIBLE
** Corresponds to a username style like domain\myname
** - DB2SEC_NAMESPACE_USER_PRINCIPAL 
** Corresponds to a username style like myname@domain.ibm.com
** Currently DB2 only supports the value
** DB2SEC_NAMESPACE_SAM_COMPATIBLE. When the user ID is not available,
** the usernamespacetype parameter is set to the value 
** DB2SEC_USER_NAMESPACE_UNDEFINED (defined in db2secPlugin.h).
**
** password
** Input.
** The password to be verified. This is decrypted by DB2
** before being passed in. 
** 
** passwordlen
** Input.
** Length in bytes of the password parameter value. 
**
** newpasswd
** Input.
** A new password, if the password is to be changed. If no
** change is requested, this parameter is set to NULL. If this 
** parameter is not NULL, the API should validate the old password 
** before changing it to the new password. The API does not have to 
** fulfill a request to change the password, but if it does not, it
** should immediately return with the return value 
** DB2SEC_PLUGIN_CHANGEPASSWORD_NOTSUPPORTED without validating the old
** password.
** 
** newpasswdlen
** Input.
** Length in bytes of the newpasswd parameter value.
** 
** dbname
** Input.
** The name of the database being connected to. The API is
** free to ignore the dbname parameter, or it can return the value
** DB2SEC_PLUGIN_CONNECTIONREFUSED if it has a policy of restricting
** access to certain databases to users who otherwise have valid
** passwords.
** 
** dbnamelen
** Input.
** Length in bytes of the dbname parameter value.
**
** connection_details 
** Input.
** A 32-bit parameter of which 3 bits are currently used to
** store the following information: 
**
** - The right-most bit indicates whether the source of the user ID is
** the default from the db2secGetDefaultLoginContext API, or was 
** explicitly provided during the connect. 
**
** - The second-from-right bit indicates whether the connection is
** local (using Inter Process Communication (IPC) or a connect from one
** of the nodes in the db2nodes.cfg in the partitioned database 
** environment), or remote (through a network or loopback). This gives
** the API the ability to decide whether clients on the same machine
** can connect to the DB2 server without a password. Currently, DB2 
** always allows local connections without a password from clients on
** the same machine (assuming the client has connect privileges). 
** 
** - The third-from-right bit indicates whether DB2 is calling the 
** API from the server side or client side.
**
** The bit values are defined in db2secPlugin.h:
** - DB2SEC_USERID_FROM_OS (0x00000001)
** Indicates that the user ID is obtained from OS and not explicitly 
** given on the connect statement.
** - DB2SEC_CONNECTION_ISLOCAL (0x00000002) 
** Indicates a local connection.
** - DB2SEC_VALIDATING_ON_SERVER_SIDE (0x0000004)
** Indicates whether DB2 is calling from the server side or client side
** to validate password. If this bit value is set, then DB2 is calling
** from server side, otherwise it is calling from the client side.
**
** DB2's default behavior for an implicit authentication is to allow
** the connection without any password validation. However, plug-in
** developers have the option to disallow implicit authentication
** by returning a DB2SEC_PLUGIN_BADPASSWORD error. 
**
** token
** Input.
** A pointer to data which can be passed as a parameter to 
** subsequent API calls during the current connection. Possible APIs 
** that might be called include db2secGetAuthIDs API and 
** db2secGetGroupsForUser API.
**
** errormsg
** Output.
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the 
** db2secValidatePassword API execution is not successful.
**
** errormsglen
** Output.
** A pointer to an integer that indicates the length in bytes
** of the error message string in errormsg parameter. 
***********************************************************************/     
     SQL_API_RC ( SQL_API_FN *db2secValidatePassword) 
                           ( const char *userid,
                             db2int32    useridlen,
                             const char *usernamespace,
                             db2int32    usernamespacelen,
                             db2int32    usernamespacetype,
                             const char *password,
                             db2int32    passwordlen,
                             const char *newpasswd,
                             db2int32    newpasswdlen,
                             const char *dbname,
                             db2int32    dbnamelen,
                             db2Uint32   connection_details,
                             void      **token,
                             char      **errormsg,
                             db2int32   *errormsglen );
/**********************************************************************
** db2secGetAuthIDs API
** Returns an SQL authid for an authenticated user. This API is called
** during database connections for both user ID/password and GSS-API
** authentication methods. 
**
** db2secGetAuthIDs API parameters
**
** userid
** Input.
** The authenticated user. This is blank for GSS-API
** authentication method.
**
** useridlen
** Input.
** Length in bytes of the userid parameter value. 
**
** usernamespace
** Input.
** The namespace from which the user ID was obtained. 
**
** usernamespacelen
** Input.
** Length in bytes of the usernamespace parameter value.
**
** usernamespacetype
** Input.
** Namespacetype value. In the current version of DB2, the only
** supported namespace type value is DB2SEC_NAMESPACE_SAM_COMPATIBLE
** (corresponds to a username style like domain\myname).
**
** dbname
** Input.
** The name of the database being connected to. The API can
** ignore this, or it can return differing authids when the same user
** connects to different databases. 
**
** dbnamelen
** Input.
** Length in bytes of the dbname parameter value.
**
** token
** Input or output.
** Data that the plug-in might pass to the
** db2secGetGroupsForUser API. For GSS-API, this is a context handle
** (gss_ctx_id_t). Ordinarily, token is an input-only parameter and its
** value is taken from the db2secValidatePassword API. It can also be
** an output parameter when authentication is done on the client and
** therefore db2secValidatePassword API is not called. 
**
** SystemAuthID
** Output.
** The system authid that corresponds to the ID of the 
** authenticated user. The size is 255 bytes, but DB2 currently uses 
** only up to (and including) 30 bytes.
**
** SystemAuthIDlen
** Output.
** Length in bytes of the SystemAuthID parameter value.
**
** InitialSessionAuthID
** Output.
** Authid used for this connection session. This
** is usually the same as the SystemAuthID parameter but can be 
** different in some situations, for instance, when issuing a SET
** SESSION AUTHORIZATION statement. The size is 255 bytes, but DB2
** currently uses only up to (and including) 30 bytes. 
**
** InitialSessionAuthIDlen
** Output.
** Length in bytes of the InitialSessionAuthID parameter value.
**
** username
** Output.
** A username corresponding to the authenticated user and
** authid. This will only be used for auditing and will be logged in
** the "User ID" field in the audit record for CONNECT statement. If 
** the API does not fill in the username parameter, DB2 copies it
** from the userid. 
** 
** usernamelen
** Output.
** Length in bytes of the username parameter value.
**
** initsessionidtype
** Output.
** Session authid type indicating whether or not the
** InitialSessionAuthid parameter is a role or an authid. The API 
** should return one of the following values (defined in
** db2secPlugin.h): 
** - DB2SEC_ID_TYPE_AUTHID (0) 
** - DB2SEC_ID_TYPE_ROLE (1). 
** Currently, DB2 only supports authid (DB2SEC_ID_TYPE_AUTHID). 
**
** errormsg
** Output.
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the 
** db2secGetAuthIDs API execution is not successful. 
** 
** errormsglen
** Output.
** A pointer to an integer that indicates the length of the
** error message string in errormsg parameter. 
***********************************************************************/ 
     SQL_API_RC ( SQL_API_FN *db2secGetAuthIDs)
                           ( const char *userid,
                             db2int32    useridlen,
                             const char *usernamespace,
                             db2int32    usernamespacelen,
                             db2int32    usernamespacetype,
                             const char *dbname,
                             db2int32    dbnamelen,
                             void      **token,
                             char        SystemAuthID[DB2SEC_MAX_AUTHID_LENGTH],
                             db2int32   *SystemAuthIDlen,
                             char        InitialSessionAuthID[DB2SEC_MAX_AUTHID_LENGTH],
                             db2int32   *InitialSessionAuthIDlen,
                             char        username[DB2SEC_MAX_USERID_LENGTH],
                             db2int32   *usernamelen,
                             db2int32   *initsessionidtype,
                             char      **errormsg,
                             db2int32   *errormsglen );
/**********************************************************************
** db2secDoesAuthIDExist API
** Determines if the authid represents an individual user (for 
** instance, whether the API can map the authid to an external user 
** id). The API should return the value DB2SEC_PLUGIN_OK if it is
** successful - the authid is valid, DB2SEC_PLUGIN_INVALID_USERORGROUP
** if it is not valid, or DB2SEC_PLUGIN_USERSTATUSNOTKNOWN if the 
** authid existence cannot be determined.
**
** db2secDoesAuthIDExist API parameters
**
** authid
** Input.
** The authid to validate. This is upper-cased, with no 
** trailing blanks.
**
** authidlen
** Input.
** Length in bytes of the authid parameter value. 
**
** errormsg
** Output.
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the 
** db2secDoesAuthIDExist API execution is not successful.
**
** errormsglen
** Output.
** A pointer to an integer that indicates the length of the 
** error message string in errormsg parameter.
***********************************************************************/ 
     SQL_API_RC ( SQL_API_FN *db2secDoesAuthIDExist) 
                           ( const char *authid,
                             db2int32    authidlen,
                             char      **errormsg,
                             db2int32   *errormsglen);
/**********************************************************************
** db2secFreeToken API
** Frees the memory held by token. This API is called by DB2 when it no
** longer needs the memory held by the token parameter.  
** 
** db2secFreeToken API parameters
** 
** token
** Input.
** Pointer to the memory to be freed.
**
** errormsg
** Output.
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the 
** db2secFreeToken API execution is not successful.
**
** errormsglen
** Output.
** A pointer to an integer that indicates the length in bytes 
** of the error message string in errormsg parameter.
***********************************************************************/
     SQL_API_RC ( SQL_API_FN *db2secFreeToken) 
                           ( void        *token,
                             char       **errormsg,
                             db2int32    *errormsglen );
/**********************************************************************
** db2secFreeErrormsg API
** Frees the memory used to hold an error message from a previous API
** call. This is the only API that does not return an error message. 
** If this API returns an error, DB2 will log it and continue. 
**
** db2secFreeErrormsg API parameters
**
** msgtofree
** Input.
** A pointer to the error message allocated from a previous API
** call. 
***********************************************************************/ 
     SQL_API_RC ( SQL_API_FN *db2secFreeErrormsg) 
                           ( char *errormsg );

/**********************************************************************
** db2secServerAuthPluginTerm API
** Frees resources used by the server authentication plug-in. This API
** is called by DB2 just before it unloads the server authentication 
** plug-in. It should be implemented in a manner that it does a proper
** cleanup of any resources the plug-in library holds, for instance,
** free any memory allocated by the plug-in, close files that are still
** open, and close network connections. The plug-in is responsible for
** keeping track of these resources in order to free them. This API is
** not called on any Windows platform. For further information, please
** refer to the topic "Restrictions on security plug-ins".
**
** db2secServerAuthPluginTerm API parameters
**
** errormsg
** Output.
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the 
** db2secServerAuthPluginTerm API execution is not successful.
**
** errormsglen
** Output.
** A pointer to an integer that indicates the length of the
** error message string in errormsg parameter.  
***********************************************************************/  
     SQL_API_RC ( SQL_API_FN *db2secServerAuthPluginTerm) 
                           ( char     **errormsg,
                             db2int32  *errormsglen );

} db2secUseridPasswordServerAuthFunctions_1;

/**********************************************************************
** Server GSSAPI plugin function pointer structure to be 
** returned during init
***********************************************************************/ 
typedef struct gssapi_server_auth_functions_1
{
     db2int32 version;
     db2int32 plugintype;
     gss_buffer_desc serverPrincipalName;
     gss_cred_id_t serverCredHandle;
/**********************************************************************
** db2secGetAuthIDs API
** Returns an SQL authid for an authenticated user. This API is called
** during database connections for both user ID/password and GSS-API
** authentication methods. 
**
** db2secGetAuthIDs API parameters
**
** userid
** Input.
** The authenticated user. This is blank for GSS-API
** authentication method.
**
** useridlen
** Input.
** Length in bytes of the userid parameter value. 
**
** usernamespace
** Input.
** The namespace from which the user ID was obtained. 
**
** usernamespacelen
** Input.
** Length in bytes of the usernamespace parameter value.
**
** usernamespacetype
** Input.
** Namespacetype value. In the current version of DB2, the only
** supported namespace type value is DB2SEC_NAMESPACE_SAM_COMPATIBLE
** (corresponds to a username style like domain\myname).
**
** dbname
** Input.
** The name of the database being connected to. The API can
** ignore this, or it can return differing authids when the same user
** connects to different databases. 
**
** dbnamelen
** Input.
** Length in bytes of the dbname parameter value.
**
** token
** Input or output.
** Data that the plug-in might pass to the
** db2secGetGroupsForUser API. For GSS-API, this is a context handle
** (gss_ctx_id_t). Ordinarily, token is an input-only parameter and its
** value is taken from the db2secValidatePassword API. It can also be
** an output parameter when authentication is done on the client and
** therefore db2secValidatePassword API is not called. 
**
** SystemAuthID
** Output.
** The system authid that corresponds to the ID of the authenticated
** user. The size is 255 bytes, but DB2 currently uses only up to
** (and including) 30 bytes.
**
** SystemAuthIDlen
** Output.
** Length in bytes of the SystemAuthID parameter value.
**
** InitialSessionAuthID
** Output.
** Authid used for this connection session. This is usually the same
** as the SystemAuthID parameter but can be different in some
** situations, for instance, when issuing a SET SESSION AUTHORIZATION
** statement. The size is 255 bytes, but DB2 currently uses only up to
** (and including) 30 bytes. 
**
** InitialSessionAuthIDlen
** Output.
** Length in bytes of the InitialSessionAuthID parameter value.
**
** username
** Output.
** A username corresponding to the authenticated user and authid. This
** will only be used for auditing and will be logged in the "User ID"
** field in the audit record for CONNECT statement. If the API does not
** fill in the username parameter, DB2 copies it from the userid. 
** 
** usernamelen
** Output.
** Length in bytes of the username parameter value.
**
** initsessionidtype
** Output
** Session authid type indicating whether or not the
** InitialSessionAuthid parameter is a role or an authid. The API 
** should return one of the following values (defined in
** db2secPlugin.h): 
** - DB2SEC_ID_TYPE_AUTHID (0) 
** - DB2SEC_ID_TYPE_ROLE (1). 
** Currently, DB2 only supports authid (DB2SEC_ID_TYPE_AUTHID). 
**
** errormsg
** Output.
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the 
** db2secGetAuthIDs API execution is not successful. 
** 
** errormsglen
** Output.
** A pointer to an integer that indicates the length of the
** error message string in errormsg parameter. 
***********************************************************************/ 
     SQL_API_RC ( SQL_API_FN *db2secGetAuthIDs)
                           ( const char *userid,
                             db2int32    useridlen,
                             const char *usernamespace,
                             db2int32    usernamespacelen,
                             db2int32    usernamespacetype,
                             const char *dbname,
                             db2int32    dbnamelen,
                             void      **token,                             
                             char        SystemAuthID[DB2SEC_MAX_AUTHID_LENGTH],
                             db2int32   *SystemAuthIDlen,
                             char        InitialSessionAuthID[DB2SEC_MAX_AUTHID_LENGTH],
                             db2int32   *InitialSessionAuthIDlen,
                             char        username[DB2SEC_MAX_USERID_LENGTH],
                             db2int32   *usernamelen,
                             db2int32   *initsessionidtype,
                             char      **errormsg,
                             db2int32   *errormsglen );
/**********************************************************************
** db2secDoesAuthIDExist API
** Determines if the authid represents an individual user (for 
** instance, whether the API can map the authid to an external user 
** id). The API should return the value DB2SEC_PLUGIN_OK if it is
** successful - the authid is valid, DB2SEC_PLUGIN_INVALID_USERORGROUP
** if it is not valid, or DB2SEC_PLUGIN_USERSTATUSNOTKNOWN if the 
** authid existence cannot be determined.
**
** db2secDoesAuthIDExist API parameters
**
** authid
** Input.
** The authid to validate. This is upper-cased, with no 
** trailing blanks.
**
** authidlen
** Input.
** Length in bytes of the authid parameter value. 
**
** errormsg
** Output.
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the 
** db2secDoesAuthIDExist API execution is not successful.
**
** errormsglen
** Output.
** A pointer to an integer that indicates the length of the 
** error message string in errormsg parameter.
***********************************************************************/ 
     SQL_API_RC ( SQL_API_FN *db2secDoesAuthIDExist) 
                           ( const char  *authid,
                             db2int32     authidlen,
                             char       **errormsg,
                             db2int32    *errormsglen );
/**********************************************************************
** db2secFreeErrormsg API
** Frees the memory used to hold an error message from a previous API
** call. This is the only API that does not return an error message. 
** If this API returns an error, DB2 will log it and continue. 
**
** db2secFreeErrormsg API parameters
**
** msgtofree
** Input.
** A pointer to the error message allocated from a previous API
** call. 
***********************************************************************/
     SQL_API_RC ( SQL_API_FN *db2secFreeErrormsg) 
                           ( char *errormsg );
/**********************************************************************
** db2secServerAuthPluginTerm API
** Frees resources used by the server authentication plug-in. This API
** is called by DB2 just before it unloads the server authentication 
** plug-in. It should be implemented in a manner that it does a proper
** cleanup of any resources the plug-in library holds, for instance,
** free any memory allocated by the plug-in, close files that are still
** open, and close network connections. The plug-in is responsible for
** keeping track of these resources in order to free them. This API is
** not called on any Windows platform. For further information, please
** refer to the topic "Restrictions on security plug-ins".
**
** db2secServerAuthPluginTerm API parameters
**
** errormsg
** Output.
** A pointer to the address of an ASCII error message string allocated
** by the plug-in that can be returned in this parameter if the 
** db2secServerAuthPluginTerm API execution is not successful.
**
** errormsglen
** Output.
** A pointer to an integer that indicates the length of the
** error message string in errormsg parameter. 
***********************************************************************/ 
     SQL_API_RC ( SQL_API_FN *db2secServerAuthPluginTerm) 
                           ( char     **errormsg,
                             db2int32  *errormsglen );
/**********************************************************************
** GSS-API functions
***********************************************************************/ 
     OM_uint32 (SQL_API_FN *gss_accept_sec_context)
                            ( OM_uint32 * minor_status,
                              gss_ctx_id_t * context_handle,
                              const gss_cred_id_t acceptor_cred_handle,
                              const gss_buffer_t input_token,
                              const gss_channel_bindings_t input_chan_bindings,
                              gss_name_t * src_name,
                              gss_OID * mech_type,
                              gss_buffer_t output_token,
                              OM_uint32 * ret_flags,
                              OM_uint32 * time_rec,
                              gss_cred_id_t * delegated_cred_handle );

     OM_uint32 (SQL_API_FN *gss_display_name)
                            ( OM_uint32 * minor_status,
                              const gss_name_t input_name,
                              gss_buffer_t output_name_buffer,
                              gss_OID * output_name_type );

     OM_uint32 (SQL_API_FN *gss_delete_sec_context)
                            ( OM_uint32 * minor_status,
                              gss_ctx_id_t * context_handle,
                              gss_buffer_t output_token );

     OM_uint32 (SQL_API_FN *gss_display_status)
                            ( OM_uint32 * minor_status,
                              OM_uint32 status_value,
                              int status_type,
                              const gss_OID mech_type,
                              OM_uint32 * message_context,
                              gss_buffer_t status_string );

     OM_uint32 (SQL_API_FN *gss_release_buffer)
                            ( OM_uint32 * minor_status,
                              gss_buffer_t buffer );

     OM_uint32 (SQL_API_FN *gss_release_cred)
                            ( OM_uint32 * minor_status,
                              gss_cred_id_t * cred_handle );

     OM_uint32 (SQL_API_FN *gss_release_name)
                            ( OM_uint32 * minor_status,
                              gss_name_t * name );

} db2secGssapiServerAuthFunctions_1;

#ifdef __cplusplus
}
#endif

#endif


