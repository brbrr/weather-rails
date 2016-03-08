require 'rails_helper'

RSpec.describe "test_reports/show", type: :view do
  before(:each) do
    @test_report = assign(:test_report, TestReport.create!(
      :temp => 1.5,
      :hum => 1.5,
      :press => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/1.5/)
  end
end
