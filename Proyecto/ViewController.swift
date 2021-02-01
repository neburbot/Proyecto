import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        validaUsuarioLogeado()
    }
    
    func validaUsuarioLogeado() {
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "usuarioLogeado", sender: self)
        }
        else {
            print("Favor de iniciar sesión")
        }
    }

}

