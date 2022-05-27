//
//  ViewController.swift
//  WeatherApp_RxSwift
//
//  Created by 박준영 on 2022/05/25.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        APIService().fetchWeather(55, 124)
        var a = APIService().setDateTime()
    }


}

