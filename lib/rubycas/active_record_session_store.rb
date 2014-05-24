module RubyCAS
  class ActiveRecordSessionStore
    def initialize
      case Rails::VERSION::MAJOR
      when 4
        # Rails 4.0
        @required_session_store = ActionDispatch::Session::ActiveRecordStore
        @current_session_store  = ::Rails.application.config.session_store
      when 3
        # Rails 3.0
        @required_session_store = ActiveRecord::SessionStore
        @current_session_store  = ::Rails.application.config.session_store

      # Untested but should be OK
      # when 2
        # if Rails::VERSION::MINOR >= 3
          # Rails 2.3
          # @required_session_store = ActiveRecord::SessionStore
          # @current_session_store  = ActionController::Base.session_store
        # else
          # Rails 2.2
          # @required_session_store = CGI::Session::ActiveRecordStore
          # @current_session_store  = ActionController::Base.session_options[:database_manager]
        # end
      end
    end

    def session_store_is_valid?
      @required_session_store == @current_session_store
    end

    def find_by_session_id(session_id)
      case Rails::VERSION::MAJOR
      when 4
        # Rails 4.0
        session = @current_session_store.session_class.find_by_session_id(session_id)
      when 3
        # Rails 3.0
        session = @current_session_store::Session.find_by_session_id(session_id)

      # Untested but should be OK
      # when 2
        # Rails 2.0
        # session = @current_session_store::Session.find_by_session_id(session_id)
      end
      session
    end
  end
end
