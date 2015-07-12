package link_sharing

import link_sharing.Seriousness

class Subscription {

    Date dateCreated
    Seriousness seriousness
    static belongsTo=[user:User,topic:Topic]


    static constraints = {

        user unique:'topic'
        seriousness blank:false,nullable:false

    }


}