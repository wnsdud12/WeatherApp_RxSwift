//
//  ViewController.swift
//  WeatherApp_RxSwift
//
//  Created by 박준영 on 2022/05/25.
//

import UIKit
import Foundation
import RxSwift
import RxDataSources
import RxCocoa

class ViewController: UIViewController {

    let viewModel = WeatherViewModel()
    let disposeBag = DisposeBag()
    private lazy var dataSource = self.getDataSource()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        weatherTable.delegate = dataSource as? UITableViewDelegate
        viewModel.weatherObservable
            .bind(to: weatherTable.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

    }

    private func getDataSource() -> RxTableViewSectionedReloadDataSource<WeatherSection> {
        let dataSource = CustomHeaderRxTableViewSectionedReloadDataSource<WeatherSection>(
            configureCell: { dataSource, tableView, indexPath, weather in
                let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.id, for: indexPath) as! WeatherTableViewCell
                cell.time.text = weather.time
                cell.tmp.text = weather.tmp
                cell.sky.text = weather.sky
                cell.skyImg.image = weather.weatherImg
                cell.pcp.text = weather.pcp
                cell.pop.text = weather.pop
                return cell
            },
            configureHeaderView: { dataSource, tableView, section, weatherSection in
                let headerCell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.id, for: IndexPath(row: 0, section: section)) as! HeaderCell
                headerCell.date.text = weatherSection.date
                headerCell.tmx.text = weatherSection.tmx
                headerCell.tmn.text = weatherSection.tmn
                return headerCell
            }
        )
        return dataSource
    }


    // MARK: - Interface Builder Links

    @IBOutlet weak var weatherTable: UITableView!
    @IBOutlet weak var test: UILabel!


}

