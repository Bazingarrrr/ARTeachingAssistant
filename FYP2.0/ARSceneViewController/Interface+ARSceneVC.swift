//
//  Interface+ARSceneVC.swift
//  FYP2.2
//
//  Created by yi 万 on 11/20/20.
//

import UIKit


extension ARSceneViewController {
    
    
    func sliderSetUp() {
        
        
        sliderBarLink1.minimumValue = 4 * linkRadius
        sliderBarLink1.maximumValue = 0.5
        sliderBarLink1.isContinuous = false
        sliderBarLink1.setValue(10 * linkRadius, animated: true)

        sliderBarLink2.minimumValue = 4 * linkRadius
        sliderBarLink2.maximumValue = 0.5
        sliderBarLink2.isContinuous = false
        sliderBarLink2.setValue(10 * linkRadius, animated: true)

        sliderBarLink3.minimumValue = 4 * linkRadius
        sliderBarLink3.maximumValue = 0.5
        sliderBarLink3.isContinuous = false
        sliderBarLink3.setValue(10 * linkRadius, animated: true)

        sliderBarLink4.minimumValue = 4 * linkRadius
        sliderBarLink4.maximumValue = 0.5
        sliderBarLink4.isContinuous = false
        sliderBarLink4.setValue(10 * linkRadius, animated: true)

        
        
        driveAngleVelocity.minimumValue = 16
        driveAngleVelocity.maximumValue = 100
        driveAngleVelocity.isContinuous = false
        driveAngleVelocity.setValue(75, animated: true)
   
    }
    
    
    
    // MARK: - Gesture Recognization Method
    func GestureSetUp() {
    
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnARSCNView))
        arView.addGestureRecognizer(tapGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchOnARSCNView))
        arView.addGestureRecognizer(pinchGesture)
        
    }
    
    
    @objc func tappedOnARSCNView() {
        
        
        guard fourBarInitialAngle != nil  && fourBarLinkLength != nil else {
            return
        }
        
        generateNewNode(mode: "FourBarLinkage")
        

    }
    
    
    // can reset
    @objc func pinchOnARSCNView() {
        
        switch self.navigationController?.isNavigationBarHidden {
            case true:
                self.navigationController?.isNavigationBarHidden = false
            case false:
                self.navigationController?.isNavigationBarHidden = true
            default:
                print("isNavigationBarHidden is nil")
        }

    }

    
    
    
}
