//
//  Extensions.swift
//  WeatherApp_RxSwift
//
//  Created by 박준영 on 2022/05/27.
//

import Foundation

extension String {
    func toInt() -> Int {
        return Int(self)!
    }
}

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultsValue: T
    var container: UserDefaults = .standard

    var wrappedValue: T {
        get {
            return container.object(forKey: key) as? T ?? defaultsValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}
extension UserDefaults {
    @UserDefault(key: keyEnum.grid_x.rawValue, defaultsValue: 56)
    static var grid_x: Int
    @UserDefault(key: keyEnum.grid_y.rawValue, defaultsValue: 124)
    static var grid_y: Int
    @UserDefault(key: keyEnum.address.rawValue, defaultsValue: "없음")
    static var address: String
    @UserDefault(key: keyEnum.degree_lat.rawValue, defaultsValue: 0.0)
    static var degree_lat: Double
    @UserDefault(key: keyEnum.degree_lon.rawValue, defaultsValue: 0.0)
    static var degree_lon: Double
    @UserDefault(key: keyEnum.isFirst.rawValue, defaultsValue: nil)
    static var isFirst: Bool? // 앱 첫 실행 여부
    enum keyEnum: String {
        case grid_x
        case grid_y
        case degree_lat
        case degree_lon
        case address
        case isFirst
    }
}
