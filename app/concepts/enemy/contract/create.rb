module Enemy::Contract
  class Create < Reform::Form
    property :name
    property :hit_points
    property :armor_class
    property :encounter_id
    property :initiative_bonus

    validates :name, presence: true
    validates :hit_points, presence: true, numericality: true
    validates :armor_class, presence: true, numericality: true
    validates :initiative_bonus, presence: true, numericality: true
    validates :encounter_id, presence: true
  end
end
