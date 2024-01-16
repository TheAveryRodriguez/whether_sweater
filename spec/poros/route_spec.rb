require "rails_helper"

RSpec.describe Route do
  before :each do
    @time_info = "3:33:33"
    @origin = "Conway,AR"
    @destination = "Dallas,TX"

    @now = Time.parse("2024-01-16 02:22:22")
    allow(Time).to receive(:now) { @now }

    @route = Route.new(@time, @origin, @destination)
  end

  it "exists" do
    expect(@route).to be_a(Route)
    expect(@route.travel_time).to eq("Impossible")
    expect(@route.date_time).to eq("2024-01-16 02")
    expect(@route.hour).to eq(2)
    expect(@route.origin).to eq("Conway,AR")
    expect(@route.destination).to eq("Dallas,TX")
  end

  context "format_datetime(time)" do
    it "give date with hours" do
      expect(@route.format_datetime("3:33:33")).to eq("2024-01-16 05")
    end
  end

  context "format_hour(time)" do
    it "takes travel time and makes in a integer" do
      expect(@route.format_hour("3:33:33")).to eq(5)
    end
  end

  context "impossibe?(time)" do
    it "returns either the time or impossible depending on the API repsonse for time" do
      expect(@route.impossible?("3:33:33")).to eq("3:33:33")
      expect(@route.impossible?(nil)).to eq("Impossible")
    end
  end
end
