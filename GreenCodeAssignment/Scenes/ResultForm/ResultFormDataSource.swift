//
//  ResultFormDataSource.swift
//  GreenCodeAssignment
//
//  Created by Michal Šimík on 11.05.2022.
//

import UIKit

final class ResultFormTableViewDataSource: NSObject, UITableViewDataSource {
    let items = ["name", "place", "duration", "storage"]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ResultFormTableViewCell.self), for: indexPath) as? ResultFormTableViewCell else {
            fatalError("unable to dequeue reusable cell with identifier \(String(describing: ResultFormTableViewCell.self))")
        }

        cell.configure(placeholderText: items[indexPath.row])
        return cell
    }
}
