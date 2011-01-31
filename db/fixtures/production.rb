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


                     
           appliances = []
           File.open("#{Rails.root.join('db/fixtures/')}appliances.txt", 'r') do |file|
             while(line = file.gets)
               appliances << {:name => line.strip.titleize}
             end
           end

           Appliance.seed(:name, appliances.each{|e| e})



