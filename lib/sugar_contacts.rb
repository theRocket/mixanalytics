class SugarContacts < SugarAdapter

  def initialize(source,credential)
    super(source,credential)
    
    @module_name = 'Contacts'
    @select_fields = %w(
      date_entered
      date_modified
      modified_user_id
      modified_by_name
      created_by
      created_by_name
      description
      assigned_user_id
      assigned_user_name
      team_id
      team_name
      salutation
      first_name
      last_name
      title
      department
      do_not_call
      phone_home
      phone_mobile
      phone_work
      phone_other
      phone_fax
      email1
      email2
      primary_address_street
      primary_address_city
      primary_address_state
      primary_address_postalcode
      primary_address_country
      alt_address_street
      alt_address_city
      alt_address_state
      alt_address_postalcode
      alt_address_country
      assistant
      assistant_phone
      lead_source
      account_name
      account_id
      opportunity_role_fields
      reports_to_id
      report_to_name
      birthdate
      portal_name
      portal_active
      portal_app
      campaign_id
      campaign_name
      c_accept_status_fields
      m_accept_status_fields
    )
    @order_by = 'last_name'
  end
end

