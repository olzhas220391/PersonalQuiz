//
//  Question.swift
//  PersonalQuiz
//
//  Created by Назар on 22.11.2023.
//

struct Question {
    let title: String
    let responseType: ResponseType // Категория вопросов и ответов
    let answers: [Answer] // Список ответов на вопросы
    
    // Обычно данные хранятся где то в сети на сервере, где мы делаем сетевой запрос, нам приходит JSON, берем из этого файла данные и отображаем на экране. Либо данные могут хранится локально. В нашем случае, у нас нет их.
    // Нам нужен какой нибудь набор тестовых данных. Но при этом сама модель не должна хранить данные, также как и вьюконтроллер.
    // Поэтому нам нужно реализовать метод, который будет возвращать эти данные в самой модели - назовем его static func getQuestions.
    // Этот метод ничего не будет принимать, но будет возвращать массив с готовыми вопросами.
    static func getQuestions() -> [Question] { // Метод должен быть static. Это тоже самое что метод класса, например, инициализатор. Инициализатор это метод класса, который мы вызываем непосредственно из самого класса до создания экземпляра. Мы его можем вызвать без использования экземпляра. Более того, из экземпляра мы не можем вызвать инициализатор.
    // Когда вы работаете с классом, в методе прописывают class перед func, аналогично со структурами, но там прописывают вместо class -> static перед func.
    // Теперь мы можем вызвать этот статичный метод во ViewController не создавая экземпляра private let questions = Question.getQuestions()
        [
            // Здесь нам требуется вернуть этот массив. Вручную наполняем массив, т.к. нет базы данных.
            Question(
                title: "Какую пищу вы предпочитаете?",
                responseType: .single,
                answers: [
                    Answer(title: "Стейк", animal: .dog),
                    Answer(title: "Рыба", animal: .cat),
                    Answer(title: "Морковь", animal: .rabbit),
                    Answer(title: "Кукуруза", animal: .turtle)
                ]
            ),
            Question(
                title: "Что вам нравится больше?",
                responseType: .multiple,
                answers: [
                    Answer(title: "Плавать", animal: .dog),
                    Answer(title: "Спать", animal: .cat),
                    Answer(title: "Обниматься", animal: .rabbit),
                    Answer(title: "Есть", animal: .turtle)
                ]
            ),
            Question(
                title: "Любите ли вы поездки на машине?",
                responseType: .ranged,
                answers: [
                    Answer(title: "Ненавижу", animal: .dog),
                    Answer(title: "Нервничаю", animal: .cat),
                    Answer(title: "Не замечаю", animal: .rabbit),
                    Answer(title: "Обожаю", animal: .turtle)
                ]
            )
        ]
    }
}
// Модель для категорий определим перечисление enum ResponseType
enum ResponseType {
    case single
    case multiple
    case ranged
}
// Модель для ответов struct Answer
struct Answer {
    let title: String // заголовок
    let animal: Animal //каждый ответ должен быть связан с животным
}
// 4 вида животных
enum Animal: Character {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
    // Чтобы выводить описание в соответствие с тем кейсом, который нам выпал - мы объявим в самом перечислении переменную. Это будет вычисляемое свойство, которое будет возвращать результат в зависимости от кейса.
    // Здесь мы используем switch, в котором мы будем перебирать сам тип данных self.
    // self - это наш тип перечисления.
    var definition: String {
        switch self {
        case .dog:
            return "Вам нравится быть с друзьями. Вы окружаете себя людьми, которые вам нравятся и всегда готовы помочь."
        case .cat:
            return "Вы себе на уме. Любите гулять сами по себе. Вы цените одиночество."
        case .rabbit:
            return "Вам нравится все мягкое. Вы здоровы и полны энергии."
        case .turtle:
            return "Ваша сила - в мудрости. Медленный и вдумчивый выигрывает на больших дистанциях."
        }
    }
}
