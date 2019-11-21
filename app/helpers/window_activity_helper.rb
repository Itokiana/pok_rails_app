module WindowActivityHelper
  def total_focus(start_time, end_time)
    ((end_time - start_time) * 24 * 60 * 60).to_i
  end
end
