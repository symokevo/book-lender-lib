class Book < ApplicationRecord
  has_many :borrowings, dependent: :destroy

  validates :title, presence: true
  validates :author, presence: true
  validates :published_year, presence: true, numeraciality: { only_integer: true }
  validates :status, inclusion: { in: %w[available borrowed] }
end
