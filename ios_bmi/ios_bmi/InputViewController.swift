//
//  ViewController.swift
//  ios_bmi
//
//  Created by a-shimizu on 2019/11/13.
//  Copyright © 2019 a-shimizu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldHeight: UITextField!
    @IBOutlet weak var textFieldWeight: UITextField!
    @IBOutlet weak var labelBmiValue: UILabel!
    @IBOutlet weak var textViewExplanation: UITextView!
    
    private let textViewDefaultStr = "言い訳を書きたければ書いてください"
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        labelBmiValue.text = "保存する"
    }
    
    // 入力エリア以外をタップするとキーボードを閉じる
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
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

