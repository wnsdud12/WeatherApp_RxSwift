//
//  WeatherTableViewCell.swift
//  WeatherApp_RxSwift
//
//  Created by 박준영 on 2022/05/30.
//

import UIKit
import RxSwift

class WeatherTableViewCell: UITableViewCell {

    // MARK: - InterfaceBuilder Links
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var tmp: UILabel!
    @IBOutlet weak var skyImg: UIImageView!
    @IBOutlet weak var sky: UILabel!
    @IBOutlet weak var pcp: UILabel!
    @IBOutlet weak var pop: UILabel!
}
