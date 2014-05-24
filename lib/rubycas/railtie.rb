require_relative 'filter'

module RubyCAS
  class Railtie < Rails::Railtie
    config.rubycas = ActiveSupport::OrderedOptions.new

    initializer 'rubycas.initialize' do |app|
      RubyCAS::Filter.setup(config.rubycas)
    end
  end
end