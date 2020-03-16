# frozen_string_literal: true

class Gif < ApplicationRecord
  has_one_attached :img

  validate :img_is_present
  validate :file_size_cannot_be_more_than_10m

  def file_size_cannot_be_more_than_10m
    if img.attached?
      if img.blob.byte_size > 500 * 1000
        errors.add(:img, "can't be more than 500K")
      end
    end
  end

  def img_is_present
    errors.add(:img, 'is missing') unless img.attached?
  end
end
