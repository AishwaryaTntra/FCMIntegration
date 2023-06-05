# frozen_string_literal: true

# app > serializers > event_serializer
class EventSerializer
  include JSONAPI::Serializer
  attributes :name, :user, :created_at, :updated_at
end
