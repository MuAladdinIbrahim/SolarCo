class GeocoderController < ApplicationController
  def getLocation
    if params[:lat] && params[:long]
      res_loc = (Geocoder.search([params[:lat], params[:long]])[0].data).to_hash['address']
      
      render json: {"city" => res_loc['city'],"country" => res_loc['country']}
    else
      puts params[:ip]
      res_ip = (Geocoder.search(params[:ip])[0].data).to_hash
      loc = res_ip['loc'].split(',') unless res_ip['loc'].nil?

      render json: {"city" => res_ip['city'],"country" => res_ip['country']}
    end
  end
end
