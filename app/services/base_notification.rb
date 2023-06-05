# frozen_string_literal: true

require 'fcm'
# app > services > base_notification
class BaseNotification
  FCM_SERVER_KEY = Rails.application.credentials.dig(:fcm, :server_key)

  def self.fcm_client
    FCM.new(FCM_SERVER_KEY)
  end

  def self.options(title, body, data)
    {
      notification: {
        title:,
        body:,
        sound: 'default',
        vibrate_timings: %w[200 300],
        # priority: 2,
        notification_priority: 2,
        default_light_settings: true
      },
      data: data.merge!(collapse_key: SecureRandom.uuid)
    }
  end

  def self.create_notification(notification_params)
    Notification.create(notification_params)
  end

  def self.fcm_data(data, notification_id)
    data.merge!(notification_id:)
  end
end
