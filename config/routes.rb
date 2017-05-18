Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/resume" => redirect("http://res.cloudinary.com/hkowwlpd3/image/upload/v1495143616/eric_norcross_resume_prwwdz.pdf")
  root 'application#home'
end
