class SugarEmployees < SugarAdapter

  def initialize(source,credential)
    super(source,credential)
    
    @module_name = 'Employees'
    @select_fields = %w(
      user_name
      sugar_login
      first_name
      last_name
      reports_to_id
      reports_to_name
      is_admin
      receive_notifications
      description
      date_entered
      date_modified
      modified_user_id
      created_by
      title
      department
      phone_home
      phone_mobile
      phone_work
      phone_other
      phone_fax
      status
      address_street
      address_city
      address_state
      address_country
      address_postalcode
      user_preferences
      employee_status
      messenger_id
      messenger_type
      email1
      is_group
      c_accept_status_fields
      m_accept_status_fields
      modified_by_name
      created_by_name
    )
    @order_by = 'last_name'
    @query_filter = "(users.employee_status='Active')"
  end
end
