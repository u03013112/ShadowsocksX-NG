//
//  HTTP.swift
//  ShadowsocksX-NG
//
//  Created by 宋志京 on 2019/9/30.
//  Copyright © 2019 qiuyuzhou. All rights reserved.
//

import Foundation

//MARK: - 同步Post方式
func synchronousPost(urlStr:String,data:Any) -> Any{
    // 1、创建URL对象；
    let url:URL! = URL(string:urlStr);
    
    // 2、创建Request对象
    // url: 请求路径
    // cachePolicy: 缓存协议
    // timeoutInterval: 网络请求超时时间(单位：秒)
    var urlRequest:URLRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
    
    // 3、设置请求方式为POST，默认是GET
    urlRequest.httpMethod = "POST"
    
    // 4、设置参数
    let jsonData = try? JSONSerialization.data(withJSONObject: data)
    urlRequest.httpBody = jsonData;
    
    // 5、响应对象
    var response:URLResponse?
    
    // 6、发出请求
    do {
        //暂时采用同步的，比较简单，如果有必要可以改成异步。
        let received =  try NSURLConnection.sendSynchronousRequest(urlRequest, returning: &response)
        let dic = try JSONSerialization.jsonObject(with: received, options: JSONSerialization.ReadingOptions.allowFragments)
        print(dic)
        //let jsonStr = String(data: received, encoding:String.Encoding.utf8);
        //print(jsonStr)
        return dic
    } catch let error{
        print(error.localizedDescription);
    }
    return [String:Any]()
}
