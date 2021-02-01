import UIKit
import Firebase

class ConfirmTicketsController: UIViewController {
    
    @IBOutlet weak var txtCarrier: UILabel!
    @IBOutlet weak var txtDestiny: UITextView!
    @IBOutlet weak var txtTotal: UILabel!
    @IBOutlet weak var txtTickets: UILabel!
    
    var carrier : String?
    var price = 1
    var destiny : String?
    var flightDate : String?
    var total:Int = 0
    var tickets = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        txtDestiny.text = destiny!
        txtCarrier.text = carrier!
        txtTotal.text = "Total: $\(price)"
    }
    
    
    @IBAction func stepperTickets(_ sender: UIStepper) {
        tickets = Int(sender.value)
        txtTickets.text = String(tickets)
        total = tickets*price
        txtTotal.text = "Total: $\(total)"
    }
    
    
    @IBAction func btnConfirm(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "MapController") as! MapController

        
        let alert = UIAlertController(title: "Ticket", message: "Tickets comprados exitosamente!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
            
            let postRef = Database.database().reference().child("ticket").childByAutoId()
            
            let postObject = [
                "Destiny" : self.destiny!,
                "Carrier" : self.carrier!,
                "Tickets" : self.tickets,
                "FlightDate" : self.flightDate!,
                "Total" : "$\(self.total) MXN"
                ] as [String:Any]
            
            postRef.setValue(postObject, withCompletionBlock: { error, ref in
                if error == nil {
                    self.dismiss(animated: true, completion:nil)
                }
            })
            self.navigationController?.pushViewController(resultViewController, animated: true)
            
            
        }))
        self.present(alert, animated: true)
        
    }
    
}
