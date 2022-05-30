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

    let cellId = "WeatherTableViewCell"

    let viewModel = WeatherViewModel()
    let disposeBag = DisposeBag()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        test.text = UserDefaults.address
        viewModel.weatherObservable
            .observe(on: MainScheduler.instance)
            .bind(to: weatherTable.rx.items(cellIdentifier: cellId,
                                            cellType: WeatherTableViewCell.self)) {
                index, item, cell in
                cell.time.text = "\(item.time.toInt() / 100)" + "시"
                cell.tmp.text = item.tmp
                cell.skyImg.image = item.weatherImg
                cell.sky.text = item.sky
                cell.pcp.text = item.pcp
                cell.pop.text = item.pop
            }
            .disposed(by: disposeBag)
    }

    // MARK: - Interface Builder Links

    @IBOutlet weak var weatherTable: UITableView!
    @IBOutlet weak var test: UILabel!


}

