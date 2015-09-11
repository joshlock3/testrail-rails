module TestRail
  class Section

    def initialize(api_client)
      @api_client = api_client
    end

    def find(section_name, suite, project)
      section_path = "get_sections/#{project["id"]}&suite_id=#{suite["id"]}"
      sections = @api_client.send_get(section_path)
      sections.select{ |x| x["name"]== section_name}.first
    end

    def create(section_name, suite, project)
      section_path = "add_section/#{project["id"]}"
      section_data = build_section_hash(suite,section_name)
      @api_client.send_post(section_path, section_data)
    end

    def find_or_create(section_name, suite, project)
      find(section_name,suite,project) || create(section_name,suite,project)
    end

    private

    def build_section_hash(suite,section_name)
      section = Hash.new
      section["name"] = section_name
      section["suite_id"] =  suite["id"]

      section
    end
  end
end