//
//  InfoForFakeResponseData.swift
//  RecipleaseTests
//
//  Created by ROUX Maxime on 16/11/2021.
//

import Foundation

struct DataTest {
    let url : URL
    let resource : String
}

let edamamFirstCall = DataTest(url: URL(string: "https://api.edamam.com/api/recipes/v2?type=public&app_id=057c28a7&app_key=b4db2359b9f2a14e2980106b8eadeffa&q=Lemon")!, resource: "FirstCall")
let edamamFirstNextCall = DataTest(url: URL(string: "https://api.edamam.com/api/recipes/v2?q=Lemon&app_key=b4db2359b9f2a14e2980106b8eadeffa&_cont=CHcVQBtNNQphDmgVQntAEX4BYlBtAgAFQGdCA2sUZFJ7BwEVX3cTC2oTNgB2DQtWETNHBmpAYAR6AFYORjRBCjZAMVV0ABFqX3cWQT1OcV9xBB8VADQWVhFCPwoxXVZEITQeVDcBaR4-SQ%3D%3D&type=public&app_id=057c28a7")!, resource: "NextCall")
