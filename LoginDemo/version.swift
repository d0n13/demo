import Foundation

struct Version: Codable {
    let version: String
}

func getVersion(completion: @escaping (String?) -> Void) {

    guard let url = URL(string: "http://127.0.0.1:3001/api/v1/version") else { return }

    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    if let token = UserDefaults.standard.string(forKey: "token") {
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }

    let session = URLSession.shared
    session.dataTask(with: request) { data, response, error in

        if let error = error {
            print("Error: \(error.localizedDescription)")
            completion(nil)
            return
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            completion(nil)
            return
        }
        
        print("Response status code: \(httpResponse.statusCode)")
        
        guard let data = data else {
            completion(nil)
            return
        }

        do {
            
            let versionResp = try JSONDecoder().decode(Version.self, from: data)
            completion(versionResp.version)
            
        } catch {
            print("Error decoding response: \(error.localizedDescription)")
            completion(nil)
        }

    }.resume()
}
