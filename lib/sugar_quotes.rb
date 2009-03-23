class SugarQuotes < SugarAdapter

  def initialize(source,credential)
    super(source,credential)
    
    @module_name = 'Quotes'
    @select_fields = %w(
      name
      date_entered
      date_modified
      assigned_user_name
      team_name
      quote_type
      payment_terms
      quote_stage
      purchase_order_num
      quote_num
      subtotal
      total
      billing_address_street
      billing_address_city
      billing_address_state
      billing_address_postalcode
      billing_address_country
      billing_account_name
      opportunity_name
    )
    @order_by = ''
  end
end
