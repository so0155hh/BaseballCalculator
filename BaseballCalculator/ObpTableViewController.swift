//
//  ObpTableViewController.swift
//  BaseballCalculator
//
//  Created by 桑原　望 on 2019/12/31.
//  Copyright © 2019 Swift-Beginners. All rights reserved.
//

import UIKit

class ObpTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var atBatsText: UITextField!
    @IBOutlet weak var numberOfHitsText: UITextField!
    @IBOutlet weak var numberOfFourBallsText: UITextField!
    @IBOutlet weak var numberOfDeadBallsText: UITextField!
    @IBOutlet weak var numberOfSacFlyText: UITextField!
    @IBOutlet weak var obpResultText: UITextField!
    
    @IBOutlet weak var calculateButton: UIButton!
     let userDefaults = UserDefaults.standard
    
    @IBAction func calculate(_ sender: Any) {
        
        view.endEditing(true)
        
        if let atBats = Int(atBatsText.text!), 
            let numberOfHits = Int(numberOfHitsText.text!),
            let numberOfFourBalls = Int(numberOfFourBallsText.text!),
            let numberOfDeadBalls = Int(numberOfDeadBallsText.text!),
            let numberOfSacFly = Int(numberOfSacFlyText.text!) {
            
            if atBats <= 0 {
                print("アラート")
                let alertController = UIAlertController(title: "エラー", message: "打数が無効です", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                present(alertController, animated: true, completion: nil)
            } else {
                if numberOfHits + numberOfFourBalls + numberOfDeadBalls + numberOfSacFly == 0 {
                    obpResultText.text = ".000"
                } else {
                    //計算式の分子
                    let numerator = numberOfHits + numberOfFourBalls + numberOfDeadBalls
                    //計算式の分母
                    let denominator = atBats + numberOfFourBalls + numberOfDeadBalls + numberOfSacFly
                    
                    let result = Double(numerator) / Double(denominator)
                    let result2 = round(result * 1000)
                    let obp = Int(result2)
                    obpResultText.text = "." + String(format: "%03d", obp)
                }
            }
           // let userDefaults = UserDefaults.standard
            userDefaults.set(Int(atBats), forKey: "atBatsObp")
            userDefaults.set(Int(numberOfHits), forKey: "hitsObp")
            userDefaults.set(Int(numberOfFourBalls), forKey: "fourBalls")
            userDefaults.set(Int(numberOfDeadBalls), forKey: "deadBalls")
            userDefaults.set(Int(numberOfSacFly), forKey: "sacFly")
            userDefaults.set(obpResultText.text, forKey: "obp")
            UserDefaults.standard.synchronize()            
        }    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.atBatsText.delegate = self
        self.numberOfHitsText.delegate = self
        self.numberOfFourBallsText.delegate = self
        self.numberOfDeadBallsText.delegate = self
        self.numberOfSacFlyText.delegate = self
        let resultAtBats = userDefaults.integer(forKey: "atBatsObp")
        let resultHits = userDefaults.integer(forKey: "hitsObp")
        let resultFourBalls = userDefaults.integer(forKey: "fourBalls")
        let resultDeadBalls = userDefaults.integer(forKey: "deadBalls")
        let resultSacFly = userDefaults.integer(forKey: "sacFly")
        let resultObp = userDefaults.string(forKey: "obp")
        atBatsText.text = "\(resultAtBats)"
        numberOfHitsText.text = "\(resultHits)"
        numberOfFourBallsText.text = "\(resultFourBalls)"
        numberOfDeadBallsText.text = "\(resultDeadBalls)"
        numberOfSacFlyText.text = "\(resultSacFly)"
        obpResultText.text = resultObp
        
        //NumberPadに"Done"ボタンを表示
        let toolBar = UIToolbar(frame: CGRect(x:0, y:0, width: 320, height: 40))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolBar.items = [space, doneButton]
        atBatsText.inputAccessoryView = toolBar
        numberOfHitsText.inputAccessoryView = toolBar
        numberOfFourBallsText.inputAccessoryView = toolBar
        numberOfDeadBallsText.inputAccessoryView = toolBar
        numberOfSacFlyText.inputAccessoryView = toolBar
        self.atBatsText.keyboardType = UIKeyboardType.numberPad
        self.numberOfHitsText.keyboardType = UIKeyboardType.numberPad  
        self.numberOfFourBallsText.keyboardType = UIKeyboardType.numberPad
        self.numberOfDeadBallsText.keyboardType = UIKeyboardType.numberPad
        self.numberOfSacFlyText.keyboardType = UIKeyboardType.numberPad  
    }
    @objc func doneButtonTapped(sender: UIButton) {
        self.view.endEditing(true) 
    }
  func textFieldDidBeginEditing(_ textField: UITextField) {
       //textFieldの選択範囲を全選択にする
        textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)

    }     // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0: return 5
        case 1: return 1
        case 2: return 1
        default: return 0
        }
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }    
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
