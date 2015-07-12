package link_sharing

import link_sharing.Resource


class DocumentResource extends Resource {
    String filePath
    String fileName
    static constraints = {
        filePath blank: false, nullable: false
        fileName blank: false, nullable: false
    }
}
