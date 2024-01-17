require "rails_helper"

RSpec.describe Daily do
  it "exists" do
    attributes = {
      date: "01-16-2024",
      astro: {
        sunset: "12:12",
        sunrise: "11:11"
      },
      day: {
        maxtemp_f: 99.9,
        mintemp_f: 77.7,
        condition: {
          text: "sunny",
          icon: "someicon.png"
        }
      }
    }

    daily_weather = Daily.new(attributes)

    expect(daily_weather).to be_a(Daily)
    expect(daily_weather.date).to eq("01-16-2024")
    expect(daily_weather.sunrise).to eq("11:11")
    expect(daily_weather.sunset).to eq("12:12")
    expect(daily_weather.max_temp).to eq(99.9)
    expect(daily_weather.min_temp).to eq(77.7)
    expect(daily_weather.condition).to eq("sunny")
    expect(daily_weather.icon).to eq("someicon.png")
  end
end
