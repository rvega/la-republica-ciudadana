class CreateVotos < ActiveRecord::Migration
  def change
    create_table :votos do |t|
      t.references :usuario
      t.references :votable, :polymorphic=>true
      t.integer :value

      t.timestamps
    end
  end
end
