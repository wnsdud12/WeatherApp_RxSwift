//
//  WeatherSection.swift
//  WeatherApp_RxSwift
//
//  Created by 박준영 on 2022/06/22.
//

import RxDataSources

struct WeatherSection {
    var date: String
    var tmx: String
    var tmn: String

    var items: [WeatherModel]
}
extension WeatherSection: SectionModelType {
    init(original: WeatherSection, items: [WeatherModel]) {
        self = original
        self.items = items
    }
}

