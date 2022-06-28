# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  protected

  def correct_avatar # rubocop:disable Metrics/AbcSize
    if avatar.attached? && !avatar.content_type.in?(%w(image/jpeg image/png))
      errors.add(:avatar, 'must be a JPEG or PNG')
    elsif avatar.attached? == false
      errors.add(:avatar, 'Required')
    elsif avatar.blob.byte_size > 4000.kilobytes
      errors[:base] << 'Too big'
    end
  end
end
