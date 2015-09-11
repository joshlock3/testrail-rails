module TestRail
  class TestResult

    def initialize(api_client)
      @api_client = api_client
    end

    def test_status(status)
      case status
        when 'passed'
          1
        when 'failed'
          5
        else
          2
      end
    end

    def test_comment(status)
      case status
        when 'Passed'
          "Automated Test Passed"
        when 'Failed'
          "Automated Test Failed"
      end
    end

    def build_test_result_hash(result_hash)
      results = Hash.new
      results["status_id"] = test_status(result_hash["status"])
      results["comment"] = test_comment(result_hash["status"])
      results["assignedto_id"] = user_id

      results
    end

    def find_user
      @api_client.send_get("get_user_by_email&email=#{@api_client.user}")
    end

    def user_id
      find_user["id"]
    end
  end
end