RailsAdmin.config do |config|
  ### Popular gems integration

  ## redirect to root if not admin
  config.authorize_with do |controller|
    unless current_user.admin
      flash[:error] = 'Accès réservé'
      redirect_to main_app.root_path
    end
  end

  ## == Devise ==
  config.authenticate_with do
     warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

  end
end
