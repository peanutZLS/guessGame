//
//  BullsAndCowsViewController.swift
//  guessGame
//
//  Created by 郭家宇 on 2023/7/31.
//

import UIKit

class BullsAndCowsViewController: UIViewController {

    @IBOutlet var inputnumberLabel: [UILabel]!
    @IBOutlet var timesImage: [UIImageView]!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var recordTextview: UITextView!
    @IBOutlet var numButtons: [UIButton]!
    @IBOutlet var okButton: UIButton!
    @IBOutlet var backButton: UIButton!
    
    var starIndex:Int = 5
    var numberOfGuess : Int = 0
    var currentIndex :Int = 0
    var userNumbers:[Int] = []
    var password:[Int]=[]
    
    var resultString = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        startGame()
        print("12312314")
    }
    
    
    @IBAction func okPressed(_ sender: Any) {
        // 判斷是否為重來按鈕，如果是則重新開始遊戲
                if okButton.title(for: .normal) == "" {
                    startGame()
                // 如果否代表為OK按鈕，確認使用者輸入的答案
                } else {
                    checkAnswer()
                }
    }
    @IBAction func numberPressed(_ sender: UIButton) {
        if currentIndex < 3 {
            currentIndex += 1
            inputnumberLabel[currentIndex].text = String(sender.tag)
            sender.isEnabled = false
        }
    }
    
    @IBAction func deleteNumber(_ sender: Any) {
        if currentIndex >= 0 {
            if let currentNumber = Int(inputnumberLabel[currentIndex].text!){
                for numberButton in numButtons{
                    if numberButton.tag == currentNumber{
                        inputnumberLabel[currentIndex].text = ""
                        numberButton.isEnabled = true
                        currentIndex -= 1
                    }
                }
            }
        }
    }
    
    
    func checkAnswer(){
        if inputnumberLabel[3].text == "" { return }
        for numberLabel in inputnumberLabel{
            if let number = Int(numberLabel.text!){
                userNumbers.append(number)
            }
        }
        var a:Int = 0
        var b:Int = 0
        for indexs in 0 ... 3{
            if userNumbers[indexs] == password[indexs]{
                a += 1
            }else if password.contains(userNumbers[indexs]){
                b += 1
            }
        }
        
        var userNumberString: String = ""
        for number in userNumbers{
            userNumberString += String(number)
        }
        resultString += "\(userNumberString) \(a)A\(b)B\n"
        recordTextview.text = resultString
        
        numberOfGuess += 1
                if numberOfGuess%2 == 0 {
                    timesImage[starIndex].image = UIImage(systemName: "")
                    starIndex -= 1
                } else {
                    timesImage[starIndex].image = UIImage(systemName: "star.slash.fill")
                }
                
                // 判斷遊戲是否結束
                if a == 4 {
                    messageLabel.text = "You're Right! Total Guess: \(numberOfGuess)"
                    gameOver()
                    print("gameOver")
                }else if starIndex < 0 {
                    var passwordString: String = ""
                    for number in password {
                        passwordString += String(number)
                    }
                    messageLabel.text = "Game over. The answer is \(passwordString)"
                    gameOver()
                } else {
                    resetNumberKeyboard()
                }
    }
    
    func startGame(){
        starIndex = 5
        for star in timesImage{
            star.image = UIImage(systemName: "star.fill")
        }
        numberOfGuess = 0
        resetNumberKeyboard()
        resultString = ""
        recordTextview.text = ""
        messageLabel.text = "What's your guess?"
        password = []
        for _ in 0 ... 3{
            var randomNumber = Int.random(in: 0...9)
            while password.contains(randomNumber){
                randomNumber = Int.random(in: 0...9)
            }
            password.append(randomNumber)
        }
        print(password)
        
    }
    func resetNumberKeyboard() {
            currentIndex = -1
            // 重設使用者輸入的數字
            userNumbers = []
            for numberLabel in inputnumberLabel {
                numberLabel.text = ""
            }
            // 重新開啟號碼鍵盤
            for button in numButtons {
                button.isEnabled = true
            }
            backButton.isEnabled = true
            // 重設OK按鈕樣式
            okButton.setImage(UIImage(systemName: ""), for: .normal)
            okButton.setTitle("OK", for: .normal)
        }
    func gameOver() {
           // 關閉所有數字鍵功能
           for button in numButtons {
               button.isEnabled = false
           }
           // 關閉刪除鍵功能
           backButton.isEnabled = false
           // 將OK鍵改為重新開始樣式
           okButton.setImage(UIImage(systemName: "arrow.counterclockwise.circle"), for: .normal)
           okButton.setTitle("", for: .normal)
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
