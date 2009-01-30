class SugarMeetings < SugarAdapter

  def initialize(source,credential)
    super(source,credential)
    
    @module_name = 'Meetings'
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
      location
      duration_hours
      duration_minutes
      date_start
      date_end
      parent_type
      status
      parent_id
      reminder_time
      contact_name
    )
    @order_by = ''
  end
end
