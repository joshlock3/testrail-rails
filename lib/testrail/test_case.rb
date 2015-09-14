require 'testrail/release'

module TestRail
  class TestCase

    def initialize(api_client)
      @api_client = api_client
      @release = TestRail::Release.new(@api_client)
    end

    def find(test_name, suite, section, project)
      test_path = "get_cases/#{project["id"]}&suite_id=#{suite["id"]}&section_id=#{section["id"]}"
      tests = @api_client.send_get(test_path)
      tests.select{ |x| x["title"]== test_name }.first
    end

    def create(test_name, section, project)
      release = @release.find_or_create(project)
      test_case_data = build_test_case_hash(release,test_name)
      test_path = "add_case/#{section["id"]}"
      @api_client.send_post(test_path, test_case_data)
    end

    def find_or_create(test_name, suite, section, project)
      find(test_name, suite, section, project) || create(test_name, section, project)
    end

    def build_test_case_hash(release,test_name)
      test_case = Hash.new
      test_case["title"] = test_name
      test_case["milestone_id"] = release["id"]

      test_case
    end
  end
end
