require 'default.rb'
require 'soap/mapping'

module DefaultMappingRegistry
  EncodedRegistry = ::SOAP::Mapping::EncodedRegistry.new
  LiteralRegistry = ::SOAP::Mapping::LiteralRegistry.new
  NsC_2004 = "urn:crmondemand/ws/servicerequest/10/2004"
  NsServicerequest = "urn:/crmondemand/xml/servicerequest"

  EncodedRegistry.register(
    :class => ListOfServiceRequestTopElmt,
    :schema_type => XSD::QName.new(NsServicerequest, "ListOfServiceRequestTopElmt"),
    :schema_element => [
      ["listOfServiceRequest", ["ListOfServiceRequest", XSD::QName.new(NsServicerequest, "ListOfServiceRequest")]]
    ]
  )

  EncodedRegistry.register(
    :class => ListOfServiceRequest,
    :schema_type => XSD::QName.new(NsServicerequest, "ListOfServiceRequest"),
    :schema_element => [
      ["serviceRequest", ["ServiceRequest[]", XSD::QName.new(NsServicerequest, "ServiceRequest")], [0, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => ServiceRequest,
    :schema_type => XSD::QName.new(NsServicerequest, "ServiceRequest"),
    :schema_element => [
      ["lastUpdated", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "LastUpdated")], [0, 1]],
      ["serviceRequestId", [nil, XSD::QName.new(NsServicerequest, "ServiceRequestId")], [0, 1]],
      ["createdDate", [nil, XSD::QName.new(NsServicerequest, "CreatedDate")], [0, 1]],
      ["modId", [nil, XSD::QName.new(NsServicerequest, "ModId")], [0, 1]],
      ["subject", [nil, XSD::QName.new(NsServicerequest, "Subject")], [0, 1]],
      ["accountName", [nil, XSD::QName.new(NsServicerequest, "AccountName")], [0, 1]],
      ["accountId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "AccountId")], [0, 1]],
      ["accountLocation", [nil, XSD::QName.new(NsServicerequest, "AccountLocation")], [0, 1]],
      ["area", [nil, XSD::QName.new(NsServicerequest, "Area")], [0, 1]],
      ["assetId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "AssetId")], [0, 1]],
      ["closedTime", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ClosedTime")], [0, 1]],
      ["serviceRequestConcatField", [nil, XSD::QName.new(NsServicerequest, "ServiceRequestConcatField")], [0, 1]],
      ["workPhone", [nil, XSD::QName.new(NsServicerequest, "WorkPhone")], [0, 1]],
      ["contactEmail", [nil, XSD::QName.new(NsServicerequest, "ContactEmail")], [0, 1]],
      ["contactFirstName", [nil, XSD::QName.new(NsServicerequest, "ContactFirstName")], [0, 1]],
      ["contactFullName", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ContactFullName")], [0, 1]],
      ["contactId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ContactId")], [0, 1]],
      ["contactLastName", [nil, XSD::QName.new(NsServicerequest, "ContactLastName")], [0, 1]],
      ["createdByName", [nil, XSD::QName.new(NsServicerequest, "CreatedByName")], [0, 1]],
      ["description", [nil, XSD::QName.new(NsServicerequest, "Description")], [0, 1]],
      ["externalSystemId", [nil, XSD::QName.new(NsServicerequest, "ExternalSystemId")], [0, 1]],
      ["integrationId", [nil, XSD::QName.new(NsServicerequest, "IntegrationId")], [0, 1]],
      ["modifiedBy", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedBy")], [0, 1]],
      ["modifiedByFullName", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedByFullName")], [0, 1]],
      ["modifiedById", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedById")], [0, 1]],
      ["modifiedDate", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedDate")], [0, 1]],
      ["openedTime", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "OpenedTime")], [0, 1]],
      ["ownerId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "OwnerId")], [0, 1]],
      ["owner", [nil, XSD::QName.new(NsServicerequest, "Owner")], [0, 1]],
      ["priority", [nil, XSD::QName.new(NsServicerequest, "Priority")], [0, 1]],
      ["product", [nil, XSD::QName.new(NsServicerequest, "Product")], [0, 1]],
      ["productId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ProductId")], [0, 1]],
      ["reassignOwnerFlag", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ReassignOwnerFlag")], [0, 1]],
      ["sRNumber", [nil, XSD::QName.new(NsServicerequest, "SRNumber")], [0, 1]],
      ["type", [nil, XSD::QName.new(NsServicerequest, "Type")], [0, 1]],
      ["assetName", [nil, XSD::QName.new(NsServicerequest, "AssetName")], [0, 1]],
      ["cause", [nil, XSD::QName.new(NsServicerequest, "Cause")], [0, 1]],
      ["source", [nil, XSD::QName.new(NsServicerequest, "Source")], [0, 1]],
      ["status", [nil, XSD::QName.new(NsServicerequest, "Status")], [0, 1]],
      ["createdById", [nil, XSD::QName.new(NsServicerequest, "CreatedById")], [0, 1]],
      ["createdBy", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "CreatedBy")], [0, 1]],
      ["dealerId", [nil, XSD::QName.new(NsServicerequest, "DealerId")], [0, 1]],
      ["make", [nil, XSD::QName.new(NsServicerequest, "Make")], [0, 1]],
      ["model", [nil, XSD::QName.new(NsServicerequest, "Model")], [0, 1]],
      ["servicingDealer", [nil, XSD::QName.new(NsServicerequest, "ServicingDealer")], [0, 1]],
      ["year", [nil, XSD::QName.new(NsServicerequest, "Year")], [0, 1]],
      ["accountExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "AccountExternalSystemId")], [0, 1]],
      ["assetExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "AssetExternalSystemId")], [0, 1]],
      ["productExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "ProductExternalSystemId")], [0, 1]],
      ["assetIntegrationId", [nil, XSD::QName.new(NsServicerequest, "AssetIntegrationId")], [0, 1]],
      ["productIntegrationId", [nil, XSD::QName.new(NsServicerequest, "ProductIntegrationId")], [0, 1]],
      ["dealerIntegrationId", [nil, XSD::QName.new(NsServicerequest, "DealerIntegrationId")], [0, 1]],
      ["dealerExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "DealerExternalSystemId")], [0, 1]],
      ["assessmentFilter1", [nil, XSD::QName.new(NsServicerequest, "AssessmentFilter1")], [0, 1]],
      ["assessmentFilter2", [nil, XSD::QName.new(NsServicerequest, "AssessmentFilter2")], [0, 1]],
      ["assessmentFilter3", [nil, XSD::QName.new(NsServicerequest, "AssessmentFilter3")], [0, 1]],
      ["assessmentFilter4", [nil, XSD::QName.new(NsServicerequest, "AssessmentFilter4")], [0, 1]],
      ["contactExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "ContactExternalSystemId")], [0, 1]],
      ["createdbyEmailAddress", [nil, XSD::QName.new(NsServicerequest, "CreatedbyEmailAddress")], [0, 1]],
      ["lastAssessmentDate", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "LastAssessmentDate")], [0, 1]],
      ["ownerExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "OwnerExternalSystemId")], [0, 1]],
      ["dealer", [nil, XSD::QName.new(NsServicerequest, "Dealer")], [0, 1]],
      ["modifiedbyEmailAddress", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedbyEmailAddress")], [0, 1]],
      ["customObject1Id", [nil, XSD::QName.new(NsServicerequest, "CustomObject1Id")], [0, 1]],
      ["customObject1Name", [nil, XSD::QName.new(NsServicerequest, "CustomObject1Name")], [0, 1]],
      ["customObject2Id", [nil, XSD::QName.new(NsServicerequest, "CustomObject2Id")], [0, 1]],
      ["customObject2Name", [nil, XSD::QName.new(NsServicerequest, "CustomObject2Name")], [0, 1]],
      ["customObject3Id", [nil, XSD::QName.new(NsServicerequest, "CustomObject3Id")], [0, 1]],
      ["customObject3Name", [nil, XSD::QName.new(NsServicerequest, "CustomObject3Name")], [0, 1]],
      ["customObject1ExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "CustomObject1ExternalSystemId")], [0, 1]],
      ["customObject2ExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "CustomObject2ExternalSystemId")], [0, 1]],
      ["customObject3ExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "CustomObject3ExternalSystemId")], [0, 1]],
      ["lastAssignmentSubmissionDate", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "LastAssignmentSubmissionDate")], [0, 1]],
      ["assignmentStatus", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "AssignmentStatus")], [0, 1]],
      ["lastAssignmentCompletionDate", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "LastAssignmentCompletionDate")], [0, 1]],
      ["currencyCode", [nil, XSD::QName.new(NsServicerequest, "CurrencyCode")], [0, 1]],
      ["indexedBoolean0", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IndexedBoolean0")], [0, 1]],
      ["indexedCurrency0", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IndexedCurrency0")], [0, 1]],
      ["indexedDate0", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IndexedDate0")], [0, 1]],
      ["indexedLongText0", [nil, XSD::QName.new(NsServicerequest, "IndexedLongText0")], [0, 1]],
      ["indexedNumber0", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IndexedNumber0")], [0, 1]],
      ["indexedPick0", [nil, XSD::QName.new(NsServicerequest, "IndexedPick0")], [0, 1]],
      ["indexedPick1", [nil, XSD::QName.new(NsServicerequest, "IndexedPick1")], [0, 1]],
      ["indexedPick2", [nil, XSD::QName.new(NsServicerequest, "IndexedPick2")], [0, 1]],
      ["indexedPick3", [nil, XSD::QName.new(NsServicerequest, "IndexedPick3")], [0, 1]],
      ["indexedPick4", [nil, XSD::QName.new(NsServicerequest, "IndexedPick4")], [0, 1]],
      ["indexedPick5", [nil, XSD::QName.new(NsServicerequest, "IndexedPick5")], [0, 1]],
      ["indexedShortText0", [nil, XSD::QName.new(NsServicerequest, "IndexedShortText0")], [0, 1]],
      ["indexedShortText1", [nil, XSD::QName.new(NsServicerequest, "IndexedShortText1")], [0, 1]],
      ["listOfActivity", ["ListOfActivity", XSD::QName.new(NsServicerequest, "ListOfActivity")], [0, 1]],
      ["listOfAuditTrail", ["ListOfAuditTrail", XSD::QName.new(NsServicerequest, "ListOfAuditTrail")], [0, 1]],
      ["listOfNote", ["ListOfNote", XSD::QName.new(NsServicerequest, "ListOfNote")], [0, 1]],
      ["listOfSolution", ["ListOfSolution", XSD::QName.new(NsServicerequest, "ListOfSolution")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => ListOfActivity,
    :schema_type => XSD::QName.new(NsServicerequest, "ListOfActivity"),
    :schema_element => [
      ["activity", ["Activity[]", XSD::QName.new(NsServicerequest, "Activity")], [0, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => Activity,
    :schema_type => XSD::QName.new(NsServicerequest, "Activity"),
    :schema_element => [
      ["integrationId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IntegrationId")], [0, 1]],
      ["owner", [nil, XSD::QName.new(NsServicerequest, "Owner")], [0, 1]],
      ["subject", [nil, XSD::QName.new(NsServicerequest, "Subject")], [0, 1]],
      ["dueDate", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "DueDate")], [0, 1]],
      ["priority", [nil, XSD::QName.new(NsServicerequest, "Priority")], [0, 1]],
      ["status", [nil, XSD::QName.new(NsServicerequest, "Status")], [0, 1]],
      ["type", [nil, XSD::QName.new(NsServicerequest, "Type")], [0, 1]],
      ["accountId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "AccountId")], [0, 1]],
      ["account", [nil, XSD::QName.new(NsServicerequest, "Account")], [0, 1]],
      ["serviceRequestId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ServiceRequestId")], [0, 1]],
      ["campaignId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "CampaignId")], [0, 1]],
      ["campaign", [nil, XSD::QName.new(NsServicerequest, "Campaign")], [0, 1]],
      ["description", [nil, XSD::QName.new(NsServicerequest, "Description")], [0, 1]],
      ["contact", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "Contact")], [0, 1]],
      ["createdById", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "CreatedById")], [0, 1]],
      ["createdByName", [nil, XSD::QName.new(NsServicerequest, "CreatedByName")], [0, 1]],
      ["createdDate", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "CreatedDate")], [0, 1]],
      ["currencyCode", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "CurrencyCode")], [0, 1]],
      ["display", [nil, XSD::QName.new(NsServicerequest, "Display")], [0, 1]],
      ["externalSystemId", [nil, XSD::QName.new(NsServicerequest, "ExternalSystemId")], [0, 1]],
      ["lead", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "Lead")], [0, 1]],
      ["leadId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "LeadId")], [0, 1]],
      ["location", [nil, XSD::QName.new(NsServicerequest, "Location")], [0, 1]],
      ["modifiedById", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedById")], [0, 1]],
      ["modifiedDate", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedDate")], [0, 1]],
      ["modifiedBy", [nil, XSD::QName.new(NsServicerequest, "ModifiedBy")], [0, 1]],
      ["opportunity", [nil, XSD::QName.new(NsServicerequest, "Opportunity")], [0, 1]],
      ["opportunityId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "OpportunityId")], [0, 1]],
      ["ownerId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "OwnerId")], [0, 1]],
      ["parentActivityId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ParentActivityId")], [0, 1]],
      ["startTime", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "StartTime")], [0, 1]],
      ["endTime", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "EndTime")], [0, 1]],
      ["primaryContactId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "PrimaryContactId")], [0, 1]],
      ["private", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "Private")], [0, 1]],
      ["createdBy", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "CreatedBy")], [0, 1]],
      ["activityId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ActivityId")], [0, 1]],
      ["indexedBoolean0", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IndexedBoolean0")], [0, 1]],
      ["indexedCurrency0", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IndexedCurrency0")], [0, 1]],
      ["indexedDate0", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IndexedDate0")], [0, 1]],
      ["indexedLongText0", [nil, XSD::QName.new(NsServicerequest, "IndexedLongText0")], [0, 1]],
      ["indexedNumber0", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IndexedNumber0")], [0, 1]],
      ["indexedPick0", [nil, XSD::QName.new(NsServicerequest, "IndexedPick0")], [0, 1]],
      ["indexedPick1", [nil, XSD::QName.new(NsServicerequest, "IndexedPick1")], [0, 1]],
      ["indexedPick2", [nil, XSD::QName.new(NsServicerequest, "IndexedPick2")], [0, 1]],
      ["indexedPick3", [nil, XSD::QName.new(NsServicerequest, "IndexedPick3")], [0, 1]],
      ["indexedPick4", [nil, XSD::QName.new(NsServicerequest, "IndexedPick4")], [0, 1]],
      ["indexedPick5", [nil, XSD::QName.new(NsServicerequest, "IndexedPick5")], [0, 1]],
      ["indexedShortText0", [nil, XSD::QName.new(NsServicerequest, "IndexedShortText0")], [0, 1]],
      ["indexedShortText1", [nil, XSD::QName.new(NsServicerequest, "IndexedShortText1")], [0, 1]],
      ["accountExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "AccountExternalSystemId")], [0, 1]],
      ["campaignExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "CampaignExternalSystemId")], [0, 1]],
      ["opportunityExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "OpportunityExternalSystemId")], [0, 1]],
      ["leadExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "LeadExternalSystemId")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => ListOfAuditTrail,
    :schema_type => XSD::QName.new(NsServicerequest, "ListOfAuditTrail"),
    :schema_element => [
      ["auditTrail", ["AuditTrail[]", XSD::QName.new(NsServicerequest, "AuditTrail")], [0, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => AuditTrail,
    :schema_type => XSD::QName.new(NsServicerequest, "AuditTrail"),
    :schema_element => [
      ["lastUpdated", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "LastUpdated")], [0, 1]],
      ["date", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "Date")], [0, 1]],
      ["user", [nil, XSD::QName.new(NsServicerequest, "User")], [0, 1]],
      ["fieldModified", [nil, XSD::QName.new(NsServicerequest, "FieldModified")], [0, 1]],
      ["newValue", [nil, XSD::QName.new(NsServicerequest, "NewValue")], [0, 1]],
      ["oldValue", [nil, XSD::QName.new(NsServicerequest, "OldValue")], [0, 1]],
      ["auditTrailId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "AuditTrailId")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => ListOfNote,
    :schema_type => XSD::QName.new(NsServicerequest, "ListOfNote"),
    :schema_element => [
      ["note", ["Note[]", XSD::QName.new(NsServicerequest, "Note")], [0, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => Note,
    :schema_type => XSD::QName.new(NsServicerequest, "Note"),
    :schema_element => [
      ["lastUpdated", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "LastUpdated")], [0, 1]],
      ["subject", [nil, XSD::QName.new(NsServicerequest, "Subject")], [0, 1]],
      ["createdByName", [nil, XSD::QName.new(NsServicerequest, "CreatedByName")], [0, 1]],
      ["createdDate", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "CreatedDate")], [0, 1]],
      ["createdBy", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "CreatedBy")], [0, 1]],
      ["externalSystemId", [nil, XSD::QName.new(NsServicerequest, "ExternalSystemId")], [0, 1]],
      ["modifiedBy", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedBy")], [0, 1]],
      ["modifiedById", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedById")], [0, 1]],
      ["modifiedDate", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedDate")], [0, 1]],
      ["description", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "Description")], [0, 1]],
      ["private", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "Private")], [0, 1]],
      ["serviceRequestId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ServiceRequestId")], [0, 1]],
      ["createdById", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "CreatedById")], [0, 1]],
      ["modId", [nil, XSD::QName.new(NsServicerequest, "ModId")], [0, 1]],
      ["noteId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "NoteId")], [0, 1]]
    ]
  )

  EncodedRegistry.register(
    :class => ListOfSolution,
    :schema_type => XSD::QName.new(NsServicerequest, "ListOfSolution"),
    :schema_element => [
      ["solution", ["Solution[]", XSD::QName.new(NsServicerequest, "Solution")], [0, nil]]
    ]
  )

  EncodedRegistry.register(
    :class => Solution,
    :schema_type => XSD::QName.new(NsServicerequest, "Solution"),
    :schema_element => [
      ["lastUpdated", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "LastUpdated")], [0, 1]],
      ["externalSystemId", [nil, XSD::QName.new(NsServicerequest, "ExternalSystemId")], [0, 1]],
      ["title", [nil, XSD::QName.new(NsServicerequest, "Title")], [0, 1]],
      ["published", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "Published")], [0, 1]],
      ["solutionId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "SolutionId")], [0, 1]],
      ["status", [nil, XSD::QName.new(NsServicerequest, "Status")], [0, 1]],
      ["createdById", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "CreatedById")], [0, 1]],
      ["createdBy", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "CreatedBy")], [0, 1]],
      ["createdDate", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "CreatedDate")], [0, 1]],
      ["fAQ", [nil, XSD::QName.new(NsServicerequest, "FAQ")], [0, 1]],
      ["modifiedBy", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedBy")], [0, 1]],
      ["modifiedById", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedById")], [0, 1]],
      ["modifiedDate", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedDate")], [0, 1]],
      ["solutionDetails", [nil, XSD::QName.new(NsServicerequest, "SolutionDetails")], [0, 1]],
      ["solutionRating", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "SolutionRating")], [0, 1]],
      ["integrationId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IntegrationId")], [0, 1]],
      ["currencyCode", [nil, XSD::QName.new(NsServicerequest, "CurrencyCode")], [0, 1]],
      ["indexedBoolean0", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IndexedBoolean0")], [0, 1]],
      ["indexedCurrency0", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IndexedCurrency0")], [0, 1]],
      ["indexedDate0", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IndexedDate0")], [0, 1]],
      ["indexedLongText0", [nil, XSD::QName.new(NsServicerequest, "IndexedLongText0")], [0, 1]],
      ["indexedNumber0", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IndexedNumber0")], [0, 1]],
      ["indexedPick0", [nil, XSD::QName.new(NsServicerequest, "IndexedPick0")], [0, 1]],
      ["indexedPick1", [nil, XSD::QName.new(NsServicerequest, "IndexedPick1")], [0, 1]],
      ["indexedPick2", [nil, XSD::QName.new(NsServicerequest, "IndexedPick2")], [0, 1]],
      ["indexedPick3", [nil, XSD::QName.new(NsServicerequest, "IndexedPick3")], [0, 1]],
      ["indexedPick4", [nil, XSD::QName.new(NsServicerequest, "IndexedPick4")], [0, 1]],
      ["indexedPick5", [nil, XSD::QName.new(NsServicerequest, "IndexedPick5")], [0, 1]],
      ["indexedShortText0", [nil, XSD::QName.new(NsServicerequest, "IndexedShortText0")], [0, 1]],
      ["indexedShortText1", [nil, XSD::QName.new(NsServicerequest, "IndexedShortText1")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ListOfServiceRequestTopElmt,
    :schema_type => XSD::QName.new(NsServicerequest, "ListOfServiceRequestTopElmt"),
    :schema_element => [
      ["listOfServiceRequest", ["ListOfServiceRequest", XSD::QName.new(NsServicerequest, "ListOfServiceRequest")]]
    ]
  )

  LiteralRegistry.register(
    :class => ListOfServiceRequest,
    :schema_type => XSD::QName.new(NsServicerequest, "ListOfServiceRequest"),
    :schema_element => [
      ["serviceRequest", ["ServiceRequest[]", XSD::QName.new(NsServicerequest, "ServiceRequest")], [0, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => ServiceRequest,
    :schema_type => XSD::QName.new(NsServicerequest, "ServiceRequest"),
    :schema_element => [
      ["lastUpdated", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "LastUpdated")], [0, 1]],
      ["serviceRequestId", [nil, XSD::QName.new(NsServicerequest, "ServiceRequestId")], [0, 1]],
      ["createdDate", [nil, XSD::QName.new(NsServicerequest, "CreatedDate")], [0, 1]],
      ["modId", [nil, XSD::QName.new(NsServicerequest, "ModId")], [0, 1]],
      ["subject", [nil, XSD::QName.new(NsServicerequest, "Subject")], [0, 1]],
      ["accountName", [nil, XSD::QName.new(NsServicerequest, "AccountName")], [0, 1]],
      ["accountId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "AccountId")], [0, 1]],
      ["accountLocation", [nil, XSD::QName.new(NsServicerequest, "AccountLocation")], [0, 1]],
      ["area", [nil, XSD::QName.new(NsServicerequest, "Area")], [0, 1]],
      ["assetId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "AssetId")], [0, 1]],
      ["closedTime", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ClosedTime")], [0, 1]],
      ["serviceRequestConcatField", [nil, XSD::QName.new(NsServicerequest, "ServiceRequestConcatField")], [0, 1]],
      ["workPhone", [nil, XSD::QName.new(NsServicerequest, "WorkPhone")], [0, 1]],
      ["contactEmail", [nil, XSD::QName.new(NsServicerequest, "ContactEmail")], [0, 1]],
      ["contactFirstName", [nil, XSD::QName.new(NsServicerequest, "ContactFirstName")], [0, 1]],
      ["contactFullName", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ContactFullName")], [0, 1]],
      ["contactId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ContactId")], [0, 1]],
      ["contactLastName", [nil, XSD::QName.new(NsServicerequest, "ContactLastName")], [0, 1]],
      ["createdByName", [nil, XSD::QName.new(NsServicerequest, "CreatedByName")], [0, 1]],
      ["description", [nil, XSD::QName.new(NsServicerequest, "Description")], [0, 1]],
      ["externalSystemId", [nil, XSD::QName.new(NsServicerequest, "ExternalSystemId")], [0, 1]],
      ["integrationId", [nil, XSD::QName.new(NsServicerequest, "IntegrationId")], [0, 1]],
      ["modifiedBy", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedBy")], [0, 1]],
      ["modifiedByFullName", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedByFullName")], [0, 1]],
      ["modifiedById", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedById")], [0, 1]],
      ["modifiedDate", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedDate")], [0, 1]],
      ["openedTime", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "OpenedTime")], [0, 1]],
      ["ownerId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "OwnerId")], [0, 1]],
      ["owner", [nil, XSD::QName.new(NsServicerequest, "Owner")], [0, 1]],
      ["priority", [nil, XSD::QName.new(NsServicerequest, "Priority")], [0, 1]],
      ["product", [nil, XSD::QName.new(NsServicerequest, "Product")], [0, 1]],
      ["productId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ProductId")], [0, 1]],
      ["reassignOwnerFlag", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ReassignOwnerFlag")], [0, 1]],
      ["sRNumber", [nil, XSD::QName.new(NsServicerequest, "SRNumber")], [0, 1]],
      ["type", [nil, XSD::QName.new(NsServicerequest, "Type")], [0, 1]],
      ["assetName", [nil, XSD::QName.new(NsServicerequest, "AssetName")], [0, 1]],
      ["cause", [nil, XSD::QName.new(NsServicerequest, "Cause")], [0, 1]],
      ["source", [nil, XSD::QName.new(NsServicerequest, "Source")], [0, 1]],
      ["status", [nil, XSD::QName.new(NsServicerequest, "Status")], [0, 1]],
      ["createdById", [nil, XSD::QName.new(NsServicerequest, "CreatedById")], [0, 1]],
      ["createdBy", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "CreatedBy")], [0, 1]],
      ["dealerId", [nil, XSD::QName.new(NsServicerequest, "DealerId")], [0, 1]],
      ["make", [nil, XSD::QName.new(NsServicerequest, "Make")], [0, 1]],
      ["model", [nil, XSD::QName.new(NsServicerequest, "Model")], [0, 1]],
      ["servicingDealer", [nil, XSD::QName.new(NsServicerequest, "ServicingDealer")], [0, 1]],
      ["year", [nil, XSD::QName.new(NsServicerequest, "Year")], [0, 1]],
      ["accountExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "AccountExternalSystemId")], [0, 1]],
      ["assetExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "AssetExternalSystemId")], [0, 1]],
      ["productExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "ProductExternalSystemId")], [0, 1]],
      ["assetIntegrationId", [nil, XSD::QName.new(NsServicerequest, "AssetIntegrationId")], [0, 1]],
      ["productIntegrationId", [nil, XSD::QName.new(NsServicerequest, "ProductIntegrationId")], [0, 1]],
      ["dealerIntegrationId", [nil, XSD::QName.new(NsServicerequest, "DealerIntegrationId")], [0, 1]],
      ["dealerExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "DealerExternalSystemId")], [0, 1]],
      ["assessmentFilter1", [nil, XSD::QName.new(NsServicerequest, "AssessmentFilter1")], [0, 1]],
      ["assessmentFilter2", [nil, XSD::QName.new(NsServicerequest, "AssessmentFilter2")], [0, 1]],
      ["assessmentFilter3", [nil, XSD::QName.new(NsServicerequest, "AssessmentFilter3")], [0, 1]],
      ["assessmentFilter4", [nil, XSD::QName.new(NsServicerequest, "AssessmentFilter4")], [0, 1]],
      ["contactExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "ContactExternalSystemId")], [0, 1]],
      ["createdbyEmailAddress", [nil, XSD::QName.new(NsServicerequest, "CreatedbyEmailAddress")], [0, 1]],
      ["lastAssessmentDate", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "LastAssessmentDate")], [0, 1]],
      ["ownerExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "OwnerExternalSystemId")], [0, 1]],
      ["dealer", [nil, XSD::QName.new(NsServicerequest, "Dealer")], [0, 1]],
      ["modifiedbyEmailAddress", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedbyEmailAddress")], [0, 1]],
      ["customObject1Id", [nil, XSD::QName.new(NsServicerequest, "CustomObject1Id")], [0, 1]],
      ["customObject1Name", [nil, XSD::QName.new(NsServicerequest, "CustomObject1Name")], [0, 1]],
      ["customObject2Id", [nil, XSD::QName.new(NsServicerequest, "CustomObject2Id")], [0, 1]],
      ["customObject2Name", [nil, XSD::QName.new(NsServicerequest, "CustomObject2Name")], [0, 1]],
      ["customObject3Id", [nil, XSD::QName.new(NsServicerequest, "CustomObject3Id")], [0, 1]],
      ["customObject3Name", [nil, XSD::QName.new(NsServicerequest, "CustomObject3Name")], [0, 1]],
      ["customObject1ExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "CustomObject1ExternalSystemId")], [0, 1]],
      ["customObject2ExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "CustomObject2ExternalSystemId")], [0, 1]],
      ["customObject3ExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "CustomObject3ExternalSystemId")], [0, 1]],
      ["lastAssignmentSubmissionDate", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "LastAssignmentSubmissionDate")], [0, 1]],
      ["assignmentStatus", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "AssignmentStatus")], [0, 1]],
      ["lastAssignmentCompletionDate", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "LastAssignmentCompletionDate")], [0, 1]],
      ["currencyCode", [nil, XSD::QName.new(NsServicerequest, "CurrencyCode")], [0, 1]],
      ["indexedBoolean0", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IndexedBoolean0")], [0, 1]],
      ["indexedCurrency0", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IndexedCurrency0")], [0, 1]],
      ["indexedDate0", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IndexedDate0")], [0, 1]],
      ["indexedLongText0", [nil, XSD::QName.new(NsServicerequest, "IndexedLongText0")], [0, 1]],
      ["indexedNumber0", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IndexedNumber0")], [0, 1]],
      ["indexedPick0", [nil, XSD::QName.new(NsServicerequest, "IndexedPick0")], [0, 1]],
      ["indexedPick1", [nil, XSD::QName.new(NsServicerequest, "IndexedPick1")], [0, 1]],
      ["indexedPick2", [nil, XSD::QName.new(NsServicerequest, "IndexedPick2")], [0, 1]],
      ["indexedPick3", [nil, XSD::QName.new(NsServicerequest, "IndexedPick3")], [0, 1]],
      ["indexedPick4", [nil, XSD::QName.new(NsServicerequest, "IndexedPick4")], [0, 1]],
      ["indexedPick5", [nil, XSD::QName.new(NsServicerequest, "IndexedPick5")], [0, 1]],
      ["indexedShortText0", [nil, XSD::QName.new(NsServicerequest, "IndexedShortText0")], [0, 1]],
      ["indexedShortText1", [nil, XSD::QName.new(NsServicerequest, "IndexedShortText1")], [0, 1]],
      ["listOfActivity", ["ListOfActivity", XSD::QName.new(NsServicerequest, "ListOfActivity")], [0, 1]],
      ["listOfAuditTrail", ["ListOfAuditTrail", XSD::QName.new(NsServicerequest, "ListOfAuditTrail")], [0, 1]],
      ["listOfNote", ["ListOfNote", XSD::QName.new(NsServicerequest, "ListOfNote")], [0, 1]],
      ["listOfSolution", ["ListOfSolution", XSD::QName.new(NsServicerequest, "ListOfSolution")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ListOfActivity,
    :schema_type => XSD::QName.new(NsServicerequest, "ListOfActivity"),
    :schema_element => [
      ["activity", ["Activity[]", XSD::QName.new(NsServicerequest, "Activity")], [0, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => Activity,
    :schema_type => XSD::QName.new(NsServicerequest, "Activity"),
    :schema_element => [
      ["integrationId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IntegrationId")], [0, 1]],
      ["owner", [nil, XSD::QName.new(NsServicerequest, "Owner")], [0, 1]],
      ["subject", [nil, XSD::QName.new(NsServicerequest, "Subject")], [0, 1]],
      ["dueDate", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "DueDate")], [0, 1]],
      ["priority", [nil, XSD::QName.new(NsServicerequest, "Priority")], [0, 1]],
      ["status", [nil, XSD::QName.new(NsServicerequest, "Status")], [0, 1]],
      ["type", [nil, XSD::QName.new(NsServicerequest, "Type")], [0, 1]],
      ["accountId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "AccountId")], [0, 1]],
      ["account", [nil, XSD::QName.new(NsServicerequest, "Account")], [0, 1]],
      ["serviceRequestId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ServiceRequestId")], [0, 1]],
      ["campaignId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "CampaignId")], [0, 1]],
      ["campaign", [nil, XSD::QName.new(NsServicerequest, "Campaign")], [0, 1]],
      ["description", [nil, XSD::QName.new(NsServicerequest, "Description")], [0, 1]],
      ["contact", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "Contact")], [0, 1]],
      ["createdById", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "CreatedById")], [0, 1]],
      ["createdByName", [nil, XSD::QName.new(NsServicerequest, "CreatedByName")], [0, 1]],
      ["createdDate", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "CreatedDate")], [0, 1]],
      ["currencyCode", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "CurrencyCode")], [0, 1]],
      ["display", [nil, XSD::QName.new(NsServicerequest, "Display")], [0, 1]],
      ["externalSystemId", [nil, XSD::QName.new(NsServicerequest, "ExternalSystemId")], [0, 1]],
      ["lead", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "Lead")], [0, 1]],
      ["leadId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "LeadId")], [0, 1]],
      ["location", [nil, XSD::QName.new(NsServicerequest, "Location")], [0, 1]],
      ["modifiedById", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedById")], [0, 1]],
      ["modifiedDate", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedDate")], [0, 1]],
      ["modifiedBy", [nil, XSD::QName.new(NsServicerequest, "ModifiedBy")], [0, 1]],
      ["opportunity", [nil, XSD::QName.new(NsServicerequest, "Opportunity")], [0, 1]],
      ["opportunityId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "OpportunityId")], [0, 1]],
      ["ownerId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "OwnerId")], [0, 1]],
      ["parentActivityId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ParentActivityId")], [0, 1]],
      ["startTime", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "StartTime")], [0, 1]],
      ["endTime", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "EndTime")], [0, 1]],
      ["primaryContactId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "PrimaryContactId")], [0, 1]],
      ["private", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "Private")], [0, 1]],
      ["createdBy", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "CreatedBy")], [0, 1]],
      ["activityId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ActivityId")], [0, 1]],
      ["indexedBoolean0", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IndexedBoolean0")], [0, 1]],
      ["indexedCurrency0", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IndexedCurrency0")], [0, 1]],
      ["indexedDate0", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IndexedDate0")], [0, 1]],
      ["indexedLongText0", [nil, XSD::QName.new(NsServicerequest, "IndexedLongText0")], [0, 1]],
      ["indexedNumber0", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IndexedNumber0")], [0, 1]],
      ["indexedPick0", [nil, XSD::QName.new(NsServicerequest, "IndexedPick0")], [0, 1]],
      ["indexedPick1", [nil, XSD::QName.new(NsServicerequest, "IndexedPick1")], [0, 1]],
      ["indexedPick2", [nil, XSD::QName.new(NsServicerequest, "IndexedPick2")], [0, 1]],
      ["indexedPick3", [nil, XSD::QName.new(NsServicerequest, "IndexedPick3")], [0, 1]],
      ["indexedPick4", [nil, XSD::QName.new(NsServicerequest, "IndexedPick4")], [0, 1]],
      ["indexedPick5", [nil, XSD::QName.new(NsServicerequest, "IndexedPick5")], [0, 1]],
      ["indexedShortText0", [nil, XSD::QName.new(NsServicerequest, "IndexedShortText0")], [0, 1]],
      ["indexedShortText1", [nil, XSD::QName.new(NsServicerequest, "IndexedShortText1")], [0, 1]],
      ["accountExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "AccountExternalSystemId")], [0, 1]],
      ["campaignExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "CampaignExternalSystemId")], [0, 1]],
      ["opportunityExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "OpportunityExternalSystemId")], [0, 1]],
      ["leadExternalSystemId", [nil, XSD::QName.new(NsServicerequest, "LeadExternalSystemId")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ListOfAuditTrail,
    :schema_type => XSD::QName.new(NsServicerequest, "ListOfAuditTrail"),
    :schema_element => [
      ["auditTrail", ["AuditTrail[]", XSD::QName.new(NsServicerequest, "AuditTrail")], [0, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => AuditTrail,
    :schema_type => XSD::QName.new(NsServicerequest, "AuditTrail"),
    :schema_element => [
      ["lastUpdated", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "LastUpdated")], [0, 1]],
      ["date", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "Date")], [0, 1]],
      ["user", [nil, XSD::QName.new(NsServicerequest, "User")], [0, 1]],
      ["fieldModified", [nil, XSD::QName.new(NsServicerequest, "FieldModified")], [0, 1]],
      ["newValue", [nil, XSD::QName.new(NsServicerequest, "NewValue")], [0, 1]],
      ["oldValue", [nil, XSD::QName.new(NsServicerequest, "OldValue")], [0, 1]],
      ["auditTrailId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "AuditTrailId")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ListOfNote,
    :schema_type => XSD::QName.new(NsServicerequest, "ListOfNote"),
    :schema_element => [
      ["note", ["Note[]", XSD::QName.new(NsServicerequest, "Note")], [0, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => Note,
    :schema_type => XSD::QName.new(NsServicerequest, "Note"),
    :schema_element => [
      ["lastUpdated", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "LastUpdated")], [0, 1]],
      ["subject", [nil, XSD::QName.new(NsServicerequest, "Subject")], [0, 1]],
      ["createdByName", [nil, XSD::QName.new(NsServicerequest, "CreatedByName")], [0, 1]],
      ["createdDate", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "CreatedDate")], [0, 1]],
      ["createdBy", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "CreatedBy")], [0, 1]],
      ["externalSystemId", [nil, XSD::QName.new(NsServicerequest, "ExternalSystemId")], [0, 1]],
      ["modifiedBy", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedBy")], [0, 1]],
      ["modifiedById", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedById")], [0, 1]],
      ["modifiedDate", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedDate")], [0, 1]],
      ["description", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "Description")], [0, 1]],
      ["private", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "Private")], [0, 1]],
      ["serviceRequestId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ServiceRequestId")], [0, 1]],
      ["createdById", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "CreatedById")], [0, 1]],
      ["modId", [nil, XSD::QName.new(NsServicerequest, "ModId")], [0, 1]],
      ["noteId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "NoteId")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ListOfSolution,
    :schema_type => XSD::QName.new(NsServicerequest, "ListOfSolution"),
    :schema_element => [
      ["solution", ["Solution[]", XSD::QName.new(NsServicerequest, "Solution")], [0, nil]]
    ]
  )

  LiteralRegistry.register(
    :class => Solution,
    :schema_type => XSD::QName.new(NsServicerequest, "Solution"),
    :schema_element => [
      ["lastUpdated", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "LastUpdated")], [0, 1]],
      ["externalSystemId", [nil, XSD::QName.new(NsServicerequest, "ExternalSystemId")], [0, 1]],
      ["title", [nil, XSD::QName.new(NsServicerequest, "Title")], [0, 1]],
      ["published", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "Published")], [0, 1]],
      ["solutionId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "SolutionId")], [0, 1]],
      ["status", [nil, XSD::QName.new(NsServicerequest, "Status")], [0, 1]],
      ["createdById", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "CreatedById")], [0, 1]],
      ["createdBy", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "CreatedBy")], [0, 1]],
      ["createdDate", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "CreatedDate")], [0, 1]],
      ["fAQ", [nil, XSD::QName.new(NsServicerequest, "FAQ")], [0, 1]],
      ["modifiedBy", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedBy")], [0, 1]],
      ["modifiedById", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedById")], [0, 1]],
      ["modifiedDate", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "ModifiedDate")], [0, 1]],
      ["solutionDetails", [nil, XSD::QName.new(NsServicerequest, "SolutionDetails")], [0, 1]],
      ["solutionRating", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "SolutionRating")], [0, 1]],
      ["integrationId", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IntegrationId")], [0, 1]],
      ["currencyCode", [nil, XSD::QName.new(NsServicerequest, "CurrencyCode")], [0, 1]],
      ["indexedBoolean0", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IndexedBoolean0")], [0, 1]],
      ["indexedCurrency0", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IndexedCurrency0")], [0, 1]],
      ["indexedDate0", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IndexedDate0")], [0, 1]],
      ["indexedLongText0", [nil, XSD::QName.new(NsServicerequest, "IndexedLongText0")], [0, 1]],
      ["indexedNumber0", ["SOAP::SOAPString", XSD::QName.new(NsServicerequest, "IndexedNumber0")], [0, 1]],
      ["indexedPick0", [nil, XSD::QName.new(NsServicerequest, "IndexedPick0")], [0, 1]],
      ["indexedPick1", [nil, XSD::QName.new(NsServicerequest, "IndexedPick1")], [0, 1]],
      ["indexedPick2", [nil, XSD::QName.new(NsServicerequest, "IndexedPick2")], [0, 1]],
      ["indexedPick3", [nil, XSD::QName.new(NsServicerequest, "IndexedPick3")], [0, 1]],
      ["indexedPick4", [nil, XSD::QName.new(NsServicerequest, "IndexedPick4")], [0, 1]],
      ["indexedPick5", [nil, XSD::QName.new(NsServicerequest, "IndexedPick5")], [0, 1]],
      ["indexedShortText0", [nil, XSD::QName.new(NsServicerequest, "IndexedShortText0")], [0, 1]],
      ["indexedShortText1", [nil, XSD::QName.new(NsServicerequest, "IndexedShortText1")], [0, 1]]
    ]
  )

  LiteralRegistry.register(
    :class => ServiceRequestWS_ServiceRequestUpdate_Input,
    :schema_name => XSD::QName.new(NsC_2004, "ServiceRequestWS_ServiceRequestUpdate_Input"),
    :schema_element => [
      ["listOfServiceRequest", ["ListOfServiceRequest", XSD::QName.new(NsServicerequest, "ListOfServiceRequest")]],
      ["echo", ["SOAP::SOAPString", XSD::QName.new(NsC_2004, "Echo")]]
    ]
  )

  LiteralRegistry.register(
    :class => ServiceRequestWS_ServiceRequestUpdate_Output,
    :schema_name => XSD::QName.new(NsC_2004, "ServiceRequestWS_ServiceRequestUpdate_Output"),
    :schema_element => [
      ["listOfServiceRequest", ["ListOfServiceRequest", XSD::QName.new(NsServicerequest, "ListOfServiceRequest")]]
    ]
  )

  LiteralRegistry.register(
    :class => ServiceRequestWS_ServiceRequestInsert_Input,
    :schema_name => XSD::QName.new(NsC_2004, "ServiceRequestWS_ServiceRequestInsert_Input"),
    :schema_element => [
      ["listOfServiceRequest", ["ListOfServiceRequest", XSD::QName.new(NsServicerequest, "ListOfServiceRequest")]],
      ["echo", ["SOAP::SOAPString", XSD::QName.new(NsC_2004, "Echo")]]
    ]
  )

  LiteralRegistry.register(
    :class => ServiceRequestWS_ServiceRequestInsert_Output,
    :schema_name => XSD::QName.new(NsC_2004, "ServiceRequestWS_ServiceRequestInsert_Output"),
    :schema_element => [
      ["listOfServiceRequest", ["ListOfServiceRequest", XSD::QName.new(NsServicerequest, "ListOfServiceRequest")]]
    ]
  )

  LiteralRegistry.register(
    :class => ServiceRequestWS_ServiceRequestDeleteChild_Input,
    :schema_name => XSD::QName.new(NsC_2004, "ServiceRequestWS_ServiceRequestDeleteChild_Input"),
    :schema_element => [
      ["listOfServiceRequest", ["ListOfServiceRequest", XSD::QName.new(NsServicerequest, "ListOfServiceRequest")]],
      ["echo", ["SOAP::SOAPString", XSD::QName.new(NsC_2004, "Echo")]]
    ]
  )

  LiteralRegistry.register(
    :class => ServiceRequestWS_ServiceRequestDeleteChild_Output,
    :schema_name => XSD::QName.new(NsC_2004, "ServiceRequestWS_ServiceRequestDeleteChild_Output"),
    :schema_element => [
      ["listOfServiceRequest", ["ListOfServiceRequest", XSD::QName.new(NsServicerequest, "ListOfServiceRequest")]]
    ]
  )

  LiteralRegistry.register(
    :class => ServiceRequestWS_ServiceRequestDelete_Input,
    :schema_name => XSD::QName.new(NsC_2004, "ServiceRequestWS_ServiceRequestDelete_Input"),
    :schema_element => [
      ["listOfServiceRequest", ["ListOfServiceRequest", XSD::QName.new(NsServicerequest, "ListOfServiceRequest")]],
      ["echo", ["SOAP::SOAPString", XSD::QName.new(NsC_2004, "Echo")]]
    ]
  )

  LiteralRegistry.register(
    :class => ServiceRequestWS_ServiceRequestDelete_Output,
    :schema_name => XSD::QName.new(NsC_2004, "ServiceRequestWS_ServiceRequestDelete_Output"),
    :schema_element => [
      ["listOfServiceRequest", ["ListOfServiceRequest", XSD::QName.new(NsServicerequest, "ListOfServiceRequest")]]
    ]
  )

  LiteralRegistry.register(
    :class => ServiceRequestWS_ServiceRequestUpdateChild_Input,
    :schema_name => XSD::QName.new(NsC_2004, "ServiceRequestWS_ServiceRequestUpdateChild_Input"),
    :schema_element => [
      ["listOfServiceRequest", ["ListOfServiceRequest", XSD::QName.new(NsServicerequest, "ListOfServiceRequest")]],
      ["echo", ["SOAP::SOAPString", XSD::QName.new(NsC_2004, "Echo")]]
    ]
  )

  LiteralRegistry.register(
    :class => ServiceRequestWS_ServiceRequestUpdateChild_Output,
    :schema_name => XSD::QName.new(NsC_2004, "ServiceRequestWS_ServiceRequestUpdateChild_Output"),
    :schema_element => [
      ["listOfServiceRequest", ["ListOfServiceRequest", XSD::QName.new(NsServicerequest, "ListOfServiceRequest")]]
    ]
  )

  LiteralRegistry.register(
    :class => ServiceRequestWS_ServiceRequestQueryPage_Input,
    :schema_name => XSD::QName.new(NsC_2004, "ServiceRequestWS_ServiceRequestQueryPage_Input"),
    :schema_element => [
      ["useChildAnd", ["SOAP::SOAPString", XSD::QName.new(NsC_2004, "UseChildAnd")]],
      ["pageSize", ["SOAP::SOAPString", XSD::QName.new(NsC_2004, "PageSize")]],
      ["listOfServiceRequest", ["ListOfServiceRequest", XSD::QName.new(NsServicerequest, "ListOfServiceRequest")]],
      ["startRowNum", ["SOAP::SOAPString", XSD::QName.new(NsC_2004, "StartRowNum")]]
    ]
  )

  LiteralRegistry.register(
    :class => ServiceRequestWS_ServiceRequestQueryPage_Output,
    :schema_name => XSD::QName.new(NsC_2004, "ServiceRequestWS_ServiceRequestQueryPage_Output"),
    :schema_element => [
      ["lastPage", ["SOAP::SOAPString", XSD::QName.new(NsC_2004, "LastPage")]],
      ["listOfServiceRequest", ["ListOfServiceRequest", XSD::QName.new(NsServicerequest, "ListOfServiceRequest")]]
    ]
  )

  LiteralRegistry.register(
    :class => ServiceRequestWS_ServiceRequestInsertOrUpdate_Input,
    :schema_name => XSD::QName.new(NsC_2004, "ServiceRequestWS_ServiceRequestInsertOrUpdate_Input"),
    :schema_element => [
      ["listOfServiceRequest", ["ListOfServiceRequest", XSD::QName.new(NsServicerequest, "ListOfServiceRequest")]],
      ["echo", ["SOAP::SOAPString", XSD::QName.new(NsC_2004, "Echo")]]
    ]
  )

  LiteralRegistry.register(
    :class => ServiceRequestWS_ServiceRequestInsertOrUpdate_Output,
    :schema_name => XSD::QName.new(NsC_2004, "ServiceRequestWS_ServiceRequestInsertOrUpdate_Output"),
    :schema_element => [
      ["listOfServiceRequest", ["ListOfServiceRequest", XSD::QName.new(NsServicerequest, "ListOfServiceRequest")]]
    ]
  )

  LiteralRegistry.register(
    :class => ServiceRequestWS_ServiceRequestInsertChild_Input,
    :schema_name => XSD::QName.new(NsC_2004, "ServiceRequestWS_ServiceRequestInsertChild_Input"),
    :schema_element => [
      ["listOfServiceRequest", ["ListOfServiceRequest", XSD::QName.new(NsServicerequest, "ListOfServiceRequest")]],
      ["echo", ["SOAP::SOAPString", XSD::QName.new(NsC_2004, "Echo")]]
    ]
  )

  LiteralRegistry.register(
    :class => ServiceRequestWS_ServiceRequestInsertChild_Output,
    :schema_name => XSD::QName.new(NsC_2004, "ServiceRequestWS_ServiceRequestInsertChild_Output"),
    :schema_element => [
      ["listOfServiceRequest", ["ListOfServiceRequest", XSD::QName.new(NsServicerequest, "ListOfServiceRequest")]]
    ]
  )

  LiteralRegistry.register(
    :class => ListOfServiceRequest,
    :schema_name => XSD::QName.new(NsServicerequest, "ListOfServiceRequest"),
    :schema_element => [
      ["serviceRequest", ["ServiceRequest[]", XSD::QName.new(NsServicerequest, "ServiceRequest")], [0, nil]]
    ]
  )
end
