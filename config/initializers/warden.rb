require "warden/strategies/ldap"

::Rails.configuration.middleware.use ::Warden::Manager do |manager|
  manager.failure_app = lambda { |env| ::SessionsController.action(:new).call(env) }
end

::Warden::Manager.serialize_into_session(&:id)

::Warden::Manager.serialize_from_session do |id|
  ::User.find(id)
end
