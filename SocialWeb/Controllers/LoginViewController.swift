import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        loginButton.layer.cornerRadius = 8
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
