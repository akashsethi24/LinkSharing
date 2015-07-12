package link_sharing
import link_sharing.Resource;
class LinkResource extends Resource{
    String url
    static constraints = {

        url (url:true,blank:false,nullable:false)
    }
}
