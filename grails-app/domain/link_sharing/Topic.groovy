package link_sharing

import link_sharing.Visibility

class Topic {
    String name
    Visibility visibility;
    Date dateCreated
    Date lastUpdated
    static belongsTo=[user:User]
    static hasMany=[resources:Resource, subscriptions:Subscription]


    static constraints = {
        visibility blank:false,nullable:false
        name unique:'user'
    }

}
