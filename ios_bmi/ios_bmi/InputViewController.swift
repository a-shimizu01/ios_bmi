//
//  ViewController.swift
//  ios_bmi
//
//  Created by a-shimizu on 2019/11/13.
//  Copyright © 2019 a-shimizu. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {

    @IBOutlet weak var textFieldHeight: UITextField!
    @IBOutlet weak var textFieldWeight: UITextField!
    @IBOutlet weak var labelBmiValue: UILabel!
    @IBOutlet weak var textViewExplanation: UITextView!
    
    static let HEIGHT_KEY = "height"
    static let WEIGHT_KEY = "weight"
    static let BMI_KEY = "bmi"
    static let EXPLANATION_KEY = "explanation"
    
    private let textViewDefaultStr = "言い訳を書きたければ書いてください"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // テスト用データ登録
        saveBmiTestData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    }
    
    
    @IBAction func bmiSaveButtonTouchDown(_ sender: UIButton) {
        
        // アラートダイアログ エラーで落ちるので一旦保留
//        showAlertDialog(title: "エラー", message: "BMI値が未入力です。")
        
        // データ保存用Dictionary
        let dataDictionary = [InputViewController.HEIGHT_KEY: textFieldHeight.text, InputViewController.WEIGHT_KEY: textFieldWeight.text, InputViewController.BMI_KEY: labelBmiValue.text, InputViewController.EXPLANATION_KEY: textViewExplanation.text]
        
        // 現在日付取得
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM", options: 0, locale: Locale(identifier: "ja_JP"))
        let todayDateStr = formatter.string(from: Date())
        
        // 現在日付をキーにDictionaryを保存する
        UserDefaults.standard.set(dataDictionary, forKey: todayDateStr)
        
        // アラートダイアログ エラーで落ちるので一旦保留）（保存しましたってダイアログ出るようにしたいなぁ）
        labelBmiValue.text = "保存完了"
    }
    
    // テスト用メソッド 複数件のBMI計算結果のテストデータを保存する
    func saveBmiTestData() {
        let testDataKey1 = "2019年10月10日"
        let testDataDictionary1 = [InputViewController.HEIGHT_KEY: "160.0", InputViewController.WEIGHT_KEY: "55.0", InputViewController.BMI_KEY: "21.48", InputViewController.EXPLANATION_KEY: "10月1日目です。"]
        
        let testDataKey2 = "2019年10月25日"
        let testDataDictionary2 = [InputViewController.HEIGHT_KEY: "160.1", InputViewController.WEIGHT_KEY: "55.1", InputViewController.BMI_KEY: "21.49", InputViewController.EXPLANATION_KEY: "10月2日目です。"]
        
        let testDataKey3 = "2019年11月15日"
        let testDataDictionary3 = [InputViewController.HEIGHT_KEY: "160.2", InputViewController.WEIGHT_KEY: "55.2", InputViewController.BMI_KEY: "21.50", InputViewController.EXPLANATION_KEY: "11月1日目です。"]
        
        let testDataKey4 = "2019年11月20日"
        let testDataDictionary4 = [InputViewController.HEIGHT_KEY: "160.3", InputViewController.WEIGHT_KEY: "55.3", InputViewController.BMI_KEY: "21.52", InputViewController.EXPLANATION_KEY: "11月2日目です。"]
        
        let testDataKey5 = "2019年12月3日"
        let testDataDictionary5 = [InputViewController.HEIGHT_KEY: "160.4", InputViewController.WEIGHT_KEY: "55.4", InputViewController.BMI_KEY: "21.53", InputViewController.EXPLANATION_KEY: "12月1日目です。"]
        
        let testDataKey6 = "2019年12月8日"
        let testDataDictionary6 = [InputViewController.HEIGHT_KEY: "160.5", InputViewController.WEIGHT_KEY: "55.5", InputViewController.BMI_KEY: "21.54", InputViewController.EXPLANATION_KEY: "12月2日目です。"]
        
        UserDefaults.standard.set(testDataDictionary1, forKey: testDataKey1)
        UserDefaults.standard.set(testDataDictionary2, forKey: testDataKey2)
        UserDefaults.standard.set(testDataDictionary3, forKey: testDataKey3)
        UserDefaults.standard.set(testDataDictionary4, forKey: testDataKey4)
        UserDefaults.standard.set(testDataDictionary5, forKey: testDataKey5)
        UserDefaults.standard.set(testDataDictionary6, forKey: testDataKey6)
    }
    
    // 入力エリア以外をタップするとキーボードを閉じる
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // BMI計算処理
    private func bmiCalculate(heightCm: Double, weight: Double) -> Double {
        let heightM = heightCm / 100
        let bmi = weight / pow(heightM, 2)
        return bmi
    }
    
    private func showAlertDialog(title: String, message: String) {
        let dialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK",  style: .cancel, handler: nil))
        dialog.present(dialog,animated: true, completion: nil)
    }
}

