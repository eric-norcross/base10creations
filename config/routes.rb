Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/resume" => redirect("http://res.cloudinary.com/hkowwlpd3/image/upload/v1494542404/eric_norcross_resume3_tc9wmo.pdf")
  root 'application#home'
end
