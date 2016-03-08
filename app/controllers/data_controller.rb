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
    result = []
    summ = [0, 0, 0]
    count = 0
    data_hash.each do |r|
      if count < 30
        count += 1
        summ[0] += r[:temperature]
        summ[1] += r[:humidity]
        summ[2] += r[:pressure]
      else
        result.push(temperature: format('%.2f', summ[0] / 30),
                    humidity: format('%.2f', summ[1] / 30),
                    pressure: format('%.2f', summ[2] / 30),
                    created_at: r[:created_at])
        count = 0
        summ = [0, 0, 0]
      end
    end
    result
    end
end
