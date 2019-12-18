module UserHelper
  def extract_host(url)
    uri = URI.parse(url)
    uri = URI.parse("http://#{url}") if uri.scheme.nil?
    host = uri.host.downcase
    host.start_with?('www.') ? host[4..-1] : host
  end

  def top_inactivity(user_id)
    schedules = HorodatorSchedule.where(["created_at::date = ? AND user_id = ?", Date.today, user_id])
    inactivities = []
    top_inactivity = nil

    schedules.each do |s|
      testa = s.inactivities.order("total DESC").limit(1)[0]
      if(testa != nil)
        inactivities << testa 
      end
    end

    top_inactivity = (inactivities.sort_by { |i| -i.total })[0]
  end
end
