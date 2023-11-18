//
//  Data.swift
//  URLSession_server
//
//  Created by 김하람 on 2023/11/03.
//

import UIKit

struct PardData : Codable {
    // 이 부분의 변수명들은 불러온 부분과 일치해야 함.
    let data : [DataList]
}

struct DataList : Codable {
    let name : String
    let age : Int
    let part : String
    let imgURL : String
}
