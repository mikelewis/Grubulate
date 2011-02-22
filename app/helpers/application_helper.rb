module ApplicationHelper
  def num_unseen_notifications(profile)
    0
    #profile.unseen_notifications.count
  end

  def most_recent_unseen_notification(profile)
    profile.unseen_notifications
  end

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

  # NEEDS WORK
  def show_link_unless_current_params(param_name, param_value,  &block)
    require 'uri'
    require 'cgi'
    new_link_to_class = Class.new do
      def initialize(helper)
        @helper = helper
      end
      define_method(:link_to) do |*args, &block|
        name = args.first
        url = args.second
        opts = CGI.parse(URI.parse(url).query || "") || {}
        param_value = [param_value] unless param_value.is_a?(Array)
        return name if @helper.params[param_name.to_sym] == param_value.first && opts[param_name] == param_value
        @helper.link_to(*args, &block)
      end
    end
    yield new_link_to_class.new(self)
  end

end
