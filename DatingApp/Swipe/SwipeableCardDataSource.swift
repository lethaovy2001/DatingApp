//
//  SwipeableCardDataSource.swift
//  DatingApp
//
//  Created by Vy Le on 2/2/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

protocol SwipeableCardDataSource {
    
    func numberOfCards() -> Int
    
    func card(forItemAt index: Int) -> SwipeCardView
    
    //if all cards have been swiped away
    func viewForEmptyCards() -> UIView?
    
}

protocol SwipeCardDelegate {
    func swipeDidEnd(on view: SwipeCardView)
}
