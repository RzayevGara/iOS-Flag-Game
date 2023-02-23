//
//  QuizPageVC.swift
//  Flag Game
//
//  Created by Rzayev Gara on 23.02.23.
//

import UIKit

class QuizPageVC: UIViewController {

    @IBOutlet weak var labelTrue: UILabel!
    
    @IBOutlet weak var labelFalse: UILabel!
    
    @IBOutlet weak var labelQuestionCount: UILabel!
    
    @IBOutlet weak var imageViewFlag: UIImageView!
    
    @IBOutlet weak var buttonA: UIButton!
    
    @IBOutlet weak var buttonB: UIButton!
    
    @IBOutlet weak var buttonC: UIButton!
    
    @IBOutlet weak var buttonD: UIButton!
    
    
    @IBOutlet weak var trueView: UIView!
    
    @IBOutlet weak var falseView: UIView!
    
    var questions = [Flags]()
    var falseChoice = [Flags]()
    var trueQuestion = Flags()
    
    var questionCount = 0
    var trueCount = 0
    var falseCount = 0
    
    // 4 dene variant bu arrayin icinde olacaq
    var choice = [Flags]()
    
    // button yasil ve ya qirmizi olduqda basqa variant secmek olmasin
    var answerCount = 0
    
    // variantlari qarisdiririq, Flag clasinda Equatable, Hashable protokollari yaradiriq istifade ucun
    var choiceRandom = Set <Flags>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonA.layer.cornerRadius = 16
        buttonB.layer.cornerRadius = 16
        buttonC.layer.cornerRadius = 16
        buttonD.layer.cornerRadius = 16
        
        trueView.layer.cornerRadius = 10
        falseView.layer.cornerRadius = 10
        
        questions = Flagsdao().randomTrueQuestion()
        
        loadQuestion()
        
        for s in questions{
            print(s.flag_name!)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vcTo = segue.destination as! ResultPageVC
        vcTo.trueCount = trueCount
    }
    
    
    func loadQuestion(){
        labelQuestionCount.text = "Question \(questionCount + 1)"
        labelTrue.text = "True: \(trueCount)"
        labelFalse.text = "False: \(falseCount)"
        
        trueQuestion = questions[questionCount]
        imageViewFlag.image = UIImage(named: trueQuestion.flag_image!)
                
        falseChoice = Flagsdao().randomFalseQuestion(flag_id: trueQuestion.flag_id!)
        
        choiceRandom.removeAll()
        
        choiceRandom.insert(trueQuestion)
        choiceRandom.insert(falseChoice[0])
        choiceRandom.insert(falseChoice[1])
        choiceRandom.insert(falseChoice[2])
        
            //choiceRandom arrayinden id olaraq melumatlari ala bilmirik, cunki random qarisdirir, ona gore onun icinde olan random classlari append edirem choice arrayine tezeden, ama birinci choice arrayini temizleyirem
        choice.removeAll()
        
        for b in choiceRandom{
            choice.append(b)
        }
        
        // butonlara set edirik
        buttonA.setTitle(choice[0].flag_name, for: .normal)
        buttonB.setTitle(choice[1].flag_name, for: .normal)
        buttonC.setTitle(choice[2].flag_name, for: .normal)
        buttonD.setTitle(choice[3].flag_name, for: .normal)
        
    }
    
    // secdiyimiz cavabin dogrulunu yoxluyur butonun usdundeki texte gore
    func checkTrueAnswer(button: UIButton){
        let buttonText = button.titleLabel?.text
        
        let trueAnswer = trueQuestion.flag_name
        
        if trueAnswer == buttonText{
            trueCount += 1
            button.layer.backgroundColor = UIColor(named: "greenColor")?.cgColor
        }else{
            falseCount += 1
            button.layer.backgroundColor = UIColor.red.cgColor
        }
        
        labelTrue.text = "True: \(trueCount)"
        labelFalse.text = "False: \(falseCount)"
    }
    
    
    // suallarimizin sayi 5 e catanda result sehifesine kecir
    func questionCountControl(button: UIButton){
        answerCount = 0
        questionCount += 1
        button.layer.backgroundColor = UIColor.darkGray.cgColor
        if questionCount != 5{
            loadQuestion()
        }else{
            performSegue(withIdentifier: "toResultPage", sender: nil)
        }
    }
    

    @IBAction func buttonATapped(_ sender: Any) {
        answerCount += 1
        if answerCount<2{
            checkTrueAnswer(button: buttonA)
            Timeout(0.7) { self.questionCountControl(button: self.buttonA) }
        }
    }
    
    @IBAction func buttonBTapped(_ sender: Any) {
        answerCount += 1
        if answerCount<2{
            checkTrueAnswer(button: buttonB)
    //        questionCountControl(button: buttonB)
            Timeout(0.7) { self.questionCountControl(button: self.buttonB) }
        }

    }
    
    
    @IBAction func buttonCTapped(_ sender: Any) {
        answerCount += 1
        if answerCount<2{
            checkTrueAnswer(button: buttonC)
    //        questionCountControl(button: buttonC)
            Timeout(0.7) { self.questionCountControl(button: self.buttonC) }
        }

    }
    
    
    @IBAction func buttonDTapped(_ sender: Any) {
        answerCount += 1
        if answerCount<2{
            checkTrueAnswer(button: buttonD)
    //        questionCountControl(button: buttonD)
            Timeout(0.7) { self.questionCountControl(button: self.buttonD) }
        }

    }
}
