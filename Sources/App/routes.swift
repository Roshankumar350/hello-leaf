import Vapor

struct Context: Content {
    //let name: String
    //let age: Int
    let movies: [Movie]
}

struct Review: Content {
    let title: String
    let rating: Int
}

struct Movie: Content {
    var name: String
    var reviews: [Review] = [Review]()
}


func routes(_ app: Application) throws {
    app.get { req -> EventLoopFuture<View> in
        
        var movie = Movie(name: "Lord of the Rings")
        let reviews = [Review(title: "Great movie!", rating: 5), Review(title: "Amazing scenary!", rating: 5)]
        movie.reviews = reviews
        
        //let movies = [Movie(name: "Spiderman"),Movie(name: "Batman")]
        let context = Context(movies: [movie])
        
        return req.view.render("index", context)
    }

    app.get("about-us") { req -> EventLoopFuture<View> in
        req.view.render("about-us")
    }
    
    app.post("add-movie") { req  -> Response in
        let movie = try req.content.decode(Movie.self)
        print(movie)
        return req.redirect(to: "/")
    }
}
