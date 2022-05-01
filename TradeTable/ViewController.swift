//
//  ViewController.swift
//  TradeTable
//
//  Created by 劉聖龍 on 2022/4/30.
//

import UIKit

class ViewController: UITableViewController {
    var socket: CustomSocket?
    var model: RecordModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.socket?.connect()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reload),  name: NSNotification.Name("NewData"), object: nil)
    }
    
    @objc func reload() {
        self.tableView.reloadData()
    }
}

extension ViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.records.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? Cell, let record = self.model?.records[indexPath[0]] else {
            return UITableViewCell()
        }
        
        let date = Date(timeIntervalSince1970: TimeInterval(record.timestamp / 1000))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        cell.timeLabel.text = dateFormatter.string(from: date)
        cell.priceLabel.text = record.price
        cell.valueLabel.text = record.quality
        
        return cell
    }
}
