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
