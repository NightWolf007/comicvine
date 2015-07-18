module Comicvine
  module Character
    URL = "/characters"
    FIELDS = [ :aliases, :api_detail_url, :birth, :character_enemies,
               :character_friends, :count_of_issue_appearances, :creators, :date_added, :date_last_updated,
               :deck, :description, :first_appeared_in_issue, :gender, :id, :image, :issue_credits, :issues_died_in,
               :movies, :name, :origin, :powers, :publisher, :real_name, :site_detail_url, :story_arc_credits,
               :team_enemies, :team_friends, :teams, :volume_credits ]
    SingleCharacter = Struct.new(*FIELDS)

    def self.find(id)
      custom_query = { filter: "id:#{id}" }
      response = HTTParty.get(Comicvine::API::BASE_URL + URL, { query: Comicvine::API::QUERY.merge(custom_query) })
      character = Comicvine::Utils.symbolize_keys(response["results"].first)
      SingleCharacter.new(*character.values_at(*SingleCharacter.members))
    end
  end
end