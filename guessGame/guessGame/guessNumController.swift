//
//  guessNumController.swift
//  guessGame
//
//  Created by 郭家宇 on 2023/7/29.
//

import Foundation
import UIKit

class guessNumController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var numInput: UITextField!
    @IBOutlet weak var timesLabel: UILabel!
    var times = 6
    var max = 100                                      // 最大範圍
    var min = 1                                        // 最小範圍
    var guessNum = Int.random(in: 2...99)              // 隨機生成的待猜數字
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("\(guessNum)")
        
    }
    
    @IBAction func guessButton(_ sender: Any) {
        var guessText = numInput.text!              // 獲取使用者輸入的猜測數字文字
        var GuessNumber = Int(guessText)               // 將使用者輸入的文字轉換為整數型態
        
        if times != 0 {
            if GuessNumber == nil { // 如果轉換失敗，說明使用者輸入的不是有效的數字
                textLabel.text = "Guess a number between \(min) ~ \(max)"   // 顯示提示訊息，要求使用者輸入正確的範圍
            } else if GuessNumber! > max { // 如果使用者輸入的數字大於最大範圍
                textLabel.text = "Guess too high！input \(min) ~ \(max)"    // 顯示提示訊息，告訴使用者輸入的數字過大
            } else if GuessNumber! < min { // 如果使用者輸入的數字小於最小範圍
                textLabel.text = "Guess too low！input \(min) ~ \(max)"   // 顯示提示訊息，告訴使用者輸入的數字過小
            } else if GuessNumber! >= min && GuessNumber! < guessNum { // 如果使用者輸入的數字在最小範圍和待猜數字之間
                times -= 1
                min = GuessNumber! // 更新最小範圍
                textLabel.text = "Guess a number between \(min) ~ \(max)"  // 顯示提示訊息，告訴使用者繼續輸入更大的數字
                timesLabel.text = "Remaining times:\(times)"
            } else if GuessNumber! <= max && GuessNumber! > guessNum {
                times -= 1
                max = GuessNumber! // 更新最大範圍
                textLabel.text = "Guess a number between \(min) ~ \(max)"  // 顯示提示訊息，告訴使用者繼續輸入更小的數字
                timesLabel.text = "Remaining times:\(times)"
            } else { // 使用者猜測正確
                textLabel.text = "恭喜！"// 顯示恭喜訊息
                showAlert(title: "Congration", message: "Do you want to play again?")
                newgame()
            }
        }else{
            showAlert(title: "Sorry", message: "You loss this game....")
            newgame()
        }
        
        
    }
    func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    func newgame(){
        max = 100                                      // 重置最大範圍為100
        min = 1                                        // 重置最小範圍為1
        guessNum = Int.random(in: 2...99)          // 重新生成待猜數字
        numInput.text = ""                          // 清空文字輸入框
        textLabel.text = "Guess a number between \(min) ~ \(max)"
        times = 6
        timesLabel.text = "Remaining times:\(times)"
        
        
    }
}
