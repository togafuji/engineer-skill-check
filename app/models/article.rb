# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :employee

  validates :title, presence: true, length: { maximum: 50 }

  scope :active, lambda {
    where(deleted_at: nil)
  }
end
