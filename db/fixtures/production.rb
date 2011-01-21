Entree.seed(:name,
            {:name => "Snack"},
            {:name => "Breakfast"},
            {:name => "Lunch"},
            {:name => "Dinner"}
           )

           ingredients = []
           File.open("#{Rails.root.join('db/fixtures/')}ingredients.txt", 'r') do |file|
             while(line = file.gets)
               ingredients << {:name => line.strip.titleize}
             end
           end

           Ingredient.seed(:name, ingredients.each{|e| e})
