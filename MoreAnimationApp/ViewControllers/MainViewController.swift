//
//  ViewController.swift
//  MoreAnimationApp
//
//  Created by Oleg Tsarenkoff on 22.06.21.
//

import Spring

protocol SettingsViewControllerDelegate {
    func outputColor(userColor: UIColor, backgroundColor: UIColor, buttonColor: UIColor)
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var animatedView: SpringView!
    @IBOutlet weak var textAnimatedLabel: SpringLabel!
    @IBOutlet weak var runAnimationButton: SpringButton!
    
    var animation = Animations.animations.randomElement()?.rawValue ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animatedView.layer.cornerRadius = 15
        runAnimationButton.layer.cornerRadius = 10
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsVC = segue.destination as! SettingsViewController
        settingsVC.delegate = self
        settingsVC.userColor = animatedView.backgroundColor
        settingsVC.buttonUserColor = runAnimationButton.backgroundColor
        settingsVC.backgroundUserColor = view.backgroundColor
    }
    
    @IBAction func tappedRunButton(_ sender: SpringButton) {
        
        animatedView.animation = animation
        animatedView.curve = Animations.animationCurves.randomElement()?.rawValue ?? ""
        animatedView.force = CGFloat.random(in: 1...5)
        animatedView.duration = CGFloat.random(in: 0.5...5)
        animatedView.delay = CGFloat.random(in: 0...1)
        animatedView.rotate = CGFloat.random(in: 0...5)
        animatedView.damping = CGFloat.random(in: 0...1)
        
        textAnimatedLabel.text = """
            Animation: \"\(animatedView.animation)\" \n
            Curve: \"\(animatedView.curve)\" \n
            Force: \(NSString(format: "%.1f", animatedView.force)) \n
            duration: \(NSString(format: "%.1f", animatedView.duration)) \n
            delay: \(NSString(format: "%.1f", animatedView.delay)) \n
            rotate: \(NSString(format: "%.1f", animatedView.rotate)) \n
            damping: \(NSString(format: "%.1f", animatedView.damping))
            """
        
        animatedView.animate()
        
        animation = Animations.animations.randomElement()?.rawValue ?? ""
        runAnimationButton.setTitle(animation, for: .normal)
        runAnimationButton.animation = "pop"
        runAnimationButton.curve = "easelnOut"
        runAnimationButton.animate()
    }
}

// MARK: - ColorDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func outputColor(userColor: UIColor, backgroundColor: UIColor, buttonColor: UIColor){
        animatedView.backgroundColor = userColor
        runAnimationButton.backgroundColor = buttonColor
        view.backgroundColor = backgroundColor
    }
}
