class RemoveIndexResultToTestPassages < ActiveRecord::Migration[5.2]
  def change
    remove_index :test_passages, :result 
  end
end
