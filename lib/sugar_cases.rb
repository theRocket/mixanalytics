class SugarCases < SugarAdapter

  def initialize(source,credential)
    super(source,credential)
    
    @module_name = 'Cases'
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
      case_number
      type
      status
      priority
      resolution
      work_log
      account_name
      account_id
    )
    @order_by = 'case_number'
  end
end
