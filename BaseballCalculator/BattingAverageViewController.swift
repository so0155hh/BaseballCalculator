//
//  BattingAverageViewController.swift
//  BaseballCalculator
//
//  Created by 桑原　望 on 2019/12/21.
//  Copyright © 2019 Swift-Beginners. All rights reserved.
//

import UIKit

class BattingAverageViewController: UIViewController, UITextFieldDelegate
{
    
    @IBOutlet weak var atBatsText: UITextField!
    @IBOutlet weak var numberOfHitsText: UITextField!
    @IBOutlet weak var averageText: UITextField!
    
    @IBOutlet weak var calculateButton: UIButton!
    
    var memo: String?
    
    let userDefaults = UserDefaults.standard
    
    @IBAction func calculateButton(_ sender: Any) {
        
        self.view.endEditing(true)
        
        if let atBats = Int(atBatsText.text!),
            let numberOfHits = Int(numberOfHitsText.text!) {
            
            if atBats <= 0 {
                //打数が0以下のためアラートを表示
                print("アラート！")
                let alertController = UIAlertController(title: "エラー", message: "打数が無効です", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                present(alertController, animated: true, completion: nil)  
            } else {
                if numberOfHits == 0 {
                    //安打数が0の場合は打率.000を表示
                    averageText.text = ".000" 
                } else {
                    //打率を計算
                    let result = Double(numberOfHits) / Double(atBats)
                    let result2 = round(result * 1000) 
                    let average = Int(result2)
                    averageText.text = "." + String(format: "%03d",average)
                }
            }
            //保存
            userDefaults.set(Int(atBats), forKey: "atBats")
            userDefaults.set(Int(numberOfHits), forKey: "hits")
            userDefaults.set(averageText.text, forKey: "average")
            userDefaults.synchronize()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        atBatsText.delegate = self
        numberOfHitsText.delegate = self
        let resultAtBats = userDefaults.integer(forKey: "atBats")
        let resultHits = userDefaults.integer(forKey: "hits")
        let resultAverage = userDefaults.string(forKey: "average")
        
        atBatsText.text = "\(resultAtBats)"
        numberOfHitsText.text = "\(resultHits)"
        averageText.text = resultAverage
        
        //NumberPadに"Done"ボタンを表示
        let toolBar = UIToolbar(frame: CGRect(x:0, y:0, width: 320, height: 40))
        //toolBar.barStyle = UIBarStyle.default
        //toolBar.sizeToFit()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolBar.items = [space, doneButton]
        atBatsText.inputAccessoryView = toolBar
        numberOfHitsText.inputAccessoryView = toolBar
        self.atBatsText.keyboardType = UIKeyboardType.numberPad
        self.numberOfHitsText.keyboardType = UIKeyboardType.numberPad  
        
    }
    @objc func doneButtonTapped(sender: UIButton) {
        self.view.endEditing(true)
    }
    //打数or安打数が空欄の場合、ボタンを押せないようにする
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false) { _ in
            self.calculateButton.isEnabled = self.atBatsText.text != "" && self.numberOfHitsText.text != ""
        }
        return true
    } 
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //textFieldの選択範囲を全選択にする
        textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
        
    } 
    
}

