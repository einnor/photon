class Event < ActiveRecord::Base
  belongs_to :chama

  # Validate fields
  validates :title, presence: true
  validates :start, presence: true
  validates :end, presence: true
  validates :importance, presence: true
  validates :chama_id, presence: true
end
