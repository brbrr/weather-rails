class ReportsController < ApplicationController
  protect_from_forgery with: :null_session, if: proc { |c| c.request.format.json? }
  before_action :set_report, only: [:show]

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.all.to_json
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
end

#
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
