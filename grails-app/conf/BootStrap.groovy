
class BootStrap {
def bootstrapService
    def init = { servletContext ->
//        createUsers();
//        createTopics();
//        createResources();
//        createReadingItems();
//        createRatings();
//        createSubscriptions
        bootstrapService.createUsers()
bootstrapService.createTopics()
        bootstrapService.createResources()
        bootstrapService.createReadingItems()
    }

    /*void createUsers()
    {
        User u1 = new User(firstName: "Akash", lastName: "Sethi", username: "akash24", password: "akash", confirmPassword: "akash", admin: "true", active: "true", photo: null, dateCreated: null, lastUpdate: null,email:"akash@hotmail.com");
        u1.save(flush:true,failOnError: true);
        User u2 = new User(firstName: "Prithvi", lastName: "Sethi", username: "prithvi", password: "prithvi", confirmPassword:  "prithvi", admin: "true", active: "true", photo: null, dateCreated: null, lastUpdate: null,email:"Manny@gmail.com");
        u2.save(flush:true,failOnError: true);
    }
    void createTopics()
    {
        List users = User.list();
        users.each { u1 ->
            5.times {
                Topic topic = new Topic(name: "Java JDk ${it+1}",visibility: Visibility.PUBLIC )
                u1.addToTopics(topic);
                u1.addToSubscriptions(new Subscription(topic: topic, seriousness: Seriousness.SERIOUS));
                u1.save(flush:true,failonerror:true)
            }
        }
    }
    void createResources() {
       List topics=Topic.list();
        topics.eachWithIndex {  topic,index->

            User user=User.findById(index%2+1)

            topic.addToResources(
                    new LinkResource(creator:user, title:"link tittle ${index+1}",description:"link tiitle${index+1}	descripion", url:"https://grails.github.io/grails-doc/link${index+1}"  )
            )

            topic.addToResources(
                    new  DocumentResource(creator:user, title:"document tittle ${index+1}",description:" document tiitle${index+1}descripion", filePath:"//filepath/grails.github.io/grails-doc/link${index+1}"  )
            )
            topic.save(flush: true, failOnError: true);
            println("Started")
        }
    }
    void createReadingItems(){

        int size=Resource.list().size()-1;
        List<Resource> r=Resource.list()
        User.list().each{user->

            user.addToReadingItems(new ReadingItem(resource: r.get(Math.abs(1)),isRead:true))
            user.addToReadingItems(new ReadingItem(resource: r.get(Math.abs(1)),isRead:true))
            user.addToReadingItems(new ReadingItem(resource: r.get(Math.abs(2)),isRead:true))
            user.save(failOnError: true)

        }

    }*/
    def destroy = {
    }
}
