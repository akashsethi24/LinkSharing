package link_sharing

class SubscriptionController {
    def scaffold=true;
    def index() {
        User user = User.findByUsername(session["user"])
        [users: user]
    }
    def showsubscription(){
        if (session["user"] != null) {
            String u = session["user"]
            User user = User.findByUsername(u)
            def s = Subscription.countByUser(user)
            def t = Topic.countByUser(user)
            def r = Resource.countByCreator(user)
            List<Visibility> top = Visibility.values();
            List<Subscription> sub = Subscription.findAllByUser(user)
            List<Topic> topic = Topic.findAllByUser(user)
            List<Seriousness> ser = Seriousness.values()
            List<String> tname = topic.name;

            List<Topic> top1 = Subscription.createCriteria().list() {   // First Extracting Subscribed Topics of User
                projections { property("topic") }
                eq('user', user)
            }
            List<Resource> AllResource = Resource.createCriteria().list() {
                // Second Searching Resources Of the Topics

                inList('topic', top1)

            }


            [users: user, scount: s, tcount: t, top: top, topic: topic, sub: sub, rcount: r, ser: ser,AllResource:AllResource]
        }
    }
}
