module WBench
  class GistWriter
    
    def self.write_gist(result, gist_results)
      gw = GistWriter.new(gist_results)
      gw.json_request(result)
      gw.create_gist
    end
  
    def initialize(gist_results)
      @gist_results = gist_results
    end
  
    def github_credentials
      # grab the github user and token from ENV[]
      @github_user   = ENV["GITHUB_USER"]
      @github_token  = ENV["GITHUB_TOKEN"]
      
      # if the user and token are not nil, proceed to create the gist
      (@github_user && @github_token) ? true : false
    end
    
    def json_request(results)
      # prepare the JSON used in the request with the options for the Gist
      name = @gist_results[:name]
      is_public = !(@gist_results[:secret])
      @json = {description: "WBench Results", public: is_public, files: {"#{name}.txt" => {content: results.to_s }}}
    end

    def create_gist
      # check to see if user has set GitHub user and token (or post anonymous)
      credentials = github_credentials ? "#{@github_user}:#{@github_token}@" : ""
      
      resp = RestClient.post "https://#{credentials}api.github.com/gists", @json.to_json, content_type: :json, accept: :json
      
      # if created response
      if resp.code == 201
        j_resp = JSON.parse(resp)
        gist_num = j_resp["id"]
        out = "=> Created Gist with ID #{gist_num}: (https://gist.github.com/#{gist_num})"
      end
    rescue
      out = "=> Something went wrong creating a Gist."
    end
  end
end