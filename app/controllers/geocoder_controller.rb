class GeocoderController < ApiController

  def getLocation    
    if geocoder_params[:lat] && geocoder_params[:long] && res_loc = (Geocoder.search([geocoder_params[:lat].round(6), geocoder_params[:long].round(6)])[0].data).to_hash['address']

      puts (Geocoder.search([geocoder_params[:lat].round(6), geocoder_params[:long].round(6)])[0].data).to_yaml

      render json: jsonFormat(geocoder_params[:lat].round(6), geocoder_params[:long].round(6), res_loc['city'], res_loc['country'])
    else
      getbyIP
    end
  end
  
  private
  
  def getbyIP
    ip = geocoder_params[:ip] || request.remote_ip
    if ( ip )
      res_ip = (Geocoder.search(ip)[0].data).to_hash
      loc = res_ip['loc'].split(',') unless res_ip['loc'].nil?
      
      render json: jsonFormat(loc[0].to_f.round(6), loc[1].to_f.round(6), res_ip['city'], res_ip['country'])
    else
      render json: {"permission" => false}
    end
  end
  
  def jsonFormat(lat, long, city, country)
    {"consumption" => geocoder_params[:consump], "ip" => geocoder_params[:ip], "latitude" => lat, "longitude" => long, "city" => city, "country" => country, "permission" => true}
  end 

  def geocoder_params
    params.require(:geocoder).permit(:id, :src, :consump, :ip, :lat, :long)
  end
end
