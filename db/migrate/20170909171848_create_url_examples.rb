class CreateUrlExamples < ActiveRecord::Migration
  def change
    create_table :url_examples do |t|
      t.string :longUrl
      t.string :shortUrl
      t.string :customAlias
      t.string :qtdAcesso

      t.timestamps null: false
    end
  end
end
