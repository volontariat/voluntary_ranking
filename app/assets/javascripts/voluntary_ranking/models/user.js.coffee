VoluntaryOnEmberjs.User = VoluntaryOnEmberjs.User.extend
  user_list_items: DS.hasMany('VoluntaryOnEmberjs.UserListItem', embedded: true)