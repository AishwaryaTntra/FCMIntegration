# frozen_string_literal: true

# app > serializers > user_serializer
class UserSerializer
  include JSONAPI::Serializer
  attributes :email, :name, :fcm_token, :created_at, :updated_at
end
