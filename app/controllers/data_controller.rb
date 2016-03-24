class DataController < ApplicationController
  def index
  end

  def all
    @all = Report.all
    render :data
  end

  def hourly
    all_data = Report.all
    @all = normalize(all_data)
    render :data
  end

  def last24h
    @all = Report.where(updated_at: (Time.now - 24.hours)..Time.now)
    render :data
  end

  def last24h_hourly
    all_data = Report.where(updated_at: (Time.now - 24.hours)..Time.now)

    @all = normalize(all_data)
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

  def normalize(all_data)
    result = []
    all_per_hour = [0, 0, 0, 0]
    first_in_hour = all_data.first
    all_data.each do |rec|
      # check if rec is same hour as first_in_hour
      if rec.created_at.hour == first_in_hour.created_at.hour
        all_per_hour[0] += rec.temperature
        all_per_hour[1] += rec.humidity
        all_per_hour[2] += rec.pressure
        all_per_hour[3] += 1
      else # if not - get average of all the fields
        next if all_per_hour[3] == 0
        result.push(temperature: format('%.2f', all_per_hour[0] / all_per_hour[3]),
                    humidity: format('%.2f', all_per_hour[1] / all_per_hour[3]),
                    pressure: format('%.2f', all_per_hour[2] / all_per_hour[3]),
                    created_at: first_in_hour.created_at)
        first_in_hour = rec
        all_per_hour = [0, 0, 0, 0]
      end
    end
    result
  end
end
