require 'test_rail/testrail'

module TestRail
  class Client
    attr_accessor :connection

    def initialize(user,password)
      @connection = TestRail::APIClient.new(url)
      @connection.user = user
      @connection.password = password
    end

    private

    def url
      APP_CONFIG[:testrail_url]
    end
  end
end