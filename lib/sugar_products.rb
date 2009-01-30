class SugarProducts < SugarAdapter

  def initialize(source,credential)
    super(source,credential)
    
    @module_name = 'Products'
    @select_fields = %w(
    name
    date_entered
    date_modified
    modified_user_id
    modified_by_name
    created_by
    created_by_name
    description
    team_id
    team_name
    product_template_id
    account_id
    contact_id
    contact_name
    type_id
    quote_id
    manufacturer_id
    category_id
    category_name
    mft_part_num
    vendor_part_num
    date_purchased
    cost_price
    discount_price
    list_price
    cost_usdollar
    discount_usdollar
    list_usdollar
    currency_id
    status
    tax_class
    website
    weight
    quantity
    support_name
    support_description
    support_contact
    support_term
    date_support_expires
    date_support_starts
    pricing_formula
    pricing_factor
    serial_number
    asset_number
    book_value
    book_value_date
    quote_name
    account_name
    
    )
    @order_by = ''
  end
end