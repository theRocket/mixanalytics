class SugarOpportunities < SugarAdapter

  def initialize(source,credential)
    super(source,credential)
    
    @module_name = 'Opportunities'
    @select_fields = %w(
      name
      date_entered
      date_modified
      modified_by_name
      created_by
      created_by_name
      description
      assigned_user_name
      opportunity_type
      account_name
      campaign_name
      lead_source
      amount
      amount_usdollar
      date_closed
      next_step
      sales_stage
      probability
    )
    @order_by = ''
  end
end
