//
//  ViewController.swift
//  quiz_app
//
//  Created by Brayam Mora on 11/05/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var labelNumberQuestion: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var progressBar: UIView!
    
    var currentScore = 0
    var currentQuestionID = 0
    var correctQuestionAnswered = 0
    let factory = QuestionFactory()
    var currentQuestion : Question!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
    }
    
    func startGame() {
        currentScore = 0
        currentQuestionID = 0
        correctQuestionAnswered = 0
        
        self.factory.questions.shuffle()
        
        askNextQuestion()
        updateUIElements()
    }
    
    func askNextQuestion() {
        if let newQuestion = factory.getQuestionAt(index: currentQuestionID),
           currentQuestionID < 10 {
            self.currentQuestion = newQuestion
            self.labelQuestion.text = self.currentQuestion.questionText
            self.currentQuestionID += 1
        } else {
            gameOver()
        }
    }
    
    func gameOver() {
        let alert = UIAlertController(
            title: "Juego terminado",
            message: "Has acertado \(self.correctQuestionAnswered)/\(self.currentQuestionID). \nTu puntaje es: \(currentScore). \nIntentalo de nuevo",
            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            self.startGame()
        }
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func updateUIElements() {
        self.labelScore.text = "Puntaje: \(self.currentScore)"
        self.labelNumberQuestion.text = "\(self.currentQuestionID)/10"
        
        for constraint in self.progressBar.constraints {
            if constraint.identifier == "barWidth" {
                constraint.constant = (self.view.frame.size.width)/10 * CGFloat(currentQuestionID)
            }
        }
    }

    @IBAction func buttonPress(_ sender: UIButton) {
        var isCorrect: Bool
        
        if (sender.tag == 1) {
            isCorrect = (self.currentQuestion.answer == true)
        } else {
            isCorrect = (self.currentQuestion.answer == false)
        }
        
        var title = "Has fallado :("
        if (isCorrect) {
            self.correctQuestionAnswered += 1
            title = "¡Excelente!"
            self.currentScore += 50*correctQuestionAnswered
        }
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            self.askNextQuestion()
            self.updateUIElements()
        }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
        
    }
        
    private func changeQuestion() {
        let factory = QuestionFactory()
        let question = factory.getRamdonQuestion()
        self.labelQuestion.text = question.description
    }
    
}

