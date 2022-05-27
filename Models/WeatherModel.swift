//
//  WeatherModel.swift
//  WeatherApp_RxSwift
//
//  Created by 박준영 on 2022/05/25.
//

import Foundation
import UIKit

// API로 받아온 날씨 값(WeatherData)을 사용할 값들로 변환
struct WeatherModel {
    let weatherImg: UIImage?
    let date: String
    let time: String
    let tmp: String // 온도
    let sky: String // sky(하늘상태), pty(강수형태) 합쳐서
    let pcp: String // pcp(강수량), sno(신적설,1시간동안 쌓이는 눈의 양) 합쳐서
    let pop: String // 강수확률
}
