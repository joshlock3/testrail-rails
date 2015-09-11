module TestRail
  class Suite

    def initialize(api_client)
      @api_client = api_client
    end

    def find(suite_name, project)
      suite_path = "get_suites/#{project["id"]}"
      suites = @api_client.send_get(suite_path)
      suites.select{ |x| x["name"]== suite_name }.first
    end

    def create(suite_name, project)
      suite_path = "add_suite/#{project["id"]}"
      @api_client.send_post(suite_path,{"name" => suite_name})
    end

    def find_or_create(suite_name, project)
      find(suite_name, project) || create(suite_name, project)
    end

  end
end
