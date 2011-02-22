Factory.define :user do |u|
  u.sequence(:email) { |n| "mike#{n}@awesome.com"}
  u.password "funnyguy1"
  u.password_confirmation {|u| u.password }
  u.authentications {|authentications| [authentications.association(:authentication)]}
end

Factory.define :profile do |p|
  p.sequence(:username) { |n| "madmike#{n}"}
  p.user {|i| i.association(:user)}
end

Factory.define :authentication do |a|
  a.provider "Facebook"
  a.sequence(:uid){|n| "random#{n}"}
end

Factory.define :entree do |e|
  e.sequence(:name) {|n| "Entree#{n}"}
end

Factory.define :ingredient do |a|
  a.sequence(:name) {|n| "Ingredient #{n}"}
end

Factory.define :recipe do |e|
  e.sequence(:title) { |n| "My Title #{n}"}
  e.short_desc "This is a short description regarding this recipe... I hope you find it OK!"
  e.instructions "Do this, then that. and maybe this for 5 minutes"
  e.difficulty 3
  e.cook_time 65
  e.profile {|i| i.association(:profile)}
  e.ingredients { |ingredients| [ingredients.association(:ingredient)]}
end

Factory.define :appliance do |a|
  a.sequence(:name) {|n| "Appliance #{n}"}
end

Factory.define :comment do |c|
  c.body  "Great Recipe man!"
  c.recipe {|i| i.association(:recipe)}
  c.profile {|i| i.association(:profile)}
end

Factory.define :notification do |n|
  n.sender {|i| i.association(:profile)}
  n.receiver {|i| i.association(:profile)}
  n.notifiable {|i| i.association(:recipe)}
  n.notifiable_type "Recipe"
end
