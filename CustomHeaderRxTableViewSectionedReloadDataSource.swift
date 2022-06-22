//
//  CustomHeaderRxTableViewSectionedReloadDataSource.swift
//  WeatherApp_RxSwift
//
//  Created by 박준영 on 2022/06/22.
//

#if os(iOS)
import UIKit
import RxDataSources

class CustomHeaderRxTableViewSectionedReloadDataSource<S: SectionModelType>: RxTableViewSectionedReloadDataSource<S>, UITableViewDelegate {

    public typealias ConfigureHeaderView = (TableViewSectionedDataSource<S>, UITableView, Int, S) -> UIView?

    init(
        configureCell: @escaping ConfigureCell,
        titleForHeaderInSection: @escaping TitleForHeaderInSection = { _, _ in nil },
        titleForFooterInSection: @escaping TitleForFooterInSection = { _, _ in nil },
        canEditRowAtIndexPath: @escaping CanEditRowAtIndexPath = { _, _ in false},
        canMoveRowAtIndexPath: @escaping CanMoveRowAtIndexPath = { _, _ in false},
        sectionIndexTitles: @escaping SectionIndexTitles = { _ in nil},
        sectionForSectionIndexTitle: @escaping SectionForSectionIndexTitle = { _, _, index in index},
        configureHeaderView: @escaping ConfigureHeaderView
    ) {
        self.configureHeaderView = configureHeaderView
        super.init(
            configureCell: configureCell,
            titleForHeaderInSection: titleForHeaderInSection,
            titleForFooterInSection: titleForFooterInSection,
            canEditRowAtIndexPath: canEditRowAtIndexPath,
            canMoveRowAtIndexPath: canMoveRowAtIndexPath,
            sectionIndexTitles: sectionIndexTitles,
            sectionForSectionIndexTitle: sectionForSectionIndexTitle)
    }

    open var configureHeaderView: ConfigureHeaderView {
        didSet {
#if DEBUG
#endif
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        configureHeaderView(self, tableView, section, sectionModels[section])
    }
}

#endif
