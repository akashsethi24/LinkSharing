package link_sharing

import grails.transaction.Transactional

@Transactional
class BootstrapService {

    void createUsers() {
        User u1 = new User(firstName: "Akash", lastName: "Sethi", username: "akash24", password: "akash",  admin: "true", active: "true", photo: null, dateCreated: null, lastUpdate: null, email: "akashsethi@hotmail.com");
        if (u1.validate()) {
            u1.save(flush: true, failOnError: true)
        } else
            println u1.errors

        User u2 = new User(firstName: "Prithvi", lastName: "Sethi", username: "prithvi", password: "prithvi",  admin: "false", active: "true", photo: null, dateCreated: null, lastUpdate: null, email: "Manny@gmail.com");
        u2.save(flush: true, failOnError: true);
    }

    void createTopics() {
        List users = User.list();
        def i = 1
        users.each { u1 ->
            5.times {
                Topic topic = new Topic(name: "Java JDk ${it + i}", visibility: Visibility.PUBLIC)
                u1.addToTopics(topic);
                u1.addToSubscriptions(new Subscription(topic: topic, seriousness:
                        Seriousness.SERIOUS));
                i++;
                u1.save(flush: true, failonerror: true)
            }
        }
    }

    void createResources() {
        List topics = Topic.list();
        topics.eachWithIndex { Topic topic, Integer index ->

            User user = User.findById(index % 2 + 1)

            topic.addToResources(
                    new LinkResource(creator: user, title: "link tittle ${index + 1}", description: "link tiitle${index + 1}	descripion", url: "https://grails.github.io/grails-doc/link${index + 1}")
            )

            topic.addToResources(
                    new DocumentResource(creator: user, title: "document tittle ${index + 1}",fileName: "Java", description: " document tiitle${index + 1}descripion", filePath: "//filepath/grails.github.io/grails-doc/link${index + 1}")
            )
            topic.save(flush: true, failOnError: true);

        }
    }

    void createReadingItems() {

        int size = Resource.list().size() - 1;
        List<Resource> r = Resource.list()
        User.list().each { user ->

            user.addToReadingItems(new ReadingItem(resource: r.get(Math.abs(1)), isRead: false))
            user.addToReadingItems(new ReadingItem(resource: r.get(Math.abs(1)), isRead: false))
            user.addToReadingItems(new ReadingItem(resource: r.get(Math.abs(2)), isRead: false))
            user.save(failOnError: true)

        }
    }
}
