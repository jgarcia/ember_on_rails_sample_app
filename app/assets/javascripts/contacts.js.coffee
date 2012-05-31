# The application
window.App = Ember.Application.create()

# The store used to talk to the RESTful resource
App.store = DS.Store.create {
  revision: 4,
  adapter: DS.RESTAdapter.create { bulkCommit: false }
}

# The Model
App.Contact = DS.Model.extend {
  name: DS.attr('string'),
  email: DS.attr('string'),
  telephone: DS.attr('string')
}

# An array controller to interact with the Store
App.contactsController = Ember.ArrayController.create {
  content: App.store.findAll(App.Contact)
}

# Client View controller
App.ContactView = Ember.View.extend {
  tagName: "tr"
}