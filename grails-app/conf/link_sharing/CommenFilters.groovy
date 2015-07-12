package link_sharing


class CommenFilters {

    def filters = {
        all(controller:'*', action:'*') {
            before = {
                if((session["user"]==null) &&(!controllerName.equalsIgnoreCase('login'))&&(!controllerName.equalsIgnoreCase('resourceRating')))
                {
                    redirect(controller: "login", action: "index")
                    return false;
                }
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}
