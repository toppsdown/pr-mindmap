require 'httparty'


# curl -v -u "toppy42" -H "X-GitHub-OTP:412513" https://api.github.com/repos/PracticallyGreen/pg/pulls/4153/files

class GithubApiClient
  include HTTParty
  base_uri 'https://api.github.com'

end
