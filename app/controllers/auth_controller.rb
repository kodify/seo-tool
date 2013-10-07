class AuthController < ApplicationController

  def oauth2
    client = GoogleOAuth::Client.new(
        :client_id => 'YOUR_CLIENT_ID',
        :client_secret => 'YOUR_CLIENT_SECRET',
        :redirect => 'YOUR_REDIRECT_URI',
    )

    redirect_to client.authorization_url
  end

  def oauth2callback
    token = client.authorize(:code => params[:code])
  end

end