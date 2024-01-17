require "rails_helper"

RSpec.describe Hourly do
  it "exists" do
    attributes = {
      time: "01-16-2024 00:00",
      temp_f: 99.9,
      condition: {
        text: "sunny",
        icon: "someicon.png"
      }
    }

    hourly_weather = Hourly.new(attributes)

    expect(hourly_weather).to be_a(Hourly)
    expect(hourly_weather.time).to eq("00:00")
    expect(hourly_weather.temperature).to eq(99.9)
    expect(hourly_weather.condition).to eq("sunny")
    expect(hourly_weather.icon).to eq("someicon.png")
  end

  context "format_time" do
    it "only give the hours and min" do
      attributes = {
        time: "01-16-2024 03:33",
        temp_f: 99.9,
        condition: {
          text: "sunny",
          icon: "someicon.png"
        }
      }

      hourly_weather = Hourly.new(attributes)

      expect(hourly_weather.format_time("01-16-2024 03:33")).to eq("03:33")
    end
  end
end
