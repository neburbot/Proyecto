import UIKit
import Firebase

class RegistroViewController: UIViewController {

    
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var correoTextField: UITextField!
    @IBOutlet weak var contraseñaTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func cancelarButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registroButton(_ sender: UIButton) {
        if let email = correoTextField.text, let password = contraseñaTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                    self.alertaMsj(descripcion: e.localizedDescription)
                }
                else {
                    self.performSegue(withIdentifier: "registroMenu", sender: self)
                }
            }
        }
    }
    
    func alertaMsj(descripcion: String) {
        let mensaje: String
        switch descripcion {
            case "The password must be 6 characters long or more.":
                mensaje = "La contraseña debe de tener 6 o mas caracteres"
            case "The email address is already in use by another account.":
                mensaje = "Correo no disponible"
            case "The email address is badly formatted.":
                mensaje = "Correo invalido"
            default:
                mensaje = "Error inespecífico"
        }
        let alerta = UIAlertController(title: "Ups!", message: mensaje, preferredStyle: .alert)
        let accion = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alerta.addAction(accion)
        present(alerta, animated: true, completion: nil)
    }
    
}
