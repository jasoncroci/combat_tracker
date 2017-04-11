class Combat < ApplicationRecord
  acts_as_paranoid
  belongs_to :user
  belongs_to :encounter
end
