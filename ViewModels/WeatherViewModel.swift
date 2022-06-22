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
    var weatherObservable = BehaviorSubject<[WeatherSection]>(value: [])

    init() {
        let useCategory = ["TMX", "TMN", "TMP", "SKY", "PTY", "PCP", "SNO", "POP"]
        var weatherSections: [WeatherSection] = []
        _ = APIService().fetchWeather()
            .retry(3)
            .map { weatherData -> [WeatherSection] in
                var weatherValue: WeatherValue = [:]
                var weatherModels: [WeatherModel] = []
                let items = weatherData.response.body.items.item.filter { useCategory.contains($0.category) }
                let dates = Array(Set(items.map{$0.fcstDate})).sorted()
                var time = ""
                var tmx = ""
                var tmn = ""
                for i in dates {
                    let values = items.filter{$0.fcstDate == i}

                    for j in Array(Set(values.map{$0.fcstTime})).sorted() {
                        time = j
                        let value = values.filter{$0.fcstTime == j}
                        value.forEach{weatherValue[$0.category] = $0.fcstValue}
                        print(values)
                        if let _tmx = weatherValue["TMX"] { tmx = _tmx }
                        if let _tmn = weatherValue["TMN"] { tmn = _tmn }
                        weatherModels.append(self.createWeatherModel(i, time, weatherValue))
                        weatherValue = [:]
                    }

                    if tmx == "" { tmx = "-" }
                    if tmn == "" { tmn = "-" }
                    weatherSections.append(WeatherSection(date: i, tmx: tmx, tmn: tmn, items: weatherModels))
                    weatherModels = []
                }
                print(weatherSections)
                return weatherSections
            }
            .bind(to: weatherObservable)
    }
}
extension WeatherViewModel {
    private func createWeatherModel(_ date: String, _ time: String, _ value: WeatherValue) -> WeatherModel {
        var weatherImg: UIImage?
        var sky: String = ""
        var pcp: String = value["PCP"]!
        let isDay: Bool = {
            if (6...20).contains(time.toInt()/100) {
                return true
            } else {
                return false
            }
        }()
        // 이미지 생성
        if value["PTY"] == "0" /* 비나 눈 등 없음 */ {
            switch value["SKY"] {
                case "1": // 맑음
                    sky = "맑음"
                    weatherImg = isDay ? UIImage(named: "sunny.png") : UIImage(named: "night.png")
                case "3": // 구름많음
                    sky = "구름많음"
                    weatherImg = isDay ? UIImage(named: "cloud_sun.png") : UIImage(named: "cloud_night.png")
                case "4": // 흐림
                    sky = "흐림"
                    weatherImg =  UIImage(named: "cloudy.png")
                default:
                    fatalError("SKY에 이상한값")
            }
        } else {
            sky = value["PTY"]!
            switch value["PTY"] {
                case "1": // 비
                    sky = "비"
                    weatherImg = UIImage(named: "rain.png")
                case "2": // 비 또는 눈
                    sky = "비/눈"
                    weatherImg = UIImage(named: "rainyORsnowy.png")
                case "3": // 눈
                    sky = "눈"
                    weatherImg = UIImage(named: "snow.png")
                    pcp = value["SNO"]!
                case "4": // 소나기
                    sky = "소나기"
                    weatherImg = UIImage(named: "rain_shower.png")
                default:
                    fatalError("PTY값에 이상한값")
            }
        }
        return WeatherModel(weatherImg: weatherImg, date: date, time: time, tmp: value["TMP"]!, sky: sky, pcp: pcp, pop: value["POP"]!)
    }
}
