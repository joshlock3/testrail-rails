module TestRail
  class Client
    attr_accessor :connection, :url, :username, :password

    def initialize(username,password,url)
      @url_endpoint = url || self.class.url
      @connection = APIClient.new(url)
      @connection.user = username || self.class.username
      @connection.password = password || self.class.password
    end

    def project
      Project.new(connection)
    end

    def release
      Release.new(connection)
    end

    def section
      Section.new(connection)
    end

    def suite
      Suite.new(connection)
    end

    def test_case
      TestCase.new(connection)
    end

    def test_result
      TestResult.new(connection)
    end

    def test_run
      TestRun.new(connection)
    end
  end
end
