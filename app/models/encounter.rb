class Encounter < ApplicationRecord
  has_many :enemies

  def characters
    @characters ||= Character.all
  end
end
