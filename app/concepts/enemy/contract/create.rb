module Enemy::Contract
  class Create < Reform::Form
    property :name
    property :hit_points
    property :armor_class

    validates :name, presence: true
    validates :hit_points, presence: true, numericality: true
    validates :armor_class, presence: true, numericality: true
  end
end
