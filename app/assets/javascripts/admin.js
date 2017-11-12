function render_user(json) {
  return `
    <tr>
      <th>${json.email}</th>
      <th>${json.first_name}</th>
      <th>${json.last_name}</th>
      <th>${json.middle_name || ''}</th>
      <th>${json.city}</th>
      <th>
        ${json.status.type}
        <br />
        ${json.status.extra.banned_at || ''}
        ${json.status.extra.soc_url || ''}
        ${handle_attachment(json.status.extra.attachment)}
      </th>
      <th>
       ${handle_actions(json.actions) || ""}
      </th>
    </tr>
  `
}

function handle_attachment(attachment) {
  if(attachment){
    return `<a href="${attachment}" target=_blank> Документ </a>`
  } else {
    return ''
  }
}
function handle_actions(actions) {
  const keys = Object.keys(actions)
  if(keys.length !== 0){
    let result = keys.reduce(function(acc, key){
      if(key === 'approve'){
        return acc + `<a class='btn btn-success' href='${actions[key]}' >Подтвердить Регистрацию</button>`
      } else if (key === 'ban') {
        return acc + `<a class='btn btn-danger' href='${actions[key]}' >Ban</button>`
      } else if (key === 'cancel') {
        return acc + `<a class='btn btn-warning' href='${actions[key]}' >Отмена регистрации</button>`
      }}, "")
    return result
  }
}

App.room = App.cable.subscriptions.create("AdminNotificationsChannel", {
  received(data) {
    return $('#users').append(
      render_user(JSON.parse(data['message']))
    );
  }
});


$('#users').ready(function () {
  window.users_data.forEach(function (user) {
    $('#users').append(render_user(user))
  })
});
