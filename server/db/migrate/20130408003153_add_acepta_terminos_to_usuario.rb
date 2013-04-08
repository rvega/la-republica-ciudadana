class AddAceptaTerminosToUsuario < ActiveRecord::Migration
  def change
    add_column :usuarios, :acepta_terminos, :boolean
  end
end
