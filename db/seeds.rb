require 'csv'

CSV_FILE_PATH =  Rails.root.join("public", "pokemon.csv")

CSV.foreach(CSV_FILE_PATH) do |row|
  Pokemon.create(name: row[1], type_1: row[2], type_2: row[3], total: row[4], hp: row[5], attack: row[6], defense: row[7], sp_atk: row[8], sp_def: row[9], speed: row[10], generation: row[11], legendary: row[12] )
end

User.create(username: 'petal', password: 'petal', email: 'petal@hotmail.com')

