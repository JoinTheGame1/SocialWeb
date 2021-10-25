import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var handle: AuthStateDidChangeListenerHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        setupGradient()
        loginButton.layer.cornerRadius = 8
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.handle = Auth.auth().addStateDidChangeListener{ auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "toVKAuthorize", sender: nil)
                self.loginTextField.text = nil
                self.passwordTextField.text = nil
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        Auth.auth().removeStateDidChangeListener(handle)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    // Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    // Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    func setupGradient() {
        let mainLayer = CAGradientLayer()
        mainLayer.colors = [UIColor(named: "loginBackground1")!.cgColor, UIColor(named: "loginBackground2")!.cgColor]
        mainLayer.locations = [0.04, 0.99]
        mainLayer.startPoint = CGPoint(x: 0, y: 0.5)
        mainLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        mainLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1.05, b: 1.02, c: -1.02, d: 0.22, tx: 0.52, ty: -0.12))
        mainLayer.bounds = view.bounds.insetBy(dx: -0.5*loginView.bounds.size.width, dy: -0.5*loginView.bounds.size.height)
        mainLayer.position = loginView.center
        loginView.layer.insertSublayer(mainLayer, at: 0)
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let closeAction = UIAlertAction(title: "Ok",
                                        style: .cancel) { [weak self] _ in
            guard let self = self else { return }
            self.loginTextField.text = ""
            self.passwordTextField.text = ""
        }
        
        alertController.addAction(closeAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        guard let email = loginTextField.text,
              let password = passwordTextField.text,
              email.count > 0,
              password.count > 0
        else {
            showAlert(title: "Error", message: "Login/password is not entered")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            if let error = error, user == nil {
                self?.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let emailTextField = alert.textFields?[0],
                  let passwordTextField = alert.textFields?[1],
                  let email = emailTextField.text,
                  let password = passwordTextField.text
            else { return }
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] user, error in
                if let error = error {
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                } else {
                    Auth.auth().signIn(withEmail: email, password: password)
                }
            }
        }
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
