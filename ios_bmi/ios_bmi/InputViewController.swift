//
//  ViewController.swift
//  ios_bmi
//
//  Created by a-shimizu on 2019/11/13.
//  Copyright © 2019 a-shimizu. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {
    
    static let PAGE_TITLE = "入力"

    @IBOutlet weak var textFieldHeight: UITextField!
    @IBOutlet weak var textFieldWeight: UITextField!
    @IBOutlet weak var labelBmiValue: UILabel!
    @IBOutlet weak var textViewExplanation: UITextView!
    
    static let MONTH_LIST_KEY = "month_list"
    
    static let DATE_KEY = "date"
    static let HEIGHT_KEY = "height"
    static let WEIGHT_KEY = "weight"
    static let BMI_KEY = "bmi"
    static let EXPLANATION_KEY = "explanation"
    
    private let textViewDefaultStr = "言い訳を書きたければ書いてください"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ヘッダータイトル設定
        self.navigationItem.title = InputViewController.PAGE_TITLE
        
        // テスト用データ登録
//        saveBmiTestData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let dialog = UIAlertController(title: "テスト", message: "メッセージ出た", preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK",  style: .cancel, handler: nil))
        dialog.present(dialog,animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func bmiCalculateButtonTouchDown(_ sender: UIButton) {
        guard let textFieldHeightStr = textFieldHeight.text,
            let textFieldWeightStr = textFieldWeight.text,
            let heightDouble = Double(textFieldHeightStr),
            let weightDouble = Double(textFieldWeightStr) else {
                // アラートダイアログ エラーで落ちるので一旦保留
//                showAlertDialog(title: "エラー", message: "入力値が正しくありません。")
                labelBmiValue.text = ""
                return
        }
        
        let bmiValue = bmiCalculate(heightCm: heightDouble, weight: weightDouble)
        labelBmiValue.text = String(bmiValue)
        
    }
    
    @IBAction func bmiClearButtonTouchDown(_ sender: UIButton) {
        textFieldHeight.text = ""
        textFieldWeight.text = ""
        labelBmiValue.text = ""
        textViewExplanation.text = textViewDefaultStr
        
        // TODO 要動作確認
        deleteTodayData()
    }
    
    func deleteTodayData() {
        // 現在日付取得
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy年M月"
        let todayMonthStr = dateformatter.string(from: Date())
        
        dateformatter.dateFormat = "d日"
        let todayDateStr = dateformatter.string(from: Date())
        
        // セクション配列
        var monthListArray = UserDefaults.standard.array(forKey: InputViewController.MONTH_LIST_KEY) as? [String] ?? []
        
        if let thisMonthSectionIndex = monthListArray.index(of: todayMonthStr),
            var thisMonthDataArray = UserDefaults.standard.array(forKey: todayMonthStr) as? [[String: String]],
            let todayData = getDateDataFromMonthDataArray(monthDataArray: thisMonthDataArray, dateStr: todayMonthStr),
            let todayDataIndex = thisMonthDataArray.index(of: todayData){
            
            if thisMonthDataArray.count == 1 {
                
                // 今月のデータリストを削除
                UserDefaults.standard.removeObject(forKey: todayMonthStr)
                
                // セクション配列から今月のセクションを削除
                monthListArray.remove(at: thisMonthSectionIndex)
                UserDefaults.standard.set(monthListArray, forKey: InputViewController.MONTH_LIST_KEY)
                
            } else {
                
                // 今月のデータリストから今日のデータを削除
                thisMonthDataArray.remove(at: todayDataIndex)
                UserDefaults.standard.set(thisMonthDataArray, forKey: todayMonthStr)
                
            }
            
        }
        
    }
    
    
    @IBAction func bmiSaveButtonTouchDown(_ sender: UIButton) {
        
        // アラートダイアログ エラーで落ちるので一旦保留
//        showAlertDialog(title: "エラー", message: "BMI値が未入力です。")
        
        // 現在日付取得
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy年M月"
        let todayMonthStr = dateformatter.string(from: Date())
        
        dateformatter.dateFormat = "d日"
        let todayDateStr = dateformatter.string(from: Date())
        
        // データ保存用Dictionary
        let dataDictionary = [InputViewController.DATE_KEY: todayDateStr, InputViewController.HEIGHT_KEY: textFieldHeight.text ?? "", InputViewController.WEIGHT_KEY: textFieldWeight.text ?? "", InputViewController.BMI_KEY: labelBmiValue.text ?? "", InputViewController.EXPLANATION_KEY: textViewExplanation.text ?? ""]
        
        if var thisMonthDataArray = UserDefaults.standard.array(forKey: todayMonthStr) as? [[String: String]] {
            // 今月のデータがすでに登録済みの場合は、今月のデータに追加、もしくは上書きして今月のデータを再登録
            if (existDateData(monthDataArray: thisMonthDataArray, dateStr: todayDateStr)) {
                // 今日のデータが登録済みの場合は上書き
                if let todayData = getDateDataFromMonthDataArray(monthDataArray: thisMonthDataArray, dateStr: todayDateStr),
                    let index = thisMonthDataArray.index(of: todayData) {
                    
                    thisMonthDataArray.remove(at: index)
                    thisMonthDataArray.insert(dataDictionary, at: index)
                    UserDefaults.standard.set(thisMonthDataArray, forKey: todayMonthStr)
                }
                
            } else {
                // 今日のデータが未登録の場合は追加
                thisMonthDataArray += [dataDictionary]
                UserDefaults.standard.set(thisMonthDataArray, forKey: todayMonthStr)
            }
            
        } else {
            // 登録済みでない場合は新規登録する
            UserDefaults.standard.set([dataDictionary], forKey: todayMonthStr)
            
            // セクションリストにも今月を追加する
            if var monthArray = UserDefaults.standard.array(forKey: InputViewController.MONTH_LIST_KEY) as? [String] {
                    monthArray += [todayMonthStr]
                    UserDefaults.standard.set(monthArray, forKey: InputViewController.MONTH_LIST_KEY)
            } else {
                // 登録済みでない場合は新規登録する
                UserDefaults.standard.set([todayMonthStr], forKey: InputViewController.MONTH_LIST_KEY)
            }
        }
        
        // アラートダイアログ エラーで落ちるので一旦保留）（保存しましたってダイアログ出るようにしたいなぁ）
        labelBmiValue.text = "保存完了"
    }
    
    // 一月分のデータに指定した日付のデータが含まれているか判定する
    func existDateData (monthDataArray: [[String: String]], dateStr: String) -> Bool {
        return getDateDataFromMonthDataArray(monthDataArray: monthDataArray, dateStr: dateStr) != nil
    }
    
    // 一月分のデータのうち指定した日付のデータがあれば取得する
    func getDateDataFromMonthDataArray (monthDataArray: [[String: String]], dateStr: String) -> [String: String]? {
        for dateData in monthDataArray {
            if dateData[InputViewController.DATE_KEY] == dateStr {
                return dateData
            }
        }
    
        return nil
    }
    
    // テスト用メソッド 複数件のBMI計算結果のテストデータを保存する
    func saveBmiTestData() {
        let sectionKey1 = "2019年10月"
        let testDataDictionary1 = [InputViewController.DATE_KEY: "10日", InputViewController.HEIGHT_KEY: "160.0", InputViewController.WEIGHT_KEY: "55.0", InputViewController.BMI_KEY: "21.48", InputViewController.EXPLANATION_KEY: "10月1日目です。"]
        
        let testDataDictionary2 = [InputViewController.DATE_KEY: "25日", InputViewController.HEIGHT_KEY: "160.1", InputViewController.WEIGHT_KEY: "55.1", InputViewController.BMI_KEY: "21.49", InputViewController.EXPLANATION_KEY: "10月2日目です。"]
        
        let sectionKey2 = "2019年11月"
        let testDataDictionary3 = [InputViewController.DATE_KEY: "15日", InputViewController.HEIGHT_KEY: "160.2", InputViewController.WEIGHT_KEY: "55.2", InputViewController.BMI_KEY: "21.50", InputViewController.EXPLANATION_KEY: "11月1日目です。"]
        
        let testDataDictionary4 = [InputViewController.DATE_KEY: "20日", InputViewController.HEIGHT_KEY: "160.3", InputViewController.WEIGHT_KEY: "55.3", InputViewController.BMI_KEY: "21.52", InputViewController.EXPLANATION_KEY: "11月2日目です。"]
        
        let sectionKey3 = "2019年12月"
        let testDataDictionary5 = [InputViewController.DATE_KEY: "3日", InputViewController.HEIGHT_KEY: "160.4", InputViewController.WEIGHT_KEY: "55.4", InputViewController.BMI_KEY: "21.53", InputViewController.EXPLANATION_KEY: "12月1日目です。"]
        
//        let testDataKey6 = "2019年12月8日"
        let testDataDictionary6 = [InputViewController.DATE_KEY: "8日", InputViewController.HEIGHT_KEY: "160.5", InputViewController.WEIGHT_KEY: "55.5", InputViewController.BMI_KEY: "21.54", InputViewController.EXPLANATION_KEY: "12月2日目です。"]
        
        let testDataSectionArray = [sectionKey1, sectionKey2, sectionKey3]
        let testDataDictionaryArray1 = [testDataDictionary1, testDataDictionary2]
        let testDataDictionaryArray2 = [testDataDictionary3, testDataDictionary4]
        let testDataDictionaryArray3 = [testDataDictionary5, testDataDictionary6]
        
        UserDefaults.standard.set(testDataSectionArray, forKey: InputViewController.MONTH_LIST_KEY)
        UserDefaults.standard.set(testDataDictionaryArray1, forKey: sectionKey1)
        UserDefaults.standard.set(testDataDictionaryArray2, forKey: sectionKey2)
        UserDefaults.standard.set(testDataDictionaryArray3, forKey: sectionKey3)
    }
    
    // 入力エリア以外をタップするとキーボードを閉じる
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // BMI計算処理
    private func bmiCalculate(heightCm: Double, weight: Double) -> Double {
        let heightM = heightCm / 100
        let bmi = weight / pow(heightM, 2)
        
        // 小数点第二位以下を丸める
        return round(bmi * 10) / 10
    }
    
    private func showAlertDialog(title: String, message: String) {
        let dialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK",  style: .cancel, handler: nil))
        dialog.present(dialog,animated: true, completion: nil)
    }
}

