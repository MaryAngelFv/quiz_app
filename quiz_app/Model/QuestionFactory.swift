//
//  QuestionFactory.swift
//  quiz_app
//
//  Created by Brayam Mora on 18/05/22.
//

import Foundation

class QuestionFactory {
    
    var questions = [Question]()
    
    init() {
        
        /*if let path = Bundle.main.path(forResource: "QuestionBank", ofType: "plist") {
            if let plist = NSDictionary(contentsOfFile: path) {
                let questionData = plist["Questions"] as! [AnyObject]
                
                for questionDict in questionData {
                    if let question = questionDict["question"],
                       let answer = questionDict["answer"] {
                        questions.append(Question(
                            questionText: question as! String,
                            answer: answer as! Bool)
                        )
                    }
                }
            }
        }*/
        
        do{
            if let url = Bundle.main.url(forResource: "QuestionBank", withExtension: "plist") {
                let data = try Data(contentsOf: url)
                let questionsBank = try PropertyListDecoder().decode(QuestionsBank.self, from: data)
                self.questions = questionsBank.questions
            }
        } catch{
            print(error)
        }
    }
    
    func getQuestionAt(index: Int) -> Question? {
        if index < 0 || index > self.questions.count - 1 {
            return nil
        } else {
            return self.questions[index]
        }
    }
    
    func getRamdonQuestion() -> Question {
        let index = Int(arc4random_uniform(UInt32(questions.count)))
        return questions[index]
    }
}
