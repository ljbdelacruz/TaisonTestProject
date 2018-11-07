//
//  AdjustingView.swift
//  TestingTaison
//
//  Created by Lainel John Dela Cruz on 07/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit

class AdjustingView: UIView {
    func Move(view:UIView, duration:Double,moveDistance:Int, up:Bool){
        let movement=CGFloat(up ? moveDistance : -moveDistance);
        UIView.animate(withDuration: duration, animations: {
            view.frame.origin.y=movement
        })
    }
}
