class ReportsController < ApplicationController
  protect_from_forgery with: :null_session, if: proc { |c| c.request.format.json? }
  before_action :set_report, only: [:show]

  # GET /reports
  # GET /reports.json
  def index
    if params['from']
      from = Time.parse(params['from'])
      to = Time.parse(params['to'])
      @reports = Report.where(updated_at: from..to)
      @reports = normalize(@reports) if params['normalize']
    else
      @reports = Report.all
    end
    render json: @reports
    # respond_to do |format|
    #   format.json { render json: @reports }
    #   format.html # index.html.erb
    # end
  end

  def new
    @report = Report.new
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    set_report
    # halt(404, { result: 'NotFound' }.to_json) if report.nil?
    # if @report.nil?
    #   render json: @report.errors, status: :unprocessable_entity
    # else
    @report.to_json
    # end
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)

    if @report.save
      render json: @report, status: :created, location: @report
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Report.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def report_params
    params.require(:report).permit(:temperature, :humidity, :pressure)
  end

  def normalize(all_data)
    result = []
    all_per_hour = [0, 0, 0, 0] # temp, humid, press, count
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

# get '/reports/temperature' do
#   Report.all_data_for(:temperature).to_json
# end
#
# get '/reports/preasure' do
#   Report.all_data_for(:preasure).to_json
# end
#
# get '/reports/humidity' do
#   Report.all_data_for(:humidity).to_json
# end
