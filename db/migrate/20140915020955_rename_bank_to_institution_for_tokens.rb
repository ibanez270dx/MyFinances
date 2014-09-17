class RenameBankToInstitutionForTokens < ActiveRecord::Migration
  def change
    change_table :tokens do |t|
      t.rename :bank, :institution
    end
  end
end
