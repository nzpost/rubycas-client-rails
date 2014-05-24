require_relative 'filter'

module RubyCAS
  class GatewayFilter < Filter
    def self.use_gatewaying?
      @@config[:use_gatewaying] != false
    end
  end
end