class SugarAccounts < SugarAdapter

  def initialize(source,credential)
    super(source,credential)
    
    @module_name = 'Accounts'
    @select_fields = %w(
      name
      date_entered
      date_modified
      description
      assigned_user_id
      assigned_user_name
      team_id
      team_name
      account_type
      industry
      annual_revenue
      phone_fax
      billing_address_street
      billing_address_city
      billing_address_state
      billing_address_postalcode
      billing_address_country
      rating
      phone_office
      phone_alternate
      website
      ownership
      employees
      ticker_symbol
      shipping_address_street
      shipping_address_city
      shipping_address_state
      shipping_address_postalcode
      shipping_address_country
      email1
      parent_id
      sic_code
      parent_name
    )
  end
end