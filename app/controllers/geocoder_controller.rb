class GeocoderController < ApiController

  def getLocation    
    if params[:lat] && params[:long] && res_loc = (Geocoder.search([params[:lat].round(4), params[:long].round(4)])[0].data).to_hash['address']
      render json: jsonFormat(params[:lat].round(4), params[:long].round(4), res_loc['city'], res_loc['country'])
    else
      getbyIP
    end
  end

  private
  
  def getbyIP
    res_ip = (Geocoder.search(params[:ip])[0].data).to_hash
    loc = res_ip['loc'].split(',') unless res_ip['loc'].nil?

    render json: jsonFormat(loc[0].to_f.round(4), loc[1].to_f.round(4), res_ip['city'], res_ip['country']) 
  end

  def jsonFormat(lat, long, city, country)
    {"consumption" => params[:consump], "ip" => params[:ip], "latitude" => lat, "longitude" => long, "city" => city, "country" => country, "permission" => true}
  end
end
