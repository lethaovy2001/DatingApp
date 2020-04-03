//
//  SwipeCardStackContainer.swift
//  DatingApp
//
//  Created by Vy Le on 2/4/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class SwipeCardStackContainer: UIView, SwipeCardDelegate {
    
    //MARK: Properties
    var numberOfCardsToShow: Int = 0
    var cardsToBeVisible: Int = 2
    var cardViews : [SwipeCardView] = []
    var remainingcards: Int = 0
    
    var visibleCards: [SwipeCardView] {
        return subviews as? [SwipeCardView] ?? []
    }
    var dataSource: SwipeableCardDataSource? {
        didSet {
            reloadData()
        }
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureViewShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup
    private func configureViewShadow() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 5.0
        self.layer.cornerRadius = Constants.PaddingValues.swipeImageCornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func reloadData() {
        removeAllCardViews()
        guard let datasource = dataSource else { return }
        setNeedsLayout()
        layoutIfNeeded()
        numberOfCardsToShow = datasource.numberOfCards()
        remainingcards = numberOfCardsToShow
        
        for i in 0..<min (numberOfCardsToShow, cardsToBeVisible) {
            addCardView(cardView: datasource.card(forItemAt: i))
        }
    }
    
    private func removeAllCardViews() {
        for cardView in visibleCards {
            cardView.removeFromSuperview()
        }
        cardViews = []
    }
    
    private func addCardView(cardView: SwipeCardView) {
       cardView.delegate = self
       cardView.frame = self.bounds
       cardViews.append(cardView)
       insertSubview(cardView, at: 0)
       remainingcards -= 1
    }
    
    func swipeDidEnd(on view: SwipeCardView) {
        guard let datasource = dataSource else { return }
        view.removeFromSuperview()

        if remainingcards > 0 {
            let newIndex = datasource.numberOfCards() - remainingcards
            addCardView(cardView: datasource.card(forItemAt: newIndex))
        }
    }

    
}
