//
//  WeatherManager.swift
//  WeatherApp_RxSwift
//
//  Created by 박준영 on 2022/05/25.
//

import Foundation
import RxSwift
import Alamofire

class APIService {
    let weatherURL = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?"
    private let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    func fetchWeather(_ nx: Int, _ ny: Int) {
        guard let apiKey = apiKey else { return }
        let dateTime = setDateTime()
        let url = "\(weatherURL)serviceKey=\(apiKey)&base_date=\(dateTime.date)&base_time=\(dateTime.time)&nx=\(nx)&ny=\(ny)&numOfRows=1000&pageNo=1&dataType=JSON"
        print("///////////////////")
        print(url)
        print("///////////////////")

        AF.request(url).responseDecodable(of: WeatherData.self) { response in
            print(response)
        }
    }
     func setDateTime() -> (date: String, time: String) {
        let now = Date.now
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        var date = formatter.string(from: now)
        formatter.dateFormat = "HHmm"
        var time = formatter.string(from: now)
        while Int(time)! % 3 != 2 {
            var newDate = now.addingTimeInterval(-3600)
            time = formatter.string(from: now)
        }

        return (date, time)
    }
}
