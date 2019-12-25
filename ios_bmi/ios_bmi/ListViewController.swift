//
//  ListViewController.swift
//  ios_bmi
//
//  Created by a-shimizu on 2019/11/26.
//  Copyright © 2019 a-shimizu. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var bmiDataTableView: UITableView!
    private let BMI_DATA_TABLE_CELL_IDENTIFIER = "bmiDataTableViewCell"
    
    var monthListArray: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bmiDataTableView.estimatedRowHeight = 100
        bmiDataTableView.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
    }
    
    /// リスト表示関連処理
    
    func numberOfSections(in tableView: UITableView) -> Int {
        monthListArray = UserDefaults.standard.array(forKey: InputViewController.MONTH_LIST_KEY) ?? []
        return monthListArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return monthListArray[section] as? String ?? ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let thisMonthDataArray = UserDefaults.standard.array(forKey: monthListArray[section] as? String ?? "") ?? []
        return thisMonthDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let bmiDataTableViewCell = bmiDataTableView.dequeueReusableCell(withIdentifier: BMI_DATA_TABLE_CELL_IDENTIFIER, for: indexPath) as! BmiDataTableViewCell
        
        let thisMonthDataArray = UserDefaults.standard.array(forKey: monthListArray[indexPath.section] as? String ?? "") ?? []
        let dataDictionary = thisMonthDataArray[indexPath.row] as? Dictionary ?? [:]
        
        // セルに表示する値を設定する
        bmiDataTableViewCell.dateLabel!.text = dataDictionary[InputViewController.DATE_KEY] as? String ?? ""
        bmiDataTableViewCell.heightLabel!.text = dataDictionary[InputViewController.HEIGHT_KEY] as? String ?? ""
        bmiDataTableViewCell.weightLabel!.text = dataDictionary[InputViewController.WEIGHT_KEY] as? String ?? ""
        bmiDataTableViewCell.bmiLabel!.text = dataDictionary[InputViewController.BMI_KEY] as? String ?? ""
        bmiDataTableViewCell.explanationTextView!.text = dataDictionary[InputViewController.EXPLANATION_KEY] as? String ?? ""
        
        return bmiDataTableViewCell
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
