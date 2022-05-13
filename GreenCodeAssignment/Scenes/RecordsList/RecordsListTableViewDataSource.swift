//
//  RecordsListTableViewDataSource.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import UIKit

final class RecordsListTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var cellModels: [RecordsListTableViewCellModel] = []
    let emptyCellModel: EmptyTableViewCellModel?
    var type: RecordListType = .all

    init(emptyCellModel: EmptyTableViewCellModel) {
        self.emptyCellModel = emptyCellModel
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cellModels.isEmpty {
            return 1
        }

        return cellModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cellModels.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EmptyTableViewCell.self), for: indexPath) as? EmptyTableViewCell else {
                fatalError("unable to dequeue reusable cell with identifier \(String(describing: EmptyTableViewCell.self))")
            }

            guard let emptyCellModel = emptyCellModel else {
                fatalError("datasource was initialized without empty cell model")
            }

            cell.configure(cellModel: emptyCellModel)
            return cell
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecordsListTableViewCell.self), for: indexPath) as? RecordsListTableViewCell else {
            fatalError("unable to dequeue reusable cell with identifier \(String(describing: RecordsListTableViewCell.self))")
        }

        cell.configure(cellModel: cellModels[indexPath.row], hideType: type != .all)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 && cellModels.isEmpty {
            return tableView.frame.height
        } else {
            return UITableView.automaticDimension
        }
    }
}
