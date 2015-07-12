package link_sharing



class DocumentResourceController {
    def scaffold=true;
    def index() {
        String username=session["user"]
        User user  = User.findByUsername(username)
        String topicname=params.topic
        Topic topi = Topic.findByName(topicname)
        println("jjjj"+topi+user)
//        user.addToTopics(topi);
        user.addToSubscriptions(new Subscription(topic: topi, seriousness:
                Seriousness.SERIOUS));
        user.save(flush: true, failonerror: true)
    println(params)

    redirect(controller: "dashboard" ,action: "index")
    }
    def search(){
        String username=session["user"]
        session["search"]=params.search
        User user  = User.findByUsername(username)
        Visibility visibility = Visibility.PUBLIC
        String search = params.search
        if(user.admin==true)
        {
           redirect(controller: "documentResource" ,action: "adminsearch")
        }
        else
        {
            search=search+"%";
            List<Topic> topicList = Topic.createCriteria().list {
                like("name",search)
                eq("visibility", visibility)
            }

            List<Resource> resourceList= Resource.createCriteria().list {
                like("description",search)
            }
            List<Topic> topics = Topic.findAllByUser(user)
            [topicList:topicList,user:user,resources: resourceList,topics:topics]
        }
    }
    def adminsearch(){
        User user = User.findByUsername(session["user"])
        println("User "+user)
        if (session["search"]==""){
            List<Resource> resources = Resource.all.toList();
            [resources: resources,user: user]
        }
        else
        {
                String search=session["search"]
            search=search+"%";


            List<Resource> resources = Resource.createCriteria().list {
                like("title",search)
            }
            [resources:resources,user: user]
        }
    }
    def unsubs(){
        println(params)
        User user = User.findByUsername(session["user"])
        Topic untop = Topic.findByName(params.topic)
        Subscription subscription = Subscription.findWhere(topic:  untop,user: user)
        println(untop.user)
        println(user)
        if(untop.user!=user)
        {
            subscription.delete(flush: true)
            redirect(controller: "dashboard" ,action: "index")
        }
        else
        {
            redirect(controller: "user" ,action: "errors")
        }


    }

    def adminsort(){

        User user = User.findByUsername(session["user"])
        String type = params.id;

        if(type=="All")
        {
            List<User> userList = User.findAllWhere("admin":false)
            [user: userList,userd: user]
        }
        else if(type=="Inactive")
                {
                    List<User> userList = User.findAllWhere("admin":false,"active":false)
                    [user: userList,userd: user]
                }
        else {
            List<User> userList = User.findAllWhere("admin":false,"active":true)
            [user:userList,userd:user]
        }

    }
}
