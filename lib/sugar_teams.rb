class SugarTeams < SugarAdapter

  def initialize(source)
    super(source)
    
    @module_name = 'Teams'
    @select_fields = %w(
      name
      private
      description
    )
    @order_by = ''
  end
end
