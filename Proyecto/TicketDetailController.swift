import UIKit

class TicketDetailController: UIViewController {
    @IBOutlet weak var txtDestiny: UITextView!
    @IBOutlet weak var txtCarrier: UILabel!
    @IBOutlet weak var txtFlightDate: UILabel!
    @IBOutlet weak var txtTickets: UILabel!
    @IBOutlet weak var txtTotal: UILabel!
    
    var carrier : String?
    var destiny : String?
    var flightDate : String?
    var tickets : Int?
    var total : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtDestiny.text = destiny
        txtCarrier.text = carrier
        txtFlightDate.text = flightDate
        txtTickets.text = "\(tickets!)"
        txtTotal.text = total
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
