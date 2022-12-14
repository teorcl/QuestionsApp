//
//  ViewController.swift
//  QuestionsApp
//
//  Created by ADMIN on 13/12/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
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
    var notButtonPressed = false
    var i = -1
    var j = 0
    var correctAnswerSoundEffect: AVAudioPlayer?
    var wrongAnswerSoundEffect: AVAudioPlayer?
    
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
        //notButtonPressed = true
    }
    
    private func sendAnswer(){
        validateAnswer()
    }
    
    private func wasAButtonPressed() -> Bool {
        yesButtonPressed || notButtonPressed
    }
    
    private func updateQuestionLabel(){
        updateQuestion()//
        questionLabel.text = questions[i]
    }
    
    private func updateQuestion(){
        if i >= questions.count-1 {
            i = 0
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
    
    private func validateAnswer() {
        if isCorrectAnswer(){
            playCorrectAnswerSound()
            updateUI()
        } else {
            playWrongAnswerSound()
            updateUI()
        }
    }
    
    private func isCorrectAnswer() -> Bool {
        let answerValue = "Q\(j)"
        let answer = yesButtonPressed == answers[answerValue] ? true : false
        // Buscar si la respuesta si es válida
        yesButtonPressed = false // Guardar en metodo
        
        //-----------------------------
        if j >= questions.count-1 {
            j = 0
        } else{
            j += 1
        }
        //-----------------------------
        
        return answer
    }
    
    private func playCorrectAnswerSound(){
        let audioPath = Bundle.main.path(forResource: "CorrectAnswerSoundEffect", ofType: "mp3")!
        let url = URL(fileURLWithPath: audioPath)
        do {
            correctAnswerSoundEffect = try AVAudioPlayer(contentsOf: url)
            correctAnswerSoundEffect?.play()
        } catch{
            print("Error")
        }
    }
    
    private func playWrongAnswerSound(){
        let audioPath = Bundle.main.path(forResource: "WrongAnswerSoundEffect", ofType: "mp3")!
        let url = URL(fileURLWithPath: audioPath)
        do {
            wrongAnswerSoundEffect = try AVAudioPlayer(contentsOf: url)
            wrongAnswerSoundEffect?.play()
        } catch{
            print("Error")
        }
    }
    
    private func updateUI(){
        updateQuestionLabel()
        updateProgressQuestionLabel()
        updateQuestionProgressView()
    }
    
}

