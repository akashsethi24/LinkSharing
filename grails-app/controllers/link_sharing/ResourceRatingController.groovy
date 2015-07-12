package link_sharing

class ResourceRatingController {
    def scaffold=true;
    User user
    Resource resource
    def index() {
         user = User.findByUsername(session["user"])
         resource = Resource.findByTitle(params.resource)

        String rate = session["rate"]
        def a = Resource.createCriteria().list() {
            projections {
                groupProperty('topic')
                rowCount("a")

            }

            'topic' {
                eq('visibility', Visibility.PUBLIC)


            }

            order("a", "desc")
        }



        List<Topic> trendingTopics = a.collect { it.first() }

println(rate)
        [user:user,resource:resource,trend:trendingTopics,rate:rate]

    }
    def ratings(){

        println(params)
        String rate = params.star;
        ResourceRating ratings = ResourceRating.findByUserAndResource(user,resource)
        if(ratings==null) {
            ResourceRating rating = new ResourceRating();
            rating.resource = resource;
            rating.user = user;

            int a = rate.toLong();
            println("a is " + a)
            rating.score = a;
            session["rate"]=a
            rating.save(flush: true)
        }
        else
        {
            session["rate"]=ratings.score;

        }

        redirect(controller: "user",action: "done")
    }
    def deleteres(){
        Resource resource1 =Resource.findByTitle(params.title)
        resource1.delete(flush: true)
        redirect(controller: "user",action: "done")
    }
}
