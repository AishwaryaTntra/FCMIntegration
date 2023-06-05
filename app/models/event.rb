# frozen_string_literal: true

# app > models > event.rb
class Event < ApplicationRecord
  validates :name, presence: true
  after_create :send_notification
  belongs_to :user

  def send_notification
    recievers = User.all
    recievers.each do |receiver|
      NewEventNotification.push(self, receiver)
    end
  end
end
