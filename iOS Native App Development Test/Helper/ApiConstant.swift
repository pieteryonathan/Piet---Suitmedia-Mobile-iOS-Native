//
//  ApiConstant.swift
//  iOS Native App Development Test
//
//  Created by Pieter Yonathan on 12/06/22.
//

import Foundation

class ApiConstant{
    static let urlUser: URL = {
        return URL(string: "https://reqres.in/api/users?page=1&per_page=10")!
    }()
}
