#!/usr/bin/env ruby
require 'defaultDriver.rb'

endpoint_url = ARGV.shift
obj = Default_Binding_ServiceRequest.new(endpoint_url)

# run ruby with -d to see SOAP wiredumps.
obj.wiredump_dev = STDERR if $DEBUG

# SYNOPSIS
#   ServiceRequestUpdate(serviceRequestWS_ServiceRequestUpdate_Input)
#
# ARGS
#   serviceRequestWS_ServiceRequestUpdate_Input ServiceRequestWS_ServiceRequestUpdate_Input - {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestUpdate_Input
#
# RETURNS
#   serviceRequestWS_ServiceRequestUpdate_Output ServiceRequestWS_ServiceRequestUpdate_Output - {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestUpdate_Output
#
serviceRequestWS_ServiceRequestUpdate_Input = nil
puts obj.serviceRequestUpdate(serviceRequestWS_ServiceRequestUpdate_Input)

# SYNOPSIS
#   ServiceRequestInsert(serviceRequestWS_ServiceRequestInsert_Input)
#
# ARGS
#   serviceRequestWS_ServiceRequestInsert_Input ServiceRequestWS_ServiceRequestInsert_Input - {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestInsert_Input
#
# RETURNS
#   serviceRequestWS_ServiceRequestInsert_Output ServiceRequestWS_ServiceRequestInsert_Output - {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestInsert_Output
#
serviceRequestWS_ServiceRequestInsert_Input = nil
puts obj.serviceRequestInsert(serviceRequestWS_ServiceRequestInsert_Input)

# SYNOPSIS
#   ServiceRequestDeleteChild(serviceRequestWS_ServiceRequestDeleteChild_Input)
#
# ARGS
#   serviceRequestWS_ServiceRequestDeleteChild_Input ServiceRequestWS_ServiceRequestDeleteChild_Input - {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestDeleteChild_Input
#
# RETURNS
#   serviceRequestWS_ServiceRequestDeleteChild_Output ServiceRequestWS_ServiceRequestDeleteChild_Output - {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestDeleteChild_Output
#
serviceRequestWS_ServiceRequestDeleteChild_Input = nil
puts obj.serviceRequestDeleteChild(serviceRequestWS_ServiceRequestDeleteChild_Input)

# SYNOPSIS
#   ServiceRequestDelete(serviceRequestWS_ServiceRequestDelete_Input)
#
# ARGS
#   serviceRequestWS_ServiceRequestDelete_Input ServiceRequestWS_ServiceRequestDelete_Input - {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestDelete_Input
#
# RETURNS
#   serviceRequestWS_ServiceRequestDelete_Output ServiceRequestWS_ServiceRequestDelete_Output - {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestDelete_Output
#
serviceRequestWS_ServiceRequestDelete_Input = nil
puts obj.serviceRequestDelete(serviceRequestWS_ServiceRequestDelete_Input)

# SYNOPSIS
#   ServiceRequestUpdateChild(serviceRequestWS_ServiceRequestUpdateChild_Input)
#
# ARGS
#   serviceRequestWS_ServiceRequestUpdateChild_Input ServiceRequestWS_ServiceRequestUpdateChild_Input - {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestUpdateChild_Input
#
# RETURNS
#   serviceRequestWS_ServiceRequestUpdateChild_Output ServiceRequestWS_ServiceRequestUpdateChild_Output - {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestUpdateChild_Output
#
serviceRequestWS_ServiceRequestUpdateChild_Input = nil
puts obj.serviceRequestUpdateChild(serviceRequestWS_ServiceRequestUpdateChild_Input)

# SYNOPSIS
#   ServiceRequestQueryPage(serviceRequestWS_ServiceRequestQueryPage_Input)
#
# ARGS
#   serviceRequestWS_ServiceRequestQueryPage_Input ServiceRequestWS_ServiceRequestQueryPage_Input - {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestQueryPage_Input
#
# RETURNS
#   serviceRequestWS_ServiceRequestQueryPage_Output ServiceRequestWS_ServiceRequestQueryPage_Output - {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestQueryPage_Output
#
serviceRequestWS_ServiceRequestQueryPage_Input = nil

puts obj.serviceRequestQueryPage(serviceRequestWS_ServiceRequestQueryPage_Input)

# SYNOPSIS
#   ServiceRequestInsertOrUpdate(serviceRequestWS_ServiceRequestInsertOrUpdate_Input)
#
# ARGS
#   serviceRequestWS_ServiceRequestInsertOrUpdate_Input ServiceRequestWS_ServiceRequestInsertOrUpdate_Input - {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestInsertOrUpdate_Input
#
# RETURNS
#   serviceRequestWS_ServiceRequestInsertOrUpdate_Output ServiceRequestWS_ServiceRequestInsertOrUpdate_Output - {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestInsertOrUpdate_Output
#
serviceRequestWS_ServiceRequestInsertOrUpdate_Input = nil
puts obj.serviceRequestInsertOrUpdate(serviceRequestWS_ServiceRequestInsertOrUpdate_Input)

# SYNOPSIS
#   ServiceRequestInsertChild(serviceRequestWS_ServiceRequestInsertChild_Input)
#
# ARGS
#   serviceRequestWS_ServiceRequestInsertChild_Input ServiceRequestWS_ServiceRequestInsertChild_Input - {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestInsertChild_Input
#
# RETURNS
#   serviceRequestWS_ServiceRequestInsertChild_Output ServiceRequestWS_ServiceRequestInsertChild_Output - {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestInsertChild_Output
#
serviceRequestWS_ServiceRequestInsertChild_Input = nil
puts obj.serviceRequestInsertChild(serviceRequestWS_ServiceRequestInsertChild_Input)


