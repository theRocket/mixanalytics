class SugarCampaigns < SugarAdapter

  def initialize(source,credential)
    super(source,credential)
    
    @module_name = 'Campaigns'
    @select_fields = %w(
    name
    date_entered
    date_modified
    modified_user_id
    modified_by_name
    created_by
    created_by_name
    assigned_user_id
    assigned_user_name
    team_id
    team_name
    tracker_key
    tracker_count
    refer_url
    tracker_text
    start_date
    end_date
    status
    impressions
    currency_id
    budget
    expected_cost
    actual_cost
    expected_revenue
    campaign_type
    objective
    content
    frequency
    )
    @order_by = ''
  end
end
