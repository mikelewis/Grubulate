madmike_user = User.seed(:email) do |s|
  s.email = "madmike@grubulate.com"
  s.password = "funnyguy1"
  s.password_confirmation = "funny_guy1"
end

jouhan_user = User.seed(:email) do |s|
  s.email = "jouhan@grubulate.com"
  s.password = "funnygirl1"
  s.password_confirmation = "funny_girl1"
end

madmike_profile = Profile.seed(:username) do |s|
  s.username = "madmike"
  s.user_id = madmike_user.first.id
end

jouhan_profile = Profile.seed(:username) do |s|
  s.username = "jouhan"
  s.user_id = jouhan_user.first.id
end

profileIds = [madmike_profile.first.id, jouhan_profile.first.id]

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


           recipes = []
           (1..22).each do |num|
             recipes << {
               :title => "Recipe #{num}", :difficulty => rand(5) + 1,
               :short_desc => "Short Desc #{num}", :instructions => "Instructions #{num}",
               :cook_time => rand(150), :profile_id => profileIds[rand(profileIds.size)]
             }
           end
           Recipe.seed(:id, :title, recipes.each{|r| r})

