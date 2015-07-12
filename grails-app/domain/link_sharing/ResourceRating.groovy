package link_sharing

class ResourceRating {
    Integer score
    static belongsTo=[user:User,resource:Resource]

    String toString()
    {
        return score
    }


    static constraints = {
    }
}
