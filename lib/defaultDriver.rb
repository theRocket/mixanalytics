require 'default.rb'
require 'defaultMappingRegistry.rb'
require 'soap/rpc/driver'

class Default_Binding_ServiceRequest < ::SOAP::RPC::Driver
  DefaultEndpointUrl = "https://secure-ausomxbha.crmondemand.com/Services/Integration"

  Methods = [
    [ "document/urn:crmondemand/ws/servicerequest/10/2004:ServiceRequestUpdate",
      "serviceRequestUpdate",
      [ ["in", "ServiceRequestWS_ServiceRequestUpdate_Input", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/10/2004", "ServiceRequestWS_ServiceRequestUpdate_Input"]],
        ["out", "ServiceRequestWS_ServiceRequestUpdate_Output", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/10/2004", "ServiceRequestWS_ServiceRequestUpdate_Output"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "document/urn:crmondemand/ws/servicerequest/10/2004:ServiceRequestInsert",
      "serviceRequestInsert",
      [ ["in", "ServiceRequestWS_ServiceRequestInsert_Input", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/10/2004", "ServiceRequestWS_ServiceRequestInsert_Input"]],
        ["out", "ServiceRequestWS_ServiceRequestInsert_Output", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/10/2004", "ServiceRequestWS_ServiceRequestInsert_Output"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "document/urn:crmondemand/ws/servicerequest/10/2004:ServiceRequestDeleteChild",
      "serviceRequestDeleteChild",
      [ ["in", "ServiceRequestWS_ServiceRequestDeleteChild_Input", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/10/2004", "ServiceRequestWS_ServiceRequestDeleteChild_Input"]],
        ["out", "ServiceRequestWS_ServiceRequestDeleteChild_Output", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/10/2004", "ServiceRequestWS_ServiceRequestDeleteChild_Output"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "document/urn:crmondemand/ws/servicerequest/10/2004:ServiceRequestDelete",
      "serviceRequestDelete",
      [ ["in", "ServiceRequestWS_ServiceRequestDelete_Input", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/10/2004", "ServiceRequestWS_ServiceRequestDelete_Input"]],
        ["out", "ServiceRequestWS_ServiceRequestDelete_Output", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/10/2004", "ServiceRequestWS_ServiceRequestDelete_Output"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "document/urn:crmondemand/ws/servicerequest/10/2004:ServiceRequestUpdateChild",
      "serviceRequestUpdateChild",
      [ ["in", "ServiceRequestWS_ServiceRequestUpdateChild_Input", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/10/2004", "ServiceRequestWS_ServiceRequestUpdateChild_Input"]],
        ["out", "ServiceRequestWS_ServiceRequestUpdateChild_Output", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/10/2004", "ServiceRequestWS_ServiceRequestUpdateChild_Output"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "document/urn:crmondemand/ws/servicerequest/10/2004:ServiceRequestQueryPage",
      "serviceRequestQueryPage",
      [ ["in", "ServiceRequestWS_ServiceRequestQueryPage_Input", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/10/2004", "ServiceRequestWS_ServiceRequestQueryPage_Input"]],
        ["out", "ServiceRequestWS_ServiceRequestQueryPage_Output", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/10/2004", "ServiceRequestWS_ServiceRequestQueryPage_Output"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "document/urn:crmondemand/ws/servicerequest/10/2004:ServiceRequestInsertOrUpdate",
      "serviceRequestInsertOrUpdate",
      [ ["in", "ServiceRequestWS_ServiceRequestInsertOrUpdate_Input", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/10/2004", "ServiceRequestWS_ServiceRequestInsertOrUpdate_Input"]],
        ["out", "ServiceRequestWS_ServiceRequestInsertOrUpdate_Output", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/10/2004", "ServiceRequestWS_ServiceRequestInsertOrUpdate_Output"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ],
    [ "document/urn:crmondemand/ws/servicerequest/10/2004:ServiceRequestInsertChild",
      "serviceRequestInsertChild",
      [ ["in", "ServiceRequestWS_ServiceRequestInsertChild_Input", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/10/2004", "ServiceRequestWS_ServiceRequestInsertChild_Input"]],
        ["out", "ServiceRequestWS_ServiceRequestInsertChild_Output", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/10/2004", "ServiceRequestWS_ServiceRequestInsertChild_Output"]] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal,
        :faults => {} }
    ]
  ]

  def initialize(endpoint_url = nil)
    endpoint_url ||= DefaultEndpointUrl
    super(endpoint_url, nil)
    self.mapping_registry = DefaultMappingRegistry::EncodedRegistry
    self.literal_mapping_registry = DefaultMappingRegistry::LiteralRegistry
    init_methods
  end

private

  def init_methods
    Methods.each do |definitions|
      opt = definitions.last
      if opt[:request_style] == :document
        add_document_operation(*definitions)
      else
        add_rpc_operation(*definitions)
        qname = definitions[0]
        name = definitions[2]
        if qname.name != name and qname.name.capitalize == name.capitalize
          ::SOAP::Mapping.define_singleton_method(self, qname.name) do |*arg|
            __send__(name, *arg)
          end
        end
      end
    end
  end
end

