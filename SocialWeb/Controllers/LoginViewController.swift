import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        loginButton.layer.cornerRadius = 8
//        loginButton.layer.borderWidth = 2
//        loginButton.layer.borderColor = UIColor.brown.cgColor
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let login = loginTextField.text!
        let password = passwordTextField.text!
        
//        guard login.isEmpty && password.isEmpty else{
//            showAlertError(message: "Введите хоть что-нибудь :(")
//            return false
//        }
        if login == "" && password == ""{
            print("Successfully")
            return true
        } else{
            print("FAIL!")
            showAlertError(message: "Введены неверные логин или пароль")
            return false
        }
    }
    
    func showAlertError(message: String){
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let loyaltyAction = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
        let action = UIAlertAction(title: "OK", style: .cancel) { _ in
            self.loginTextField.text! = ""
            self.passwordTextField.text! = ""
        }
        
        alert.addAction(action)
        alert.addAction(loyaltyAction)
        self.present(alert, animated: true)
    }
    
    @objc func keyboardWasShown(notification: Notification) {
            
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
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
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        UIButton.animate(withDuration: 5,
                         delay: 0,
                         usingSpringWithDamping: 0.75,
                         initialSpringVelocity: 0.1,
                         options: [.curveEaseInOut],
                         animations: {
                            self.loginButton.bounds = self.loginButton.bounds.insetBy(dx: -20, dy: -7)
                         },
                         completion: nil)
    }
}
