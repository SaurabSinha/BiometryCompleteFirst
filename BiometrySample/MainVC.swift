//
//  ViewController.swift
//  BiometrySample
//
//  Created by CTPL on 07/09/21.
//

import UIKit
import LocalAuthentication
class MainVC: UIViewController {
    @IBOutlet var identyBtn:UIButton!
    
let context = LAContext()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.beingIdentity()
    }

    @IBAction func identyBtnTabbed() {
        self.beingIdentity()
    }
    func beingIdentity(){
        
        var error:NSError?
        
        guard self.context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return print(error!)
        }
        if self.context.biometryType == .faceID {
            //face ID
            print("FaceID")
            self.identyBtn.setImage(UIImage(named:"FaceID"), for: .normal)
        }else if self.context.biometryType == .touchID {
            // Touch ID
            print("Touch_ID")
            self.identyBtn.setImage(UIImage(named:"Touch_ID"), for: .normal)
        }else{
           // none
            print("None")
        }
        
        let reason = "Identify yourself to continue"
        self.context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: reason) {
            (isSuccess, error) in
            if isSuccess {
               //Success
                print("Success")
            } else {
              //Error
                self.showLAError(laError: error!)
            }
        }
    }

    //fuction to detect an error type
    func showLAError(laError: Error) -> Void {
        var message = ""
        switch laError {
        case LAError.appCancel:
            message = "Authentication was Cancelled by Application"
        case LAError.authenticationFailed:
            message = "The User Failed to provide valid Credentials"
        case LAError.invalidContext:
            message = "The context is invalid"
        case LAError.passcodeNotSet:
            message = "Passcode is not set on the ios device"
        case LAError.systemCancel:
            message = "Authentication was cancelled by the system"
        case LAError.biometryLockout:
            message = "Too many failed attempts"
        case LAError.biometryNotAvailable:
            message = "Touch ID is not available on the device"
        case LAError.userCancel:
            message = "The user did cancel"
        case LAError.userFallback:
            message = "The user choose to use the fall back"
        default:
            message = "Face ID / Touch ID may not be configured"
        }
        print("LAError - \(message)")
    }
}

