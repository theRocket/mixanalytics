class SugarOpportunities < SugarAdapter

  def initialize(source,credential)
    super(source,credential)
    
    @module_name = 'Opportunities'
    @select_fields = %w(
      name
      date_entered
      date_modified
      modified_user_id
      modified_by_name
      created_by
      created_by_name
      description
      assigned_user_id
      assigned_user_name
      opportunity_type
      account_name
      campaign_id
      campaign_name
      lead_source
      amount
      amount_usdollar
      currency_id
      currency_name
      currency_symbol
      date_closed
      next_step
      sales_stage
      probability
    )
    @order_by = ''
  end
end
