require "reform/form/coercion"

module Combat::Contract
  class Create < Reform::Form
    feature Coercion

    property :current_round, default: 1, virtual: true
    property :current_turn, virtual: true

    property :encounter, populate_if_empty: Encounter, virtual: true do
      property :name
      property :challenge_rating
      property :experience_points
    end

    collection :enemies, populate_if_empty: Enemy, default: [], virtual: true do
      property :id
      property :name
      property :hit_points, type: Types::Form::Int
      property :armor_class, type: Types::Form::Int
      property :initiative_bonus, type: Types::Form::Int
      # Virtual Fields
      property :current_hit_points, type: Types::Form::Int, virtual: true, default: -> { self.hit_points }
      property :initiative, type: Types::Form::Int, virtual: true, default: 0
      property :visible, type: Types::Form::Bool, virtual: true, default: false

      def identity
        "enemy_#{id}"
      end
    end

    collection :characters, populate_if_empty: Character, default: [], virtual: true do
      property :id
      property :name
      property :hit_points, type: Types::Form::Int
      property :armor_class, type: Types::Form::Int
      # Virtual Fields
      property :current_hit_points, type: Types::Form::Int, virtual: true, default: -> { self.hit_points }
      property :initiative, type: Types::Form::Int, virtual: true, default: 0
      property :visible, type: Types::Form::Bool, virtual: true, default: true

      def identity
        "character_#{id}"
      end
    end

    def start_combat!
      set_enemy_initiative!
    end

    def active_enemies
      enemies.select { |enemy| enemy.current_hit_points > 0 }
    end

    def combatants
      (active_enemies + characters).sort!{ |a, b| b.initiative <=> a.initiative }
    end

    private

    def set_enemy_initiative!
      enemies.each do |enemy|
        enemy.initiative = D20.roll(enemy.initiative_bonus)
      end
    end
  end
end
