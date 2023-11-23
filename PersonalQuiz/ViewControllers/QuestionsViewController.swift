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
    @IBOutlet var rangedLabels: [UILabel]!
    // didSet будет вызываться каждый раз, когда слайдер будет обновляться. В слайдере мы определим количество ответов, чтобы задать диапазон для слайдера.
    @IBOutlet var rangedSlider: UISlider! {
        didSet {
            let answerCount = Float(currentAnswers.count - 1)
            rangedSlider.maximumValue = answerCount
            rangedSlider.value = answerCount / 2
        }
    }
    
    // Здесь у нас появился массив благодаря методу static func getQuestions() -> [Question] прописанный в файле Question.
    private let questions = Question.getQuestions()
    // Массив с выбранными ответами
    private var answerChosen: [Answer] = []
    // Определим свойство вычисляемого индекса и в зависимости от значения этого свойства будем определять тот или иной вопрос, для того чтобы отобразить этот вопрос на экране.
    private var questionIndex = 0
    // Создаем вычисляемое свойство. Оно будет возвращать массив с ответами в тот момент, когда мы обратимся к массиву questions. Обратимся мы к этому массиву в методе updateUI.
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
    // Нужно определить индекс выбранный пользователем кнопки
        guard let buttonIndex = singleButtons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswers[buttonIndex]
        answerChosen.append(currentAnswer)
        
    // Обновляем интерфейс
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                answerChosen.append(answer)
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        // Значение с типом Float приводим к типу Int, округляем до целого числа значение с типом Float
        let index = lrintf(rangedSlider.value)
        answerChosen.append(currentAnswers[index])
        nextQuestion()
    }
}

// Определим расширение для приватных методов. Обязательно нужно писать заголовок для расширения.

// MARK: - Privet Methods
extension QuestionsViewController {
    // Метод будет обновлять пользовательский интерфейс.
    private func updateUI() {
        for stackView in [singleStackView, multipleStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        // Извлекаем текущий вопрос
        let currentQuestion = questions[questionIndex]
        // Из экземпляра модели currentQuestion мы должны взять title и передать в Label
        questionLabelView.text = currentQuestion.title
        // Вычислить текущий прогресс. Нужно текущий индекс вопроса разделить на общее количество вопросов. Каждое отдельное свойство привести к Float.
        let totalProgress = Float(questionIndex) / Float(questions.count)
        // Теперь нужно задать вычисленное значение в questionProgressView
        questionProgressView.setProgress(totalProgress, animated: true)
        // Задаем заголовок вопроса
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        // Отобразить текущие ответы. Чтобы это получить, нужно отобразить текущую категорию.
        showCurrentAnswers(for: currentQuestion.responseType)
    }
    private func showCurrentAnswers(for type: ResponseType) {
        switch type {
        case .single: showSingleStackView(with: currentAnswers)
        case .multiple: showMultipleStackView(with: currentAnswers)
        case .ranged: showRangedStackView(with: currentAnswers)
        }
    }
    // Отобразим одиночные ответы
    private func showSingleStackView(with answers: [Answer]) {
    // Отобразим стэк
        singleStackView.isHidden.toggle()
    // Кортеж с кнопками и ответами, где button и answer принимают одно из четырех кнопок и ответов.
    // zip - это функция, которая создает последовательность пар из двух базовых последовательностей. Если две последовательности переданные в zip будут иметь разную длину, то полученная последовательность будет иметь длину короткой.
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.title, for: .normal)        }
    }
    
    private func showMultipleStackView(with answers: [Answer]) {
        multipleStackView.isHidden.toggle()
        
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.title
        }
    }
    
    private func showRangedStackView(with answers: [Answer]) {
        rangedStackView.isHidden.toggle()
        
        rangedLabels.first?.text = answers.first?.title
        rangedLabels.last?.text = answers.last?.title
    }
    
    private func nextQuestion() {
        questionIndex += 1
        
        // Если у нас текущий индекс меньше количество элементов массива, то мы еще не вышли за пределы массива и вызываем метод updateUI(), после чего выходим return.
        if questionIndex < questions.count {
            updateUI()
            return
        }
        
        performSegue(withIdentifier: "showResult", sender: nil)
    }
}
