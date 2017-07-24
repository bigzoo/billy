class CreateTableCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table(:companies)do |t|
      t.column(:name,:string)
      t.column(:email,:string)
      t.column(:password,:string)
      t.column(:image,:varchar)
      t.timestamps()
    end
  end
end
