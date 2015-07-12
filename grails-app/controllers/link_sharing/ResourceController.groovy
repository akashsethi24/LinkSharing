package link_sharing

class ResourceController {
    def scaffold=true;
    def mailService
    User user
    def index() {
        user=User.findByUsername(session["user"])
        List<Topic> topics1 = Subscription.createCriteria().list {
            projections{
                property('topic')
            }
            eq('user',user)
        }
        [topics:topics1,user: user]
    }


def invites(){
    user = User.findByUsername(session["user"]);
    List<Topic> topics1 = Subscription.createCriteria().list {
        projections{
            property('topic')
        }
        eq('user',user)
    }
    String topics = params.topic
    [topic:topics1,user: user ,topics: topics]
}

    def invited(){
        user=User.findByUsername(session["user"])
String topicname= params.topic
        String email=params.email
        if(email) {
            mailService.sendMail {
                to email
                subject "Link Sharing Invitation"
                body user.toString() + " Like to Share a Topic -" + topicname
                redirect(controller: "user", action: "done")
            }
        }
        else
            redirect(controller: "user",action: "errors")

    }
    def createreource(){

        if(params.type=="link")
        {
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
                    redirect(controller: "user" ,action: "done")
                }
            } else {
                redirect(controller: "user",action: "errors")

            }
        }
        else {
            DocumentResource documentResource = new DocumentResource();
            documentResource.title = Topic.findByName(params.topic)
            documentResource.creator = user
            documentResource.filePath = params.filePath
            Topic tt = Topic.findByName(params.topic)
            documentResource.topic = Topic.findByName(params.topic)
            documentResource.description = params["description"]
//        def file=request.getFile("filePath");
//        documentResource.filePath=file.getBytes()
            if (documentResource.validate()) {
                documentResource.save()
                List<Subscription> subscriptionList = Subscription.findAllByTopic(tt)
                subscriptionList.each {
                    if (user != it.user) {
                        ReadingItem readingItem = new ReadingItem(isRead: false, user: it.user, resource: documentResource)
                        readingItem.save()
                    }
                    redirect(controller: "user" ,action: "done")
                }
            } else {
                redirect(controller: "user",action: "errors")

            }
        }

    }
    def viewfull()
    {
        LinkResource linkResource = LinkResource.findByTitle(params.resource)
        redirect(url:linkResource.url)
    }
    def downloadit(){
        DocumentResource documentResource = DocumentResource.findByTitle(params.resource)
        def file = new File("${documentResource.filePath}")

        if (file.exists())
        {
            response.setContentType("application/octet-stream") // or or image/JPEG or text/xml or whatever type the file is
            //response.setHeader("Content-disposition", "attachment;filename=\"${documentResource.fileName}\"")
            response.outputStream << file.bytes
        }
        else
            redirect(controller: "user",action: "errors")


    }

}
