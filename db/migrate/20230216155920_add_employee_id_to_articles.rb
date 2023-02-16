class AddEmployeeIdToArticles < ActiveRecord::Migration[6.1]
  def change
    add_reference :articles, :employee, foreign_key: true
  end
end
