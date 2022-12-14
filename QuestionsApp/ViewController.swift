//
//  ViewController.swift
//  QuestionsApp
//
//  Created by ADMIN on 13/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressQuestionLabel: UILabel!
    
    let questions = [
        "¿Swift es un lenguaje de programación desarrollado por Apple?",
        "¿Siri es un asistente de windows?",
        "¿Un array puede tener valores duplicados?",
        "¿La palabra reservada let se usa para definir constantes?"
    ]
    
    var yesButtonPressed = false
    var notButtonPressed = false
    var i = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        updateQuestionLabel()
        updateProgressQuestionLabel()
    }

    private func nextQuestion(){
        updateQuestionLabel()
        updateProgressQuestionLabel()
        updateQuestion()
    }
    
    @IBAction func yesAnswerButtonPressed(_ sender: Any) {
        nextQuestion()
        yesButtonPressed = true
    }
    
    @IBAction func notAnswerButtonPressed(_ sender: Any) {
        nextQuestion()
        notButtonPressed = true
    }
    
    private func wasAButtonPressed() -> Bool {
        yesButtonPressed || notButtonPressed
    }
    
    private func updateQuestionLabel(){
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
        progressQuestionLabel.text = "\(i+1)/10"
    }
    
}

