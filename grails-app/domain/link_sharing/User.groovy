package link_sharing


class User {

    String email
    String username
    String password

    String firstName
    String lastName
    byte[] photo
    boolean admin=false
    boolean active=true
    Date dateCreated
    Date lastUpdated
    String photoName;
    boolean activate=true;

    static hasMany=[topics:Topic,subscriptions:Subscription,readingItems:ReadingItem,resourceRatings:ResourceRating]

    static constraints = {
        activate(null:true)
        photoName(nullable: true)
        photo (nullable:true,maxSize:1024*1024*5)
        email(email: true,blank:false,unique:true)
        lastName(nullable: true,blank: true)

        password (password:true,blank: false, nullable: false, validator: {password, obj ->
            def password2 = obj.password
            password2 == password ? true : ['invalid.matchingpasswords']
        })
    }

    String  toString()
    {
        return firstName+" "+lastName
    }


}