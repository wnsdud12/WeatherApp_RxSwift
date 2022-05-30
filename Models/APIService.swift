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

    func fetchWeather() -> Observable<WeatherData> {
        return Observable.create() { observer in
            AF.request(self.createURL()).responseDecodable(of: WeatherData.self, queue: .global()) { response in
                switch response.result {
                    case .success(let data):
                        observer.onNext(data)
                        observer.onCompleted()
                    case .failure(let err):
                        observer.onError(err)
                }
            }
            return Disposables.create()
        }
    }
    
    private func createURL() -> String {
        guard let apiKey = self.apiKey else {
            return ""
        }
        let dateTime = self.setDateTime()
        let url = "\(self.weatherURL)serviceKey=\(apiKey)&base_date=\(dateTime.date)&base_time=\(dateTime.time)&nx=\(UserDefaults.grid_x)&ny=\(UserDefaults.grid_y)&numOfRows=1000&pageNo=1&dataType=JSON"
        print("///////////////////")
        print(url)
        print("///////////////////")
        return url
    }

    private func setDateTime() -> (date: String, time: String) {
        var now = Date.now
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "GMT+9")
        formatter.dateFormat = "HH"
        var time = formatter.string(from: now)
        while Int(time)! % 3 != 2 {
            now = now.addingTimeInterval(-3600)
            time = formatter.string(from: now)
        }
        formatter.dateFormat = "yyyyMMdd"
        let baseDate = formatter.string(from: now)
        formatter.dateFormat = "HHmm"
        let baseTime = formatter.string(from: now)
        return (baseDate, baseTime)
    }
}
