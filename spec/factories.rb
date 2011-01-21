Factory.define :user do |u|
  u.sequence(:email) { |n| "mike#{n}@awesome.com"}
  u.password "funnyguy1"
  u.password_confirmation {|u| u.password }
end

Factory.define :profile do |p|
  p.sequence(:username) { |n| "madmike#{n}"}
  p.user {|i| i.association(:user)}
end

Factory.define :entree do |e|
  e.sequence(:name) {|n| "Entree#{n}"}
end

Factory.define :recipe do |e|
  e.sequence(:title) { |n| "My Title #{n}"}
  e.short_desc "This is a short description regarding this recipe... I hope you find it OK!"
  e.instructions "Do this, then that. and maybe this for 5 minutes"
  e.difficulty 3
  e.cook_time 65
  e.profile {|i| i.association(:profile)}
end

Factory.define :appliance do |a|
  a.sequence(:name) {|n| "Appliance #{n}"}
end

Factory.define :ingredient do |a|
  a.sequence(:name) {|n| "Ingredient #{n}"}
end
