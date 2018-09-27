//
//  ViewController.swift
//  ColorfulCircle
//
//  Created by Vadim Denisov on 27/09/2018.
//  Copyright © 2018 Vadim Denisov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    var circleView: UIView!
    private var circleViewModel: CircleViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        addCircle()
    }

    private func addCircle() {
        circleView = UIView(frame: CGRect(origin: view.center, size: CGSize(width: 50, height: 50)))
        circleView.backgroundColor = UIColor.red
        circleView.layer.cornerRadius = circleView.frame.width / 2
        circleView.center = view.center
        
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(circleMoved(_:)))
        circleView.addGestureRecognizer(recognizer)
        
        view.addSubview(circleView)
        
        circleViewModel = CircleViewModel()
        circleView.rx.observe(CGPoint.self, "center")
            .bind(to: circleViewModel.centerVariable)
        
        circleViewModel.backgroundColorObservable.subscribe(onNext: { [weak self] backgroundColor in
            UIView.animate(withDuration: 0.1) {
                self?.circleView.backgroundColor = backgroundColor
            }
        })
    }
    
    @IBAction func circleMoved(_ recognizer: UIPanGestureRecognizer) {
        let location = recognizer.location(in: view)
        UIView.animate(withDuration: 0.1) {
            self.circleView.center = location
        }
    }

}

