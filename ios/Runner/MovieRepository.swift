import Alamofire
import SwiftyJSON

class MovieRepository {
    let baseUrl = "https://api.themoviedb.org/3"
    let apiKey = "API_KEY"

    func fetchMovies(completion: @escaping (Result<String, Error>) -> Void) {
        let url = "\(baseUrl)/movie/popular?api_key=\(apiKey)"
        AF.request(url).responseString { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
