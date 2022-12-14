//
//  ViewController.swift
//  QuestionsApp
//
//  Created by ADMIN on 13/12/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private struct Const {
        static let score = "Puntaje"
        static let tryAgain = "Volver a jugar"
        static let correctAnswerSound = "CorrectAnswerSoundEffect"
        static let wrongAnswerSound = "WrongAnswerSoundEffect"
        static let mp3 = "mp3"
    }
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressQuestionLabel: UILabel!
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    let questions = [
        "¿Swift es un lenguaje de programación desarrollado por Apple?",
        "¿Siri es un asistente de windows?",
        "¿Un array puede tener valores duplicados?",
        "¿La palabra reservada let se usa para definir constantes?"
    ]
    
    var answers:[String: Bool] = [
        "Q0":true,
        "Q1":false,
        "Q2":true,
        "Q3":true
    ]
    
    var yesButtonPressed = false
    var i = -1
    var j = 0
    var score = 0
    var correctAnswerSoundEffect: AVAudioPlayer?
    var wrongAnswerSoundEffect: AVAudioPlayer?
    var soundEffect: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func yesAnswerButtonPressed(_ sender: Any) {
        yesButtonPressed = true
        sendAnswer()
    }
    
    @IBAction func notAnswerButtonPressed(_ sender: Any) {
        sendAnswer()
    }
    
    private func sendAnswer(){
        validateAnswer()
    }
    
    private func validateAnswer() {
        if isCorrectAnswer(){
            updateScore()
            UIDevice.vibrate()
            playSound(sound: Const.correctAnswerSound)
            updateUI()
        } else {
            UIDevice.vibrate()
            playSound(sound: Const.wrongAnswerSound)
            updateUI()
        }
    }
    
    private func isCorrectAnswer() -> Bool {
        let answerValue = "Q\(j)"
        let answer = yesButtonPressed == answers[answerValue] ? true : false
        yesButtonPressed = false
        nextAnswer()
        return answer
    }
    
    private func nextAnswer(){
        if j >= questions.count-1 {
            j = 0
        } else{
            j += 1
        }
    }
    
    private func updateQuestionLabel(){
        updateQuestion()
        questionLabel.text = questions[i]
    }
    
    private func updateQuestion(){
        if i >= questions.count-1 {
            showScore()
        } else{
            i += 1
        }
    }
    
    private func updateProgressQuestionLabel(){
        let currentQuestion = i+1
        let totalQuestions = questions.count
        progressQuestionLabel.text = "\(currentQuestion)/\(totalQuestions)"
    }
    
    private func updateQuestionProgressView(){
        let currentQuestion = i+1
        let totalQuestions = questions.count
        questionProgressView.progress = Float(currentQuestion)/Float(totalQuestions)
    }
    
    private func updateUI(){
        updateQuestionLabel()
        updateProgressQuestionLabel()
        updateQuestionProgressView()
    }
    
    private func updateScore(){
        score += 1
    }
    
    private func showScore(){
        let message = "Su puntaje fue \(score)"
        let scoreAlert = UIAlertController(title: Const.score, message: message, preferredStyle: .alert)
        let tryAgainAction = UIAlertAction(title: Const.tryAgain, style: .default) { _ in
            self.restartGame()
        }
        scoreAlert.addAction(tryAgainAction)
        present(scoreAlert, animated: true)
    }
    
    private func restartGame(){
        i = -1
        score = 0
        updateUI()
    }
    
    private func playSound(sound: String){
        let audioPath = Bundle.main.path(forResource: sound, ofType: Const.mp3)!
        let url = URL(fileURLWithPath: audioPath)
        do {
            soundEffect = try AVAudioPlayer(contentsOf: url)
            soundEffect?.play()
        } catch{
            print("Error")
        }
    }
}

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}

