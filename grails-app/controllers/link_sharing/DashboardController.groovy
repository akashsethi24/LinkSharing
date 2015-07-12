package link_sharing

class DashboardController {
    User user
def mailService;
    def index() {
        if (session["user"] != null) {
            String u = session["user"]
            user = User.findByUsername(u)
            def s = Subscription.countByUser(user)
            def t = Topic.countByUser(user)
            def r = Resource.countByCreator(user)
            List<Visibility> top = Visibility.values();
            List<Subscription> sub = Subscription.findAllByUser(user, [max: 5])
            List<Topic> topics = Topic.findAllByUser(user)
            List<Seriousness> ser = Seriousness.values()
            List<String> tname = topics.name;

            //INBOX

            List<Resource> inboxlist = ReadingItem.createCriteria().list() {
                projections {
                    property 'resource'
                }
                eq('user', user)
                eq('isRead', false)
//                'resource' {
//                    order('lastUpdated', 'desc')
//                }
            }
            println("inbox is "+inboxlist)
            //INBOX ENDS HERE
List
            def a = Resource.createCriteria().list(max: 3, offset: 0) {
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


            List<Topic> topics1 = Subscription.createCriteria().list {
                projections{
                    property('topic')
                }
                eq('user',user)
            }


            [users: user, scount: s, tcount: t, top: top, topic: topics, sub: sub, rcount: r, ser: ser, tname: tname, inbox: inboxlist, res: ReadingItem.count(),trend:trendingTopics,tlist:topics1]

        } else {
            println(session["user"])
            redirect(controller: "login", action: "index")
        }
    }
    def deleteit()
    {
        Topic untop = Topic.findByName(params.topic)
        println(params.topic)
        println(untop.user.toString())
        println(user)
        if(untop.user.toString()==user.toString()) {

            untop.delete(flush: true)
            println("Done deleted")
            redirect(controller: "dashboard" ,action: "index")
        }
        else

        redirect(controller: "user",action: "errors")

    }

    def home() {

        user=User.findByUsername(session["user"])
        println(user)
        Topic topi = new Topic(params);
        String u = session["user"];
        user = User.findByUsername(u)
        topi.user = user;
        if (topi.validate()) {
            user.addToTopics(topi);
            user.addToSubscriptions(new Subscription(topic: topi, seriousness:
                    Seriousness.SERIOUS));
            user.save(flush: true, failonerror: true)
            redirect(controller: "dashboard",action: "index")


        } else {
            redirect(controller: "user",action: "errors")
        }
    }

    def sharedoc() {

        println(params)



        String userName= session["user"]
         user=User.findByUsername(userName)

        def file = request.getFile('file')
        if(file.empty) {
            flash.message = "Some Error Occured"
            redirect(controller: "user",action: "errors")
        }
        else {
            DocumentResource documentResource=new DocumentResource()
            documentResource.topic=Topic.findByName(params['topic'])
            String s=file.originalFilename+new Date()
            documentResource.description=params.des
            documentResource.creator=user
            documentResource.fileName=file.originalFilename
            documentResource.title=file.originalFilename
            String path='web-app/document/'+"${documentResource.topic.id}/"

            File dir=new File(path)
            if( !dir.exists() ) {

                dir.mkdirs()
            }
            documentResource.filePath = path + s
            file.transferTo(new File(documentResource.filePath))

            documentResource.save(failOnError: true)
            Resource resource=documentResource
            new ReadingItem(resource:resource, isRead: false, user: user).save()
            flash.message="Document Resource Shared Successfully"
            redirect(controller: "dashboard",action: "index")
        }

    }

    def Sharelink() {
        println(params)
        LinkResource linkResource=new LinkResource()
        linkResource.creator=user
        linkResource.url=params.url
        Topic tt = Topic.findByName(params.topic)
        linkResource.topic=tt
        linkResource.description=params.description
        linkResource.title=tt.name
        if (linkResource.validate()) {
            linkResource.save()
            List<Subscription> subscriptionList = Subscription.findAllByTopic(tt)
            subscriptionList.each {
                if (user != it.user) {
                    ReadingItem readingItem = new ReadingItem(isRead: false, user: it.user, resource: linkResource)
                    readingItem.save()
                }
                redirect(controller: "dashboard",action: "index")
            }
        } else {
            redirect(controller: "user",action: "errors")

        }
    }
    def Invite(){
    println(params)
        String email = params.emailid;
        if(email) {
            mailService.sendMail {
                to email
                subject "Link Sharing Invitation"
                body user.toString() + " Like to Share a Topic -" + params.topic
            redirect(controller:"dashboard", action:"index")
            }


        }
        else
            redirect(controller: "user",action: "errors")

    }
    def SInvite(){
println(" hello"+params)
        session["topic"]= params.topic
        redirect(controller: "resource" ,action: "invites")
            }
    def trending(){

    }


}
