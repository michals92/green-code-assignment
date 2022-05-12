//
//  ResultFormDataSource.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 11.05.2022.
//

import UIKit

final class ResultFormTableViewDataSource: NSObject, UITableViewDataSource {
    var cellModels: [ResultFormTableViewCellModel] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ResultFormTableViewCell.self), for: indexPath) as? ResultFormTableViewCell else {
            fatalError("unable to dequeue reusable cell with identifier \(String(describing: ResultFormTableViewCell.self))")
        }

        cell.configure(cellModel: cellModels[indexPath.row])
        return cell
    }
}
