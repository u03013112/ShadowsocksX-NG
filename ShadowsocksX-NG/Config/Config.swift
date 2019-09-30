//
//  Config.swift
//  ShadowsocksX-NG
//
//  Created by 宋志京 on 2019/9/30.
//  Copyright © 2019 qiuyuzhou. All rights reserved.
//

import Foundation

func setProfile(data:[String:Any]) {
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
}
