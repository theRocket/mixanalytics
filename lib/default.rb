require 'xsd/qname'

# {urn:/crmondemand/xml/servicerequest}ListOfServiceRequestTopElmt
#   listOfServiceRequest - ListOfServiceRequest
class ListOfServiceRequestTopElmt
  attr_accessor :listOfServiceRequest

  def initialize(listOfServiceRequest = nil)
    @listOfServiceRequest = listOfServiceRequest
  end
end

# {urn:/crmondemand/xml/servicerequest}ListOfServiceRequest
class ListOfServiceRequest < ::Array
end

# {urn:/crmondemand/xml/servicerequest}ServiceRequest
#   lastUpdated - SOAP::SOAPString
#   serviceRequestId - (any)
#   createdDate - (any)
#   modId - (any)
#   subject - (any)
#   accountName - (any)
#   accountId - SOAP::SOAPString
#   accountLocation - (any)
#   area - (any)
#   assetId - SOAP::SOAPString
#   closedTime - SOAP::SOAPString
#   serviceRequestConcatField - (any)
#   workPhone - (any)
#   contactEmail - (any)
#   contactFirstName - (any)
#   contactFullName - SOAP::SOAPString
#   contactId - SOAP::SOAPString
#   contactLastName - (any)
#   createdByName - (any)
#   description - (any)
#   externalSystemId - (any)
#   integrationId - (any)
#   modifiedBy - SOAP::SOAPString
#   modifiedByFullName - SOAP::SOAPString
#   modifiedById - SOAP::SOAPString
#   modifiedDate - SOAP::SOAPString
#   openedTime - SOAP::SOAPString
#   ownerId - SOAP::SOAPString
#   owner - (any)
#   priority - (any)
#   product - (any)
#   productId - SOAP::SOAPString
#   reassignOwnerFlag - SOAP::SOAPString
#   sRNumber - (any)
#   type - (any)
#   assetName - (any)
#   cause - (any)
#   source - (any)
#   status - (any)
#   createdById - (any)
#   createdBy - SOAP::SOAPString
#   dealerId - (any)
#   make - (any)
#   model - (any)
#   servicingDealer - (any)
#   year - (any)
#   accountExternalSystemId - (any)
#   assetExternalSystemId - (any)
#   productExternalSystemId - (any)
#   assetIntegrationId - (any)
#   productIntegrationId - (any)
#   dealerIntegrationId - (any)
#   dealerExternalSystemId - (any)
#   assessmentFilter1 - (any)
#   assessmentFilter2 - (any)
#   assessmentFilter3 - (any)
#   assessmentFilter4 - (any)
#   contactExternalSystemId - (any)
#   createdbyEmailAddress - (any)
#   lastAssessmentDate - SOAP::SOAPString
#   ownerExternalSystemId - (any)
#   dealer - (any)
#   modifiedbyEmailAddress - SOAP::SOAPString
#   customObject1Id - (any)
#   customObject1Name - (any)
#   customObject2Id - (any)
#   customObject2Name - (any)
#   customObject3Id - (any)
#   customObject3Name - (any)
#   customObject1ExternalSystemId - (any)
#   customObject2ExternalSystemId - (any)
#   customObject3ExternalSystemId - (any)
#   lastAssignmentSubmissionDate - SOAP::SOAPString
#   assignmentStatus - SOAP::SOAPString
#   lastAssignmentCompletionDate - SOAP::SOAPString
#   currencyCode - (any)
#   indexedBoolean0 - SOAP::SOAPString
#   indexedCurrency0 - SOAP::SOAPString
#   indexedDate0 - SOAP::SOAPString
#   indexedLongText0 - (any)
#   indexedNumber0 - SOAP::SOAPString
#   indexedPick0 - (any)
#   indexedPick1 - (any)
#   indexedPick2 - (any)
#   indexedPick3 - (any)
#   indexedPick4 - (any)
#   indexedPick5 - (any)
#   indexedShortText0 - (any)
#   indexedShortText1 - (any)
#   listOfActivity - ListOfActivity
#   listOfAuditTrail - ListOfAuditTrail
#   listOfNote - ListOfNote
#   listOfSolution - ListOfSolution
class ServiceRequest
  attr_accessor :lastUpdated
  attr_accessor :serviceRequestId
  attr_accessor :createdDate
  attr_accessor :modId
  attr_accessor :subject
  attr_accessor :accountName
  attr_accessor :accountId
  attr_accessor :accountLocation
  attr_accessor :area
  attr_accessor :assetId
  attr_accessor :closedTime
  attr_accessor :serviceRequestConcatField
  attr_accessor :workPhone
  attr_accessor :contactEmail
  attr_accessor :contactFirstName
  attr_accessor :contactFullName
  attr_accessor :contactId
  attr_accessor :contactLastName
  attr_accessor :createdByName
  attr_accessor :description
  attr_accessor :externalSystemId
  attr_accessor :integrationId
  attr_accessor :modifiedBy
  attr_accessor :modifiedByFullName
  attr_accessor :modifiedById
  attr_accessor :modifiedDate
  attr_accessor :openedTime
  attr_accessor :ownerId
  attr_accessor :owner
  attr_accessor :priority
  attr_accessor :product
  attr_accessor :productId
  attr_accessor :reassignOwnerFlag
  attr_accessor :sRNumber
  attr_accessor :type
  attr_accessor :assetName
  attr_accessor :cause
  attr_accessor :source
  attr_accessor :status
  attr_accessor :createdById
  attr_accessor :createdBy
  attr_accessor :dealerId
  attr_accessor :make
  attr_accessor :model
  attr_accessor :servicingDealer
  attr_accessor :year
  attr_accessor :accountExternalSystemId
  attr_accessor :assetExternalSystemId
  attr_accessor :productExternalSystemId
  attr_accessor :assetIntegrationId
  attr_accessor :productIntegrationId
  attr_accessor :dealerIntegrationId
  attr_accessor :dealerExternalSystemId
  attr_accessor :assessmentFilter1
  attr_accessor :assessmentFilter2
  attr_accessor :assessmentFilter3
  attr_accessor :assessmentFilter4
  attr_accessor :contactExternalSystemId
  attr_accessor :createdbyEmailAddress
  attr_accessor :lastAssessmentDate
  attr_accessor :ownerExternalSystemId
  attr_accessor :dealer
  attr_accessor :modifiedbyEmailAddress
  attr_accessor :customObject1Id
  attr_accessor :customObject1Name
  attr_accessor :customObject2Id
  attr_accessor :customObject2Name
  attr_accessor :customObject3Id
  attr_accessor :customObject3Name
  attr_accessor :customObject1ExternalSystemId
  attr_accessor :customObject2ExternalSystemId
  attr_accessor :customObject3ExternalSystemId
  attr_accessor :lastAssignmentSubmissionDate
  attr_accessor :assignmentStatus
  attr_accessor :lastAssignmentCompletionDate
  attr_accessor :currencyCode
  attr_accessor :indexedBoolean0
  attr_accessor :indexedCurrency0
  attr_accessor :indexedDate0
  attr_accessor :indexedLongText0
  attr_accessor :indexedNumber0
  attr_accessor :indexedPick0
  attr_accessor :indexedPick1
  attr_accessor :indexedPick2
  attr_accessor :indexedPick3
  attr_accessor :indexedPick4
  attr_accessor :indexedPick5
  attr_accessor :indexedShortText0
  attr_accessor :indexedShortText1
  attr_accessor :listOfActivity
  attr_accessor :listOfAuditTrail
  attr_accessor :listOfNote
  attr_accessor :listOfSolution

  def initialize(lastUpdated = nil, serviceRequestId = nil, createdDate = nil, modId = nil, subject = nil, accountName = nil, accountId = nil, accountLocation = nil, area = nil, assetId = nil, closedTime = nil, serviceRequestConcatField = nil, workPhone = nil, contactEmail = nil, contactFirstName = nil, contactFullName = nil, contactId = nil, contactLastName = nil, createdByName = nil, description = nil, externalSystemId = nil, integrationId = nil, modifiedBy = nil, modifiedByFullName = nil, modifiedById = nil, modifiedDate = nil, openedTime = nil, ownerId = nil, owner = nil, priority = nil, product = nil, productId = nil, reassignOwnerFlag = nil, sRNumber = nil, type = nil, assetName = nil, cause = nil, source = nil, status = nil, createdById = nil, createdBy = nil, dealerId = nil, make = nil, model = nil, servicingDealer = nil, year = nil, accountExternalSystemId = nil, assetExternalSystemId = nil, productExternalSystemId = nil, assetIntegrationId = nil, productIntegrationId = nil, dealerIntegrationId = nil, dealerExternalSystemId = nil, assessmentFilter1 = nil, assessmentFilter2 = nil, assessmentFilter3 = nil, assessmentFilter4 = nil, contactExternalSystemId = nil, createdbyEmailAddress = nil, lastAssessmentDate = nil, ownerExternalSystemId = nil, dealer = nil, modifiedbyEmailAddress = nil, customObject1Id = nil, customObject1Name = nil, customObject2Id = nil, customObject2Name = nil, customObject3Id = nil, customObject3Name = nil, customObject1ExternalSystemId = nil, customObject2ExternalSystemId = nil, customObject3ExternalSystemId = nil, lastAssignmentSubmissionDate = nil, assignmentStatus = nil, lastAssignmentCompletionDate = nil, currencyCode = nil, indexedBoolean0 = nil, indexedCurrency0 = nil, indexedDate0 = nil, indexedLongText0 = nil, indexedNumber0 = nil, indexedPick0 = nil, indexedPick1 = nil, indexedPick2 = nil, indexedPick3 = nil, indexedPick4 = nil, indexedPick5 = nil, indexedShortText0 = nil, indexedShortText1 = nil, listOfActivity = nil, listOfAuditTrail = nil, listOfNote = nil, listOfSolution = nil)
    @lastUpdated = lastUpdated
    @serviceRequestId = serviceRequestId
    @createdDate = createdDate
    @modId = modId
    @subject = subject
    @accountName = accountName
    @accountId = accountId
    @accountLocation = accountLocation
    @area = area
    @assetId = assetId
    @closedTime = closedTime
    @serviceRequestConcatField = serviceRequestConcatField
    @workPhone = workPhone
    @contactEmail = contactEmail
    @contactFirstName = contactFirstName
    @contactFullName = contactFullName
    @contactId = contactId
    @contactLastName = contactLastName
    @createdByName = createdByName
    @description = description
    @externalSystemId = externalSystemId
    @integrationId = integrationId
    @modifiedBy = modifiedBy
    @modifiedByFullName = modifiedByFullName
    @modifiedById = modifiedById
    @modifiedDate = modifiedDate
    @openedTime = openedTime
    @ownerId = ownerId
    @owner = owner
    @priority = priority
    @product = product
    @productId = productId
    @reassignOwnerFlag = reassignOwnerFlag
    @sRNumber = sRNumber
    @type = type
    @assetName = assetName
    @cause = cause
    @source = source
    @status = status
    @createdById = createdById
    @createdBy = createdBy
    @dealerId = dealerId
    @make = make
    @model = model
    @servicingDealer = servicingDealer
    @year = year
    @accountExternalSystemId = accountExternalSystemId
    @assetExternalSystemId = assetExternalSystemId
    @productExternalSystemId = productExternalSystemId
    @assetIntegrationId = assetIntegrationId
    @productIntegrationId = productIntegrationId
    @dealerIntegrationId = dealerIntegrationId
    @dealerExternalSystemId = dealerExternalSystemId
    @assessmentFilter1 = assessmentFilter1
    @assessmentFilter2 = assessmentFilter2
    @assessmentFilter3 = assessmentFilter3
    @assessmentFilter4 = assessmentFilter4
    @contactExternalSystemId = contactExternalSystemId
    @createdbyEmailAddress = createdbyEmailAddress
    @lastAssessmentDate = lastAssessmentDate
    @ownerExternalSystemId = ownerExternalSystemId
    @dealer = dealer
    @modifiedbyEmailAddress = modifiedbyEmailAddress
    @customObject1Id = customObject1Id
    @customObject1Name = customObject1Name
    @customObject2Id = customObject2Id
    @customObject2Name = customObject2Name
    @customObject3Id = customObject3Id
    @customObject3Name = customObject3Name
    @customObject1ExternalSystemId = customObject1ExternalSystemId
    @customObject2ExternalSystemId = customObject2ExternalSystemId
    @customObject3ExternalSystemId = customObject3ExternalSystemId
    @lastAssignmentSubmissionDate = lastAssignmentSubmissionDate
    @assignmentStatus = assignmentStatus
    @lastAssignmentCompletionDate = lastAssignmentCompletionDate
    @currencyCode = currencyCode
    @indexedBoolean0 = indexedBoolean0
    @indexedCurrency0 = indexedCurrency0
    @indexedDate0 = indexedDate0
    @indexedLongText0 = indexedLongText0
    @indexedNumber0 = indexedNumber0
    @indexedPick0 = indexedPick0
    @indexedPick1 = indexedPick1
    @indexedPick2 = indexedPick2
    @indexedPick3 = indexedPick3
    @indexedPick4 = indexedPick4
    @indexedPick5 = indexedPick5
    @indexedShortText0 = indexedShortText0
    @indexedShortText1 = indexedShortText1
    @listOfActivity = listOfActivity
    @listOfAuditTrail = listOfAuditTrail
    @listOfNote = listOfNote
    @listOfSolution = listOfSolution
  end
end

# {urn:/crmondemand/xml/servicerequest}ListOfActivity
class ListOfActivity < ::Array
end

# {urn:/crmondemand/xml/servicerequest}Activity
#   integrationId - SOAP::SOAPString
#   owner - (any)
#   subject - (any)
#   dueDate - SOAP::SOAPString
#   priority - (any)
#   status - (any)
#   type - (any)
#   accountId - SOAP::SOAPString
#   account - (any)
#   serviceRequestId - SOAP::SOAPString
#   campaignId - SOAP::SOAPString
#   campaign - (any)
#   description - (any)
#   contact - SOAP::SOAPString
#   createdById - SOAP::SOAPString
#   createdByName - (any)
#   createdDate - SOAP::SOAPString
#   currencyCode - SOAP::SOAPString
#   display - (any)
#   externalSystemId - (any)
#   lead - SOAP::SOAPString
#   leadId - SOAP::SOAPString
#   location - (any)
#   modifiedById - SOAP::SOAPString
#   modifiedDate - SOAP::SOAPString
#   modifiedBy - (any)
#   opportunity - (any)
#   opportunityId - SOAP::SOAPString
#   ownerId - SOAP::SOAPString
#   parentActivityId - SOAP::SOAPString
#   startTime - SOAP::SOAPString
#   endTime - SOAP::SOAPString
#   primaryContactId - SOAP::SOAPString
#   private - SOAP::SOAPString
#   createdBy - SOAP::SOAPString
#   activityId - SOAP::SOAPString
#   indexedBoolean0 - SOAP::SOAPString
#   indexedCurrency0 - SOAP::SOAPString
#   indexedDate0 - SOAP::SOAPString
#   indexedLongText0 - (any)
#   indexedNumber0 - SOAP::SOAPString
#   indexedPick0 - (any)
#   indexedPick1 - (any)
#   indexedPick2 - (any)
#   indexedPick3 - (any)
#   indexedPick4 - (any)
#   indexedPick5 - (any)
#   indexedShortText0 - (any)
#   indexedShortText1 - (any)
#   accountExternalSystemId - (any)
#   campaignExternalSystemId - (any)
#   opportunityExternalSystemId - (any)
#   leadExternalSystemId - (any)
class Activity
  attr_accessor :integrationId
  attr_accessor :owner
  attr_accessor :subject
  attr_accessor :dueDate
  attr_accessor :priority
  attr_accessor :status
  attr_accessor :type
  attr_accessor :accountId
  attr_accessor :account
  attr_accessor :serviceRequestId
  attr_accessor :campaignId
  attr_accessor :campaign
  attr_accessor :description
  attr_accessor :contact
  attr_accessor :createdById
  attr_accessor :createdByName
  attr_accessor :createdDate
  attr_accessor :currencyCode
  attr_accessor :display
  attr_accessor :externalSystemId
  attr_accessor :lead
  attr_accessor :leadId
  attr_accessor :location
  attr_accessor :modifiedById
  attr_accessor :modifiedDate
  attr_accessor :modifiedBy
  attr_accessor :opportunity
  attr_accessor :opportunityId
  attr_accessor :ownerId
  attr_accessor :parentActivityId
  attr_accessor :startTime
  attr_accessor :endTime
  attr_accessor :primaryContactId
  attr_accessor :private
  attr_accessor :createdBy
  attr_accessor :activityId
  attr_accessor :indexedBoolean0
  attr_accessor :indexedCurrency0
  attr_accessor :indexedDate0
  attr_accessor :indexedLongText0
  attr_accessor :indexedNumber0
  attr_accessor :indexedPick0
  attr_accessor :indexedPick1
  attr_accessor :indexedPick2
  attr_accessor :indexedPick3
  attr_accessor :indexedPick4
  attr_accessor :indexedPick5
  attr_accessor :indexedShortText0
  attr_accessor :indexedShortText1
  attr_accessor :accountExternalSystemId
  attr_accessor :campaignExternalSystemId
  attr_accessor :opportunityExternalSystemId
  attr_accessor :leadExternalSystemId

  def initialize(integrationId = nil, owner = nil, subject = nil, dueDate = nil, priority = nil, status = nil, type = nil, accountId = nil, account = nil, serviceRequestId = nil, campaignId = nil, campaign = nil, description = nil, contact = nil, createdById = nil, createdByName = nil, createdDate = nil, currencyCode = nil, display = nil, externalSystemId = nil, lead = nil, leadId = nil, location = nil, modifiedById = nil, modifiedDate = nil, modifiedBy = nil, opportunity = nil, opportunityId = nil, ownerId = nil, parentActivityId = nil, startTime = nil, endTime = nil, primaryContactId = nil, private = nil, createdBy = nil, activityId = nil, indexedBoolean0 = nil, indexedCurrency0 = nil, indexedDate0 = nil, indexedLongText0 = nil, indexedNumber0 = nil, indexedPick0 = nil, indexedPick1 = nil, indexedPick2 = nil, indexedPick3 = nil, indexedPick4 = nil, indexedPick5 = nil, indexedShortText0 = nil, indexedShortText1 = nil, accountExternalSystemId = nil, campaignExternalSystemId = nil, opportunityExternalSystemId = nil, leadExternalSystemId = nil)
    @integrationId = integrationId
    @owner = owner
    @subject = subject
    @dueDate = dueDate
    @priority = priority
    @status = status
    @type = type
    @accountId = accountId
    @account = account
    @serviceRequestId = serviceRequestId
    @campaignId = campaignId
    @campaign = campaign
    @description = description
    @contact = contact
    @createdById = createdById
    @createdByName = createdByName
    @createdDate = createdDate
    @currencyCode = currencyCode
    @display = display
    @externalSystemId = externalSystemId
    @lead = lead
    @leadId = leadId
    @location = location
    @modifiedById = modifiedById
    @modifiedDate = modifiedDate
    @modifiedBy = modifiedBy
    @opportunity = opportunity
    @opportunityId = opportunityId
    @ownerId = ownerId
    @parentActivityId = parentActivityId
    @startTime = startTime
    @endTime = endTime
    @primaryContactId = primaryContactId
    @private = private
    @createdBy = createdBy
    @activityId = activityId
    @indexedBoolean0 = indexedBoolean0
    @indexedCurrency0 = indexedCurrency0
    @indexedDate0 = indexedDate0
    @indexedLongText0 = indexedLongText0
    @indexedNumber0 = indexedNumber0
    @indexedPick0 = indexedPick0
    @indexedPick1 = indexedPick1
    @indexedPick2 = indexedPick2
    @indexedPick3 = indexedPick3
    @indexedPick4 = indexedPick4
    @indexedPick5 = indexedPick5
    @indexedShortText0 = indexedShortText0
    @indexedShortText1 = indexedShortText1
    @accountExternalSystemId = accountExternalSystemId
    @campaignExternalSystemId = campaignExternalSystemId
    @opportunityExternalSystemId = opportunityExternalSystemId
    @leadExternalSystemId = leadExternalSystemId
  end
end

# {urn:/crmondemand/xml/servicerequest}ListOfAuditTrail
class ListOfAuditTrail < ::Array
end

# {urn:/crmondemand/xml/servicerequest}AuditTrail
#   lastUpdated - SOAP::SOAPString
#   date - SOAP::SOAPString
#   user - (any)
#   fieldModified - (any)
#   newValue - (any)
#   oldValue - (any)
#   auditTrailId - SOAP::SOAPString
class AuditTrail
  attr_accessor :lastUpdated
  attr_accessor :date
  attr_accessor :user
  attr_accessor :fieldModified
  attr_accessor :newValue
  attr_accessor :oldValue
  attr_accessor :auditTrailId

  def initialize(lastUpdated = nil, date = nil, user = nil, fieldModified = nil, newValue = nil, oldValue = nil, auditTrailId = nil)
    @lastUpdated = lastUpdated
    @date = date
    @user = user
    @fieldModified = fieldModified
    @newValue = newValue
    @oldValue = oldValue
    @auditTrailId = auditTrailId
  end
end

# {urn:/crmondemand/xml/servicerequest}ListOfNote
class ListOfNote < ::Array
end

# {urn:/crmondemand/xml/servicerequest}Note
#   lastUpdated - SOAP::SOAPString
#   subject - (any)
#   createdByName - (any)
#   createdDate - SOAP::SOAPString
#   createdBy - SOAP::SOAPString
#   externalSystemId - (any)
#   modifiedBy - SOAP::SOAPString
#   modifiedById - SOAP::SOAPString
#   modifiedDate - SOAP::SOAPString
#   description - SOAP::SOAPString
#   private - SOAP::SOAPString
#   serviceRequestId - SOAP::SOAPString
#   createdById - SOAP::SOAPString
#   modId - (any)
#   noteId - SOAP::SOAPString
class Note
  attr_accessor :lastUpdated
  attr_accessor :subject
  attr_accessor :createdByName
  attr_accessor :createdDate
  attr_accessor :createdBy
  attr_accessor :externalSystemId
  attr_accessor :modifiedBy
  attr_accessor :modifiedById
  attr_accessor :modifiedDate
  attr_accessor :description
  attr_accessor :private
  attr_accessor :serviceRequestId
  attr_accessor :createdById
  attr_accessor :modId
  attr_accessor :noteId

  def initialize(lastUpdated = nil, subject = nil, createdByName = nil, createdDate = nil, createdBy = nil, externalSystemId = nil, modifiedBy = nil, modifiedById = nil, modifiedDate = nil, description = nil, private = nil, serviceRequestId = nil, createdById = nil, modId = nil, noteId = nil)
    @lastUpdated = lastUpdated
    @subject = subject
    @createdByName = createdByName
    @createdDate = createdDate
    @createdBy = createdBy
    @externalSystemId = externalSystemId
    @modifiedBy = modifiedBy
    @modifiedById = modifiedById
    @modifiedDate = modifiedDate
    @description = description
    @private = private
    @serviceRequestId = serviceRequestId
    @createdById = createdById
    @modId = modId
    @noteId = noteId
  end
end

# {urn:/crmondemand/xml/servicerequest}ListOfSolution
class ListOfSolution < ::Array
end

# {urn:/crmondemand/xml/servicerequest}Solution
#   lastUpdated - SOAP::SOAPString
#   externalSystemId - (any)
#   title - (any)
#   published - SOAP::SOAPString
#   solutionId - SOAP::SOAPString
#   status - (any)
#   createdById - SOAP::SOAPString
#   createdBy - SOAP::SOAPString
#   createdDate - SOAP::SOAPString
#   fAQ - (any)
#   modifiedBy - SOAP::SOAPString
#   modifiedById - SOAP::SOAPString
#   modifiedDate - SOAP::SOAPString
#   solutionDetails - (any)
#   solutionRating - SOAP::SOAPString
#   integrationId - SOAP::SOAPString
#   currencyCode - (any)
#   indexedBoolean0 - SOAP::SOAPString
#   indexedCurrency0 - SOAP::SOAPString
#   indexedDate0 - SOAP::SOAPString
#   indexedLongText0 - (any)
#   indexedNumber0 - SOAP::SOAPString
#   indexedPick0 - (any)
#   indexedPick1 - (any)
#   indexedPick2 - (any)
#   indexedPick3 - (any)
#   indexedPick4 - (any)
#   indexedPick5 - (any)
#   indexedShortText0 - (any)
#   indexedShortText1 - (any)
class Solution
  attr_accessor :lastUpdated
  attr_accessor :externalSystemId
  attr_accessor :title
  attr_accessor :published
  attr_accessor :solutionId
  attr_accessor :status
  attr_accessor :createdById
  attr_accessor :createdBy
  attr_accessor :createdDate
  attr_accessor :fAQ
  attr_accessor :modifiedBy
  attr_accessor :modifiedById
  attr_accessor :modifiedDate
  attr_accessor :solutionDetails
  attr_accessor :solutionRating
  attr_accessor :integrationId
  attr_accessor :currencyCode
  attr_accessor :indexedBoolean0
  attr_accessor :indexedCurrency0
  attr_accessor :indexedDate0
  attr_accessor :indexedLongText0
  attr_accessor :indexedNumber0
  attr_accessor :indexedPick0
  attr_accessor :indexedPick1
  attr_accessor :indexedPick2
  attr_accessor :indexedPick3
  attr_accessor :indexedPick4
  attr_accessor :indexedPick5
  attr_accessor :indexedShortText0
  attr_accessor :indexedShortText1

  def initialize(lastUpdated = nil, externalSystemId = nil, title = nil, published = nil, solutionId = nil, status = nil, createdById = nil, createdBy = nil, createdDate = nil, fAQ = nil, modifiedBy = nil, modifiedById = nil, modifiedDate = nil, solutionDetails = nil, solutionRating = nil, integrationId = nil, currencyCode = nil, indexedBoolean0 = nil, indexedCurrency0 = nil, indexedDate0 = nil, indexedLongText0 = nil, indexedNumber0 = nil, indexedPick0 = nil, indexedPick1 = nil, indexedPick2 = nil, indexedPick3 = nil, indexedPick4 = nil, indexedPick5 = nil, indexedShortText0 = nil, indexedShortText1 = nil)
    @lastUpdated = lastUpdated
    @externalSystemId = externalSystemId
    @title = title
    @published = published
    @solutionId = solutionId
    @status = status
    @createdById = createdById
    @createdBy = createdBy
    @createdDate = createdDate
    @fAQ = fAQ
    @modifiedBy = modifiedBy
    @modifiedById = modifiedById
    @modifiedDate = modifiedDate
    @solutionDetails = solutionDetails
    @solutionRating = solutionRating
    @integrationId = integrationId
    @currencyCode = currencyCode
    @indexedBoolean0 = indexedBoolean0
    @indexedCurrency0 = indexedCurrency0
    @indexedDate0 = indexedDate0
    @indexedLongText0 = indexedLongText0
    @indexedNumber0 = indexedNumber0
    @indexedPick0 = indexedPick0
    @indexedPick1 = indexedPick1
    @indexedPick2 = indexedPick2
    @indexedPick3 = indexedPick3
    @indexedPick4 = indexedPick4
    @indexedPick5 = indexedPick5
    @indexedShortText0 = indexedShortText0
    @indexedShortText1 = indexedShortText1
  end
end

# {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestUpdate_Input
#   listOfServiceRequest - ListOfServiceRequest
#   echo - SOAP::SOAPString
class ServiceRequestWS_ServiceRequestUpdate_Input
  attr_accessor :listOfServiceRequest
  attr_accessor :echo

  def initialize(listOfServiceRequest = nil, echo = nil)
    @listOfServiceRequest = listOfServiceRequest
    @echo = echo
  end
end

# {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestUpdate_Output
#   listOfServiceRequest - ListOfServiceRequest
class ServiceRequestWS_ServiceRequestUpdate_Output
  attr_accessor :listOfServiceRequest

  def initialize(listOfServiceRequest = nil)
    @listOfServiceRequest = listOfServiceRequest
  end
end

# {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestInsert_Input
#   listOfServiceRequest - ListOfServiceRequest
#   echo - SOAP::SOAPString
class ServiceRequestWS_ServiceRequestInsert_Input
  attr_accessor :listOfServiceRequest
  attr_accessor :echo

  def initialize(listOfServiceRequest = nil, echo = nil)
    @listOfServiceRequest = listOfServiceRequest
    @echo = echo
  end
end

# {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestInsert_Output
#   listOfServiceRequest - ListOfServiceRequest
class ServiceRequestWS_ServiceRequestInsert_Output
  attr_accessor :listOfServiceRequest

  def initialize(listOfServiceRequest = nil)
    @listOfServiceRequest = listOfServiceRequest
  end
end

# {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestDeleteChild_Input
#   listOfServiceRequest - ListOfServiceRequest
#   echo - SOAP::SOAPString
class ServiceRequestWS_ServiceRequestDeleteChild_Input
  attr_accessor :listOfServiceRequest
  attr_accessor :echo

  def initialize(listOfServiceRequest = nil, echo = nil)
    @listOfServiceRequest = listOfServiceRequest
    @echo = echo
  end
end

# {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestDeleteChild_Output
#   listOfServiceRequest - ListOfServiceRequest
class ServiceRequestWS_ServiceRequestDeleteChild_Output
  attr_accessor :listOfServiceRequest

  def initialize(listOfServiceRequest = nil)
    @listOfServiceRequest = listOfServiceRequest
  end
end

# {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestDelete_Input
#   listOfServiceRequest - ListOfServiceRequest
#   echo - SOAP::SOAPString
class ServiceRequestWS_ServiceRequestDelete_Input
  attr_accessor :listOfServiceRequest
  attr_accessor :echo

  def initialize(listOfServiceRequest = nil, echo = nil)
    @listOfServiceRequest = listOfServiceRequest
    @echo = echo
  end
end

# {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestDelete_Output
#   listOfServiceRequest - ListOfServiceRequest
class ServiceRequestWS_ServiceRequestDelete_Output
  attr_accessor :listOfServiceRequest

  def initialize(listOfServiceRequest = nil)
    @listOfServiceRequest = listOfServiceRequest
  end
end

# {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestUpdateChild_Input
#   listOfServiceRequest - ListOfServiceRequest
#   echo - SOAP::SOAPString
class ServiceRequestWS_ServiceRequestUpdateChild_Input
  attr_accessor :listOfServiceRequest
  attr_accessor :echo

  def initialize(listOfServiceRequest = nil, echo = nil)
    @listOfServiceRequest = listOfServiceRequest
    @echo = echo
  end
end

# {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestUpdateChild_Output
#   listOfServiceRequest - ListOfServiceRequest
class ServiceRequestWS_ServiceRequestUpdateChild_Output
  attr_accessor :listOfServiceRequest

  def initialize(listOfServiceRequest = nil)
    @listOfServiceRequest = listOfServiceRequest
  end
end

# {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestQueryPage_Input
#   useChildAnd - SOAP::SOAPString
#   pageSize - SOAP::SOAPString
#   listOfServiceRequest - ListOfServiceRequest
#   startRowNum - SOAP::SOAPString
class ServiceRequestWS_ServiceRequestQueryPage_Input
  attr_accessor :useChildAnd
  attr_accessor :pageSize
  attr_accessor :listOfServiceRequest
  attr_accessor :startRowNum

  def initialize(useChildAnd = nil, pageSize = nil, listOfServiceRequest = nil, startRowNum = nil)
    @useChildAnd = useChildAnd
    @pageSize = pageSize
    @listOfServiceRequest = listOfServiceRequest
    @startRowNum = startRowNum
  end
end

# {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestQueryPage_Output
#   lastPage - SOAP::SOAPString
#   listOfServiceRequest - ListOfServiceRequest
class ServiceRequestWS_ServiceRequestQueryPage_Output
  attr_accessor :lastPage
  attr_accessor :listOfServiceRequest

  def initialize(lastPage = nil, listOfServiceRequest = nil)
    @lastPage = lastPage
    @listOfServiceRequest = listOfServiceRequest
  end
end

# {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestInsertOrUpdate_Input
#   listOfServiceRequest - ListOfServiceRequest
#   echo - SOAP::SOAPString
class ServiceRequestWS_ServiceRequestInsertOrUpdate_Input
  attr_accessor :listOfServiceRequest
  attr_accessor :echo

  def initialize(listOfServiceRequest = nil, echo = nil)
    @listOfServiceRequest = listOfServiceRequest
    @echo = echo
  end
end

# {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestInsertOrUpdate_Output
#   listOfServiceRequest - ListOfServiceRequest
class ServiceRequestWS_ServiceRequestInsertOrUpdate_Output
  attr_accessor :listOfServiceRequest

  def initialize(listOfServiceRequest = nil)
    @listOfServiceRequest = listOfServiceRequest
  end
end

# {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestInsertChild_Input
#   listOfServiceRequest - ListOfServiceRequest
#   echo - SOAP::SOAPString
class ServiceRequestWS_ServiceRequestInsertChild_Input
  attr_accessor :listOfServiceRequest
  attr_accessor :echo

  def initialize(listOfServiceRequest = nil, echo = nil)
    @listOfServiceRequest = listOfServiceRequest
    @echo = echo
  end
end

# {urn:crmondemand/ws/servicerequest/10/2004}ServiceRequestWS_ServiceRequestInsertChild_Output
#   listOfServiceRequest - ListOfServiceRequest
class ServiceRequestWS_ServiceRequestInsertChild_Output
  attr_accessor :listOfServiceRequest

  def initialize(listOfServiceRequest = nil)
    @listOfServiceRequest = listOfServiceRequest
  end
end
