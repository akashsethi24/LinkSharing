package link_sharing



class TopicController {
    def scaffold=true;
    def index() {
        println(params)
        String u = session["user"]
       User user = User.findByUsername(u)
        String s1 = params.topic
        Topic topic=Topic.findByName(s1)
        Subscription subscription= Subscription.findByTopic(topic)
        def t = Subscription.countByTopic(topic)
        def r = Resource.countByTopic(topic)
        List<Resource> resourceList = Resource.findAllByTopic(topic)
        List <User> userList=Subscription.createCriteria().list(){
            projections{property('user')}
            eq('topic',topic)
        }


        [user:user,topic:topic,tcount:t,rcount:r,subs:subscription,userlist:userList,resource: resourceList]
    }
    def readunread(){
        println(params)
        User user= User.findByUsername(session["user"])
        Resource resource = Resource.findByTitle(params.title)
        ReadingItem readingItem = ReadingItem.findWhere(resource: resource,isRead: false,user:user)
        println(resource.description)
        println(readingItem.resource)
        if(readingItem.isRead==true)
        {
            readingItem.isRead==false
            readingItem.save(flush: true)
            println("done")
        }
        else
        {
            readingItem.isRead=true
            readingItem.save(flush: true)

        }
        redirect(controller: "dashboard" ,action: "index")
    }
    def created(){
        User user=User.findByUsername(session["user"])

        Topic topi = new Topic(params);

        String u = session["user"];
        user = User.findByUsername(u)
        topi.user = user;
        if (topi.validate()) {
            user.addToTopics(topi);
            user.addToSubscriptions(new Subscription(topic: topi, seriousness:
                    Seriousness.SERIOUS));
            user.save(flush: true, failonerror: true)
            // topi.save(flush: true);
            flash.message = "Saved "

            redirect(controller: "user" ,action: "done")
        } else {
            redirect(controller: "user",action: "errors")
        }
    }

def createtopic(){
User user = User.findByUsername(session["user"])
    [user: user]
}
def edittopic(){
    println(params)
    User user = User.findByUsername(session["user"])

    Topic topic = Topic.findByName(params.topic)
    Subscription subscription = Subscription.findByTopic(topic)
    session["topicname"]=params.topic
    [topic: topic,users:user,subs:subscription]
}
    def changetopic()
    {
        println(params)
        Topic topic= Topic.findByName(session["topicname"])
        Subscription subscription = Subscription.findByTopic(topic)
        subscription.seriousness=params.seriousness;
        subscription.save(flush: true)
        topic.name=params.name;
        topic.visibility=params.visibility;
        topic.save(failOnError: true,flush: true)
        redirect(controller: "dashboard",action: "index")
    }
    def admintopic(){
        User user = User.findByUsername(session["user"])
        params.max = params.max ?: 20
        List<Topic> topics = Topic.createCriteria().list(max:20,offset:0) {
            like("name","%")
        }
        println(topics)
        def tcount= Topic.count()
        [user: user,topic: topics,total:tcount]
    }

}
