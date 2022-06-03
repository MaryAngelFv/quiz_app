//
//  Question.swift
//  quiz_app
//
//  Created by Brayam Mora on 13/05/22.
//

import Foundation

class Question : Codable {
    
    let questionText: String
    let answer: Bool
    
    enum CodingKeys : String, CodingKey {
        case questionText = "question"
        case answer = "answer"
    }
    
    var description: String {
        let respuesta = (answer ? "Verdadero" : "Falso")
        return """
        Pregunta:
        - \(questionText)
        Respuesta:
        - \(respuesta)
        """
    }
    
    init(questionText: String, answer: Bool) {
        self.questionText = questionText
        self.answer = answer
    }
}
