//
//  BorrowBikeProtocol.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 1/24/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation


protocol BorrowBikeDelegate : class{
    func onBorrowBikeSuccess(bike : BikeModel)
    func onBorrowBikeFailed(message : String)
}
