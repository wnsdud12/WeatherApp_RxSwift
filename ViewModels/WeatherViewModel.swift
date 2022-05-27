//
//  WeatherViewModel.swift
//  WeatherApp_RxSwift
//
//  Created by 박준영 on 2022/05/25.
//

import Foundation
import RxSwift
import RxCocoa

typealias WeatherValue = [String: String] // key : 자료구분문자(category), value : 예보 값(fcstValue)


class WeatherViewModel {
    var weatherObservable = BehaviorSubject<[WeatherModel]>(value: [])
    //lazy var test = weatherObservable.map{$0.first?.sky ?? "기다리는중"}

    init() {
        let useCategory = ["TMX", "TMN", "TMP", "SKY", "PTY", "PCP", "SNO", "POP"]
        var weatherModels: [WeatherModel] = []
        _ = APIService().fetchWeather()
            .debug()
            .map { data -> WeatherData in
                let weatherData = try! JSONDecoder().decode(WeatherData.self, from: data)
                return weatherData
            }
            .map { weatherData -> [WeatherModel] in
                var weatherValue: WeatherValue = [:]
                let items = weatherData.response.body.items.item.filter { useCategory.contains($0.category) }
                var date: String = items[0].fcstDate
                var time: String = items[0].fcstTime
                for i in items.indices {
                    let category = items[i].category
                    let value = items[i].fcstValue
                    if time == items[i].fcstTime {
                        weatherValue[category] = value
                    } else {
                        print(weatherValue)
                        weatherModels.append(self.createWeatherModel(date, time, weatherValue))
                        weatherValue = [:]
                        weatherValue[category] = value
                        time = items[i].fcstTime
                        date = items[i].fcstDate
                    }
                }
                print("///////////////")
                print(weatherModels)
                print("///////////////")
                return weatherModels
            }
            .bind(to: weatherObservable)
    }
    private func createWeatherModel(_ date: String, _ time: String, _ value: WeatherValue) -> WeatherModel {
        var weatherImg: UIImage?
        var sky: String = ""
        var pcp: String = value["PCP"]!
        let isDay: Bool = {
            if (6...20).contains(time.toInt()) {
                return true
            } else {
                return false
            }
        }()
        // 이미지 생성
        if value["PTY"] == "0" /* 비나 눈 등 없음 */ {
            sky = value["SKY"]!
            switch value["SKY"] {
                case "1": // 맑음
                    weatherImg = isDay ? UIImage(named: "sunny.png") : UIImage(named: "night.png")
                case "3": // 구름많음
                    weatherImg = isDay ? UIImage(named: "cloud_sun.png")  :UIImage(named: "cloud_night.png")
                case "4": // 흐림
                    weatherImg =  UIImage(named: "cloudy.png")
                default:
                    fatalError("SKY에 이상한값")
            }
        } else {
            sky = value["PTY"]!
            switch value["PTY"] {
                case "1": // 비
                    weatherImg = UIImage(named: "rain.png")
                case "2": // 비 또는 눈
                    weatherImg = UIImage(named: "rainyORsnowy.png")
                case "3": // 눈
                    weatherImg = UIImage(named: "snow.png")
                    pcp = value["SNO"]!
                case "4": // 소나기
                    weatherImg = UIImage(named: "rain_shower.png")
                default:
                    fatalError("PTY값에 이상한값")
            }
        }
        return WeatherModel(weatherImg: weatherImg, date: date, time: time, tmp: value["TMP"]!, sky: sky, pcp: pcp, pop: value["POP"]!)
    }
}
