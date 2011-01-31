class Appliance < ActiveRecord::Base
  has_many :equipments
  has_many :recipes, :through => :equipments

  validates :name, :presence => true


  def as_json(options={})
    {:value => name}
  end

  class << self
    def names_to_ids(appliances)
      where(:name => appliances).select('id').map{|e| e.id}
    end
  end

end
