class SugarContacts < SugarAdapter

  def initialize(source,credential)
    super(source,credential)
    
    @module_name = 'Contacts'
    @select_fields = %w(
      date_entered
      date_modified
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
      reports_to_id
      report_to_name
      birthdate
      campaign_id
      campaign_name
    )
    @order_by = 'last_name'
  end
end

