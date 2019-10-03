//
//  Config.swift
//  ShadowsocksX-NG
//
//  Created by 宋志京 on 2019/9/30.
//  Copyright © 2019 qiuyuzhou. All rights reserved.
//

import Foundation

class Config: NSObject {
    
    static let instance:Config = Config()
    
    var data:[String:Any] = [:]
    var token = ""
    
    func updateData(data:[String:Any]) -> Bool{
        if ((NSDictionary(dictionary: data).isEqual(to: self.data))==false){
            self.data = data
            return true
        }
        return false
    }
    
    func setProfile(data:[String:Any]) {
        if (updateData(data: data)==false){
//            no update
            return
        }
        
        let profileMgr = ServerProfileManager.instance
        var profile = ServerProfile() //default is new one
        if !profileMgr.profiles.isEmpty {
            profile = profileMgr.profiles[0]//mod first one
        }
        profile.remark = "J"
        profile.serverHost = data["IP"] as! String
        profile.serverPort = UInt16(data["port"] as! String) ?? 58700
        profile.method = data["method"] as! String
        profile.password = data["passwd"] as! String
        if(profileMgr.profiles.isEmpty){
            profileMgr.profiles.append(profile)
        }
        profileMgr.setActiveProfiledId(profile.uuid)
        SyncSSLocal()
    }

    func getConfig(){
        var dict = [String:Any]()
        dict["token"] = self.token
        let config = synchronousPost(urlStr:"http://frp.u03013112.win:18021/v1/config/get-config",data:dict)
        let data = config as! [String:Any]
        if (data["error"] as? String != nil){
            UserDefaults.standard.set(false, forKey: "ShadowsocksOn")
            return
        }
        self.setProfile(data:data)
    }
    
    func login(username:String ,passwd:String){
        var dict = [String:Any]()
        dict["username"] = username
        dict["passwd"] = passwd
        let token = synchronousPost(urlStr:"http://frp.u03013112.win:18021/v1/user/login",data:dict) as! [String:Any]
        
        if (token["error"] as? String != nil){
            print("login err:",token["message"] as! String)
        }
        if (token["token"] as? String != nil){
            self.token = token["token"] as! String
            
//            save here
            UserDefaults.standard.set(self.token, forKey: "token")
            UserDefaults.standard.set(username, forKey: "username")
        }
    }
}
