//
//  GameViewController.swift
//  QuestionsApp
//
//  Created by TEO on 13/12/22.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
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
    
    // Question and Answer
    var answers:[Int: Bool] = [
        0:true,
        1:false,
        2:true,
        3:true
    ]
    
    var affirmativeAnswerSelected = false
    var questionIndex = 0
    var score = 0
    var correctAnswerSoundEffect: AVAudioPlayer?
    var wrongAnswerSoundEffect: AVAudioPlayer?
    var soundEffect: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func yesAnswerButtonPressed(_ sender: Any) {
        affirmativeAnswerSelected = true
        processAnswer()
    }
    
    @IBAction func notAnswerButtonPressed(_ sender: Any) {
        affirmativeAnswerSelected = false
        processAnswer()
    }
    
    private func processAnswer() {
        let soundToPlay: String
        if isCorrectAnswer(){
            updateScore()
            soundToPlay = Const.correctAnswerSound
        } else {
            soundToPlay = Const.wrongAnswerSound
        }
        nextAnswer()
        playSound(sound: soundToPlay)
        UIDevice.vibrate()
        updateUI()
    }
    
    private func isCorrectAnswer() -> Bool {
        return affirmativeAnswerSelected == answers[questionIndex]
    }
    
    private func nextAnswer(){
        if questionIndex >= questions.count-1 {
            showScore()
        } else{
            questionIndex += 1
        }
    }
    
    private func updateQuestionLabel(){
        questionLabel.text = questions[questionIndex]
    }
        
    private func updateProgressQuestionLabel(){
        let totalQuestions = questions.count
        progressQuestionLabel.text = "\(questionIndex + 1)/\(totalQuestions)"
    }
    
    private func updateQuestionProgressView(){
        let totalQuestions = questions.count
        questionProgressView.progress = Float(questionIndex)/Float(totalQuestions)
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
        questionIndex = 0
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

