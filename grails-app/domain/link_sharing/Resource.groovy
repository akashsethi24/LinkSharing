package link_sharing

class Resource {
    User creator
    String title
    String description
    Date dateCreated
    Date lastUpdated

    static hasMany=[readingItems:ReadingItem,resourceRatings:ResourceRating]
    static belongsTo=[topic:Topic]


    static mapping = {
        tablePerHierarchy false
    }

    static constraints = {

        title (unique:'topic')
        description ( size:1..1024)


    }

    String toString()
    {
        return description;
    }


}
