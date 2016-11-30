//
//  Info.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 10/15/2559 BE.
//  Copyright © 2559 Kajornsak Peerapathananont. All rights reserved.
//

import Foundation

public class BaseViewModel : NSObject{
    public weak var delegate: BaseViewModelDelegate?
    
    required public init(delegate: BaseViewModelDelegate) {
        self.delegate = delegate
    }
}
