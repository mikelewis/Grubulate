

madmike_user = User.seed(:email) do |s|
  s.email = "madmike@grubulate.com"
  s.password = "funnyguy1"
  s.password_confirmation = "funnyguy1"
end

jouhan_user = User.seed(:email) do |s|
  s.email = "jouhan@grubulate.com"
  s.password = "funnygirl1"
  s.password_confirmation = "funnygirl1"
end


tim_user = User.seed(:email) do |s|
  s.email = "tim@grubulate.com"
  s.password = "funnyguy2"
  s.password_confirmation = "funnyguy2"
end
alex_user = User.seed(:email) do |s|
  s.email = "alex@grubulate.com"
  s.password = "funnyguy3"
  s.password_confirmation = "funnyguy3"
end

madmike_profile = Profile.seed(:username) do |s|
  s.username = "madmike"
  s.user_id = madmike_user.first.id
end

jouhan_profile = Profile.seed(:username) do |s|
  s.username = "jouhan"
  s.user_id = jouhan_user.first.id
end

tim_profile = Profile.seed(:username) do |s|
  s.username = "tim"
  s.user_id = tim_user.first.id
end

alex_profile = Profile.seed(:username) do |s|
  s.username = "alex"
  s.user_id = alex_user.first.id
end


profileIds = [madmike_profile.first.id, jouhan_profile.first.id, tim_profile.first.id, alex_profile.first.id]
profiles = [madmike_profile.first, jouhan_profile.first, tim_profile.first, alex_profile.first]


#need to factor these out soon
def load_comments(recipe, profileIds)
  return if !recipe.comments.empty?
  (1..rand(10)).each do |num|
    recipe.comments.create({
      :body => "Fantastic Recipe #{num}", :profile_id => profileIds[rand(profileIds.size)]
    })
  end

end

def load_ratings(recipe, profiles)
  return if recipe.total_rates > 0
  (1..profiles.size).each do |num|
    recipe.rate(rand(5) + 1, profiles[rand(profiles.size)])
  end
end

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




           recipes = []
           (1..22).each do |num|
             recipes << {
               :title => "Recipe #{num}", :difficulty => rand(5) + 1,
               :short_desc => "Short Desc #{num}", :instructions => "Instructions #{num}",
               :cook_time => rand(150), :profile_id => profileIds[rand(profileIds.size)]

             }
           end
           Recipe.seed(:id, :title, recipes.each{|r| r})

           Recipe.all.each do |recipe|
             load_comments(recipe, profileIds)
             load_ratings(recipe, profiles)
           end
