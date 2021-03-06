# The application
window.App = Ember.Application.create()

# The store used to talk to the RESTful resource
App.store = DS.Store.create {
  revision: 4
  adapter: DS.RESTAdapter.create { bulkCommit: false }
}

# The Model
App.Contact = DS.Model.extend {
  name: DS.attr('string')
  email: DS.attr('string')
  telephone: DS.attr('string')
  isNew: false
}

# An array controller to interact with the Store
App.contactsController = Ember.ArrayController.create {
  content: App.store.findAll(App.Contact)

  create: ->
    App.store.createRecord App.Contact, { isNew: true }

  save: ->
    App.store.commit()

  delete: (contact) ->
    contact.deleteRecord()
    App.store.commit()
}

# Client View controller
App.ContactView = Ember.View.extend {
  tagName: "tr"

  editingContactBinding: "App.contactsController.editingContact"

  create: ->
    contact = App.contactsController.create()
    this.set "editingContact", contact

  edit: ->
    contact = this.get "contact"
    this.set "editingContact", contact

  delete: ->
    contact = this.get "contact"
    App.contactsController.delete contact
}

# Client Form
App.ContactForm = Ember.View.extend {
  editingContactBinding: "App.contactsController.editingContact"

  save: ->
    App.contactsController.save()

  cancel: ->
    contact = this.get "editingContact"
    isNew = contact.get "isNew"
    if isNew
      App.contactsController.delete contact
}