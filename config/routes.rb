Rails.application.routes.draw do
  # get '/assets/*', to: redirect('/trackers/:name.gif')
  # get '/assets', to: redirect('/trackers/1'), constraints: { name: /.+/, ext: /(jpg|png|gif)/ }

  # Admins
  scope nil, module: :admins do
    devise_for :admins, 
      skip: :registrations
  end

  authenticated :admin do
    # Manage
    get '/dashboard',      to: redirect('manage/pages'), as: :dashboard

    namespace :manage, module: :manage, admin_scope: true do
      resources :links,       except: [:new, :show]
      resources :figures,     except: [:new, :show]
      resources :items,       except: [:new, :show]
      resources :pages,       except: [:show]
      resources :quotes,      except: [:show]
      resources :sections,    except: [:new, :show]
      resources :trackers,    except: [:show]
    end
  end

  resources :pages,           only: [:show]
  resources :trackers,        only: [:show]

  get "/resume"     => redirect("http://res.cloudinary.com/hkowwlpd3/image/upload/v1500399019/eric_norcross_resume_uf9l1d.pdf")
  # get "/assets/tracker-b1442e85b03bdcaf66dc58c7abb98745dd2687d86350be9a298a1d9382ac849b.gif" => redirect("http://base10creations.com/trackers/1")


  


  # http://base10creations.com/assets/tracker-b1442e85b03bdcaf66dc58c7abb98745dd2687d86350be9a298a1d9382ac849b.gif
  if Rails.env.production?
    # Production only routes
    match '*a',
      to:   redirect { |p, req| req.flash[:error] = "The page you were looking for \"#{req.env["HTTP_HOST"]}#{req.env["REQUEST_PATH"]}\" could not be found."; '/' },
      via:  :get
  end
  

  root to: 'application#home', id: "home"
end
