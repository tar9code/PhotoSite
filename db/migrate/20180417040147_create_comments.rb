class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.column  :photo_id,          :integer
      t.column  :user_id,           :integer
      t.column  :comment_text,      :string
      t.column  :date_time,        :date_time
      t.timestamps
    end
  end
end
