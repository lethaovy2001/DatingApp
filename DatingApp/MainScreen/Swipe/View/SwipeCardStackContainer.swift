//
//  SwipeCardStackContainer.swift
//  DatingApp
//
//  Created by Vy Le on 2/4/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

class SwipeCardStackContainer: UIView {
    
    // MARK: Properties
    private var numberOfCardsToShow: Int = 0
    private var cardsToBeVisible: Int = 2
    private var cardViews : [SwipeCardView] = []
    private var remainingcards: Int = 0
    private var visibleCards: [SwipeCardView] {
        return subviews as? [SwipeCardView] ?? []
    }
    var dataSource: SwipeableCardDataSource? {
        didSet {
            reloadData()
        }
    }
    var matchUserDelegate: UserChoiceDelegate?
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureSelf()
        self.accessibilityIdentifier = "swipeCardStackContainer"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func configureSelf() {
        self.layer.cornerRadius =  Constants.PaddingValues.swipeImageCornerRadius
        self.layer.addShadow(withDirection: .bottom)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addDelegate(viewController: MainViewController) {
        viewController.autoSwipeDelegate = self
        self.matchUserDelegate = viewController
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
}

// MARK: SwipeCardDelegate
extension SwipeCardStackContainer: SwipeCardDelegate {
    func swipeDidEnd(on view: SwipeCardView, isMatch: Bool) {
        guard let user = view.dataSource else { return }
        guard let datasource = dataSource else { return }
        if isMatch {
            matchUserDelegate?.like(user)
        } else {
            matchUserDelegate?.dislike(user)
        }
        view.removeFromSuperview()
        cardViews.remove(at: 0)
        if remainingcards > 0 {
            let newIndex = datasource.numberOfCards() - remainingcards
            addCardView(cardView: datasource.card(forItemAt: newIndex))
        }
        if visibleCards.count == 0 {
            datasource.reloadData()
        }
    }
}

// MARK: AutoSwipeDelegate
extension SwipeCardStackContainer: AutoSwipeDelegate {
    func swipe(direction: SwipeDirection) {
        if (cardViews.isEmpty) {
            return
        }
        let card = cardViews[0]
        let centerOfParentContainer = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        var point = CGPoint(x: 0, y: 0)
        var rotation: CGFloat = 0
        var isMatch = false
        switch direction {
        case .right:
            point = CGPoint(x: centerOfParentContainer.x + 300, y: centerOfParentContainer.y + 50)
            rotation = -100
            isMatch = true
        case .left:
            point = CGPoint(x: centerOfParentContainer.x - 300, y: centerOfParentContainer.y - 50)
            rotation = 100
            isMatch = false
        }
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
            card.transform = CGAffineTransform(rotationAngle: rotation)
            card.center = point
            card.alpha = 0
            self.layoutIfNeeded()
        }, completion: { finished in
            self.swipeDidEnd(on: card, isMatch: isMatch)
        })
    }
}

protocol UserChoiceDelegate {
    func like(_ user: UserModel)
    func dislike(_ user: UserModel)
}
