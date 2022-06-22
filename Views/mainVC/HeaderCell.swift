//
//  HeaderCell.swift
//  WeatherApp_RxSwift
//
//  Created by 박준영 on 2022/06/22.
//

import UIKit

class HeaderCell: UITableViewCell {

    static let id = "HeaderCell"

    // MARK: - InterfaceBuilder Links
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var tmn: UILabel!
    @IBOutlet weak var tmx: UILabel!
}
