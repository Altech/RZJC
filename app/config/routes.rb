Rails.application.routes.draw do
  root to: "single#index"
  %w[index qanda teams solo_players].each do |page|
    get "/#{page}", to: "single##{page}"
  end
  %w[submit mediation].each do |page|
    get "/#{page}", to: "single##{page}"
    post "/#{page}", to: "single##{page}_post"
  end
  get "/priv/confirmation_for_team", to: "single#confirmation_for_team"
  get "/priv/confirmation_for_solo_player", to: "single#confirmation_for_solo_player"
end
