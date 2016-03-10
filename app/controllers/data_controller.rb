class DataController < ApplicationController
  def index
  end

  def all
    @all = Report.all
    render :data
  end

  def hourly
    all_data = Report.all
    @all = normalize_per_hour(all_data)
    render :data
  end

  def last24h
    # @all = Report.last_24h
    @all = Report.where(updated_at: (Time.now - 24.hours)..Time.now)
    render :data
  end

  def last24h_hourly
    # all_data = Report.last_24h
    all_data = Report.where(updated_at: (Time.now - 24.hours)..Time.now)

    @all = normalize_per_hour(all_data)
    render :data
  end

  private

  def normalize_per_hour(data_hash)
    recs_p_hour = 30 # 1 record per 2 min => 30 records per 1 hour
    result = []
    summ = [0, 0, 0]
    count = 0
    data_hash.each do |r|
      if count < recs_p_hour
        count += 1
        summ[0] += r[:temperature]
        summ[1] += r[:humidity]
        summ[2] += r[:pressure]
      else
        result.push(temperature: format('%.2f', summ[0] / recs_p_hour),
                    humidity: format('%.2f', summ[1] / recs_p_hour),
                    pressure: format('%.2f', summ[2] / recs_p_hour),
                    created_at: r[:created_at])
        count = 0
        summ = [0, 0, 0]
      end
    end
    result
  end

  def normalize(recs, range)
    result = []
    range.each do |h|
      all = recs.select { |r| r.created_at.hour == h }
      next if all.empty?
      rec = all.clone.reduce do |memo, r|
        memo.temperature += r.temperature
        memo.humidity += r.humidity
        memo.pressure += r.pressure
        memo
      end
      rec.temperature /= all.size
      rec.humidity /= all.size
      rec.pressure /= all.size
      result << rec
    end
    result
  end
end
