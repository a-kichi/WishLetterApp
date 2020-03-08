//
//  Letter.swift
//  WishLetterApp
//
//  Created by あーきち on 2020/03/06.
//  Copyright © 2020 あーきち. All rights reserved.
//

import Foundation

class Letter {
    
    var sentDate : Date!
    var letterText: String!
    var span: Int!
    var receiveDate: String!
    
    init(sentDate: Date, letterText: String, span: Int, receiveDate: String){
        
        self.sentDate = sentDate
        self.letterText = letterText
        self.span = span
        self.receiveDate = receiveDate
        
    }
    
}

