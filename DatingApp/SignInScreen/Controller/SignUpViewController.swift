//
//  SignUpViewController.swift
//  DatingApp
//
//  Created by Vy Le on 5/13/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController : UIViewController {
    // MARK: - Properties
    private let mainView = SignUpView()
    private let database: Database
    private let auth: Authentication
    var keyboardDelegate: KeyboardDelegate?
    
    // MARK: - Initializer
    init(authentication: Authentication = FirebaseService.shared, database: Database = FirebaseService.shared) {
        self.auth = authentication
        self.database = database
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "signUpView"
        setupUI()
        setSelectors()
        mainView.addDelegate(viewController: self)
        mainView.addTapGesture(target: self, selector: #selector(dismissKeyboard))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.addSubview(mainView)
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setSelectors() {
        mainView.setLoginSelector(selector: #selector(signUp), target: self)
        mainView.setBackButtonSelector(selector: #selector(backButtonPressed), target: self)
    }
    
    //MARK: Actions
    @objc private func signUp() {
        guard
            let email = mainView.getEmailText(),
            let password = mainView.getPasswordText(),
            let name = mainView.getNameText()
            else { return }
        let queue = OperationQueue()
        let createUserOperation = CreateUserOperation(email: email, password: password)
        let signInOperation = SignInOperation(email: email, password: password)
        signInOperation.addDependency(createUserOperation)
        createUserOperation.completionBlock = {
            switch createUserOperation.result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.mainView.showError(message: error.localizedDescription)
                }
                queue.cancelAllOperations()
            default:
                break
            }
        }
        signInOperation.completionBlock = {
            self.database.updateListOfUsers()
            guard let id = self.auth.getCurrentUserId() else { return }
            let info: [String: Any] = [
                "first_name": name,
                "id": id
            ]
            let user = UserModel(info: info)
            let vc = PreferenceViewController()
            DispatchQueue.main.async {
                vc.user = user
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        queue.addOperations([createUserOperation, signInOperation], waitUntilFinished: false)
    }
    
    @objc private func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Keyboards
extension SignUpViewController {
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func handleKeyboardWillHide(notification: NSNotification) {
        keyboardDelegate?.hideKeyboard()
        performKeyboardAnimation(notification: notification)
    }
    
    @objc private func handleKeyboardWillShow(notification: NSNotification) {
        let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue ?? CGRect(x: 0, y: 0, width: 0, height: 0)
        mainView.getKeyboard(frame: keyboardFrame)
        keyboardDelegate?.showKeyboard()
        performKeyboardAnimation(notification: notification)
    }
    
    private func performKeyboardAnimation(notification: NSNotification) {
        let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        UIView.animate(withDuration: keyboardDuration!) {
            self.view.layoutIfNeeded()
        }
    }
}

extension AsyncOperation {
    enum State: String {
        case ready, executing, finished
        
        fileprivate var keyPath: String {
            "is\(rawValue.capitalized)"
        }
    }
}

class AsyncOperation: Operation {
    var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    
    // MARK: - Override Properties
    override var isReady: Bool {
        super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        state == .executing
    }
    
    override var isFinished: Bool {
        state == .finished
    }
    
    override func cancel() {
        state = .finished
    }
    
    override var isAsynchronous: Bool {
        true
    }
    
    // MARK: - Override Function
    override func start() {
        if isCancelled {
            state = .finished
            return
        }
        main()
        state = .executing
    }
}

final class CreateUserOperation: AsyncResultOperation<AuthDataResult, Error> {
    // MARK: - Properties
    private let auth: Authentication
    private let email: String
    private let password: String
    
    init(auth: Authentication = FirebaseService.shared,
         email: String,
         password: String) {
        self.auth = auth
        self.email = email
        self.password = password
    }
    
    override func main() {
        guard !dependencies.contains(where: { $0.isCancelled }), !isCancelled else {
            return
        }
        auth.createUser(email: email, password: password) { result in
            switch result {
            case .success(let data):
                self.finish(with: .success(data))
            case .failure(let error):
                self.finish(with: .failure(error))
            }
        }
    }
}

final class SignInOperation: AsyncOperation {
    // MARK: - Properties
    private let auth: Authentication
    private let email: String
    private let password: String
    
    init(auth: Authentication = FirebaseService.shared,
         email: String,
         password: String) {
        self.auth = auth
        self.email = email
        self.password = password
    }
    
    override func main() {
        guard !dependencies.contains(where: { $0.isCancelled }), !isCancelled else {
            return
        }
        self.auth.logUserIn(withEmail: email, password: password) { signInError in
            if let message = signInError {
                return
            }
            self.state = .finished
        }
    }
}

class AsyncResultOperation<Success, Failure>: AsyncOperation where Failure: Error {
    var result: Result<Success, Failure>?
    
    func finish(with result: Result<Success, Failure>) {
        self.result = result
        super.state = .finished
    }
    
    func cancel(with error: Failure) {
        self.result = .failure(error)
        super.cancel()
    }
}
