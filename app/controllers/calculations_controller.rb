class CalculationsController < ApplicationController
  before_action :set_calculation, only: [:show, :update, :destroy]

  # GET /calculations
  def index

  end

  # GET /calculations/1
  def show
    render json: @calculation
  end

  # POST /calculations
  def create
    @calculation = Calculation.new()

    @loc = request.location.data['loc']
    @loc.split(',') unless @loc.nil?

    res = { "data" => {"ip" => "41.237.106.209","city" => "Alexandria","region" => "Alexandria","country" => "EG","loc" => "31.2018,29.9158","timezone" => "Africa/Cairo"} }
    @loc ||= res['data']['loc'].split(',')

    consumption = params[:consump].to_i || 300
    lat = @loc[0].to_f
    long = @loc[1].to_f
    
    panel = @calculation.panel_Calculate(consumption, lat)
    battery = @calculation.battery_Calculate(panel['wh_per_day'], lat)
    componets = @calculation.inverter_mppt_Calculate()
    position = @calculation.position_Calculate(lat, long)
    
    @system = System.create(latitude: lat, longitude: long, electricity_bill: consumption, city: res['data']['region'],country: res['data']['country'], user_id: 1)
    
    @calculation.update(system_id: @system.id, system_circuits: componets['inverters_num'], panels_num: panel['panels_num'], panel_watt: panel['panel_watt'], battery_Ah: battery['battery_Ah'], batteries_num: battery['batteries_num'], inverter_watt: componets['inverter_watt'], mppt_amp: componets['mppt_amp'])
    
    cables_protections = @calculation.cables_protections_Calculate(@calculation)

    @cal = {"res" => {"panel" => panel, "battery" => battery, "componets" => componets, "cables_protections" => cables_protections, "Installations" => position}, "sys" => @system, "calc" => @calculation}
    
    render json: @cal 
  end

  # PATCH/PUT /calculations/1
  def update
    if @calculation.update(calculation_params)
      render json: @calculation
    else
      render json: @calculation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /calculations/1
  def destroy
    @calculation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calculation
      @calculation = Calculation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def calculation_params
      params.fetch(:calculation, :consump)
    end

  ##### Panel #####
  def panelCalculation(consumption, lat)
    wh_per_day = (consumption/30)*1000
    if lat.abs() < 70
      gen_factor = ((90/lat.abs()) * 2.1).ceil(3) if lat.abs() > 30 || 6.5 #Generation Factor ~ sun rise hours 
    end
    tot_power = (wh_per_day*1.3 / gen_factor).ceil(3)
    num_of_panels = ( tot_power / 250).ceil()
    num_of_panels += 1 if num_of_panels .odd?

    {"panel_rating_power" => 250, "wh_per_day" => wh_per_day, "gen_factor" => gen_factor, "tot_power" => tot_power, "num_of_panels" => num_of_panels}
  end

  ##### Battery #####
  def batteryCalculation(wh_per_day, lat)
    battery_dod = 0.4  #Depth of Discharge
    battery_volt = 12   #Battery Voltage
    if lat.abs() < 70
      cloudy_days = ((lat.abs()/90)*5.5).ceil(3) if lat.abs() > 30 || 1 #Cloudy days without charging ~ climate
    end 
    battery_losses_factor = (0.95 - lat.abs()*0.0035).ceil(3) #Battery Losses ~ Temperature 
    battery_capacity = ((wh_per_day*cloudy_days)/(battery_losses_factor*battery_dod*battery_volt)).ceil(3)
    num_of_batteries = (battery_capacity/200).ceil()
    num_of_batteries += 1 if num_of_batteries.odd?

    {"battery_losses_factor" => battery_losses_factor, "battery_capacity" => 200, "num_of_batteries" => num_of_batteries, "cloudy_days" => cloudy_days}
  end

  # ##### AC-Inverter #####
  def inverterCalculation(num_of_panels)
    inverter_rate = ((num_of_panels*250)/0.85).ceil(3)
    num_of_inverters = 1
    if inverter_rate > 2000
      num_of_inverters = ( ((inverter_rate/2000)+0.1).ceil(1) ).round()
      num_of_inverters += 1 if num_of_inverters.odd?
      inverter_rate = (inverter_rate/num_of_inverters).ceil(3)
    end
    {"inverter_rate" => inverter_rate, "num_of_inverters" => num_of_inverters}
  end

  # ##### MPPT Charger Controller #####
  def mpptCalculation(num_of_panels, num_of_inverters)
    mppt_rate = ((num_of_panels*250*1.2)/24).ceil()
    mppt_rate = mppt_rate / num_of_inverters if num_of_inverters > 1
    num_of_mppt = num_of_inverters
    {"mppt_rate" => mppt_rate, "num_of_mppt" => num_of_mppt}
  end
end
