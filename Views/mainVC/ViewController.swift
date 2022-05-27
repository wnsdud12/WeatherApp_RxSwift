//
//  ViewController.swift
//  WeatherApp_RxSwift
//
//  Created by 박준영 on 2022/05/25.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var test: UILabel!
    let viewModel = WeatherViewModel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
  
    }
}

