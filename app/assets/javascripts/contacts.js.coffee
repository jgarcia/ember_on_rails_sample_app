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

  create: ->
    App.store.createRecord App.Contact, {}

  save: ->
    App.store.commit()
}

# Client View controller
App.ContactView = Ember.View.extend {
  tagName: "tr"

  editingContactBinding: "App.contactsController.editingContact"

  create: ->
    contact = App.contactsController.create()
    this.set "editingContact", contact
}

App.ContactForm = Ember.View.extend {
  editingContactBinding: "App.contactsController.editingContact"

  save: ->
    App.contactsController.save()
}