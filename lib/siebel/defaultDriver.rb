require 'siebel/default.rb'

require 'soap/rpc/driver'

class Default_Binding_ServiceRequest < ::SOAP::RPC::Driver
  DefaultEndpointUrl = "http://CHANGE_ME"
  MappingRegistry = ::SOAP::Mapping::Registry.new

  Methods = [
    [ "document/urn:crmondemand/ws/servicerequest/:ServiceRequestUpdate",
      "serviceRequestUpdate",
      [ ["in", "ServiceRequestWS_ServiceRequestUpdate_Input", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/", "ServiceRequestWS_ServiceRequestUpdate_Input"], true],
        ["out", "ServiceRequestWS_ServiceRequestUpdate_Output", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/", "ServiceRequestWS_ServiceRequestUpdate_Output"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "document/urn:crmondemand/ws/servicerequest/:ServiceRequestInsert",
      "serviceRequestInsert",
      [ ["in", "ServiceRequestWS_ServiceRequestInsert_Input", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/", "ServiceRequestWS_ServiceRequestInsert_Input"], true],
        ["out", "ServiceRequestWS_ServiceRequestInsert_Output", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/", "ServiceRequestWS_ServiceRequestInsert_Output"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "document/urn:crmondemand/ws/servicerequest/:ServiceRequestDeleteChild",
      "serviceRequestDeleteChild",
      [ ["in", "ServiceRequestWS_ServiceRequestDeleteChild_Input", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/", "ServiceRequestWS_ServiceRequestDeleteChild_Input"], true],
        ["out", "ServiceRequestWS_ServiceRequestDeleteChild_Output", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/", "ServiceRequestWS_ServiceRequestDeleteChild_Output"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "document/urn:crmondemand/ws/servicerequest/:ServiceRequestDelete",
      "serviceRequestDelete",
      [ ["in", "ServiceRequestWS_ServiceRequestDelete_Input", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/", "ServiceRequestWS_ServiceRequestDelete_Input"], true],
        ["out", "ServiceRequestWS_ServiceRequestDelete_Output", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/", "ServiceRequestWS_ServiceRequestDelete_Output"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "document/urn:crmondemand/ws/servicerequest/:ServiceRequestUpdateChild",
      "serviceRequestUpdateChild",
      [ ["in", "ServiceRequestWS_ServiceRequestUpdateChild_Input", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/", "ServiceRequestWS_ServiceRequestUpdateChild_Input"], true],
        ["out", "ServiceRequestWS_ServiceRequestUpdateChild_Output", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/", "ServiceRequestWS_ServiceRequestUpdateChild_Output"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "document/urn:crmondemand/ws/servicerequest/:ServiceRequestQueryPage",
      "serviceRequestQueryPage",
      [ ["in", "ServiceRequestWS_ServiceRequestQueryPage_Input", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/", "ServiceRequestWS_ServiceRequestQueryPage_Input"], true],
        ["out", "ServiceRequestWS_ServiceRequestQueryPage_Output", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/", "ServiceRequestWS_ServiceRequestQueryPage_Output"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "document/urn:crmondemand/ws/servicerequest/:ServiceRequestInsertOrUpdate",
      "serviceRequestInsertOrUpdate",
      [ ["in", "ServiceRequestWS_ServiceRequestInsertOrUpdate_Input", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/", "ServiceRequestWS_ServiceRequestInsertOrUpdate_Input"], true],
        ["out", "ServiceRequestWS_ServiceRequestInsertOrUpdate_Output", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/", "ServiceRequestWS_ServiceRequestInsertOrUpdate_Output"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ "document/urn:crmondemand/ws/servicerequest/:ServiceRequestInsertChild",
      "serviceRequestInsertChild",
      [ ["in", "ServiceRequestWS_ServiceRequestInsertChild_Input", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/", "ServiceRequestWS_ServiceRequestInsertChild_Input"], true],
        ["out", "ServiceRequestWS_ServiceRequestInsertChild_Output", ["::SOAP::SOAPElement", "urn:crmondemand/ws/servicerequest/", "ServiceRequestWS_ServiceRequestInsertChild_Output"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ]
  ]

  def initialize(endpoint_url = nil)
    endpoint_url ||= DefaultEndpointUrl
    super(endpoint_url, nil)
    self.mapping_registry = MappingRegistry
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

