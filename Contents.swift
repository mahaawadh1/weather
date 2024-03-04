import UIKit
import Foundation

struct Weather: Codable {
    let city: String
    let temperature: Double
    let condition: String
    let forecast: [Forecast]

    
    struct Forecast: Codable {
        let day: String
        let highTemperature: Double
        let lowTemperature: Double
        let condition: String
    }
}

func decodeWeather(from data: Data) {
    do {
        let decoder = JSONDecoder()
        let weather = try decoder.decode(Weather.self, from: data)
        print("City: \(weather.city)")
        print("Temperature: \(weather.temperature)")
        print("Condition: \(weather.condition)")
        print("Forecast:")
        for forecast in weather.forecast {
            print("- Day: \(forecast.day)")
            print("  High Temperature: \(forecast.highTemperature)")
            print("  Low Temperature: \(forecast.lowTemperature)")
            print("  Condition: \(forecast.condition)")
        }
    } catch {
        print("Error decoding weather data: \(error)")
    }
}

let jsonString = """
{
  "city": "New York",
  "temperature": 20,
  "condition": "Sunny",
  "forecast": [
    {
      "day": "Monday",
      "highTemperature": 25,
      "lowTemperature": 15,
      "condition": "Partly Cloudy"
    },
    {
      "day": "Tuesday",
      "highTemperature": 22,
      "lowTemperature": 12,
      "condition": "Rainy"
    }
  ]
}
"""


do {
    if let jsonData = try? jsonString.data(using: .utf8) {
        decodeWeather(from: jsonData)
    } else {
        print("Failed to convert string to data")
    }
} catch {
    print("Error: \(error)")
}
