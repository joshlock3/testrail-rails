require 'testrail/release'

module TestRail
  class TestRun

    def initialize(api_client)
      @api_client = api_client
      @release = TestRail::Release.new(api_client)
    end

    def find(test_run_name, project)
      test_run_path = "get_runs/#{project["id"]}"
      tests = @api_client.send_get(test_run_path)
      tests.select{ |x| x["name"]== test_run_name }.first
    end

    def create(test_run_name, project, suite)
      release = @release.find_or_create(project)
      test_run_path = "add_run/#{project["id"]}"
      test_run_data = build_test_run_hash(suite,test_run_name,release)
      @api_client.send_post(test_run_path,test_run_data)
    end

    def find_or_create(project, suite)
      find(test_run_name,project) || create(test_run_name, project, suite)
    end

    private

    def test_run_name
      "Auto Regression Test Run for: #{Date.today}"
    end

    def build_test_run_hash(suite,test_run_name,release)
      test_run = Hash.new
      test_run["name"] = test_run_name
      test_run["suite_id"] =  suite["id"]
      test_run["description"] = "Testing for #{Time.at(release["due_on"]).to_date} release"
      test_run["milestone_id"] = release["id"]
      test_run["assignedto_id"] = user_id

      test_run
    end

    def find_user
      @api_client.send_get("get_user_by_email&email=#{@api_client.user}")
    end

    def user_id
      find_user["id"]
    end

  end
end
