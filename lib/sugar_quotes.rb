class SugarQuotes < SugarAdapter

  def initialize(source,credential)
    super(source,credential)
    
    @module_name = 'Quotes'
    @select_fields = %w(
      name
      date_entered
      date_modified
      modified_user_id
      modified_by_name
      created_by
      created_by_name
      description
      deleted
      assigned_user_id
      assigned_user_name
      team_id
      team_name
      shipper_id
      currency_id
      taxrate_id
      show_line_nums
      calc_grand_total
      quote_type
      date_quote_expected_closed
      original_po_date
      payment_terms
      date_quote_closed
      date_order_shipped
      order_stage
      quote_stage
      purchase_order_num
      quote_num
      subtotal
      subtotal_usdollar
      shipping
      shipping_usdollar
      tax
      tax_usdollar
      total
      total_usdollar
      billing_address_street
      billing_address_city
      billing_address_state
      billing_address_postalcode
      billing_address_country
      shipping_address_street
      shipping_address_city
      shipping_address_state
      shipping_address_postalcode
      shipping_address_country
      system_id
      shipping_account_name
      shipping_contact_name
      shipping_contact_id
      account_name
      billing_account_name
      billing_contact_name
      billing_contact_id
      opportunity_name    
    )
    @order_by = ''
  end
end
