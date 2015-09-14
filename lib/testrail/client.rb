require 'test_rail/testrail'

module TestRail
  class Client
    attr_accessor :connection

    def initialize(user,password,url)
      @connection = TestRail::APIClient.new(url)
      @connection.user = user
      @connection.password = password
    end
  end
end
