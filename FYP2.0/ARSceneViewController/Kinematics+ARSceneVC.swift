//
//  Kinematics+ARSceneVC.swift
//  FYP2.2
//
//  Created by yi 万 on 11/18/20.
//


import UIKit

extension ARSceneViewController {
    
    
    // MARK: - calculation for each joint
    func determineTypeOfFourBar( fourBarLinkLength:[Float] ) -> String {
        
        let longestLink = fourBarLinkLength.max()!
        let shortestLink = fourBarLinkLength.min()!
        
        let longestLinkIndex = fourBarLinkLength.firstIndex(of: longestLink)
        let shortestLinkIndex = fourBarLinkLength.lastIndex(of: shortestLink)
        
        var tempArrayForIntermediateIndex = [Int]()
        
        for i in 0...3 {
            if i != longestLinkIndex && i != shortestLinkIndex {
                
                tempArrayForIntermediateIndex.append(i)
            }
        }
        
        let intermediateLink1 = fourBarLinkLength[ tempArrayForIntermediateIndex[0] ]
        let intermediateLink2 = fourBarLinkLength[ tempArrayForIntermediateIndex[1] ]
        
        if shortestLink + longestLink < intermediateLink1 + intermediateLink2 {
            return ("Change Point")
            
            // Determine which link is the frame, side and coupler
            switch shortestLink {
            case fourBarLinkLength[3]:
                print("whose shortest link is frame, Double Crank\n")
                break
            case fourBarLinkLength[2]:
                print("whose shortest link is side bar, Crank Rocker\n")
                break
            case fourBarLinkLength[1]:
                print("whose shortest link is coupler, Double Rocker\n")
                break
            case fourBarLinkLength[0]:
                print("whose shortest link is side bar, Crank Rocker \n")
                break
            default:
                break
            }
            
        }
        else if ( shortestLink + longestLink == intermediateLink1 + intermediateLink2 ) {
            return ("Change Point")
        }
        else { // shortestLink + longestLink > intermediateLink1 + intermediateLink2
            return ("Triple rocker")
        }
        
    }
    
    func inverseKinematics(fourBarLinkLength:[Float], driveRotationAngle:Float, initialAngle:[Float]) ->   [Float]? {
        
        let L:[Float] = fourBarLinkLength
        let L1 = L[0]
        let L2 = L[1]
        let L3 = L[2]
        let L4 = L[3]
        
        let driveRotationAngle = driveRotationAngle + initialAngle[0]
        var fourBarLinkRotationAngle = [Float]()
              
        let type = determineTypeOfFourBar(fourBarLinkLength: fourBarLinkLength)
        
        if type == "Change Point"{
            
            let t1 = pi/2 - driveRotationAngle
            let k1 = sqrt( L1*L1 + L4*L4 - 2*L1*L4*cos(t1) )
            let t2 = acos( (L1*L1 + k1*k1 - L4*L4 )/( 2*L1*k1 ) )
            print(t2)
            let t3 = acos( (L2*L2 + k1*k1 - L3*L3)/( 2*L2*k1 ) )
            print(t3)
            let theta2 = pi - t2 - t3
            let t4 = acos( (L2*L2 + L3*L3 - k1*k1)/(2*L2*L3) )
            let theta3 = pi-t4
            let theta4 = 3*pi/2 - driveRotationAngle - theta2 - theta3
            
            fourBarLinkRotationAngle += [driveRotationAngle - initialAngle[0], theta2 - initialAngle[1], theta3-initialAngle[2], theta4-initialAngle[3]]
            print(fourBarLinkRotationAngle)
        }
        
        // TODO: 一套模型是不适用于所有长度的四连杆的， 要针对不同类型的四连杆，建立不同的运动学模型。
        // A model is not suitable for all types of FourBarLinkage,m
//        do {
//
//            driveRotationAngle = initialAngle[0] + driveRotationAngle
//
//            var L_diagonal:Float = L[0]*L[0] + L[3]*L[3] - 2*L[0]*L[3]*cos(pi/2 - driveRotationAngle)
//            L_diagonal = L_diagonal.squareRoot()
//
//
//
//            let alpha21 =  acos( (pow(L[0], 2) + pow(L_diagonal, 2) - pow(L[3], 2))
//                                / (2*L[0]*L_diagonal) )
//
//
////            let alpha41 =  pi - ( pi/2 - driveRotationAngle ) - alpha21
//
//
//
//            let alpha22 =  acos( (pow(L[1], 2) + pow(L_diagonal, 2) - pow(L[2], 2))
//                                / (2*L[1]*L_diagonal) )
//
////            let alpha42 =  acos( (pow(L[2], 2) + pow(L_diagonal, 2) - pow(L[1], 2) )
////                               / (2*L[2]*L_diagonal) )
//
//
//            let theta2 = pi - alpha21 - alpha22 - initialAngle[1]
//
//            let theta3 = pi - acos( (L[1]*L[1] + L[2]*L[2] - L_diagonal * L_diagonal) / (2*L[1]*L[2]) ) - initialAngle[2]
//
//            driveRotationAngle -= initialAngle[0]
//            let theta4 = 3*pi/2 - driveRotationAngle - theta2 - theta3
//
//
//            fourBarLinkRotationAngle += [driveRotationAngle, theta2, theta3, theta4]
//
////            print(fourBarRotationAngle)
//
//
//        }
        
        
        
        
        // Vector-Displacement Analysis向量法位移分析
//        do {
//            let x = L[3] - L[0]*sin(driveRotationAngle)
//            let y = L[0] * cos(driveRotationAngle)
//            let B = -y
//            let A = x
//
//
//
//
//
//            let rhs = asin( (pow(x,2) + pow(y,2) + pow(L[2],2) - pow(L[1], 2)) / (2*L[2]*sqrt(A*A + B*B)) )
//            let fai = atan(B/A)
//            let theta123 = rhs - fai
//            let theta12 = atan( (x - L[2]*sin(theta123))/( -L[2]*cos(theta123) - y)  )
//
//            let theta3 = theta123 - theta12 - initialAngle[2]
//            let theta2 = theta12 - driveRotationAngle - initialAngle[1]
//
//            let theta4 = 3*pi/2 - theta123 - initialAngle[3]
//
//            driveRotationAngle -= initialAngle[0]
//
//
//            fourBarLinkRotationAngle += [driveRotationAngle, theta2, theta3, theta4]
//
//
////            printDegreeFormat(fourBarLinkRotationAngle: fourBarLinkRotationAngle)
//
//
//        }
        
//        do {
//
//            var L_diagonal:Float = L[0]*L[0] + L[3]*L[3] - 2*L[0]*L[3]*cos(pi/2 - driveRotationAngle)
//
//            L_diagonal = L_diagonal.squareRoot()
//
//            let alpha21 = abs( acos( (pow(L[0], 2) + pow(L_diagonal, 2) - pow(L[3], 2))
//                                / (2*L[0]*L_diagonal) ) )
//
//
//            let alpha41 = abs( pi - ( pi/2 - driveRotationAngle ) - alpha21 )
//
//            let alpha22 = abs( acos( (pow(L[1], 2) + pow(L_diagonal, 2) - pow(L[2], 2))
//                                / (2*L[1]*L_diagonal) ) )
//
//            let alpha42 = abs( acos( (pow(L[2], 2) + pow(L_diagonal, 2) - pow(L[1], 2) )
//                               / (2*L[2]*L_diagonal) ) )
//
//            var theta4 = pi - alpha41 - alpha42
//
//            var theta2 = pi - alpha21 - alpha22
//
//            var theta3 = pi - acos( (L[1]*L[1] + L[2]*L[2] - L_diagonal * L_diagonal) / (2*L[1]*L[2]) )
//
//            theta2 = abs(pi/2 - theta2)
//            theta3 = abs(theta3 - pi/2)
//            theta4 = abs(pi/2 - theta4)
//
//            fourBarLinkRotationAngle += [driveRotationAngle - initialAngle[0], theta2 - initialAngle[1], -theta3-initialAngle[2], theta4-initialAngle[3]]
//
//        }

        
        return fourBarLinkRotationAngle
        
    }
    
    func printDegreeFormat(fourBarLinkRotationAngle:[Float]) {
        var degreeOutput = [Float]()
        
        for item in fourBarLinkRotationAngle {
            
            degreeOutput.append(item * 180 / pi)
        }
        print(degreeOutput)

    }
    
    func initialPositionCaculate(fourBarLinkLength:[Float]) -> [Float] {
        
        let L:[Float] = fourBarLinkLength
        var initialAngle = [Float]()

        let theta1 = pi/2 -  acos( (pow((L[0] + L[1]),2) + pow(L[3],2) - pow(L[2],2)) / (2 * (L[0] + L[1]) * L[3] ) )
        let theta2:Float = 0
        
        let theta3 = pi - acos( (pow((L[0] + L[1]),2) + pow(L[2],2) - pow(L[3],2)) / (2 * (L[0] + L[1]) * L[2] ) )
        
        let theta4 = 3*pi/2 - theta1 - theta2 - theta3
        
        
        initialAngle += [-theta1, -theta2, -theta3, -theta4]
        
        return initialAngle
        
    }
    

    // MARK: - Display the Movement
    func generateNewNode(mode:String = "CrankSlider"){
        
        var dtheta:Float = 0
        var displayAngle:[Float] = [0, 0, 0, 0]     // 【0】作为驱动角， 并更新从动角的各个值
        
        // 更新 长度 和 速度 参数。
//        self.fourBarLinkLength = Array(repeating: sliderBarLink1.value, count: 4)
//        self.fourBarLinkLength = [0.13, 0.18, 0.15, 0.16]
        
        self.fourBarLinkLength = [sliderBarLink1.value,
                                  sliderBarLink2.value,
                                  sliderBarLink3.value,
                                  sliderBarLink4.value]
        // 从两个位置确定
        if secondJoint != nil && firstJoint != nil {
            let frameLength = sqrt( pow( ( (firstJoint?.position.x)! - (secondJoint?.position.x)! ),2) - pow(((firstJoint?.position.y)! - (secondJoint?.position.y)!), 2)   )

            self.fourBarLinkLength![0] = frameLength
            
            if thirdJoint != nil {
                self.fourBarLinkLength![1] = sqrt( pow( ( (secondJoint?.position.x)! - (thirdJoint?.position.x)! ),2) - pow(((secondJoint?.position.y)! - (thirdJoint?.position.y)!), 2)   )
                
                if forthJoint != nil {
                    self.fourBarLinkLength![2] = sqrt( pow( ( (thirdJoint?.position.x)! - (forthJoint?.position.x)! ),2) - pow(((thirdJoint?.position.y)! - (forthJoint?.position.y)!), 2)   )
                    self.fourBarLinkLength![3] = sqrt( pow( ( (forthJoint?.position.x)! - (firstJoint?.position.x)! ),2) - pow(((forthJoint?.position.y)! - (firstJoint?.position.y)!), 2)   )
                    print(self.fourBarLinkLength)
                }
            }
        }
        self.driverLength.text = String( sliderBarLink1.value )
        
        // 逆时针转 or 顺时针转
        switch directionFlag {
        case false:
            dtheta = pi/90
            break;
        default:
            dtheta = -pi/90
        }
        fourBarRotationAngle![0] += dtheta
        
        func fourBar(){
            
            if fourBarRotationAngle![0] >= pi-pi/90 {  directionFlag = true }
            if fourBarRotationAngle![0] <= 0 + pi/90 {   directionFlag = false    }
            
            fourBarRotationAngle = inverseKinematics(fourBarLinkLength: fourBarLinkLength!, driveRotationAngle: fourBarRotationAngle![0], initialAngle: fourBarInitialAngle!)
            
            
            for i in 0...3 {
                displayAngle[i] = fourBarInitialAngle![i] + fourBarRotationAngle![i]
            }
            
            addFourBarLink(to: arView, ofLength: fourBarLinkLength!, with: displayAngle)
        }
        
        func crankSlider(){
            let followerAngle = inverseKinematics(driveAngle: fourBarRotationAngle![0], crankLength: sliderBarLink1.value, followerLength: 0.25)
            addCrankSlider(driveAngle: fourBarRotationAngle![0], followerAngle: followerAngle, crankLength: sliderBarLink1.value, followerLength: 0.25)
        }
        
        func renewNode(){
            // 新的角度算完了以后，移除当前的node
                    guard fourBarInitialAngle != nil  && fourBarLinkLength != nil else {
                        return
                    }
                    removeAllNodes()
                    
            // 更新当前的node, 以区分于初始状态（初始化 和 后续状态 是不一样的）
                    if (currentNode_detected != nil) {
                        currentNode = currentNode_detected
                    }
                    else { // currentNode_detected 就是扫描二维码得到的位置， 当currentNode_detected为nil时，就说明没有detect到。
                        currentNode = arView.scene.rootNode
                    }
        }
        
        renewNode()
        
        switch mode {
            case "FourBarLinkage":
                
                if determineTypeOfFourBar(fourBarLinkLength: self.fourBarLinkLength!) == "Change Point" {
                    fourBar()
                }else{
                    print("Not applicable to the app yet")
                }
                
                break
            case "CrankSlider":
                crankSlider()
                break
            default:
                break
        }
        
    }
    
    
    func tapTimer() -> Void {
        
        self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(1/self.driveAngleVelocity.value), repeats: true) { (Timer) in
            self.generateNewNode(mode: self.mode)
        }
        
    }
}
