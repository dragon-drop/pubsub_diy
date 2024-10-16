class Event < ApplicationRecord
  belongs_to :record, polymorphic: true
end
