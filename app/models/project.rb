class Project < ApplicationRecord
  has_many :events, as: :record
end
