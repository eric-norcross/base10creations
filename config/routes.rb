Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/resume" => redirect("http://res.cloudinary.com/hkowwlpd3/image/upload/v1500399019/eric_norcross_resume_uf9l1d.pdf")
  root 'application#home'
end
