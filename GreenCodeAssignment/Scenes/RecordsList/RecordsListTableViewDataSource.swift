//
//  RecordsListTableViewDataSource.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 10.05.2022.
//

import UIKit

final class RecordListTableViewDataSource: NSObject, UITableViewDataSource {
    var results: [SportResult] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecordsListTableViewCell.self), for: indexPath) as? RecordsListTableViewCell else {
            fatalError("unable to dequeue reusable cell with identifier \(String(describing: RecordsListTableViewCell.self))")
        }

        cell.configure(result: results[indexPath.row])
        return cell
    }
}
