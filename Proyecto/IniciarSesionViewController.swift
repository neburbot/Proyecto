import UIKit
import Firebase

class IniciarSesionViewController: UIViewController {

    @IBOutlet weak var correoTextField: UITextField!
    @IBOutlet weak var contraseñaTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func cancelarButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func iniciarSesionButton(_ sender: UIButton) {
        if let email = correoTextField.text, let password = contraseñaTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                    self.alertaMsj(descripcion: e.localizedDescription)
                }
                else {
                    if let respuestaFirebase = authResult {
                        print("\(respuestaFirebase.user) inicio sesión!")
                        self.performSegue(withIdentifier: "loginMenu", sender: self)
                    }
                }
            }
        }
    }
    
    func alertaMsj(descripcion: String) {
        let mensaje: String
        switch descripcion {
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
