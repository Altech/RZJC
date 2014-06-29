Rails.application.routes.draw do
  root to: "single#index"
  %w[index qanda submit mediation].each do |page|
    get "/#{page}", to: "single##{page}"
  end
end
