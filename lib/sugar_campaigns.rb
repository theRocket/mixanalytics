class SugarCampaigns < SugarAdapter

  def initialize(source,credential)
    super(source,credential)
    
    @module_name = 'Campaigns'
    @select_fields = %w(
    name
    date_entered
    date_modified
    assigned_user_name
    team_name
    start_date
    end_date
    status
    budget
    expected_revenue
    campaign_type
    )
    @order_by = ''
  end
end
