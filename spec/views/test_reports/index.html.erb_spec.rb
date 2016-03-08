require 'rails_helper'

RSpec.describe "test_reports/index", type: :view do
  before(:each) do
    assign(:test_reports, [
      TestReport.create!(
        :temp => 1.5,
        :hum => 1.5,
        :press => 1.5
      ),
      TestReport.create!(
        :temp => 1.5,
        :hum => 1.5,
        :press => 1.5
      )
    ])
  end

  it "renders a list of test_reports" do
    render
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
