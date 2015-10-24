ActiveRecord::Base.module_eval do
  class << self
    def inherited_with_paper_trail(subclass)
      skip_models = %w(schema_migrations versions).freeze

      inherited_without_paper_trail(subclass)

      table_name = subclass.table_name

      if !skip_models.include?(table_name) && table_name.present?
        subclass.send(:has_paper_trail)
      end
    end

    alias_method_chain :inherited, :paper_trail
  end
end
