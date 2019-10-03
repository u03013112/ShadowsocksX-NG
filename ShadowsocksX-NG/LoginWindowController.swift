//
//  LoginWinController.swift
//  ShadowsocksX-NG
//
//  Created by 宋志京 on 2019/10/3.
//  Copyright © 2019 qiuyuzhou. All rights reserved.
//

import Cocoa
class LoginWindowController: NSWindowController {
    @IBOutlet weak var usernameTextField: NSTextField!
    @IBOutlet weak var passwdTextField: NSSecureTextField!
    
    
    @IBAction func didLoginClicked(_ sender: NSButton) {
        let username = self.usernameTextField.stringValue
        let passwd = self.passwdTextField.stringValue
        print(username,passwd)
        
        Config.instance.login(username: username, passwd: passwd)
        
        window?.performClose(self)
//        self.close()

        
        NotificationCenter.default
            .post(name: NOTIFY_CONF_CHANGED, object: nil)
    }
}
