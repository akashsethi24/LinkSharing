package link_sharing

class ReadingItem {

    boolean isRead

    static belongsTo=[user:User,resource:Resource]


//    String toString()
//    {return resource}

    static constraints = {

    }
}
