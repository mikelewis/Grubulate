class Notification < ActiveRecord::Base
  belongs_to :notifiable, :polymorphic => true
  belongs_to :sender, :foreign_key => "sender_id", :class_name => "Profile"
  belongs_to :receiver, :foreign_key => "receiver_id", :class_name => "Profile"
  validates :sender_id, :presence => true
  validates :receiver_id, :presence => true
  validates :notifiable_id, :presence => true
  validates :notifiable_type, :presence => true


  class << self
    def add(notifiable, sender=nil, receiver = nil)
      if notifiable.is_a?(Comment)
        sender ||= notifiable.profile
        receiver ||= notifiable.recipe.profile
      elsif notifiable.is_a?(Recipe) 
        sender ||= notifiable.profile
        receiver ||= notifiable.profile.fans
      end

      attrs = {:sender => sender, :receiver => receiver, :notifiable => notifiable, 
               :notifiable_type => notifiable.class.to_s}

      if receiver.is_a?(Array)
        receiver.each{|r| create_notification(attrs.merge(:receiver => r)) }
      else
        create_notification(attrs)
      end
    end

    def create_notification(args)
      create(args)
    end

    def method_missing(meth, *args, &blk)
      if meth.to_s =~ /^add_(comment|recipe)$/
        add(*args, &blk)
      else
        super
      end
    end

    def respond_to?(meth, include_private = false)
      if meth.to_s =~ /^add_(comment|recipe)$/
        true
      else
        super
      end
    end
  end
end
