import Foundation

class Connection{
    var api = ""
    
    init(api : String){
        self.api = api
    }
    
    
    func conectaMaps(){
        let session = URLSession.shared
        let urlApi = URL(string : api)!
        let request = URLRequest(url : urlApi)
        
        let thread = session.dataTask(with: request, completionHandler: executeMaps)
        thread.resume()
    }
    
    
    func conectaWeather(){
        let session = URLSession.shared
        let urlApi = URL(string : api)!
        let request = URLRequest(url : urlApi)
        
        let thread = session.dataTask(with: request, completionHandler: executeWeather)
        thread.resume()
    }
    
    
    private func executeMaps(data : Data?, response : URLResponse?, error : Error?){
        if(error == nil){
            guard let datos = data else{ return }
            
            do {
                
                
                let jsonDic = try JSONSerialization.jsonObject(with: datos, options: .mutableContainers) as! Dictionary<String,Any>
                //forecast
                print(jsonDic)
                let jsonList = jsonDic["results"] as! [Any]
                let place = jsonList[0] as! [String:Any]
                print("json place -------------------------")
                print(place["name"]!)
                print("json address -------------------------")
                print(place["formatted_address"]!)
                print("json rating -------------------------")
                print(place["rating"]!)

                print("json tamaño -------------------------")
                print(jsonList.count)
                
                var places = Array<[String:Any]>()
                for place in jsonList{
                    places.append( place as! [String:Any])
                }
//                let place1 = jsonList[0] as! [String:Any]
//                print(place1["formatted_address"])
                
//
//                let day1 = jsonList[0] as! [String:Any]
//                let day1main = day1["main"] as! [String:Any]
//                let day1weather = day1["weather"] as! [Any]
//                let day1icon = day1weather[0] as! [String:Any]
//                print(day1["dt_txt"]!)
//                
//                
//                guard let temperatura1 = day1main["temp"] else{ return }
//                guard let icon1 = day1icon["icon"] else{ return }
//                
                NotificationCenter.default.post(name:NSNotification.Name(rawValue: "places"), object: nil, userInfo: ["places":places])
//
                
                
            } catch {
                fatalError("Error al obtener la respuesta.\n\(error)")
            }
        }
    }
    
    
    private func executeWeather(data : Data?, response : URLResponse?, error : Error?){
        if(error == nil){
            guard let datos = data else{ return }
            
            do {
                
                
                let jsonDic = try JSONSerialization.jsonObject(with: datos, options: .mutableContainers) as! Dictionary<String,Any>

                //forecast
                let jsonList = jsonDic["list"] as! [Any]
                
                let day1 = jsonList[0] as! [String:Any]
                let day1main = day1["main"] as! [String:Any]
                let day1weather = day1["weather"] as! [Any]
                let day1icon = day1weather[0] as! [String:Any]
                print(day1["dt_txt"]!)
                
                guard let temperatura1 = day1main["temp"] else{ return }
                guard let icon1 = day1icon["icon"] else{ return }
                
                print("Temperatura: \(temperatura1) ºC")
                
                
                NotificationCenter.default.post(name:NSNotification.Name(rawValue: "clima"), object: nil, userInfo: ["temperatura1":temperatura1, "icon1":icon1])
                
                
            } catch {
                fatalError("Error al obtener la respuesta.\n\(error)")
            }
            
            //hacer un calendario de 3 dias de como va a estar el clima(junto con su icono)
        }
    }
    
    
    func conectaCity1(){
        let session = URLSession.shared
        let headers = [
            "x-rapidapi-host": "skyscanner-skyscanner-flight-search-v1.p.rapidapi.com",
            "x-rapidapi-key": "a364abbdf0mshe469fa80cc86869p160ebbjsn6ce9ea917a0b"
        ]
        let urlApi = URL(string : api)!
        var request = URLRequest(url : urlApi)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        
        let thread = session.dataTask(with: request, completionHandler: executeCity1)
        thread.resume()
    }
    func executeCity1(data : Data?, response : URLResponse?, error : Error?){
        if(error == nil){
            guard let datos = data else{ return }
            
            do {
                
                
                let jsonDic = try JSONSerialization.jsonObject(with: datos, options: .mutableContainers) as! Dictionary<String,Any>
                let jsonList = jsonDic["Places"] as! [Any]
                let PlaceId = jsonList[0] as! [String:Any]
//                print(PlaceId["PlaceId"]!)
                
                NotificationCenter.default.post(name:NSNotification.Name(rawValue: "placeId1"), object: nil, userInfo: ["placeId1":PlaceId["PlaceId"]!])

            } catch {
                fatalError("Error al obtener la respuesta.\n\(error)")
            }
            
        }
    }
    func conectaCity2(){
        let session = URLSession.shared
        let headers = [
            "x-rapidapi-host": "skyscanner-skyscanner-flight-search-v1.p.rapidapi.com",
            "x-rapidapi-key": "a364abbdf0mshe469fa80cc86869p160ebbjsn6ce9ea917a0b"
        ]
        let urlApi = URL(string : api)!
        var request = URLRequest(url : urlApi)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        
        let thread = session.dataTask(with: request, completionHandler: executeCity2)
        thread.resume()
    }
    func executeCity2(data : Data?, response : URLResponse?, error : Error?){
        if(error == nil){
            guard let datos = data else{ return }
            
            do {
                
                
                let jsonDic = try JSONSerialization.jsonObject(with: datos, options: .mutableContainers) as! Dictionary<String,Any>
                let jsonList = jsonDic["Places"] as! [Any]
                let PlaceId = jsonList[0] as! [String:Any]
                //                print(PlaceId["PlaceId"]!)
                
                NotificationCenter.default.post(name:NSNotification.Name(rawValue: "placeId2"), object: nil, userInfo: ["placeId2":PlaceId["PlaceId"]!])
                
            } catch {
                fatalError("Error al obtener la respuesta.\n\(error)")
            }
            
        }
    }
    
    func conectaFlights(){
        let session = URLSession.shared
        let headers = [
            "x-rapidapi-host": "skyscanner-skyscanner-flight-search-v1.p.rapidapi.com",
            "x-rapidapi-key": "a364abbdf0mshe469fa80cc86869p160ebbjsn6ce9ea917a0b"
        ]
        let urlApi = URL(string : api)!
        var request = URLRequest(url : urlApi)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        
        let thread = session.dataTask(with: request, completionHandler: executeFlights)
        thread.resume()
    }
    func executeFlights(data : Data?, response : URLResponse?, error : Error?){
        if(error == nil){
            guard let datos = data else{ return }
            
            do {
                
                
                let jsonDic = try JSONSerialization.jsonObject(with: datos, options: .mutableContainers) as! Dictionary<String,Any>
                let jsonCarriers = jsonDic["Carriers"] as! [Any]
                var carriers = Array<[String:Any]>()
                for carrier in jsonCarriers{
                    carriers.append( carrier as! [String:Any])
//                    let c = carrier as! [String:Any]
//                    let x = c as! [String:Any]
//                    print(x["Name"]!)
//                    print(x["CarrierId"]!)
                }
                
                let jsonQuotes = jsonDic["Quotes"] as! [Any]
                if jsonQuotes.count > 0 {
                    let quotes =  jsonQuotes[0] as! [String:Any]
                    let minPrice = quotes["MinPrice"]!
                    let carrierIds = quotes["OutboundLeg"] as! [String:Any]
                    let id = carrierIds["CarrierIds"]! as! Array<Any>
                    //                print(id[0])
                    //                print(minPrice)
                    
                    NotificationCenter.default.post(name:NSNotification.Name(rawValue: "flight"), object: nil, userInfo: ["carriers":carriers,"minPrice":minPrice,"carrierId":id[0]])
                }else{ return }
                
                
            } catch {
                fatalError("Error al obtener la respuesta.\n\(error)")
            }
            
        }
    }
}
