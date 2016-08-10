require "ldap_fluff"
require "warden"

module Warden
  module Strategies
    class LDAP < Warden::Strategies::Base
      class << self
        attr_reader :domain
      end

      def self.configure
        full_config_path = ::Rails.root.join("config", "ldap_config.yml")
        yaml_string = ::ERB.new(::File.read(full_config_path)).result
        yaml_config = ::YAML.load(yaml_string, :safe => true)[::Rails.env]

        # FIXME: This is janky. There has to be a better way.
        @domain = yaml_config.delete("option_active_directory_domain")

        config.merge!(yaml_config)
      end

      def self.config
        @config ||= {}.with_indifferent_access
      end

      def authenticate!
        if ldap.authenticate?(active_directory_username, password)
          user = ::User.where(:username => username.parameterize).first_or_initialize
          user.assign_attributes(
            :email_address => "#{username}@mx.com",
            :first_name => name.first,
            :last_name => name.last
          )
          user.save!
        end

        user ? success!(user) : fail!("You could not be authenticated with LDAP.")
      end

      def valid?
        password && username
      end

    private

      def active_directory_username
        @active_directory_username ||= "#{self.class.domain}\\#{username}"
      end

      def ldap
        @ldap ||= LdapFluff.new(self.class.config)
      end

      def name
        @name ||= begin
          names = username.split(".")
          names.map!(&:capitalize)
          names
        end
      end

      def password
        params["password"]
      end

      def username
        @username ||= params["username"].gsub(/@mx\.com$/, "")
      end

      # Initialize the configuration
      configure

      ::Warden::Strategies.add(:ldap, self)
    end
  end
end
