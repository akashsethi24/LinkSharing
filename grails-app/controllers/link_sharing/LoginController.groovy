package link_sharing

import grails.plugin.mail.MailService

class LoginController {
    def mailService;
    User u2
    boolean aBoolean = true, bbool = true, loginb = true, logini = true,bemail=true;

    def index() {
        session["user"] = null
        params.max = params.max ?: 4
        List<Resource> rList = Resource.listOrderByLastUpdated(max: 4, order: "desc")

        List<Topic> top = Topic.findAllByVisibility("PUBLIC")

        List<Resource> Allresources = Resource.findAllByTopicInList(top)

        List<Resource> topposts = ResourceRating.createCriteria().list([max: 5]) {
            projections {
                groupProperty("resource")
                avg("score", 'avg')

            }
            order('avg', 'desc')
            inList('resource', Allresources)

        }*.getAt(0)


        List<Topic> topicList = Topic.list(params)
        render(view: 'login', model: [resources: rList, total: Resource.count(), topic: topposts, bool: aBoolean, user: u2, bbool: bbool, loginb: loginb, logini: logini])

    }
    def login = {
        render params
        String u = params.username;
        String p = params.password;
        println(params)
        User u1 = User.findByUsername(u)
        if (u1?.password == p) {
            session["user"] = u1.username;
            if (u1.active == true) {
                logini=true
                redirect(controller: "dashboard", action: "index")
            } else {
                loginb = false
                redirect(controller: "login", action: "index")
            }
        } else {
            logini = false;
            redirect(controller: "login", action: "index")
        }
    }
    def recent = {[email:bemail]}
    def invite(){
        String email = params.email

        User user = User.findByEmail(email)
        if (user) {
            mailService.sendMail {

                to user.email
                subject "Link Sharing Application Password"
                body "Your Password For Link Sharing Application is " + user.password

            }
            bemail=true;
            redirect(action: "index")

        } else {
            println("No User Found  ")
            bemail=false;
            redirect(action: "recent")
        }

    }

    def register() {


        u2 = new User(params);
        u2.active = true;
        def file = request.getFile('photo')
        if (params.password == params.confirmPassword) {
            bbool = true;
            if (!file.empty) {
                u2.photo = file.getBytes()
            } else {
                u2.photo = null;
            }
            if (u2.validate()) {
                u2.save(flush: true)
                session["user"] = u2.username
                aBoolean = true;
                redirect(controller: "dashboard", action: "index")
            } else {
                flash["user"] = u2
                aBoolean = false
                redirect(controller: "login", action: "index")
            }

        } else {
            bbool = false;
            println("Here")
            redirect(controller: "login", action: "index")
        }
    }

}
