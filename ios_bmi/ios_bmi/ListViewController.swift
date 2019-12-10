//
//  ListViewController.swift
//  ios_bmi
//
//  Created by a-shimizu on 2019/11/26.
//  Copyright © 2019 a-shimizu. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    @IBOutlet weak var dateLabel: UILabel!
//    @IBOutlet weak var heightLabel: UILabel!
//    @IBOutlet weak var weightLabel: UILabel!
//    @IBOutlet weak var bmiLabel: UILabel!
//    @IBOutlet weak var explanationLabel: UILabel!
    
    @IBOutlet weak var bmiDataTableView: UITableView!
    private let BMI_DATA_TABLE_CELL_IDENTIFIER = "bmiDataTableCell"
    
    let fruits = ["apple", "banana", "grape"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM", options: 0, locale: Locale(identifier: "ja_JP"))
        let todayDateStr = formatter.string(from: Date())
        
        
        
//        guard let dataDictionary = UserDefaults.standard.dictionary(forKey: todayDateStr) else {
//            dateLabel.text = todayDateStr
//            heightLabel.text = "データがnil"
//            weightLabel.text = "データがnil"
//            bmiLabel.text = "データがnil"
//            explanationLabel.text = "データがnil"
//            return
//        }
//        let heightStr = dataDictionary[InputViewController.HEIGHT_KEY] as? String ?? ""
//        let weightStr = dataDictionary[InputViewController.WEIGHT_KEY] as? String ?? ""
//        let bmiStr = dataDictionary[InputViewController.BMI_KEY] as? String ?? ""
//        let explanationStr = dataDictionary[InputViewController.EXPLANATION_KEY] as? String ?? ""
//
//        dateLabel.text = todayDateStr
//        heightLabel.text = heightStr
//        weightLabel.text = weightStr
//        bmiLabel.text = bmiStr
//        explanationLabel.text = explanationStr
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let bmiDataTableCell: UITableViewCell = bmiDataTableView.dequeueReusableCell(withIdentifier: BMI_DATA_TABLE_CELL_IDENTIFIER, for: indexPath)
        
        // セルに表示する値を設定する
        bmiDataTableCell.textLabel!.text = fruits[indexPath.row]
        
        return bmiDataTableCell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
