ActiveAdmin.register Client do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :provider, :uid, :encrypted_password, :reset_password_token, :reset_password_sent_at, :allow_password_change, :remember_created_at, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :name, :image, :email, :tokens, :type
  #
  # or
  #
  # permit_params do
  #   permitted = [:provider, :uid, :encrypted_password, :reset_password_token, :reset_password_sent_at, :allow_password_change, :remember_created_at, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :name, :image, :email, :tokens, :type]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
