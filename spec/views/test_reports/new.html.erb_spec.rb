require 'rails_helper'

RSpec.describe "test_reports/new", type: :view do
  before(:each) do
    assign(:test_report, TestReport.new(
      :temp => 1.5,
      :hum => 1.5,
      :press => 1.5
    ))
  end

  it "renders new test_report form" do
    render

    assert_select "form[action=?][method=?]", test_reports_path, "post" do

      assert_select "input#test_report_temp[name=?]", "test_report[temp]"

      assert_select "input#test_report_hum[name=?]", "test_report[hum]"

      assert_select "input#test_report_press[name=?]", "test_report[press]"
    end
  end
end
