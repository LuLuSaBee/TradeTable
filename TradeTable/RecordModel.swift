//
//  RecordModel.swift
//  TradeTable
//
//  Created by 劉聖龍 on 2022/5/2.
//

import Foundation

struct Record {
    var timestamp: Int
    var price: String
    var quality: String
}

class RecordModel {
    var records: [Record] = []
    
    public func addNewData(_ data: String) {
        guard let jsonData = parseToJson(data) else { return }
        
        let record = Record(timestamp: jsonData["E"] as! Int, price: jsonData["p"] as! String, quality: jsonData["q"] as! String)
        self.records.insert(record, at: 0)
        
        if self.records.count > 40 {
            self.records = Array(self.records[..<40])
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("NewData"), object: nil)
    }

    private func parseToJson(_ text: String) -> [String: Any]? {
        guard let json = try? JSONSerialization.jsonObject(with: text.data(using: .utf8)!, options : .allowFragments) as? [String: Any], let data = json["data"] as? [String: Any] else {
            return nil
        }
        
        return data
    }
}
