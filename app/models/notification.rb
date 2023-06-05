# frozen_string_literal: true

# app > models > notification.rb
class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true
  validates :title, :body, :data, :notifiable_type, :notifiable_id, presence: true
end
