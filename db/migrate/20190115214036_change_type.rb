class ChangeType < ActiveRecord::Migration[5.2]
  def change
    change_column :stators, :corrosives_resistance, 'integer USING CAST(corrosives_resistance AS integer)'
    change_column :stators, :api_index, 'integer USING CAST(api_index AS integer)'
    change_column :stators, :aromatics, 'integer USING CAST(aromatics AS integer)'
  end
end
