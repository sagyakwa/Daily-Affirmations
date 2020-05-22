//
//  GestureRecognizer.swift
//  Daily Affirmations
//
//  Created by Samuel Agyakwa on 5/22/20.
//  Copyright © 2020 Samuel Agyakwa. All rights reserved.
//
import SwiftUI

//  Class to recognize all gestures
class AnyGestureRecognizer: UIGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        //To prevent keyboard hide and show when switching from one textfield to another
        if
            let textField = touches.first?.view,
            textField is UITextField || textField is UITextView
        {
            state = .cancelled // Use canceled instead of failed so the selection popup won't be dismissed after selection.
        } else {
            state = .began
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       state = .ended
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .cancelled
    }
}


