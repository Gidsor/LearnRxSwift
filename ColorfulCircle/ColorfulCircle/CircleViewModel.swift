//
//  CircleViewModel.swift
//  ColorfulCircle
//
//  Created by Vadim Denisov on 27/09/2018.
//  Copyright © 2018 Vadim Denisov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CircleViewModel {
    var centerVariable = Variable<CGPoint?>(.zero)
    var backgroundColorObservable: Observable<UIColor>!
    
    init() {
        backgroundColorObservable = centerVariable.asObservable().map { center in
            guard let center = center else { return UIColor.red }
            let red: CGFloat = ((center.x + center.y).truncatingRemainder(dividingBy: 255)) / 255
            let green: CGFloat = (center.x .truncatingRemainder(dividingBy: 255)) / 255
            let blue: CGFloat = (center.y.truncatingRemainder(dividingBy: 255)) / 255
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}
