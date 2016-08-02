class Soc_med < ApplicationRecord
  validates :t_id, uniqueness: true
end
