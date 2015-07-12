package link_sharing

import org.springframework.web.multipart.commons.CommonsMultipartFile

class UserController {
    User user
    def index() {
        String username=session["user"];
        user = User.findByUsername(username)
        def s = Subscription.countByUser(user)
        def t = Topic.countByUser(user)
        def r = Resource.countByCreator(user)
        List<Visibility> top = Visibility.values();
        List<Seriousness> ser = Seriousness.values()
        List<Subscription> sub = Subscription.findAllByUser(user, [max: 5])
        List<Topic> topic = Topic.findAllByUser(user)

        List<Topic> top1 = Subscription.createCriteria().list() {   // First Extracting Subscribed Topics of User
            projections { property("topic") }
            eq('user', user)
        }
        List<Resource> AllResource = Resource.createCriteria().list() {
            // Second Searching Resources Of the Topics

            inList('topic', top1)

        }

        [users: user, scount: s, tcount: t,rcount:r,topic:topic,ser:ser,sub:sub,AllResource:AllResource]
    }
def edituser()
{
    String username=session["user"];
    println("hello "+username)
   user = User.findByUsername(username)
    def s = Subscription.countByUser(user)
    def t = Topic.countByUser(user)
    def r = Resource.countByCreator(user)

//    [users: user, scount: s, tcount: t,rcount:r]
    println(params)
    [used:user,sc:s,tc:t,rc:r]

}
    def changedata(){
        String username=session["user"];
        user = User.findByUsername(username)
        println("Params Pic "+params.photo)
        println("User Pic "+user.photo)
        user.firstName=params.fName;
        user.lastName=params.lName;
        user.username=params.username
        session["user"]=params.username


            def file = request.getFile('photo')
            user.photo=file.getBytes()
        if(user.photo.size()==0)
        {
            user.photo=null
        }
            println("123 "+user.photo)
            user.save(flush: true)
            redirect(controller: "dashboard",action: "index")


    }
    def done(){

    }
    def errors(){

    }
    def Changepass(){
        User u1 = User.findByUsername(session["user"])
        String password=params.password
        String cpass=params.confirm_password;
        if(u1) {
            if(cpass==password)
            u1.password = password;
            else
                redirect(controller: "user",action: "errors")
            if(u1.validate()) {
                u1.save(flush: true)
                println("Password Changed")
                render(view: "done")
            }
            else
            {
                println(params)
                println(u1.errors.allErrors)
                render(view:"done")
            }
        }
    }
    def adminuser()
    {
        params.max = params.max ?: 20
        List<User> userList= User.findAllWhere("admin":false,[max: 20])
        user = User.findByUsername(session["user"])
        def total = User.findAll()
        [user:userList,admin: user,total:total]

    }
    def changeuser(){
    println(params)
        User user1=User.findByUsername(params.active)
        if(user1.active==true)
        {
            user1.active=false
            user1.save(flush: true)

        }
        else
        {
            user1.active=true;
            user1.save(flush: true)

        }
        redirect(controller: "user",action: "adminuser")
    }
}
