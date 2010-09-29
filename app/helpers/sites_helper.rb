module SitesHelper
  RPIORITY_ZONES	=	/US|Arizona|Indiana|Hawaii|Alaska|Tokyo|Osaka/

  def priority_zones
    ActiveSupport::TimeZone.all.find_all { |z| z.name =~ RPIORITY_ZONES }
  end
end
