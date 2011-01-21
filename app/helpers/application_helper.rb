module ApplicationHelper
  def setup_user(user)
    user.tap do |u|
      u.build_profile if u.profile.nil?
    end
  end

  def setup_recipe(recipe)
    recipe.tap do |r|
      r.entrees.build if r.entrees.empty?
    end
  end

  def form_errors(model)
    str = ""
    if model.errors.any?
      str << "<div>"
      str << "<h2>"
      str << "#{pluralize(model.errors.count, 'errors')} prohibited this #{model.class.to_s.downcase} from being saved."
      str << "</h2>"
      model.errors.full_messages.each do |msg|
        str << "<li>#{msg}</li>"
      end
      str << "</div>"
    end
    str.html_safe
  end

  def recipe_in_entree?(recipe, entree)
    recipe.entrees.include?(entree)
  end
end
