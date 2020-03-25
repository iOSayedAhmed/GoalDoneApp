//
//  UIViewExt.swift
//  GoalDone
//
//  Created by Develop on 2/8/20.
//  Copyright © 2020 Develop. All rights reserved.
//

import UIKit
extension UIView {
    
    func bindToKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keybordWillChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
   @objc func keybordWillChange(_ notification : NSNotification){
    let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
    let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
    let startingFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
    let endingFrame = ( notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    let deltaY = endingFrame.origin.y - startingFrame.origin.y
    UIView.animateKeyframes(withDuration: duration, delay:0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
        self.frame.origin.y += deltaY
        print(deltaY)


    }, completion: nil)
    }
    
}
/*func bindToKeyboard () {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame , object: nil)
}

@objc func keyboardWillChange(_ notification : NSNotification) {
    let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
    let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
    let startingFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
    let endingFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

    let deltaY = endingFrame.origin.y - startingFrame.origin.y

    UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {self.frame.origin.y += deltaY
    },completion: nil)


    btc.constant -= deltaY
}
 */
