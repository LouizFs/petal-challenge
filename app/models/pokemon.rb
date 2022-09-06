class Pokemon < ApplicationRecord
  include Filterable

  scope :filter_by_name, ->(name) { where(name: name) }

  validates :name, presence: true

end
