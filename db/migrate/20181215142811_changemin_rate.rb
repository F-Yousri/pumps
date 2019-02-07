class ChangeminRate < ActiveRecord::Migration[5.2]
  def change
    rename_column :esp_performance_curves, :minRate, :minrate
    rename_column :esp_performance_curves, :maxRate, :maxrate
  end
end
