class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: 'login',action: 'index')
        "500"(view:'/error500')
        "404"(view: '/NotFound')
	}
}
