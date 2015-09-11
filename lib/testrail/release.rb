module TestRail
  class Release
    BASE_DATE= Date.new(2015,3,24)

    def initialize(api_client)
      @api_client = api_client
    end

    def find(release_name, project)
      milestone_path = "get_milestones/#{project["id"]}"
      releases = @api_client.send_get(milestone_path)
      releases.select{ |x| x["name"]== release_name }.first
    end

    def create(project)
      release_path = "add_milestone/#{project["id"]}"
      release_data = determine_release
      @api_client.send_post(release_path,release_data)
    end

    def find_or_create(project)
      release_data = determine_release
      find(release_data["name"], project) || create(project)
    end

    private

    def determine_release(days_per_sprint=14)
      current_date = Date.today
      days = (current_date - BASE_DATE).to_i
      release_data = Hash.new

      if days % days_per_sprint == 0
        release_date = (current_date + days_per_sprint)
        release_data = build_release_hash(release_date)
      else
        release_date = BASE_DATE + (days_per_sprint * (days/days_per_sprint).floor) + days_per_sprint
        release_data = build_release_hash(release_date)
      end

      release_data
    end

    def build_release_hash(release_date)
      release = Hash.new
      release["name"] = "Sprint Release #{release_date.strftime("%d%m%y")}"
      release["due_on"] =  release_date.to_time.to_i
      release["description"] =  "Automated Release Milestone created for #{release_date} release"

      release
    end
  end
end