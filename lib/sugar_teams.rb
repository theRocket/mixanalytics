class SugarTeams < SugarAdapter

  def initialize(source,credential)
    super(source,credential)
    
    @module_name = 'Teams'
    @select_fields = %w(
      name
      private
      description
    )
    @order_by = ''
  end
end
