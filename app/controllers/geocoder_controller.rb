class GeocoderController < ApplicationController
  def getLocation
    if params[:lat] && params[:long]
      render json: {"permission" => false} if (params[:lat].to_f).abs > 70
      res_loc = (Geocoder.search([params[:lat], params[:long]])[0].data).to_hash['address']
      
      render json: {"city" => res_loc['city'],"country" => res_loc['country'], "permission" => true}
    else
      puts params[:ip]
      res_ip = (Geocoder.search(params[:ip])[0].data).to_hash
      loc = res_ip['loc'].split(',') unless res_ip['loc'].nil?
      puts loc
      render json: {"permission" => false} if (loc[0].to_f).abs() > 70

      render json: {"city" => res_ip['city'],"country" => res_ip['country'], "permission" => true}
    end
  end
end
