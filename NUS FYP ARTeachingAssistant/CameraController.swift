//
//  CameraController.swift
//  NUS FYP ARTeachingAssistant
//
//  Created by yi 万 on 29/09/2020.
//  Copyright © 2020 yi 万. All rights reserved.
//
// https://medium.com/@gaspard.rosay/create-a-camera-app-with-swiftui-60876fcb9118


import UIKit
import AVFoundation

class CameraController: NSObject{
    
    var captureSession: AVCaptureSession?
    var frontCamera: AVCaptureDevice?
    var frontCameraInput: AVCaptureDeviceInput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    enum CameraControllerError: Swift.Error {
       case captureSessionAlreadyRunning
       case captureSessionIsMissing
       case inputsAreInvalid
       case invalidOperation
       case noCamerasAvailable
       case unknown
    }
    
    func prepare(completionHandler: @escaping (Error?) -> Void){
        
        // 创建进程
        func createCaptureSession(){
            self.captureSession = AVCaptureSession()
        }
        
        // 配置捕捉设备
        func configureCaptureDevices() throws {
            
            //选择摄像头
            let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front)
            // 为什么要这样，找一个中间变量？
            self.frontCamera = camera
            
            try camera?.lockForConfiguration()
            camera?.unlockForConfiguration()
                
        }
        
        func configureDeviceInputs() throws {
            guard let captureSession = self.captureSession else { throw CameraControllerError.captureSessionIsMissing }
               
            if let frontCamera = self.frontCamera {
                
                //利用 AVCaptureDeviceInput 调用摄像头捕捉到的图像
                self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)
                   
                if captureSession.canAddInput(self.frontCameraInput!) { captureSession.addInput(self.frontCameraInput!)}
                else { throw CameraControllerError.inputsAreInvalid }
                   
            }
            else { throw CameraControllerError.noCamerasAvailable }
               
            captureSession.startRunning()
               
        }
           
        DispatchQueue(label: "prepare").async {
            do {
                createCaptureSession()
                try configureCaptureDevices()
                try configureDeviceInputs()
            }
                
            catch {
                DispatchQueue.main.async{
                    completionHandler(error)
                }
                
                return
            }
            
            DispatchQueue.main.async {
                completionHandler(nil)
            }
        }
    }
    
    
    func displayPreview(on view: UIView) throws {
        guard let captureSession = self.captureSession, captureSession.isRunning else { throw CameraControllerError.captureSessionIsMissing }
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.previewLayer?.connection?.videoOrientation = .portrait
        
        view.layer.insertSublayer(self.previewLayer!, at: 0)
        self.previewLayer?.frame = view.frame
    }
    
}
