Rails.application.routes.draw do
  root to: "single#index"
  %w[index qanda submit mediation teams].each do |page|
    get "/#{page}", to: "single##{page}"
  end
  %w[submit mediaton].each do |page|
    get "/#{page}", to: "single##{page}"
    post "/#{page}", to: "single##{page}_post"
  end
  get "/priv/confirmation_for_team", to: "single#confirmation_for_team"
end
