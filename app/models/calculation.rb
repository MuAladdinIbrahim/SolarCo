class Calculation < ApplicationRecord
  belongs_to :system, dependent: :destroy

  attr_accessor :panel_wt, :panels_no, :battery_dod, :battery_voltage, :battery_amp, :sys_circuits, :load_voltage
  
  #### Panel #####
  def panel_Calculate(system)
    wh_per_day = system.consumption/30.to_f*1000
    wh_per_day *= 0.2 if system.backup
    @panel_wt = 250 if wh_per_day >= 2000
    @panel_wt = 150 if wh_per_day < 2000
    if system.latitude.abs() < 70
      gen_factor = ((90/system.latitude.abs()) * 1.78).ceil(2) if system.latitude.abs() > 25 || 6.5 #Generation Factor ~ sun rise hours 
    end

    tot_power = (wh_per_day*1.35 / gen_factor).ceil(-2)
    @panels_no = ( tot_power / 250).ceil()
    @panels_no += 1 if @panels_no.odd? || @panels_no == 0

    {"panel_watt" => @panel_wt, "wh_per_day" => wh_per_day, "gen_factor" => gen_factor, "tot_power" => tot_power, "panels_no" => @panels_no}
  end

  ##### Battery #####
  def battery_Calculate(wh_per_day, lat)
    @battery_dod = 0.5      #Depth of Discharge
    @battery_voltage = 12   #Battery Voltage
    @battery_amp = 200 if wh_per_day >= 2000
    @battery_amp = 100 if wh_per_day < 2000
    if lat.abs() < 70
      cloudy_days = ((lat.abs()/90)*5.5).ceil(2) if lat.abs() > 30 || 1.2 #Cloudy days without charging ~ climate
    end 
    battery_losses_factor = (0.95 - lat.abs()*0.0035).ceil(2) #Battery Losses ~ Temperature 
    system_capacity = ((wh_per_day*cloudy_days)/(battery_losses_factor*@battery_dod*@battery_voltage*2)).ceil()
    batteries_num = (system_capacity/@battery_amp).ceil()
    batteries_num += 1 if batteries_num.odd? || batteries_num == 0

    {"system_capacity" => system_capacity, "system_voltage" => @battery_voltage*2, "battery_losses_factor" => battery_losses_factor, "battery_amp" => @battery_amp, "batteries_num" => batteries_num, "cloudy_days" => cloudy_days}
  end

  # ##### AC-Inverter #####
  # ##### MPPT Charger Controller #####
  def inverter_mppt_Calculate
    inverter_watt = ((@panels_no*@panel_wt)/0.7).ceil(3)
    @sys_circuits = 1
    if inverter_watt > 2500
      @sys_circuits = (((inverter_watt/2500)+0.4).ceil(1)).round()
      @sys_circuits += 1 if @sys_circuits.odd?
      inverter_watt = (inverter_watt/@sys_circuits).ceil(3)
    end
    inverter_watt = 1000 if inverter_watt < 1000
    mppt_amp = ((@panels_no*@panel_wt*1.25)/(@battery_voltage*2)).ceil()
    mppt_amp = mppt_amp / @sys_circuits if @sys_circuits > 1
    
    {"inverter_watt" => inverter_watt.ceil(-2), "inverters_num" => @sys_circuits, "mppt_amp" => mppt_amp.ceil(-1), "mppts_num" => @sys_circuits}
  end


    # ##### Tilt Angle and Azimth #####
    def position_Calculate(lat, long)
      if lat >= 0 
        {"tilt_angle" => lat.abs().ceil(2), "description" => "from North to be due south"} 
      else
        {"tilt_angle" => lat.abs().ceil(2), "description" => "from South to be due North"}
      end
    end

    # ##### Cables and Protections #####
    def cables_protections_Calculate(calc_obj)
      section1 = section1(calc_obj.mppt_amp)
      section2 = section2(calc_obj.batteries_num/calc_obj.system_circuits, calc_obj.battery_Ah)
      section3 = section3(calc_obj.inverter_watt)
      {"section1" => section1, "section2" => section2, "section3" => section3}
    end

    def section1(mppt_amp)     #Cable and Fuse
      fuse_rate = (mppt_amp).ceil()
      cable_rate = (1.2*fuse_rate).ceil()
      {"mppt_max_rate" => (mppt_amp+10), "cable_current1" => "#{cable_rate}, solid", "fuse_current1" => fuse_rate}
    end

    def section2(batteries_num_per_circuit, battery_Ah)   #cable and Fuse
        fuse_rate = ((batteries_num_per_circuit/2)*battery_Ah).ceil()
        cable_rate = (1.2*fuse_rate).ceil()
        {"battery_max_rate" => (battery_Ah+10), "cable_current2" => "#{cable_rate}, solid", "fuse_current2" => fuse_rate}
    end

    def section3(inverter_watt)     #cable and CircuitBreaker 
        load_voltage = 220
        cb_rate = ((inverter_watt*1.9)/load_voltage).ceil()
        cable_rate = (1.3*cb_rate).ceil()
        {"inverter_max_rate" => (inverter_watt+100), "system_voltage" => load_voltage, "cable_current3" => "#{cable_rate}, stranded", "circuitBreaker_current3" => cb_rate}
    end

    def getCalculationsByUser(systems)
      # systems = (System.all).find_by(user_id: user_id)
      calc = [];
      systems.each do |system|
          calc << {"calculation" => system.calculation, "system" => system, "cost" => system.estimatedCost(system)}
      end
      calc
    end

end
