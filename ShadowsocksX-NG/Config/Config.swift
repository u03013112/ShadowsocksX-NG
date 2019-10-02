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

    func getConfig() {
        let dict = [String:Any]()
        let config = synchronousPost(urlStr:"http://frp.u03013112.win:18021/v1/config/get-config",data:dict)
        self.setProfile(data:config as! [String:Any])
    }

}
