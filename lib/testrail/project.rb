module TestRail
  class Project

    def initialize(api_client)
      @api_client = api_client
    end

    def find(project_name)
      projects = @api_client.send_get('get_projects')
      projects.select{ |x| x["name"]== project_name }.first
    end
  end
end