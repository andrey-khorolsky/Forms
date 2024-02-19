class FieldType < ApplicationRecord
  validates :name, presence: true
  validates :name, format: {with: /\A[a-zA-Z]+\z/, message: "Only letters are allowed"}
end
