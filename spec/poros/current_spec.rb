require "rails_helper"

RSpec.describe Current do
  it "exists" do
    attributes = {
      last_updated: "01-16-2024",
      temp_f: 99.9,
      feelslike_f: 88.8,
      humidity: 77.7,
      uv: 66.6,
      vis_miles: 55.5,
      condition: {
        text: "sunny",
        icon: "someicon.png"
      }
    }

    current_weather = Current.new(attributes)

    expect(current_weather).to be_a(Current)
    expect(current_weather.last_updated).to eq("01-16-2024")
    expect(current_weather.temperature).to eq(99.9)
    expect(current_weather.feels_like).to eq(88.8)
    expect(current_weather.humidity).to eq(77.7)
    expect(current_weather.uvi).to eq(66.6)
    expect(current_weather.visibility).to eq(55.5)
    expect(current_weather.condition).to eq("sunny")
    expect(current_weather.icon).to eq("someicon.png")
  end
end
