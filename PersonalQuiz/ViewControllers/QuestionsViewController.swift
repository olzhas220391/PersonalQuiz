//
//  ViewController.swift
//  PersonalQuiz
//
//  Created by Назар on 22.11.2023.
//

import UIKit
// У нас во вьюконтроллере должны быть данные, для того чтобы мы их могли отобразить. Создадим приватный экземпляр модели данных private let questions.
class QuestionsViewController: UIViewController {
    
    @IBOutlet var questionProgressView: UIProgressView!
    @IBOutlet var questionLabelView: UILabel!
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedSlider: UISlider!
    @IBOutlet var rangedLabels: [UILabel]!
    
    
    private let questions = Question.getQuestions() // Здесь у нас появился массив благодаря методу static func getQuestions() -> [Question] прописанный в файле Question.
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

