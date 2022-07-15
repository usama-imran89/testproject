# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  protected

  def correct_avatar
    if avatar.attached? == false
      errors.add(:avatar, 'Avtar Required')
    elsif !avatar.content_type.in?(%w[image/jpeg image/png])
      errors.add(:avatar, 'must be a JPEG or PNG')
    elsif avatar.blob.byte_size > 4000.kilobytes
      errors.add(:avatar, 'Size is too big')
    end
  end
end
