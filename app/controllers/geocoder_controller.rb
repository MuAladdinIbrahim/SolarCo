class GeocoderController < ApplicationController
  def getLocation
    render json: {"permission" => false} if  params[:lat] && (params[:lat].to_f).abs > 70
    if params[:lat] && params[:long]
      res_loc = (Geocoder.search([params[:lat].round(4), params[:long].round(4)])[0].data).to_hash['address']
      if res_loc['city'] && res_loc['country']
        render json: {"city" => res_loc['city'],"country" => res_loc['country'], "permission" => true}
      else
        getbyIP
      end
    else
      getbyIP
    end
  end

  def getbyIP
    res_ip = (Geocoder.search(params[:ip])[0].data).to_hash
    loc = res_ip['loc'].split(',') unless res_ip['loc'].nil?
    render json: {"permission" => false} if (loc[0].to_f).abs() > 70

    render json: {"city" => res_ip['city'],"country" => res_ip['country'], "permission" => true} if res_ip['city'] && res_ip['country']
  end
end
