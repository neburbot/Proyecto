import UIKit
import Firebase

struct CellTicket {
    let carrier : Any?
    let destiny : Any?
    let flightDate : Any?
    let tickets : Any?
    let total : Any?
}


class MyTicketsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableTickets: UITableView!
    var tickets = [CellTicket]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ticketRef = Database.database().reference().child("ticket")
        
        ticketRef.observe(.value, with: { snapshot in
            for child in snapshot.children{
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let carrier = dict["Carrier"] as? String,
                    let destiny = dict["Destiny"] as? String,
                    let flightDate = dict["FlightDate"] as? String,
                    let ticketN = dict["Tickets"] as? Int,
                    let total = dict["Total"] as? String {
                    self.tickets.append(CellTicket.init(carrier: carrier, destiny: destiny, flightDate: flightDate, tickets: ticketN, total: total))
                    
                }
            }
            self.tableTickets.reloadData()

        })

    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(tickets.count)
        return tickets.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "celdaTickets")
        
        let ticket = tickets[indexPath.row]
        
        cell.textLabel?.text = ticket.destiny as? String
        cell.detailTextLabel?.text = ticket.flightDate as? String
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "TicketDetailController") as! TicketDetailController
        let ticket = tickets[indexPath.row]
        
        resultViewController.carrier = ticket.carrier as? String
        resultViewController.destiny = ticket.destiny as? String
        resultViewController.flightDate = ticket.flightDate as? String
        resultViewController.tickets = ticket.tickets as? Int
        resultViewController.total = ticket.total as? String

        if tableView.cellForRow(at: indexPath)?.textLabel?.text != nil{
            self.navigationController?.pushViewController(resultViewController, animated: true)
        }

    }

}
